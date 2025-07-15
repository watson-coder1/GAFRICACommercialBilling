<?php

/**
 * Setup Reseller Auto Invoice Cron Job
 * Creates a cron job to automatically process monthly reseller invoices
 */

echo "=== RESELLER AUTO INVOICE CRON SETUP ===\n";

$cronCommand = "0 0 25 * * cd /opt/glinta-hotspot/app && php reseller_auto_invoice.php >> /var/log/reseller_invoices.log 2>&1";

echo "Suggested cron job command:\n";
echo "$cronCommand\n\n";

echo "This will run on the 25th of each month at midnight.\n";
echo "It will:\n";
echo "• Check all active resellers expiring in 3 days\n";
echo "• Calculate 0.5% commission on monthly revenue\n";
echo "• Send STK push for payment\n";
echo "• Log all activities\n\n";

echo "To install this cron job:\n";
echo "1. Run: crontab -e\n";
echo "2. Add the above line to the crontab\n";
echo "3. Save and exit\n\n";

echo "Alternative: Run manually with:\n";
echo "php reseller_auto_invoice.php\n\n";

// Create log file
$logFile = '/var/log/reseller_invoices.log';
if (!file_exists($logFile)) {
    touch($logFile);
    chmod($logFile, 0644);
    echo "Created log file: $logFile\n";
}

// Create a simple manual runner script
file_put_contents('run_reseller_invoices.sh', "#!/bin/bash\ncd /opt/glinta-hotspot/app\nphp reseller_auto_invoice.php\n");
chmod('run_reseller_invoices.sh', 0755);

echo "Created manual runner script: run_reseller_invoices.sh\n";
echo "You can run it with: ./run_reseller_invoices.sh\n\n";

echo "=== SETUP COMPLETE ===\n";

?>