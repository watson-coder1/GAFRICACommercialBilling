<?php
/**
 * Add no-cache headers to prevent browser caching issues
 * Include this at the top of PHP files that need fresh content
 */

// Prevent caching
header("Cache-Control: no-cache, no-store, must-revalidate"); // HTTP 1.1
header("Pragma: no-cache"); // HTTP 1.0
header("Expires: 0"); // Proxies

// Security headers
header("X-Content-Type-Options: nosniff");
header("X-Frame-Options: SAMEORIGIN");
header("X-XSS-Protection: 1; mode=block");

// Optional: Add timestamp to prevent caching
if (!defined('CACHE_BUSTER')) {
    define('CACHE_BUSTER', time());
}
?>