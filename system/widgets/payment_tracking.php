<?php

/**
 * Payment Tracking Widget
 * Track all payments: hotspot users, PPOE, and resellers
 */

class payment_tracking
{
    public function getWidget($widget)
    {
        global $config;
        
        $current_date = date('Y-m-d');
        $start_of_month = date('Y-m-01');
        
        // Hotspot User Payments
        $hotspot_today = ORM::for_table('tbl_transactions')
            ->where('recharged_on', $current_date)
            ->where('type', 'Hotspot')
            ->sum('price') ?: 0;
        
        $hotspot_month = ORM::for_table('tbl_transactions')
            ->where_gte('recharged_on', $start_of_month)
            ->where('type', 'Hotspot')
            ->sum('price') ?: 0;
        
        // PPOE User Payments
        $ppoe_today = ORM::for_table('tbl_transactions')
            ->where('recharged_on', $current_date)
            ->where('type', 'PPOE')
            ->sum('price') ?: 0;
        
        $ppoe_month = ORM::for_table('tbl_transactions')
            ->where_gte('recharged_on', $start_of_month)
            ->where('type', 'PPOE')
            ->sum('price') ?: 0;
        
        // Reseller Subscription Payments
        $reseller_today = ORM::for_table('tbl_reseller_subscription_payments')
            ->where('payment_date', $current_date)
            ->where('status', 'completed')
            ->sum('amount') ?: 0;
        
        $reseller_month = ORM::for_table('tbl_reseller_subscription_payments')
            ->where_gte('payment_date', $start_of_month)
            ->where('status', 'completed')
            ->sum('amount') ?: 0;
        
        // Total payments
        $total_today = $hotspot_today + $ppoe_today + $reseller_today;
        $total_month = $hotspot_month + $ppoe_month + $reseller_month;
        
        // Recent payments (last 10)
        $recent_payments = ORM::for_table('tbl_transactions')
            ->select('*')
            ->select_expr('"Customer" as payment_type')
            ->where_gte('recharged_on', date('Y-m-d', strtotime('-7 days')))
            ->order_by_desc('id')
            ->limit(5)
            ->find_many();
        
        // Recent reseller payments
        $recent_reseller_payments = ORM::for_table('tbl_reseller_subscription_payments')
            ->table_alias('rsp')
            ->select('rsp.*')
            ->select('r.name', 'reseller_name')
            ->select_expr('"Reseller" as payment_type')
            ->join('tbl_resellers', 'rsp.reseller_id = r.id', 'r')
            ->where_gte('rsp.payment_date', date('Y-m-d', strtotime('-7 days')))
            ->where('rsp.status', 'completed')
            ->order_by_desc('rsp.id')
            ->limit(5)
            ->find_many();
        
        // Active resellers count
        $active_resellers = ORM::for_table('tbl_resellers')
            ->where('subscription_status', 'active')
            ->count();
        
        $trial_resellers = ORM::for_table('tbl_resellers')
            ->where('subscription_status', 'trial')
            ->count();
        
        $expired_resellers = ORM::for_table('tbl_resellers')
            ->where_in('subscription_status', ['expired', 'suspended'])
            ->count();
        
        // Payment methods breakdown
        $mpesa_today = ORM::for_table('tbl_transactions')
            ->where('recharged_on', $current_date)
            ->where('method', 'M-Pesa')
            ->sum('price') ?: 0;
        
        $manual_today = ORM::for_table('tbl_transactions')
            ->where('recharged_on', $current_date)
            ->where('method', 'Manual')
            ->sum('price') ?: 0;
        
        $html = '
        <div class="card">
            <div class="card-header">
                <h4 class="card-title"><i class="fa fa-money"></i> Payment Tracking</h4>
            </div>
            <div class="card-body">
                <!-- Summary Row -->
                <div class="row">
                    <div class="col-md-3">
                        <div class="card bg-primary text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h4>KSh ' . number_format($total_today, 2) . '</h4>
                                        <p>Today\'s Total</p>
                                    </div>
                                    <div>
                                        <i class="fa fa-calendar-day fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-success text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h4>KSh ' . number_format($total_month, 2) . '</h4>
                                        <p>This Month</p>
                                    </div>
                                    <div>
                                        <i class="fa fa-calendar-alt fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-info text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h4>' . $active_resellers . '</h4>
                                        <p>Active Resellers</p>
                                    </div>
                                    <div>
                                        <i class="fa fa-users fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-warning text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h4>' . $trial_resellers . '</h4>
                                        <p>Trial Resellers</p>
                                    </div>
                                    <div>
                                        <i class="fa fa-clock fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Payment Breakdown -->
                <div class="row mt-3">
                    <div class="col-md-6">
                        <h5>Today\'s Payments by Service</h5>
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Service</th>
                                    <th>Amount</th>
                                    <th>%</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><i class="fa fa-wifi text-info"></i> Hotspot</td>
                                    <td>KSh ' . number_format($hotspot_today, 2) . '</td>
                                    <td>' . ($total_today > 0 ? number_format(($hotspot_today / $total_today) * 100, 1) : 0) . '%</td>
                                </tr>
                                <tr>
                                    <td><i class="fa fa-network-wired text-success"></i> PPOE</td>
                                    <td>KSh ' . number_format($ppoe_today, 2) . '</td>
                                    <td>' . ($total_today > 0 ? number_format(($ppoe_today / $total_today) * 100, 1) : 0) . '%</td>
                                </tr>
                                <tr>
                                    <td><i class="fa fa-store text-warning"></i> Resellers</td>
                                    <td>KSh ' . number_format($reseller_today, 2) . '</td>
                                    <td>' . ($total_today > 0 ? number_format(($reseller_today / $total_today) * 100, 1) : 0) . '%</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-md-6">
                        <h5>Payment Methods Today</h5>
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Method</th>
                                    <th>Amount</th>
                                    <th>%</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><i class="fa fa-mobile text-success"></i> M-Pesa</td>
                                    <td>KSh ' . number_format($mpesa_today, 2) . '</td>
                                    <td>' . ($total_today > 0 ? number_format(($mpesa_today / $total_today) * 100, 1) : 0) . '%</td>
                                </tr>
                                <tr>
                                    <td><i class="fa fa-hand-holding-usd text-info"></i> Manual</td>
                                    <td>KSh ' . number_format($manual_today, 2) . '</td>
                                    <td>' . ($total_today > 0 ? number_format(($manual_today / $total_today) * 100, 1) : 0) . '%</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <!-- Recent Payments -->
                <div class="row mt-3">
                    <div class="col-md-12">
                        <h5>Recent Payments (Last 7 Days)</h5>
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Date</th>
                                        <th>Type</th>
                                        <th>Customer/Reseller</th>
                                        <th>Amount</th>
                                        <th>Method</th>
                                    </tr>
                                </thead>
                                <tbody>';
                                
        // Add recent customer payments
        foreach ($recent_payments as $payment) {
            $html .= '
                <tr>
                    <td>' . date('M d', strtotime($payment->recharged_on)) . '</td>
                    <td><span class="badge badge-info">Customer</span></td>
                    <td>' . $payment->username . '</td>
                    <td>KSh ' . number_format($payment->price, 2) . '</td>
                    <td>' . $payment->method . '</td>
                </tr>';
        }
        
        // Add recent reseller payments
        foreach ($recent_reseller_payments as $payment) {
            $html .= '
                <tr>
                    <td>' . date('M d', strtotime($payment->payment_date)) . '</td>
                    <td><span class="badge badge-warning">Reseller</span></td>
                    <td>' . $payment->reseller_name . '</td>
                    <td>KSh ' . number_format($payment->amount, 2) . '</td>
                    <td>' . $payment->payment_method . '</td>
                </tr>';
        }
        
        $html .= '
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
                <!-- Quick Actions -->
                <div class="row mt-3">
                    <div class="col-md-12">
                        <div class="btn-group" role="group">
                            <a href="' . U . 'reports/period" class="btn btn-primary">
                                <i class="fa fa-chart-line"></i> View Reports
                            </a>
                            <a href="' . U . 'resellers" class="btn btn-warning">
                                <i class="fa fa-users"></i> Manage Resellers
                            </a>
                            <a href="' . U . 'plan/list" class="btn btn-info">
                                <i class="fa fa-list"></i> View Plans
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>';
        
        return $html;
    }
}