<?php
// Template Fallback - Ensures Smarty is always available
global $template;

if (!isset($template) || !is_object($template)) {
    // Include required files
    require_once __DIR__ . "/system/vendor/smarty/smarty/libs/Smarty.class.php";
    
    // Create new Smarty instance
    $template = new Smarty();
    
    // Set template directories
    $template->setTemplateDir(__DIR__ . '/ui/');
    $template->setCompileDir(__DIR__ . '/ui/compiled/');
    $template->setCacheDir(__DIR__ . '/ui/cache/');
    $template->setConfigDir(__DIR__ . '/ui/conf/');
    
    // Set basic template variables
    $template->assign("_title", "Glinta Reseller Portal");
    $template->assign("_system_name", "Glinta Hotspot Billing");
    $template->assign("_admin", ["fullname" => "Reseller Admin"]);
    
    // Debug: Confirm template is created
    if (defined('DEBUG_TEMPLATE')) {
        echo "Template object created successfully<br>";
    }
}

// Make sure $ui is also available for compatibility
if (!isset($ui)) {
    $ui = $template;
}
?>