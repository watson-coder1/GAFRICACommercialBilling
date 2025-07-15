<?php

/**
 * Automatic Payment Visibility System
 * Ensures resellers see their customer payments automatically
 */
class AutomaticPaymentSync
{
    /**
     * Process M-Pesa callback and assign to correct reseller
     */
    public static function processMpesaCallback($mpesa_payment) {
        try {
            // Get the portal session to determine which reseller this belongs to
            $session = ORM::for_table('tbl_portal_sessions')
                ->where('session_id', $mpesa_payment->session_id)
                ->find_one();
            
            if (!$session) {
                error_log("AutomaticPaymentSync: No session found for payment {$mpesa_payment->id}");
                return false;
            }
            
            // Determine reseller_id based on package ownership
            $package = ORM::for_table('tbl_hotspot_packages')
                ->where('id', $session->package_id)
                ->find_one();
            
            $reseller_id = $package ? $package->reseller_id : 1;
            
            // Update M-Pesa transaction with correct reseller_id
            $mpesa_payment->reseller_id = $reseller_id;
            $mpesa_payment->save();
            
            // Update session with reseller_id
            $session->reseller_id = $reseller_id;
            $session->save();
            
            error_log("AutomaticPaymentSync: Assigned payment {$mpesa_payment->id} to reseller {$reseller_id}");
            
            return true;
            
        } catch (Exception $e) {
            error_log("AutomaticPaymentSync: Error processing payment {$mpesa_payment->id}: " . $e->getMessage());
            return false;
        }
    }
    
    /**
     * Sync completed payment to transactions table with correct reseller
     */
    public static function syncToTransactions($mpesa_payment) {
        try {
            // Check if already synced
            $existing = ORM::for_table('tbl_transactions')
                ->where('invoice', 'MPESA-' . $mpesa_payment->id)
                ->find_one();
            
            if ($existing) {
                return true; // Already synced
            }
            
            // Get session and package info
            $session = ORM::for_table('tbl_portal_sessions')
                ->where('session_id', $mpesa_payment->session_id)
                ->find_one();
            
            if (!$session) {
                error_log("AutomaticPaymentSync: No session for payment {$mpesa_payment->id}");
                return false;
            }
            
            $package = ORM::for_table('tbl_hotspot_packages')
                ->where('id', $session->package_id)
                ->find_one();
            
            $packageName = $package ? $package->name : 'Unknown Package';
            $reseller_id = $mpesa_payment->reseller_id ?: 1;
            
            // Create transaction record
            $transaction = ORM::for_table('tbl_transactions')->create();
            $transaction->invoice = 'MPESA-' . $mpesa_payment->id;
            $transaction->username = $mpesa_payment->phone_number;
            $transaction->plan_name = $packageName;
            $transaction->price = $mpesa_payment->amount;
            $transaction->recharged_on = date('Y-m-d', strtotime($mpesa_payment->created_at));
            $transaction->recharged_time = date('H:i:s', strtotime($mpesa_payment->created_at));
            $transaction->method = 'M-Pesa';
            $transaction->routers = 'Portal';
            $transaction->type = 'Hotspot';
            $transaction->admin_id = 1;
            $transaction->reseller_id = $reseller_id;
            
            // Calculate expiration
            if ($package && $package->duration_hours > 0) {
                $transaction->expiration = date('Y-m-d', 
                    strtotime($mpesa_payment->created_at . ' +' . $package->duration_hours . ' hours'));
                $transaction->time = sprintf('%02d:00:00', $package->duration_hours);
            } else {
                $transaction->expiration = date('Y-m-d', 
                    strtotime($mpesa_payment->created_at . ' +24 hours'));
                $transaction->time = '24:00:00';
            }
            
            $transaction->save();
            
            // Update reseller's daily report cache
            self::updateResellerReports($reseller_id, $mpesa_payment->amount);
            
            error_log("AutomaticPaymentSync: Synced payment {$mpesa_payment->id} to transaction {$transaction->id} for reseller {$reseller_id}");
            
            return true;
            
        } catch (Exception $e) {
            error_log("AutomaticPaymentSync: Sync error for payment {$mpesa_payment->id}: " . $e->getMessage());
            return false;
        }
    }
    
