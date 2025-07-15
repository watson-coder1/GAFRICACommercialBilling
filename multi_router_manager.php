<?php

/**
 * Multi-Router Manager for Resellers
 * Manages multiple MikroTik routers for load balancing and redundancy
 */

require_once 'init.php';

class MultiRouterManager {
    
    private $reseller_id;
    private $routers = [];
    
    public function __construct($reseller_id) {
        $this->reseller_id = $reseller_id;
        $this->loadRouters();
    }
    
    private function loadRouters() {
        $this->routers = ORM::for_table('tbl_routers')
            ->where('reseller_id', $this->reseller_id)
            ->where('enabled', 1)
            ->find_many();
    }
    
    /**
     * Get the best available router for new customer
     * Based on load balancing algorithm
     */
    public function getBestRouter() {
        if (empty($this->routers)) {
            return null;
        }
        
        $router_loads = [];
        
        foreach ($this->routers as $router) {
            $load = $this->getRouterLoad($router);
            $router_loads[$router->id] = [
                'router' => $router,
                'load' => $load,
                'active' => $this->isRouterActive($router)
            ];
        }
        
        // Sort by load (ascending) and select the least loaded active router
        uasort($router_loads, function($a, $b) {
            if (!$a['active'] && $b['active']) return 1;
            if ($a['active'] && !$b['active']) return -1;
            return $a['load'] - $b['load'];
        });
        
        $best = reset($router_loads);
        return $best['active'] ? $best['router'] : null;
    }
    
    /**
     * Get router load (number of active users)
     */
    public function getRouterLoad($router) {
        try {
            require_once 'system/devices/RouterOSAPI.php';
            
            $API = new RouterosAPI();
            
            if ($router->api_ssl) {
                $API->useSsl = true;
            }
            
            if ($API->connect($router->ip_address, $router->username, $router->password, $router->api_port ?: 8728)) {
                // Get PPPoE active
                $pppoe_active = $API->comm('/ppp/active/print');
                
                // Get Hotspot active
                $hotspot_active = $API->comm('/ip/hotspot/active/print');
                
                $API->disconnect();
                
                return count($pppoe_active) + count($hotspot_active);
            }
            
            return 9999; // High load if can't connect
            
        } catch (Exception $e) {
            error_log("Error getting router load: " . $e->getMessage());
            return 9999;
        }
    }
    
    /**
     * Check if router is active and responding
     */
    public function isRouterActive($router) {
        try {
            require_once 'system/devices/RouterOSAPI.php';
            
            $API = new RouterosAPI();
            $API->timeout = 3; // Quick timeout
            
            if ($router->api_ssl) {
                $API->useSsl = true;
            }
            
            if ($API->connect($router->ip_address, $router->username, $router->password, $router->api_port ?: 8728)) {
                $API->disconnect();
                return true;
            }
            
            return false;
            
        } catch (Exception $e) {
            return false;
        }
    }
    
    /**
     * Add user to all routers (for redundancy)
     */
    public function addUserToAllRouters($customer, $plan, $type = 'Hotspot') {
        $results = [];
        
        foreach ($this->routers as $router) {
            if ($this->isRouterActive($router)) {
                $result = $this->addUserToRouter($customer, $plan, $router, $type);
                $results[$router->id] = $result;
            }
        }
        
        return $results;
    }
    
    /**
     * Add user to specific router
     */
    public function addUserToRouter($customer, $plan, $router, $type = 'Hotspot') {
        try {
            require_once 'system/devices/RouterOSAPI.php';
            
            $API = new RouterosAPI();
            
            if ($router->api_ssl) {
                $API->useSsl = true;
            }
            
            if ($API->connect($router->ip_address, $router->username, $router->password, $router->api_port ?: 8728)) {
                
                if ($type === 'Hotspot') {
                    return $this->addHotspotUser($API, $customer, $plan);
                } elseif ($type === 'PPOE') {
                    return $this->addPPOEUser($API, $customer, $plan);
                }
                
                $API->disconnect();
            }
            
            return ['success' => false, 'message' => 'Connection failed'];
            
        } catch (Exception $e) {
            return ['success' => false, 'message' => $e->getMessage()];
        }
    }
    
