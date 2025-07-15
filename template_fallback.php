<?php
global $template;
if (!isset($template) || !is_object($template)) {
    require_once __DIR__ . "/system/vendor/smarty/smarty/libs/Smarty.class.php";
    $template = new Smarty();
    $template->setTemplateDir(__DIR__ . '/ui/');
    $template->setCompileDir(__DIR__ . '/ui/compiled/');
    $template->setCacheDir(__DIR__ . '/ui/cache/');
    $template->setConfigDir(__DIR__ . '/ui/conf/');
    
    // Set some basic template variables
    $template->assign("_title", "Glinta Reseller Portal");
    $template->assign("_system_name", "Glinta Hotspot Billing");
    $template->assign("_admin", ["fullname" => "Reseller Admin"]);
}
?>