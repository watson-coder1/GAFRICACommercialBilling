<?php

/**
 * Widget Export Controller
 * Handles Excel/CSV exports for dashboard widgets
 */

_admin();

$type = _req('type');
$format = _req('format', 'csv'); // Default to CSV

if (empty($type)) {
    r2(getUrl('dashboard'), 'e', 'Export type is required');
}

// Set headers for file download
$filename = '';
$data = [];

switch ($type) {
    case 'pppoe_clients':
        $filename = 'pppoe_clients_' . date('Y-m-d_H-i-s');
        $data = exportPPPoEClients();
        break;
        
    case 'hotspot_clients':
        $filename = 'hotspot_clients_' . date('Y-m-d_H-i-s');
        $data = exportHotspotClients();
        break;
        
    case 'service_statistics':
        $filename = 'service_statistics_' . date('Y-m-d_H-i-s');
        $data = exportServiceStatistics();
        break;
        
    default:
        r2(getUrl('dashboard'), 'e', 'Invalid export type');
}

// Generate and download file
if ($format === 'csv') {
    downloadCSV($data, $filename . '.csv');
} else {
    r2(getUrl('dashboard'), 'e', 'Only CSV format is currently supported');
}

/**
 * Export PPPoE clients data
 */
function exportPPPoEClients()
{
    global $current_date;
    
    $data = [];
    $data[] = ['Customer Name', 'Username', 'Phone', 'Email', 'Service Type', 'Plan Name', 'Status', 'Expiration', 'Price', 'Router', 'Created Date'];
    
    // Get PPPoE customers with their active plans
    $customers = ORM::for_table('tbl_customers')
        ->select('tbl_customers.*')
        ->select('tbl_user_recharges.username', 'plan_username')
        ->select('tbl_user_recharges.namebp', 'plan_name')
        ->select('tbl_user_recharges.status', 'plan_status')
        ->select('tbl_user_recharges.expiration', 'plan_expiration')
        ->select('tbl_plans.price', 'plan_price')
        ->select('tbl_user_recharges.routers', 'plan_router')
        ->select('tbl_user_recharges.recharged_on', 'plan_created')
        ->left_outer_join('tbl_user_recharges', array('tbl_customers.username', '=', 'tbl_user_recharges.customer_id'))
        ->left_outer_join('tbl_plans', array('tbl_plans.id', '=', 'tbl_user_recharges.plan_id'))
        ->where('tbl_customers.service_type', 'PPPoE')
        ->order_by_desc('tbl_user_recharges.id')
        ->find_many();
    
    foreach ($customers as $customer) {
        $status = 'No Plan';
        if ($customer->plan_status) {
            if ($customer->plan_expiration && $customer->plan_expiration < $current_date) {
                $status = 'Expired';
            } else {
                $status = $customer->plan_status === 'on' ? 'Active' : 'Disabled';
            }
        }
        
        $data[] = [
            $customer->fullname ?: 'N/A',
            $customer->username ?: 'N/A',
            $customer->phonenumber ?: 'N/A',
            $customer->email ?: 'N/A',
            'PPPoE',
            $customer->plan_name ?: 'No Plan',
            $status,
            $customer->plan_expiration ?: 'N/A',
            $customer->plan_price ? 'KSh ' . number_format($customer->plan_price, 2) : 'N/A',
            $customer->plan_router ?: 'N/A',
            $customer->plan_created ?: 'N/A'
        ];
    }
    
    return $data;
}

/**
 * Export Hotspot clients data
 */
function exportHotspotClients()
{
    global $current_date;
    
    $data = [];
    $data[] = ['Customer Name', 'Username', 'Phone', 'Email', 'Service Type', 'Plan Name', 'Status', 'Expiration', 'Price', 'Router', 'Created Date', 'Session Info'];
    
    // Get Hotspot customers with their active plans
    $customers = ORM::for_table('tbl_customers')
        ->select('tbl_customers.*')
        ->select('tbl_user_recharges.username', 'plan_username')
        ->select('tbl_user_recharges.namebp', 'plan_name')
        ->select('tbl_user_recharges.status', 'plan_status')
        ->select('tbl_user_recharges.expiration', 'plan_expiration')
        ->select('tbl_plans.price', 'plan_price')
        ->select('tbl_user_recharges.routers', 'plan_router')
        ->select('tbl_user_recharges.recharged_on', 'plan_created')
        ->left_outer_join('tbl_user_recharges', array('tbl_customers.username', '=', 'tbl_user_recharges.customer_id'))
        ->left_outer_join('tbl_plans', array('tbl_plans.id', '=', 'tbl_user_recharges.plan_id'))
        ->where('tbl_customers.service_type', 'Hotspot')
        ->order_by_desc('tbl_user_recharges.id')
        ->find_many();
    
    foreach ($customers as $customer) {
        $status = 'No Plan';
        if ($customer->plan_status) {
            if ($customer->plan_expiration && $customer->plan_expiration < $current_date) {
                $status = 'Expired';
            } else {
                $status = $customer->plan_status === 'on' ? 'Active' : 'Disabled';
            }
        }
        
        // Check for portal sessions
        $sessionInfo = 'No Sessions';
        try {
            $portalSession = ORM::for_table('tbl_portal_sessions')
                ->where('phone_number', $customer->phonenumber)
                ->order_by_desc('created_at')
                ->find_one();
            
            if ($portalSession) {
                $sessionStatus = $portalSession->expires_at > date('Y-m-d H:i:s') ? 'Active' : 'Expired';
                $sessionInfo = "Session: $sessionStatus (Expires: {$portalSession->expires_at})";
            }
        } catch (Exception $e) {
            $sessionInfo = 'Session data unavailable';
        }
        
        $data[] = [
            $customer->fullname ?: 'N/A',
            $customer->username ?: 'N/A',
            $customer->phonenumber ?: 'N/A',
            $customer->email ?: 'N/A',
            'Hotspot',
            $customer->plan_name ?: 'No Plan',
            $status,
            $customer->plan_expiration ?: 'N/A',
            $customer->plan_price ? 'KSh ' . number_format($customer->plan_price, 2) : 'N/A',
            $customer->plan_router ?: 'N/A',
            $customer->plan_created ?: 'N/A',
            $sessionInfo
        ];
    }
    
    return $data;
}

