<?php
/**
 * Remove fake test data while preserving real customer data
 */

require_once 'config.php';
require_once 'system/orm.php';

echo "=== Remove Fake Test Data ===\n\n";

// Check what data exists first
echo "BEFORE CLEANUP:\n";
$total_customers = ORM::for_table('tbl_customers')->count();
$total_transactions = ORM::for_table('tbl_transactions')->count();
$total_recharges = ORM::for_table('tbl_user_recharges')->count();
$total_revenue = ORM::for_table('tbl_transactions')->sum('price');

echo "Customers: $total_customers\n";
echo "Transactions: $total_transactions\n";
echo "User Recharges: $total_recharges\n";
echo "Total Revenue: KES " . number_format($total_revenue, 2) . "\n";

echo "\nFinding fake test data...\n\n";

// Find and remove fake test customers (testcustomer1, testcustomer2, etc.)
$fake_customers = ORM::for_table('tbl_customers')
    ->where_like('username', 'testcustomer%')
    ->find_many();

echo "Found " . count($fake_customers) . " fake test customers:\n";
foreach ($fake_customers as $customer) {
    echo "- {$customer->username} ({$customer->fullname})\n";
}

// Find and remove fake test transactions
$fake_transactions = ORM::for_table('tbl_transactions')
    ->where_like('username', 'testcustomer%')
    ->find_many();

$fake_revenue = 0;
echo "\nFound " . count($fake_transactions) . " fake test transactions:\n";
foreach ($fake_transactions as $transaction) {
    echo "- {$transaction->username}: {$transaction->plan_name} - KES {$transaction->price}\n";
    $fake_revenue += $transaction->price;
}
echo "Total fake revenue: KES " . number_format($fake_revenue, 2) . "\n";

// Find and remove fake test user recharges
$fake_recharges = ORM::for_table('tbl_user_recharges')
    ->where_like('username', 'testcustomer%')
    ->find_many();

echo "\nFound " . count($fake_recharges) . " fake test recharges:\n";
foreach ($fake_recharges as $recharge) {
    echo "- {$recharge->username}: {$recharge->namebp}\n";
}

// Confirm before deletion
echo "\n" . str_repeat("=", 50) . "\n";
echo "READY TO DELETE:\n";
echo "- " . count($fake_customers) . " fake customers\n";
echo "- " . count($fake_transactions) . " fake transactions (KES " . number_format($fake_revenue, 2) . ")\n";
echo "- " . count($fake_recharges) . " fake user recharges\n";
echo "\nThis will clean up your dashboard statistics.\n";
echo str_repeat("=", 50) . "\n\n";

// Delete fake data
echo "Deleting fake test customers...\n";
foreach ($fake_customers as $customer) {
    echo "Deleted customer: {$customer->username}\n";
    $customer->delete();
}

echo "\nDeleting fake test transactions...\n";
foreach ($fake_transactions as $transaction) {
    echo "Deleted transaction: {$transaction->username} - KES {$transaction->price}\n";
    $transaction->delete();
}

echo "\nDeleting fake test recharges...\n";
foreach ($fake_recharges as $recharge) {
    echo "Deleted recharge: {$recharge->username}\n";
    $recharge->delete();
}

// Clean up any Test Package plans that might be fake
$fake_plans = ORM::for_table('tbl_plans')
    ->where_like('name_plan', 'Test Package%')
    ->find_many();

if (count($fake_plans) > 0) {
    echo "\nFound " . count($fake_plans) . " fake test plans:\n";
    foreach ($fake_plans as $plan) {
        echo "Deleted plan: {$plan->name_plan}\n";
        $plan->delete();
    }
}

echo "\nAFTER CLEANUP:\n";
$new_customers = ORM::for_table('tbl_customers')->count();
$new_transactions = ORM::for_table('tbl_transactions')->count();
$new_recharges = ORM::for_table('tbl_user_recharges')->count();
$new_revenue = ORM::for_table('tbl_transactions')->sum('price');

echo "Customers: $new_customers (was $total_customers)\n";
echo "Transactions: $new_transactions (was $total_transactions)\n";
echo "User Recharges: $new_recharges (was $total_recharges)\n";
echo "Total Revenue: KES " . number_format($new_revenue, 2) . " (was KES " . number_format($total_revenue, 2) . ")\n";

echo "\n✅ Cleanup Complete!\n";
echo "Removed KES " . number_format($fake_revenue, 2) . " in fake revenue.\n";
echo "Your dashboard should now show only real customer data.\n";
?>