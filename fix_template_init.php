<?php

/**
 * Fix Template Initialization
 * Creates proper Smarty template initialization for reseller system
 */

$template_fallback_content = '<?php
global $template;
if (!isset($template) || !is_object($template)) {
    require_once __DIR__ . "/system/vendor/smarty/smarty/libs/Smarty.class.php";
    $template = new Smarty();
    $template->setTemplateDir(__DIR__ . \'/ui/\');
    $template->setCompileDir(__DIR__ . \'/ui/compiled/\');
    $template->setCacheDir(__DIR__ . \'/ui/cache/\');
    $template->setConfigDir(__DIR__ . \'/ui/conf/\');
    
    // Set some basic template variables
    $template->assign("_title", "Glinta Reseller Portal");
    $template->assign("_system_name", "Glinta Hotspot Billing");
    $template->assign("_admin", ["fullname" => "Reseller Admin"]);
}
?>';

// Write the template fallback file
file_put_contents(__DIR__ . '/template_fallback.php', $template_fallback_content);

echo "✓ Created template_fallback.php with proper Smarty initialization\n";
echo "✓ This file should be copied to the Docker container at /var/www/html/template_fallback.php\n";

// Also create a reseller template directory structure check
$reseller_login_fix = '<?php

/**
 * Fixed Reseller Login Controller
 * Ensures proper template initialization before use
 */

// Ensure template is initialized
global $template;
if (!isset($template) || !is_object($template)) {
    require_once __DIR__ . "/../../template_fallback.php";
}

// Now we can safely use the template
if (isset($_POST["username"]) && isset($_POST["password"])) {
    $username = $_POST["username"];
    $password = $_POST["password"];
    
    // Authenticate user
    $auth = ResellerAuth::authenticate($username, $password);
    
    if ($auth["success"]) {
        // Set session variables
        $_SESSION["reseller_admin_id"] = $auth["admin"]["id"];
        $_SESSION["reseller_id"] = $auth["admin"]["reseller_id"];
        $_SESSION["reseller_admin_name"] = $auth["admin"]["fullname"];
        
        // Redirect to dashboard
        header("Location: " . RESELLER_URL . "/dashboard");
        exit;
    } else {
        $error = $auth["message"];
        $template->assign("error", $error);
    }
}

// Assign template variables
$template->assign("_title", "Reseller Login - Glinta Hotspot");
$template->assign("_system_name", "Glinta Hotspot Billing");
$template->assign("login_url", RESELLER_URL . "/login");

// Check if reseller template exists, otherwise use default
$reseller_template = __DIR__ . "/../../ui/reseller/login.tpl";
if (file_exists($reseller_template)) {
    $template->display($reseller_template);
} else {
    // Fall back to admin login template with modifications
    $template->assign("_title", "Reseller Login");
    $template->assign("_admin", ["fullname" => "Reseller Portal"]);
    $template->display("admin/admin/login.tpl");
}

?>';

file_put_contents(__DIR__ . '/system/controllers/reseller_login_fixed.php', $reseller_login_fix);

echo "✓ Created fixed reseller_login_fixed.php controller\n";
echo "✓ This should replace the problematic reseller_login.php\n";

echo "\n=== DOCKER COMMANDS TO RUN ===\n";
echo "# Copy template fallback to container:\n";
echo "docker cp template_fallback.php glinta-web:/var/www/html/template_fallback.php\n";
echo "\n# Replace the broken reseller_login.php:\n";
echo "docker cp system/controllers/reseller_login_fixed.php glinta-web:/var/www/html/system/controllers/reseller_login.php\n";
echo "\n# Test the reseller login:\n";
echo "curl https://glintaafrica.com/reseller.php\n";

?>