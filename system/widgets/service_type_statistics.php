<?php

/**
 * Service Type Statistics Widget
 * Shows comparison between PPPoE and Hotspot service statistics
 */
class service_type_statistics
{
    public function getWidget()
    {
        global $ui, $current_date, $start_date;
        
        // Calculate weekly start date (last 7 days)
        $week_start_date = date('Y-m-d', strtotime('-7 days'));

        // PPPoE Statistics
        $pppoe_customers = ORM::for_table('tbl_customers')
            ->where('service_type', 'PPPoE')
            ->count();

        $pppoe_revenue_today = ORM::for_table('tbl_transactions')
            ->where('type', 'PPPOE')
            ->where('recharged_on', $current_date)
            ->sum('price');

        $pppoe_revenue_week = ORM::for_table('tbl_transactions')
            ->where('type', 'PPPOE')
            ->where_gte('recharged_on', $week_start_date)
            ->where_lte('recharged_on', $current_date)
            ->sum('price');

        $pppoe_revenue_month = ORM::for_table('tbl_transactions')
            ->where('type', 'PPPOE')
            ->where_gte('recharged_on', $start_date)
            ->where_lte('recharged_on', $current_date)
            ->sum('price');

        $pppoe_active_plans = ORM::for_table('tbl_user_recharges')
            ->where('type', 'PPPOE')
            ->where('status', 'on')
            ->where_gte('expiration', $current_date)
            ->count();

        // Hotspot Statistics
        $hotspot_customers = ORM::for_table('tbl_customers')
            ->where('service_type', 'Hotspot')
            ->count();

        $hotspot_revenue_today = ORM::for_table('tbl_transactions')
            ->where('type', 'Hotspot')
            ->where('recharged_on', $current_date)
            ->sum('price');

        $hotspot_revenue_week = ORM::for_table('tbl_transactions')
            ->where('type', 'Hotspot')
            ->where_gte('recharged_on', $week_start_date)
            ->where_lte('recharged_on', $current_date)
            ->sum('price');

        $hotspot_revenue_month = ORM::for_table('tbl_transactions')
            ->where('type', 'Hotspot')
            ->where_gte('recharged_on', $start_date)
            ->where_lte('recharged_on', $current_date)
            ->sum('price');

        $hotspot_active_plans = ORM::for_table('tbl_user_recharges')
            ->where('type', 'Hotspot')
            ->where('status', 'on')
            ->where_gte('expiration', $current_date)
            ->count();

        // Calculate totals
        $total_customers = $pppoe_customers + $hotspot_customers;
        $total_revenue_today = ($pppoe_revenue_today ? $pppoe_revenue_today : 0) + ($hotspot_revenue_today ? $hotspot_revenue_today : 0);
        $total_revenue_week = ($pppoe_revenue_week ? $pppoe_revenue_week : 0) + ($hotspot_revenue_week ? $hotspot_revenue_week : 0);
        $total_revenue_month = ($pppoe_revenue_month ? $pppoe_revenue_month : 0) + ($hotspot_revenue_month ? $hotspot_revenue_month : 0);
        $total_active_plans = $pppoe_active_plans + $hotspot_active_plans;

        // Calculate percentages
        $pppoe_customer_percent = $total_customers > 0 ? round(($pppoe_customers / $total_customers) * 100, 1) : 0;
        $hotspot_customer_percent = $total_customers > 0 ? round(($hotspot_customers / $total_customers) * 100, 1) : 0;

        $pppoe_revenue_percent_week = $total_revenue_week > 0 ? round((($pppoe_revenue_week ? $pppoe_revenue_week : 0) / $total_revenue_week) * 100, 1) : 0;
        $hotspot_revenue_percent_week = $total_revenue_week > 0 ? round((($hotspot_revenue_week ? $hotspot_revenue_week : 0) / $total_revenue_week) * 100, 1) : 0;
        
        $pppoe_revenue_percent = $total_revenue_month > 0 ? round((($pppoe_revenue_month ? $pppoe_revenue_month : 0) / $total_revenue_month) * 100, 1) : 0;
        $hotspot_revenue_percent = $total_revenue_month > 0 ? round((($hotspot_revenue_month ? $hotspot_revenue_month : 0) / $total_revenue_month) * 100, 1) : 0;

        // Assign variables to template
        $ui->assign('pppoe_customers', $pppoe_customers);
        $ui->assign('pppoe_revenue_today', $pppoe_revenue_today ? number_format($pppoe_revenue_today, 2) : '0.00');
        $ui->assign('pppoe_revenue_week', $pppoe_revenue_week ? number_format($pppoe_revenue_week, 2) : '0.00');
        $ui->assign('pppoe_revenue_month', $pppoe_revenue_month ? number_format($pppoe_revenue_month, 2) : '0.00');
        $ui->assign('pppoe_active_plans', $pppoe_active_plans);
        $ui->assign('pppoe_customer_percent', $pppoe_customer_percent);
        $ui->assign('pppoe_revenue_percent_week', $pppoe_revenue_percent_week);
        $ui->assign('pppoe_revenue_percent', $pppoe_revenue_percent);

        $ui->assign('hotspot_customers', $hotspot_customers);
        $ui->assign('hotspot_revenue_today', $hotspot_revenue_today ? number_format($hotspot_revenue_today, 2) : '0.00');
        $ui->assign('hotspot_revenue_week', $hotspot_revenue_week ? number_format($hotspot_revenue_week, 2) : '0.00');
        $ui->assign('hotspot_revenue_month', $hotspot_revenue_month ? number_format($hotspot_revenue_month, 2) : '0.00');
        $ui->assign('hotspot_active_plans', $hotspot_active_plans);
        $ui->assign('hotspot_customer_percent', $hotspot_customer_percent);
        $ui->assign('hotspot_revenue_percent_week', $hotspot_revenue_percent_week);
        $ui->assign('hotspot_revenue_percent', $hotspot_revenue_percent);

        $ui->assign('total_customers', $total_customers);
        $ui->assign('total_revenue_today', number_format($total_revenue_today, 2));
        $ui->assign('total_revenue_week', number_format($total_revenue_week, 2));
        $ui->assign('total_revenue_month', number_format($total_revenue_month, 2));
        $ui->assign('total_active_plans', $total_active_plans);

        return $ui->fetch('widget/service_type_statistics.tpl');
    }
}