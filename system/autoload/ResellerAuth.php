<?php

/**
 * Reseller Authentication and Subscription Check
 * Ensures resellers have active subscriptions before accessing the system
 */
class ResellerAuth
{
    /**
     * Check if reseller subscription is active
     */
    public static function checkSubscription($reseller_id)
    {
        if ($reseller_id == 1) {
            // Super admin always has access
            return ['active' => true, 'status' => 'super_admin'];
        }
        
        $reseller = ORM::for_table('tbl_resellers')
            ->where('id', $reseller_id)
            ->find_one();
        
        if (!$reseller) {
            return ['active' => false, 'status' => 'not_found'];
        }
        
        // Check subscription status
        $status = $reseller->subscription_status;
        $expires = strtotime($reseller->expires_at);
        $now = time();
        
        switch ($status) {
            case 'active':
                if ($expires < $now) {
                    // Expired, check grace period
                    $graceDays = $reseller->grace_days ?: 3;
                    $graceEnd = $expires + ($graceDays * 86400);
                    
                    if ($now <= $graceEnd) {
                        // Update to grace period
                        $reseller->subscription_status = 'grace_period';
                        $reseller->save();
                        
                        return [
                            'active' => true,
                            'status' => 'grace_period',
                            'message' => 'Your subscription expired. You have ' . 
                                       ceil(($graceEnd - $now) / 86400) . 
                                       ' days grace period to renew.',
                            'days_left' => ceil(($graceEnd - $now) / 86400)
                        ];
                    } else {
                        // Past grace period, suspend
                        $reseller->subscription_status = 'suspended';
                        $reseller->save();
                        
                        return [
                            'active' => false,
                            'status' => 'suspended',
                            'message' => 'Your subscription has been suspended. Please renew to continue.'
                        ];
                    }
                }
                
                // Active and not expired
                return [
                    'active' => true,
                    'status' => 'active',
                    'expires_in' => ceil(($expires - $now) / 86400)
                ];
                
            case 'trial':
                if ($expires < $now) {
                    $reseller->subscription_status = 'expired';
                    $reseller->save();
                    
                    return [
                        'active' => false,
                        'status' => 'trial_expired',
                        'message' => 'Your trial period has ended. Please subscribe to continue.'
                    ];
                }
                
                return [
                    'active' => true,
                    'status' => 'trial',
                    'expires_in' => ceil(($expires - $now) / 86400)
                ];
                
            case 'grace_period':
                $graceDays = $reseller->grace_days ?: 3;
                $graceEnd = $expires + ($graceDays * 86400);
                
                if ($now > $graceEnd) {
                    $reseller->subscription_status = 'suspended';
                    $reseller->save();
                    
                    return [
                        'active' => false,
                        'status' => 'suspended',
                        'message' => 'Grace period ended. Your account is suspended.'
                    ];
                }
                
                return [
                    'active' => true,
                    'status' => 'grace_period',
                    'message' => 'Grace period: ' . ceil(($graceEnd - $now) / 86400) . ' days left to renew.',
                    'days_left' => ceil(($graceEnd - $now) / 86400)
                ];
                
            case 'suspended':
            case 'expired':
                return [
                    'active' => false,
                    'status' => $status,
                    'message' => 'Your subscription is ' . $status . '. Please renew to continue.'
                ];
                
            default:
                return [
                    'active' => false,
                    'status' => 'unknown',
                    'message' => 'Invalid subscription status.'
                ];
        }
    }
    
    /**
     * Middleware to check subscription on each request
     */
    public static function enforceSubscription()
    {
        global $routes, $ui;
        
        // Skip check for certain pages
        $skipPages = ['login', 'logout', 'register', 'subscription', 'payment'];
        if (in_array($routes['0'], $skipPages)) {
            return true;
        }
        
        // Get current admin user
        $admin = _admin(false);
        if (!$admin) {
            return true; // Let normal auth handle this
        }
        
        // Check if admin is associated with a reseller
        $reseller_id = $admin['reseller_id'] ?? 1;
        
        $check = self::checkSubscription($reseller_id);
        
        if (!$check['active']) {
            // Redirect to subscription page
            $_SESSION['subscription_error'] = $check['message'];
            r2(U . 'subscription/renew', 'e', $check['message']);
            exit;
        }
        
        // Show warning for grace period
        if ($check['status'] == 'grace_period') {
            $ui->assign('subscription_warning', $check['message']);
        }
        
        // Show reminder for expiring soon
        if ($check['status'] == 'active' && isset($check['expires_in']) && $check['expires_in'] <= 7) {
            $ui->assign('subscription_reminder', 
                'Your subscription expires in ' . $check['expires_in'] . ' days. Please renew soon.');
        }
        
        return true;
    }
    
    /**
     * Process reseller subscription payment
     */
    public static function processSubscriptionPayment($reseller_id, $amount, $period, $reference)
    {
        try {
            // Record payment
            $payment = ORM::for_table('tbl_reseller_subscription_payments')->create();
            $payment->reseller_id = $reseller_id;
            $payment->amount = $amount;
            $payment->payment_date = date('Y-m-d H:i:s');
            $payment->payment_method = 'M-Pesa';
            $payment->transaction_reference = $reference;
            $payment->subscription_period = $period;
            $payment->status = 'completed';
            
            // Calculate new expiry date
            $reseller = ORM::for_table('tbl_resellers')->find_one($reseller_id);
            $currentExpiry = strtotime($reseller->expires_at);
            $now = time();
            
            // If expired, start from today, otherwise extend from current expiry
            $startDate = ($currentExpiry < $now) ? $now : $currentExpiry;
            
            switch ($period) {
                case 'monthly':
                    $newExpiry = strtotime('+1 month', $startDate);
                    break;
                case 'quarterly':
                    $newExpiry = strtotime('+3 months', $startDate);
                    break;
                case 'yearly':
                    $newExpiry = strtotime('+1 year', $startDate);
                    break;
                default:
                    $newExpiry = strtotime('+1 month', $startDate);
            }
            
            $payment->extends_to = date('Y-m-d', $newExpiry);
            $payment->save();
            
            // Update reseller
            $reseller->expires_at = date('Y-m-d H:i:s', $newExpiry);
            $reseller->subscription_status = 'active';
            $reseller->last_payment_date = date('Y-m-d H:i:s');
            $reseller->next_payment_due = date('Y-m-d', $newExpiry);
            $reseller->save();
            
            // Log the payment
            _log('Reseller ' . $reseller->name . ' subscription payment: ' . $amount . ' for ' . $period, 'Reseller', 1);
            
            return [
                'success' => true,
                'new_expiry' => date('Y-m-d', $newExpiry),
                'message' => 'Subscription renewed successfully until ' . date('Y-m-d', $newExpiry)
            ];
            
        } catch (Exception $e) {
            return [
                'success' => false,
                'message' => 'Payment processing failed: ' . $e->getMessage()
            ];
        }
    }
}