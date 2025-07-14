<?php

/**
 * M-Pesa Integration Class
 * Handles M-Pesa STK Push and callback processing
 */

class MpesaIntegration
{
    private $consumerKey;
    private $consumerSecret;
    private $passkey;
    private $shortcode;
    private $environment;
    private $callbackUrl;
    
    public function __construct()
    {
        global $_c;
        
        // Load configuration from database
        $this->consumerKey = $_c['mpesa_consumer_key'] ?? '';
        $this->consumerSecret = $_c['mpesa_consumer_secret'] ?? '';
        $this->passkey = $_c['mpesa_passkey'] ?? '';
        $this->shortcode = $_c['mpesa_shortcode'] ?? '';
        $this->environment = $_c['mpesa_environment'] ?? 'sandbox';
        $this->callbackUrl = $_c['mpesa_callback_url'] ?? ($_c['app_url'] . '/portal/callback');
    }
    
    /**
     * Get access token for M-Pesa API
     */
    private function getAccessToken()
    {
        if (empty($this->consumerKey) || empty($this->consumerSecret)) {
            return false;
        }
        
        $url = $this->environment == 'live' 
            ? 'https://api.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials'
            : 'https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials';
        
        $credentials = base64_encode($this->consumerKey . ':' . $this->consumerSecret);
        
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_HTTPHEADER, ['Authorization: Basic ' . $credentials]);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, true);
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 2);
        
        $response = curl_exec($curl);
        $httpCode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
        curl_close($curl);
        
        if ($httpCode == 200) {
            $data = json_decode($response, true);
            return $data['access_token'] ?? false;
        }
        
        return false;
    }
    
    /**
     * Generate password for STK Push
     */
    private function generatePassword()
    {
        $timestamp = date('YmdHis');
        $password = base64_encode($this->shortcode . $this->passkey . $timestamp);
        return ['password' => $password, 'timestamp' => $timestamp];
    }
    
    /**
     * Initiate STK Push
     */
    public function initiateSTKPush($phoneNumber, $amount, $sessionId, $description = 'Hotspot Package')
    {
        if (empty($this->consumerKey)) {
            return [
                'success' => false,
                'message' => 'M-Pesa configuration not set up yet. Please contact administrator.'
            ];
        }
        
        $accessToken = $this->getAccessToken();
        if (!$accessToken) {
            return [
                'success' => false,
                'message' => 'Failed to get M-Pesa access token'
            ];
        }
        
        $url = $this->environment == 'live'
            ? 'https://api.safaricom.co.ke/mpesa/stkpush/v1/processrequest'
            : 'https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest';
        
        $passwordData = $this->generatePassword();
        
        // Ensure amount is a whole number for Mpesa API
        $amount = (int) round((float) $amount);
        
        $payload = [
            'BusinessShortCode' => $this->shortcode,
            'Password' => $passwordData['password'],
            'Timestamp' => $passwordData['timestamp'],
            'TransactionType' => 'CustomerPayBillOnline',
            'Amount' => $amount,
            'PartyA' => $phoneNumber,
            'PartyB' => $this->shortcode,
            'PhoneNumber' => $phoneNumber,
            'CallBackURL' => $this->callbackUrl,
            'AccountReference' => 'Glinta Africa',
            'TransactionDesc' => $description
        ];
        
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_HTTPHEADER, [
            'Authorization: Bearer ' . $accessToken,
            'Content-Type: application/json'
        ]);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($payload));
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, true);
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 2);
        
        $response = curl_exec($curl);
        $httpCode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
        curl_close($curl);
        
        $data = json_decode($response, true);
        
        if ($httpCode == 200 && isset($data['CheckoutRequestID'])) {
            // Store transaction reference
            $transaction = ORM::for_table('tbl_mpesa_transactions')
                ->where('session_id', $sessionId)
                ->find_one();
                
            if ($transaction) {
                $transaction->transaction_id = $data['CheckoutRequestID'];
                $transaction->save();
            }
            
            return [
                'success' => true,
                'checkout_request_id' => $data['CheckoutRequestID'],
                'message' => 'STK Push sent successfully'
            ];
        }
        
        return [
            'success' => false,
            'message' => $data['errorMessage'] ?? 'STK Push failed'
        ];
    }
    
    /**
     * Process M-Pesa callback
     */
    public function processCallback($callbackData)
    {
        if (!isset($callbackData['Body']['stkCallback'])) {
            return false;
        }
        
        $callback = $callbackData['Body']['stkCallback'];
        $checkoutRequestId = $callback['CheckoutRequestID'];
        $resultCode = $callback['ResultCode'];
        
        // Find transaction
        $transaction = ORM::for_table('tbl_mpesa_transactions')
            ->where('transaction_id', $checkoutRequestId)
            ->find_one();
            
        if (!$transaction) {
            return false;
        }
        
        $transaction->callback_response = json_encode($callbackData);
        
        if ($resultCode == 0) {
            // Payment successful
            $transaction->status = 'completed';
            
            // Extract M-Pesa receipt number
            if (isset($callback['CallbackMetadata']['Item'])) {
                foreach ($callback['CallbackMetadata']['Item'] as $item) {
                    if ($item['Name'] == 'MpesaReceiptNumber') {
                        $transaction->mpesa_receipt_number = $item['Value'];
                        break;
                    }
                }
            }
            
            // Update session
            $session = ORM::for_table('tbl_portal_sessions')
                ->where('session_id', $transaction->session_id)
                ->find_one();
                
            if ($session) {
                $session->payment_status = 'completed';
                
                // Get package duration
                $package = ORM::for_table('tbl_hotspot_packages')
                    ->where('id', $session->package_id)
                    ->find_one();
                    
                if ($package) {
                    $session->expires_at = date('Y-m-d H:i:s', 
                        strtotime('+' . $package->duration_hours . ' hours'));
                }
                
                $session->save();
                
                // Create MikroTik user (placeholder)
                $this->createMikroTikUser($session, $package);
            }
        } else {
            // Payment failed
            $transaction->status = 'failed';
            
            $session = ORM::for_table('tbl_portal_sessions')
                ->where('session_id', $transaction->session_id)
                ->find_one();
                
            if ($session) {
                $session->payment_status = 'failed';
                $session->save();
            }
        }
        
        $transaction->save();
        return true;
    }
    
    /**
     * Create MikroTik hotspot user after successful payment
     */
    private function createMikroTikUser($session, $package)
    {
        try {
            // Create unique username
            $username = 'hs_' . substr(str_replace(':', '', $session->mac_address), -6) . '_' . time();
            $password = substr(md5($username . time()), 0, 8);
            
            // Get router information
            $router = ORM::for_table('tbl_routers')
                ->where('enabled', 1)
                ->find_one();
                
            if (!$router) {
                file_put_contents('system/uploads/hotspot_users.log', 
                    date('Y-m-d H:i:s') . ' - ERROR: No enabled router found' . PHP_EOL, FILE_APPEND);
                return false;
            }
            
            // Load MikroTik device handler
            require_once 'system/devices/MikrotikHotspot.php';
            $device = new MikrotikHotspot();
            
            // Create customer and plan data compatible with existing MikroTik class
            $customer = [
                'username' => $username,
                'password' => $password,
                'mac_address' => $session->mac_address,
                'fullname' => 'Hotspot User ' . substr($session->phone_number, -4),
                'email' => 'user@glintaafrica.com',
                'id' => 0
            ];
            
            $plan = [
                'name_plan' => $package->name,
                'typebp' => 'Limited',
                'limit_type' => 'Time_Limit',
                'time_limit' => $package->duration_hours,
                'time_unit' => 'Hrs',
                'shared_users' => 1,
                'routers' => $router->id
            ];
            
            // Add user to MikroTik hotspot
            $device->add_customer($customer, $plan);
            
            // Store MikroTik user in session
            $session->mikrotik_user = $username;
            $session->save();
            
            // IMPORTANT: Automatically login the user to hotspot
            try {
                // Get client IP from session
                $clientIP = $session->ip_address;
                
                // Auto-login user to MikroTik hotspot
                $device->connect_customer($customer, $clientIP, $session->mac_address, $router->id);
                
                file_put_contents('system/uploads/hotspot_users.log', 
                    date('Y-m-d H:i:s') . ' - AUTO-LOGIN: User ' . $username . ' logged in automatically' . PHP_EOL, FILE_APPEND);
                    
            } catch (Exception $e) {
                file_put_contents('system/uploads/hotspot_users.log', 
                    date('Y-m-d H:i:s') . ' - AUTO-LOGIN ERROR: ' . $e->getMessage() . PHP_EOL, FILE_APPEND);
            }
            
            // Log success
            file_put_contents('system/uploads/hotspot_users.log', 
                date('Y-m-d H:i:s') . ' - Created user: ' . $username . ' for MAC: ' . $session->mac_address . ' - Package: ' . $package->name . PHP_EOL, FILE_APPEND);
                
            return true;
            
        } catch (Exception $e) {
            // Log error
            file_put_contents('system/uploads/hotspot_users.log', 
                date('Y-m-d H:i:s') . ' - ERROR: ' . $e->getMessage() . PHP_EOL, FILE_APPEND);
            return false;
        }
    }
    
    /**
     * Check if M-Pesa is configured
     */
    public function isConfigured()
    {
        return !empty($this->consumerKey) && 
               !empty($this->consumerSecret) && 
               !empty($this->passkey) && 
               !empty($this->shortcode);
    }
}