    private function addHotspotUser($API, $customer, $plan) {
        try {
            // Check if user exists
            $existing = $API->comm('/ip/hotspot/user/print', [
                '?name' => $customer->username
            ]);
            
            if (empty($existing)) {
                // Add new user
                $API->comm('/ip/hotspot/user/add', [
                    'name' => $customer->username,
                    'password' => $customer->password,
                    'profile' => $plan->name_plan,
                    'limit-uptime' => $plan->validity . $plan->validity_unit
                ]);
            } else {
                // Update existing user
                $API->comm('/ip/hotspot/user/set', [
                    '.id' => $existing[0]['.id'],
                    'profile' => $plan->name_plan,
                    'limit-uptime' => $plan->validity . $plan->validity_unit
                ]);
            }
            
            $API->disconnect();
            return ['success' => true, 'message' => 'Hotspot user added/updated successfully'];
            
        } catch (Exception $e) {
            return ['success' => false, 'message' => $e->getMessage()];
        }
    }
    
    private function addPPOEUser($API, $customer, $plan) {
        try {
            // Check if user exists
            $existing = $API->comm('/ppp/secret/print', [
                '?name' => $customer->username
            ]);
            
            if (empty($existing)) {
                // Add new user
                $API->comm('/ppp/secret/add', [
                    'name' => $customer->username,
                    'password' => $customer->password,
                    'profile' => $plan->name_plan,
                    'service' => 'pppoe'
                ]);
            } else {
                // Update existing user
                $API->comm('/ppp/secret/set', [
                    '.id' => $existing[0]['.id'],
                    'profile' => $plan->name_plan
                ]);
            }
            
            $API->disconnect();
            return ['success' => true, 'message' => 'PPOE user added/updated successfully'];
            
        } catch (Exception $e) {
            return ['success' => false, 'message' => $e->getMessage()];
        }
    }
    
    /**
     * Remove user from all routers
     */
    public function removeUserFromAllRouters($customer) {
        $results = [];
        
        foreach ($this->routers as $router) {
            if ($this->isRouterActive($router)) {
                $result = $this->removeUserFromRouter($customer, $router);
                $results[$router->id] = $result;
            }
        }
        
        return $results;
    }
    
    /**
     * Remove user from specific router
     */
    public function removeUserFromRouter($customer, $router) {
        try {
            require_once 'system/devices/RouterOSAPI.php';
            
            $API = new RouterosAPI();
            
            if ($router->api_ssl) {
                $API->useSsl = true;
            }
            
            if ($API->connect($router->ip_address, $router->username, $router->password, $router->api_port ?: 8728)) {
                
                // Remove from hotspot
                $hotspot_users = $API->comm('/ip/hotspot/user/print', [
                    '?name' => $customer->username
                ]);
                
                foreach ($hotspot_users as $user) {
                    $API->comm('/ip/hotspot/user/remove', [
                        '.id' => $user['.id']
                    ]);
                }
                
                // Remove from PPOE
                $pppoe_users = $API->comm('/ppp/secret/print', [
                    '?name' => $customer->username
                ]);
                
                foreach ($pppoe_users as $user) {
                    $API->comm('/ppp/secret/remove', [
                        '.id' => $user['.id']
                    ]);
                }
                
                $API->disconnect();
                return ['success' => true, 'message' => 'User removed successfully'];
            }
            
            return ['success' => false, 'message' => 'Connection failed'];
            
        } catch (Exception $e) {
            return ['success' => false, 'message' => $e->getMessage()];
        }
    }
    
    /**
     * Disconnect user from all routers
     */
    public function disconnectUserFromAllRouters($customer) {
        $results = [];
        
        foreach ($this->routers as $router) {
            if ($this->isRouterActive($router)) {
                $result = $this->disconnectUserFromRouter($customer, $router);
                $results[$router->id] = $result;
            }
        }
        
        return $results;
    }
    