    /**
     * Update reseller daily/weekly/monthly report cache
     */
    public static function updateResellerReports($reseller_id, $amount) {
        try {
            $today = date('Y-m-d');
            
            // Update daily report
            $daily_report = ORM::for_table('tbl_reseller_reports')
                ->where('reseller_id', $reseller_id)
                ->where('report_type', 'daily')
                ->where('report_date', $today)
                ->find_one();
            
            if (!$daily_report) {
                $daily_report = ORM::for_table('tbl_reseller_reports')->create();
                $daily_report->reseller_id = $reseller_id;
                $daily_report->report_type = 'daily';
                $daily_report->report_date = $today;
                $daily_report->data = json_encode([
                    'revenue' => 0,
                    'transactions' => 0,
                    'customers' => 0
                ]);
            }
            
            $data = json_decode($daily_report->data, true);
            $data['revenue'] += $amount;
            $data['transactions'] += 1;
            $daily_report->data = json_encode($data);
            $daily_report->save();
            
            // Update weekly report
            $week_start = date('Y-m-d', strtotime('monday this week'));
            $weekly_report = ORM::for_table('tbl_reseller_reports')
                ->where('reseller_id', $reseller_id)
                ->where('report_type', 'weekly')
                ->where('report_date', $week_start)
                ->find_one();
            
            if (!$weekly_report) {
                $weekly_report = ORM::for_table('tbl_reseller_reports')->create();
                $weekly_report->reseller_id = $reseller_id;
                $weekly_report->report_type = 'weekly';
                $weekly_report->report_date = $week_start;
                $weekly_report->data = json_encode([
                    'revenue' => 0,
                    'transactions' => 0,
                    'customers' => 0
                ]);
            }
            
            $data = json_decode($weekly_report->data, true);
            $data['revenue'] += $amount;
            $data['transactions'] += 1;
            $weekly_report->data = json_encode($data);
            $weekly_report->save();
            
            // Update monthly report
            $month_start = date('Y-m-01');
            $monthly_report = ORM::for_table('tbl_reseller_reports')
                ->where('reseller_id', $reseller_id)
                ->where('report_type', 'monthly')
                ->where('report_date', $month_start)
                ->find_one();
            
            if (!$monthly_report) {
                $monthly_report = ORM::for_table('tbl_reseller_reports')->create();
                $monthly_report->reseller_id = $reseller_id;
                $monthly_report->report_type = 'monthly';
                $monthly_report->report_date = $month_start;
                $monthly_report->data = json_encode([
                    'revenue' => 0,
                    'transactions' => 0,
                    'customers' => 0
                ]);
            }
            
            $data = json_decode($monthly_report->data, true);
            $data['revenue'] += $amount;
            $data['transactions'] += 1;
            $monthly_report->data = json_encode($data);
            $monthly_report->save();
            
        } catch (Exception $e) {
            error_log("AutomaticPaymentSync: Report update error for reseller {$reseller_id}: " . $e->getMessage());
        }
    }
    
    /**
     * Determine reseller from customer registration
     */
    public static function determineResellerFromCustomer($customer_data) {
        // If customer is being added through reseller panel
        if (isset($_SESSION['reseller_id'])) {
            return $_SESSION['reseller_id'];
        }
        
        // If customer is being added through super admin panel
        if (isset($_SESSION['uid'])) {
            // Check if admin belongs to a reseller
            $admin = ORM::for_table('tbl_admins')->find_one($_SESSION['uid']);
            return $admin && isset($admin->reseller_id) ? $admin->reseller_id : 1;
        }
        
        // Default to super admin
        return 1;
    }
    
    /**
     * Auto-assign new customers to correct reseller
     */
    public static function assignCustomerToReseller($customer) {
        $reseller_id = self::determineResellerFromCustomer([]);
        
        $customer->reseller_id = $reseller_id;
        $customer->save();
        
        return $reseller_id;
    }
    
    /**
     * Process PPPoE user creation and assign to reseller
     */
    public static function processPPPoEPayment($transaction_data) {
        $reseller_id = self::determineResellerFromCustomer($transaction_data);
        
        // Update transaction with reseller_id
        if (isset($transaction_data['transaction_id'])) {
            $transaction = ORM::for_table('tbl_transactions')
                ->find_one($transaction_data['transaction_id']);
            
            if ($transaction) {
                $transaction->reseller_id = $reseller_id;
                $transaction->save();
                
                // Update reseller reports
                self::updateResellerReports($reseller_id, $transaction->price);
            }
        }
        
        return $reseller_id;
    }
    
    /**
     * Get reseller revenue summary
     */
    public static function getResellerRevenueSummary($reseller_id) {
        $summary = [
            'today' => 0,
            'week' => 0,
            'month' => 0,
            'total' => 0
        ];
        
        try {
            // Today
            $today_report = ORM::for_table('tbl_reseller_reports')
                ->where('reseller_id', $reseller_id)
                ->where('report_type', 'daily')
                ->where('report_date', date('Y-m-d'))
                ->find_one();
            
            if ($today_report) {
                $data = json_decode($today_report->data, true);
                $summary['today'] = $data['revenue'] ?? 0;
            }
            
            // Week
            $week_report = ORM::for_table('tbl_reseller_reports')
                ->where('reseller_id', $reseller_id)
                ->where('report_type', 'weekly')
                ->where('report_date', date('Y-m-d', strtotime('monday this week')))
                ->find_one();
            
            if ($week_report) {
                $data = json_decode($week_report->data, true);
                $summary['week'] = $data['revenue'] ?? 0;
            }
            
            // Month
            $month_report = ORM::for_table('tbl_reseller_reports')
                ->where('reseller_id', $reseller_id)
                ->where('report_type', 'monthly')
                ->where('report_date', date('Y-m-01'))
                ->find_one();
            
            if ($month_report) {
                $data = json_decode($month_report->data, true);
                $summary['month'] = $data['revenue'] ?? 0;
            }
            
            // Total
            $summary['total'] = ORM::for_table('tbl_transactions')
                ->where('reseller_id', $reseller_id)
                ->sum('price') ?: 0;
                
        } catch (Exception $e) {
            error_log("AutomaticPaymentSync: Revenue summary error for reseller {$reseller_id}: " . $e->getMessage());
        }
        
        return $summary;
    }
}