<?php
/**
 * Glinta Africa - Hotspot Billing System Landing Page
 * Marketing page for resellers and hotspot users
 */

session_start();
require_once 'system/vendor/autoload.php';
require_once 'init.php';

$ui = new Smarty();
$ui->assign('_title', 'Glinta Africa - Hotspot Billing Solutions');
$ui->assign('_c', $config);
$ui->assign('app_url', APP_URL);

// Check if user is already logged in
$logged_in_admin = Admin::getID();
$logged_in_customer = User::getID();

$ui->assign('logged_in_admin', $logged_in_admin);
$ui->assign('logged_in_customer', $logged_in_customer);

$ui->display('landing.tpl');
?>