    /**
     * Disconnect user from specific router
     */
    public function disconnectUserFromRouter($customer, $router) {
        try {
            require_once 'system/devices/RouterOSAPI.php';
            
            $API = new RouterosAPI();
            
            if ($router->api_ssl) {
                $API->useSsl = true;
            }
            
            if ($API->connect($router->ip_address, $router->username, $router->password, $router->api_port ?: 8728)) {
                
                // Disconnect from hotspot
                $hotspot_active = $API->comm('/ip/hotspot/active/print', [
                    '?user' => $customer->username
                ]);
                
                foreach ($hotspot_active as $session) {
                    $API->comm('/ip/hotspot/active/remove', [
                        '.id' => $session['.id']
                    ]);
                }
                
                // Disconnect from PPOE
                $pppoe_active = $API->comm('/ppp/active/print', [
                    '?name' => $customer->username
                ]);
                
                foreach ($pppoe_active as $session) {
                    $API->comm('/ppp/active/remove', [
                        '.id' => $session['.id']
                    ]);
                }
                
                $API->disconnect();
                return ['success' => true, 'message' => 'User disconnected successfully'];
            }
            
            return ['success' => false, 'message' => 'Connection failed'];
            
        } catch (Exception $e) {
            return ['success' => false, 'message' => $e->getMessage()];
        }
    }
    
    /**
     * Get comprehensive router status
     */
    public function getRouterStatus() {
        $status = [];
        
        foreach ($this->routers as $router) {
            $status[$router->id] = [
                'router' => $router,
                'active' => $this->isRouterActive($router),
                'load' => $this->getRouterLoad($router),
                'details' => $this->getRouterDetails($router)
            ];
        }
        
        return $status;
    }
    
    /**
     * Get detailed router information
     */
    public function getRouterDetails($router) {
        try {
            require_once 'system/devices/RouterOSAPI.php';
            
            $API = new RouterosAPI();
            
            if ($router->api_ssl) {
                $API->useSsl = true;
            }
            
            if ($API->connect($router->ip_address, $router->username, $router->password, $router->api_port ?: 8728)) {
                
                $identity = $API->comm('/system/identity/print');
                $resource = $API->comm('/system/resource/print');
                $pppoe_active = $API->comm('/ppp/active/print');
                $hotspot_active = $API->comm('/ip/hotspot/active/print');
                
                $API->disconnect();
                
                return [
                    'identity' => $identity[0]['name'] ?? 'Unknown',
                    'version' => $resource[0]['version'] ?? 'Unknown',
                    'uptime' => $resource[0]['uptime'] ?? 'Unknown',
                    'cpu_load' => $resource[0]['cpu-load'] ?? 'Unknown',
                    'free_memory' => $resource[0]['free-memory'] ?? 'Unknown',
                    'total_memory' => $resource[0]['total-memory'] ?? 'Unknown',
                    'pppoe_users' => count($pppoe_active),
                    'hotspot_users' => count($hotspot_active),
                    'total_users' => count($pppoe_active) + count($hotspot_active)
                ];
            }
            
            return ['error' => 'Connection failed'];
            
        } catch (Exception $e) {
            return ['error' => $e->getMessage()];
        }
    }
}

// Usage example
if (isset($_GET['test']) && isset($_GET['reseller_id'])) {
    $reseller_id = $_GET['reseller_id'];
    $manager = new MultiRouterManager($reseller_id);
    
    echo "=== MULTI-ROUTER STATUS FOR RESELLER $reseller_id ===\n";
    
    $status = $manager->getRouterStatus();
    
    foreach ($status as $router_id => $info) {
        echo "\nRouter ID: $router_id\n";
        echo "Name: " . $info['router']->name . "\n";
        echo "IP: " . $info['router']->ip_address . "\n";
        echo "Active: " . ($info['active'] ? 'Yes' : 'No') . "\n";
        echo "Load: " . $info['load'] . " users\n";
        
        if (isset($info['details']['identity'])) {
            echo "Identity: " . $info['details']['identity'] . "\n";
            echo "Version: " . $info['details']['version'] . "\n";
            echo "Uptime: " . $info['details']['uptime'] . "\n";
            echo "CPU Load: " . $info['details']['cpu_load'] . "%\n";
            echo "PPPoE Users: " . $info['details']['pppoe_users'] . "\n";
            echo "Hotspot Users: " . $info['details']['hotspot_users'] . "\n";
        }
        
        echo "---\n";
    }
    
    $best_router = $manager->getBestRouter();
    if ($best_router) {
        echo "\nBest Router: " . $best_router->name . " (" . $best_router->ip_address . ")\n";
    } else {
        echo "\nNo active routers available\n";
    }
}

?>