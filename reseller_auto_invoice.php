<?php

/**
 * Reseller Auto Invoice System
 * Automatically generates and sends STK push for reseller monthly invoices
 * Based on 0.5% of all transactions
 */

require_once 'init.php';

// Get all active resellers
$resellers = ORM::for_table('tbl_resellers')
    ->where('subscription_status', 'active')
    ->where_lt('expires_at', date('Y-m-d', strtotime('+3 days'))) // 3 days before expiry
    ->find_many();

$processed = 0;
$errors = 0;

foreach ($resellers as $reseller) {
    try {
        // Calculate monthly revenue for commission
        $monthlyRevenue = ORM::for_table('tbl_transactions')
            ->where('reseller_id', $reseller->id)
            ->where_gte('recharged_on', date('Y-m-01'))
            ->sum('price') ?: 0;
        
        $commission = $monthlyRevenue * 0.005; // 0.5%
        $minimumPayment = 100; // Minimum payment in KSh
        $invoiceAmount = max($commission, $minimumPayment);
        
        // Skip if no revenue and already notified
        if ($invoiceAmount <= $minimumPayment && $reseller->low_revenue_notified) {
            continue;
        }
        
        // Get reseller admin phone
        $admin = ORM::for_table('tbl_reseller_admins')
            ->where('reseller_id', $reseller->id)
            ->where('status', 'active')
            ->find_one();
        
        if (!$admin || empty($admin->phone)) {
            echo "Skipping reseller {$reseller->name} - No admin phone found\n";
            continue;
        }
        
        // Format phone number
        $phone = preg_replace('/[^0-9]/', '', $admin->phone);
        if (substr($phone, 0, 1) === '0') {
            $phone = '254' . substr($phone, 1);
        } elseif (substr($phone, 0, 3) !== '254') {
            $phone = '254' . $phone;
        }
        
        // Create invoice record
        $invoice = ORM::for_table('tbl_reseller_invoices')->create();
        $invoice->reseller_id = $reseller->id;
        $invoice->invoice_number = 'INV-' . $reseller->id . '-' . date('Ym');
        $invoice->monthly_revenue = $monthlyRevenue;
        $invoice->commission_rate = 0.005;
        $invoice->commission_amount = $commission;
        $invoice->minimum_payment = $minimumPayment;
        $invoice->invoice_amount = $invoiceAmount;
        $invoice->invoice_date = date('Y-m-d');
        $invoice->due_date = date('Y-m-d', strtotime('+7 days'));
        $invoice->status = 'pending';
        $invoice->created_at = date('Y-m-d H:i:s');
        $invoice->save();
        
        // Send STK Push
        require_once 'system/paymentgateway/mpesa.php';
        
        $mpesa = new MpesaGateway();
        $reference = 'RESELLER_INV_' . $reseller->id . '_' . date('Ym');
        
        $stkResult = $mpesa->stkpush([
            'amount' => ceil($invoiceAmount),
            'phone' => $phone,
            'description' => 'Monthly Reseller Invoice - ' . date('M Y'),
            'callback_url' => $config['web_url'] . '/callback/reseller_invoice',
            'reference' => $reference
        ]);
        
        if ($stkResult['success']) {
            // Update invoice with STK details
            $invoice->stk_push_id = $stkResult['CheckoutRequestID'];
            $invoice->phone_number = $phone;
            $invoice->stk_sent_at = date('Y-m-d H:i:s');
            $invoice->save();
            
            // Update reseller
            $reseller->last_invoice_sent = date('Y-m-d H:i:s');
            $reseller->save();
            
            // Log the action
            _log('Monthly invoice STK push sent to ' . $reseller->name . ' - KSh ' . number_format($invoiceAmount, 2), 'Reseller', $reseller->id);
            
            echo "✓ Invoice STK push sent to {$reseller->name} - KSh " . number_format($invoiceAmount, 2) . "\n";
            $processed++;
            
        } else {
            $invoice->status = 'failed';
            $invoice->error_message = $stkResult['message'];
            $invoice->save();
            
            echo "✗ Failed to send STK push to {$reseller->name}: {$stkResult['message']}\n";
            $errors++;
        }
        
        // Send email notification as backup
        if (!empty($admin->email)) {
            $emailSubject = "Monthly Reseller Invoice - " . date('M Y');
            $emailBody = "
                <h2>Monthly Reseller Invoice</h2>
                <p>Dear {$admin->fullname},</p>
                <p>Your monthly reseller invoice is ready:</p>
                <ul>
                    <li>Invoice Number: {$invoice->invoice_number}</li>
                    <li>Monthly Revenue: KSh " . number_format($monthlyRevenue, 2) . "</li>
                    <li>Commission (0.5%): KSh " . number_format($commission, 2) . "</li>
                    <li>Invoice Amount: KSh " . number_format($invoiceAmount, 2) . "</li>
                    <li>Due Date: " . date('M d, Y', strtotime($invoice->due_date)) . "</li>
                </ul>
                <p>An STK push has been sent to your registered phone number ({$phone}).</p>
                <p>Please complete the payment to continue your reseller services.</p>
                <p>Best regards,<br>Glinta Africa Team</p>
            ";
            
            // Send email (implement your email sending logic)
            // mail($admin->email, $emailSubject, $emailBody);
        }
        
    } catch (Exception $e) {
        echo "Error processing reseller {$reseller->name}: " . $e->getMessage() . "\n";
        $errors++;
    }
}

echo "\n=== RESELLER AUTO INVOICE SUMMARY ===\n";
echo "Processed: $processed\n";
echo "Errors: $errors\n";
echo "Total Resellers Checked: " . count($resellers) . "\n";
echo "Timestamp: " . date('Y-m-d H:i:s') . "\n";

// Create reseller invoices table if it doesn't exist
try {
    $createTable = "
    CREATE TABLE IF NOT EXISTS `tbl_reseller_invoices` (
        `id` int(11) NOT NULL AUTO_INCREMENT,
        `reseller_id` int(11) NOT NULL,
        `invoice_number` varchar(50) NOT NULL,
        `monthly_revenue` decimal(10,2) DEFAULT '0.00',
        `commission_rate` decimal(5,4) DEFAULT '0.0050',
        `commission_amount` decimal(10,2) DEFAULT '0.00',
        `minimum_payment` decimal(10,2) DEFAULT '100.00',
        `invoice_amount` decimal(10,2) NOT NULL,
        `invoice_date` date NOT NULL,
        `due_date` date NOT NULL,
        `status` enum('pending','paid','failed','cancelled') DEFAULT 'pending',
        `stk_push_id` varchar(100) DEFAULT NULL,
        `phone_number` varchar(20) DEFAULT NULL,
        `stk_sent_at` datetime DEFAULT NULL,
        `paid_at` datetime DEFAULT NULL,
        `payment_reference` varchar(100) DEFAULT NULL,
        `error_message` text,
        `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
        `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (`id`),
        KEY `reseller_id` (`reseller_id`),
        KEY `invoice_number` (`invoice_number`),
        KEY `status` (`status`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ";
    
    ORM::get_db()->exec($createTable);
} catch (Exception $e) {
    echo "Note: Could not create invoices table (may already exist): " . $e->getMessage() . "\n";
}

?>