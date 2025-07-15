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

        // Get PPPoE clients who are currently active (not expired)
        $pppoe_active = ORM::for_table('tbl_user_recharges')
            ->where('type', 'PPPOE')
            ->where('status', 'on')
            ->where_gte('expiration', $current_date)
            ->count();

        // Get PPPoE clients who are expired
        $pppoe_expired = ORM::for_table('tbl_user_recharges')
            ->where('type', 'PPPOE')
            ->where('status', 'on')
            ->where_lt('expiration', $current_date)
            ->count();

        // Get PPPoE clients who are disabled/off
        $pppoe_disabled = ORM::for_table('tbl_user_recharges')
            ->where('type', 'PPPOE')
            ->where('status', 'off')
            ->count();

        // Get currently online PPPoE sessions from RADIUS accounting
        $pppoe_online = 0;
        try {
            $pppoe_online = ORM::for_table('rad_acct')
                ->where('acctstoptime', null)
                ->where('acctstatustype', 'Start')
                ->count();
        } catch (Exception $e) {
            // If rad_acct table doesn't exist or has issues, keep count as 0
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

        // Assign variables to template
        $ui->assign('pppoe_active', $pppoe_active);
        $ui->assign('pppoe_expired', $pppoe_expired);
        $ui->assign('pppoe_disabled', $pppoe_disabled);
        $ui->assign('pppoe_online', $pppoe_online);
        $ui->assign('pppoe_total', $pppoe_total);
        $ui->assign('pppoe_transactions_today', $pppoe_transactions_today);

        return $ui->fetch('widget/pppoe_clients_status.tpl');
    }
}