<?php

/**
 * PPPoE Clients Status Widget
 * Shows current status of PPPoE clients (Online, Offline, Expired)
 */
class pppoe_clients_status
{
    public function getWidget()
    {
        global $ui, $current_date;

        // Get PPPoE clients who are currently active (not expired) - REAL DATA
        $pppoe_active = ORM::for_table('tbl_user_recharges')
            ->where('type', 'PPPOE')
            ->where('status', 'on')
            ->where_raw("CONCAT(expiration, ' ', time) > NOW()")
            ->count();

        // Get PPPoE clients who are expired - REAL DATA
        $pppoe_expired = ORM::for_table('tbl_user_recharges')
            ->where('type', 'PPPOE')
            ->where('status', 'on')
            ->where_raw("CONCAT(expiration, ' ', time) <= NOW()")
            ->count();

        // Get PPPoE clients who are disabled/off
        $pppoe_disabled = ORM::for_table('tbl_user_recharges')
            ->where('type', 'PPPOE')
            ->where('status', 'off')
            ->count();

        // Get currently online PPPoE sessions from MikroTik API - REAL DATA
        $pppoe_online = 0;
        try {
            // Get all routers and check PPPoE sessions
            $routers = ORM::for_table('tbl_routers')
                ->where('enabled', 1)
                ->find_many();
            
            foreach ($routers as $router) {
                try {
                    $client = Mikrotik::getClient($router->ip_address, $router->username, $router->password);
                    
                    if ($client) {
                        // Get PPPoE active sessions
                        $pppoeRequest = new PEAR2\Net\RouterOS\Request('/ppp/active/print');
                        $pppoeResults = $client->sendSync($pppoeRequest);
                        
                        $count = 0;
                        foreach ($pppoeResults as $result) {
                            $count++;
                        }
                        $pppoe_online += $count;
                    }
                } catch (Exception $e) {
                    // Skip this router if connection fails
                    continue;
                }
            }
        } catch (Exception $e) {
            // Keep count as 0 if there's an error
        }
        
        // Calculate disconnected users (have valid plan but not connected)
        $pppoe_disconnected = $pppoe_active - $pppoe_online;
        if ($pppoe_disconnected < 0) {
            $pppoe_disconnected = 0;
        }

        // Get total PPPoE customers
        $pppoe_total = ORM::for_table('tbl_customers')
            ->where('service_type', 'PPPoE')
            ->count();

        // Recent PPPoE transactions today
        $pppoe_transactions_today = ORM::for_table('tbl_transactions')
            ->where('type', 'PPPOE')
            ->where('recharged_on', $current_date)
            ->count();

        // Assign variables to template - ALL REAL DATA
        $ui->assign('pppoe_active', $pppoe_active);
        $ui->assign('pppoe_expired', $pppoe_expired);
        $ui->assign('pppoe_disabled', $pppoe_disabled);
        $ui->assign('pppoe_online', $pppoe_online);
        $ui->assign('pppoe_disconnected', $pppoe_disconnected);
        $ui->assign('pppoe_total', $pppoe_total);
        $ui->assign('pppoe_transactions_today', $pppoe_transactions_today);

        return $ui->fetch('widget/pppoe_clients_status.tpl');
    }
}