/**
 * Export service statistics data
 */
function exportServiceStatistics()
{
    global $current_date, $start_date;
    
    $week_start_date = date('Y-m-d', strtotime('-7 days'));
    
    $data = [];
    $data[] = ['Metric', 'PPPoE', 'Hotspot', 'Total', 'PPPoE %', 'Hotspot %'];
    
    // Customers
    $pppoe_customers = ORM::for_table('tbl_customers')->where('service_type', 'PPPoE')->count();
    $hotspot_customers = ORM::for_table('tbl_customers')->where('service_type', 'Hotspot')->count();
    $total_customers = $pppoe_customers + $hotspot_customers;
    
    $data[] = [
        'Total Customers',
        $pppoe_customers,
        $hotspot_customers,
        $total_customers,
        $total_customers > 0 ? round(($pppoe_customers / $total_customers) * 100, 1) . '%' : '0%',
        $total_customers > 0 ? round(($hotspot_customers / $total_customers) * 100, 1) . '%' : '0%'
    ];
    
    // Revenue Today
    $pppoe_today = ORM::for_table('tbl_transactions')->where('type', 'PPPOE')->where('recharged_on', $current_date)->sum('price') ?: 0;
    $hotspot_today = ORM::for_table('tbl_transactions')->where('type', 'Hotspot')->where('recharged_on', $current_date)->sum('price') ?: 0;
    $total_today = $pppoe_today + $hotspot_today;
    
    $data[] = [
        'Revenue Today (KSh)',
        number_format($pppoe_today, 2),
        number_format($hotspot_today, 2),
        number_format($total_today, 2),
        $total_today > 0 ? round(($pppoe_today / $total_today) * 100, 1) . '%' : '0%',
        $total_today > 0 ? round(($hotspot_today / $total_today) * 100, 1) . '%' : '0%'
    ];
    
    // Revenue This Week
    $pppoe_week = ORM::for_table('tbl_transactions')->where('type', 'PPPOE')->where_gte('recharged_on', $week_start_date)->where_lte('recharged_on', $current_date)->sum('price') ?: 0;
    $hotspot_week = ORM::for_table('tbl_transactions')->where('type', 'Hotspot')->where_gte('recharged_on', $week_start_date)->where_lte('recharged_on', $current_date)->sum('price') ?: 0;
    $total_week = $pppoe_week + $hotspot_week;
    
    $data[] = [
        'Revenue This Week (KSh)',
        number_format($pppoe_week, 2),
        number_format($hotspot_week, 2),
        number_format($total_week, 2),
        $total_week > 0 ? round(($pppoe_week / $total_week) * 100, 1) . '%' : '0%',
        $total_week > 0 ? round(($hotspot_week / $total_week) * 100, 1) . '%' : '0%'
    ];
    
    // Revenue This Month
    $pppoe_month = ORM::for_table('tbl_transactions')->where('type', 'PPPOE')->where_gte('recharged_on', $start_date)->where_lte('recharged_on', $current_date)->sum('price') ?: 0;
    $hotspot_month = ORM::for_table('tbl_transactions')->where('type', 'Hotspot')->where_gte('recharged_on', $start_date)->where_lte('recharged_on', $current_date)->sum('price') ?: 0;
    $total_month = $pppoe_month + $hotspot_month;
    
    $data[] = [
        'Revenue This Month (KSh)',
        number_format($pppoe_month, 2),
        number_format($hotspot_month, 2),
        number_format($total_month, 2),
        $total_month > 0 ? round(($pppoe_month / $total_month) * 100, 1) . '%' : '0%',
        $total_month > 0 ? round(($hotspot_month / $total_month) * 100, 1) . '%' : '0%'
    ];
    
    // Active Plans
    $pppoe_active = ORM::for_table('tbl_user_recharges')->where('type', 'PPPOE')->where('status', 'on')->where_gte('expiration', $current_date)->count();
    $hotspot_active = ORM::for_table('tbl_user_recharges')->where('type', 'Hotspot')->where('status', 'on')->where_gte('expiration', $current_date)->count();
    $total_active = $pppoe_active + $hotspot_active;
    
    $data[] = [
        'Active Plans',
        $pppoe_active,
        $hotspot_active,
        $total_active,
        $total_active > 0 ? round(($pppoe_active / $total_active) * 100, 1) . '%' : '0%',
        $total_active > 0 ? round(($hotspot_active / $total_active) * 100, 1) . '%' : '0%'
    ];
    
    return $data;
}

/**
 * Download CSV file
 */
function downloadCSV($data, $filename)
{
    header('Content-Type: text/csv');
    header('Content-Disposition: attachment; filename="' . $filename . '"');
    header('Pragma: no-cache');
    header('Expires: 0');
    
    $output = fopen('php://output', 'w');
    
    foreach ($data as $row) {
        fputcsv($output, $row);
    }
    
    fclose($output);
    exit;
}