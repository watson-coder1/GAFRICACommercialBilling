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

        // Get Hotspot clients who are currently active (not expired) - REAL DATA
        $hotspot_active = ORM::for_table('tbl_user_recharges')
            ->where('type', 'Hotspot')
            ->where('status', 'on')
            ->where_raw("CONCAT(expiration, ' ', time) > NOW()")
            ->count();

        // Get Hotspot clients who are expired - REAL DATA
        $hotspot_expired = ORM::for_table('tbl_user_recharges')
            ->where('type', 'Hotspot')
            ->where('status', 'on')
            ->where_raw("CONCAT(expiration, ' ', time) <= NOW()")
            ->count();

        // Get Hotspot clients who are disabled/off
        $hotspot_disabled = ORM::for_table('tbl_user_recharges')
            ->where('type', 'Hotspot')
            ->where('status', 'off')
            ->count();

        // Get currently online Hotspot sessions from MikroTik API - REAL DATA
        $hotspot_online = 0;
        try {
            // Get all routers and check Hotspot sessions
            $routers = ORM::for_table('tbl_routers')
                ->where('enabled', 1)
                ->find_many();
            
            foreach ($routers as $router) {
                try {
                    $client = Mikrotik::getClient($router->ip_address, $router->username, $router->password);
                    
                    if ($client) {
                        // Get Hotspot active sessions
                        $hotspotRequest = new PEAR2\Net\RouterOS\Request('/ip/hotspot/active/print');
                        $hotspotResults = $client->sendSync($hotspotRequest);
                        
                        $count = 0;
                        foreach ($hotspotResults as $result) {
                            $count++;
                        }
                        $hotspot_online += $count;
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
        $hotspot_disconnected = $hotspot_active - $hotspot_online;
        if ($hotspot_disconnected < 0) {
            $hotspot_disconnected = 0;
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

        // Assign variables to template - ALL REAL DATA
        $ui->assign('hotspot_active', $hotspot_active);
        $ui->assign('hotspot_expired', $hotspot_expired);
        $ui->assign('hotspot_disabled', $hotspot_disabled);
        $ui->assign('hotspot_online', $hotspot_online);
        $ui->assign('hotspot_disconnected', $hotspot_disconnected);
        $ui->assign('hotspot_total', $hotspot_total);
        $ui->assign('hotspot_transactions_today', $hotspot_transactions_today);
        $ui->assign('hotspot_logged_out', $hotspot_logged_out);

        return $ui->fetch('widget/hotspot_clients_status.tpl');
    }
}