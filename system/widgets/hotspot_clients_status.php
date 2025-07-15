<?php

/**
 * Hotspot Clients Status Widget
 * Shows current status of Hotspot clients (Online, Offline, Expired, Logged Out)
 */
class hotspot_clients_status
{
    public function getWidget()
    {
        global $ui, $current_date;

        // Get Hotspot clients who are currently active (not expired)
        $hotspot_active = ORM::for_table('tbl_user_recharges')
            ->where('type', 'Hotspot')
            ->where('status', 'on')
            ->where_gte('expiration', $current_date)
            ->count();

        // Get Hotspot clients who are expired
        $hotspot_expired = ORM::for_table('tbl_user_recharges')
            ->where('type', 'Hotspot')
            ->where('status', 'on')
            ->where_lt('expiration', $current_date)
            ->count();

        // Get Hotspot clients who are disabled/off
        $hotspot_disabled = ORM::for_table('tbl_user_recharges')
            ->where('type', 'Hotspot')
            ->where('status', 'off')
            ->count();

        // Get currently online Hotspot sessions from MikroTik API
        $hotspot_online = 0;
        try {
            // Get all routers and check Hotspot sessions
            $routers = ORM::for_table('tbl_routers')
                ->where('enabled', 1)
                ->find_many();
            
            foreach ($routers as $router) {
                try {
                    require_once 'system/devices/MikrotikHotspot.php';
                    $mikrotik = new MikrotikHotspot();
                    $client = $mikrotik->getClient($router->ip_address, $router->username, $router->password);
                    
                    if ($client) {
                        // Get Hotspot active sessions
                        $hotspotRequest = new PEAR2\Net\RouterOS\Request('/ip/hotspot/active/print');
                        $hotspotResults = $client->sendSync($hotspotRequest);
                        
                        if ($hotspotResults) {
                            foreach ($hotspotResults as $session) {
                                if ($session->getType() === PEAR2\Net\RouterOS\Response::TYPE_DATA) {
                                    $hotspot_online++;
                                }
                            }
                        }
                    }
                } catch (Exception $e) {
                    // Skip this router if connection fails
                    continue;
                }
            }
        } catch (Exception $e) {
            // Keep count as 0 if there's an error
        }

        // Get total Hotspot customers
        $hotspot_total = ORM::for_table('tbl_customers')
            ->where('service_type', 'Hotspot')
            ->count();

        // Recent Hotspot transactions today
        $hotspot_transactions_today = ORM::for_table('tbl_transactions')
            ->where('type', 'Hotspot')
            ->where('recharged_on', $current_date)
            ->count();

        // Get Portal sessions that have expired (logged out due to time limit)
        $hotspot_logged_out = 0;
        try {
            $hotspot_logged_out = ORM::for_table('tbl_portal_sessions')
                ->where('payment_status', 'completed')
                ->where_lt('expires_at', date('Y-m-d H:i:s'))
                ->count();
        } catch (Exception $e) {
            // Keep as 0 if table doesn't exist
        }

        // Assign variables to template
        $ui->assign('hotspot_active', $hotspot_active);
        $ui->assign('hotspot_expired', $hotspot_expired);
        $ui->assign('hotspot_disabled', $hotspot_disabled);
        $ui->assign('hotspot_online', $hotspot_online);
        $ui->assign('hotspot_total', $hotspot_total);
        $ui->assign('hotspot_transactions_today', $hotspot_transactions_today);
        $ui->assign('hotspot_logged_out', $hotspot_logged_out);

        return $ui->fetch('widget/hotspot_clients_status.tpl');
    }
}