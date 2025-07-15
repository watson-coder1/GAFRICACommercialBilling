<?php

/**
 * Reseller Invoice Payment Callback Handler
 * Handles M-Pesa STK push callbacks for reseller monthly invoices
 */

require_once 'init.php';

// Get the JSON payload
$input = file_get_contents('php://input');
$data = json_decode($input, true);

// Log the callback
_log('Reseller Invoice Callback received: ' . $input, 'Reseller', 1);

try {
    if (isset($data['Body']['stkCallback'])) {
        $callback = $data['Body']['stkCallback'];
        $checkoutRequestId = $callback['CheckoutRequestID'];
        $resultCode = $callback['ResultCode'];
        $resultDesc = $callback['ResultDesc'];
        
        // Find the invoice by STK push ID
        $invoice = ORM::for_table('tbl_reseller_invoices')
            ->where('stk_push_id', $checkoutRequestId)
            ->find_one();
        
        if (!$invoice) {
            _log('Reseller Invoice: STK push ID not found - ' . $checkoutRequestId, 'Reseller', 1);
            http_response_code(404);
            echo json_encode(['error' => 'Invoice not found']);
            exit;
        }
        
        $reseller = ORM::for_table('tbl_resellers')->find_one($invoice->reseller_id);
        
        if ($resultCode == 0) {
            // Payment successful
            $callbackMetadata = $callback['CallbackMetadata']['Item'];
            $transactionId = '';
            $phoneNumber = '';
            $amount = 0;
            
            foreach ($callbackMetadata as $item) {
                switch ($item['Name']) {
                    case 'MpesaReceiptNumber':
                        $transactionId = $item['Value'];
                        break;
                    case 'PhoneNumber':
                        $phoneNumber = $item['Value'];
                        break;
                    case 'Amount':
                        $amount = $item['Value'];
                        break;
                }
            }
            
            // Update invoice
            $invoice->status = 'paid';
            $invoice->paid_at = date('Y-m-d H:i:s');
            $invoice->payment_reference = $transactionId;
            $invoice->save();
            
            // Extend reseller subscription
            $currentExpiry = strtotime($reseller->expires_at);
            $now = time();
            
            // If expired, start from today, otherwise extend from current expiry
            $startDate = ($currentExpiry < $now) ? $now : $currentExpiry;
            $newExpiry = strtotime('+1 month', $startDate);
            
            $reseller->expires_at = date('Y-m-d H:i:s', $newExpiry);
            $reseller->subscription_status = 'active';
            $reseller->last_payment_date = date('Y-m-d H:i:s');
            $reseller->next_payment_due = date('Y-m-d', $newExpiry);
            $reseller->save();
            
            // Create subscription payment record
            $payment = ORM::for_table('tbl_reseller_subscription_payments')->create();
            $payment->reseller_id = $invoice->reseller_id;
            $payment->amount = $amount;
            $payment->payment_date = date('Y-m-d H:i:s');
            $payment->payment_method = 'M-Pesa';
            $payment->transaction_reference = $transactionId;
            $payment->subscription_period = 'monthly';
            $payment->extends_to = date('Y-m-d', $newExpiry);
            $payment->status = 'completed';
            $payment->invoice_id = $invoice->id;
            $payment->save();
            
            // Log the payment
            _log('Reseller ' . $reseller->name . ' monthly invoice paid: KSh ' . number_format($amount, 2) . ' - ' . $transactionId, 'Reseller', $reseller->id);
            
            echo json_encode([
                'success' => true,
                'message' => 'Payment processed successfully',
                'invoice_id' => $invoice->id,
                'transaction_id' => $transactionId,
                'new_expiry' => date('Y-m-d', $newExpiry)
            ]);
            
        } else {
            // Payment failed
            $invoice->status = 'failed';
            $invoice->error_message = $resultDesc;
            $invoice->save();
            
            _log('Reseller ' . $reseller->name . ' monthly invoice payment failed: ' . $resultDesc, 'Reseller', $reseller->id);
            
            echo json_encode([
                'success' => false,
                'message' => 'Payment failed: ' . $resultDesc,
                'invoice_id' => $invoice->id
            ]);
        }
        
    } else {
        _log('Reseller Invoice: Invalid callback format', 'Reseller', 1);
        http_response_code(400);
        echo json_encode(['error' => 'Invalid callback format']);
    }
    
} catch (Exception $e) {
    _log('Reseller Invoice Callback Error: ' . $e->getMessage(), 'Reseller', 1);
    http_response_code(500);
    echo json_encode(['error' => 'Internal server error']);
}

?>