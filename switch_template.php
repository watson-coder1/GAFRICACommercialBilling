<?php
/**
 * Template Switcher for Glinta Africa Billing System
 * 
 * This script allows safe switching between original and modern templates
 * without breaking the system.
 * 
 * Usage:
 * - php switch_template.php modern   (switch to modern template)
 * - php switch_template.php original (switch to original template)
 * - php switch_template.php status   (check current template)
 */

$baseDir = __DIR__;
$templateDir = $baseDir . '/ui/ui/admin/';
$sectionsDir = $baseDir . '/ui/ui/sections/';

// Define template files
$templates = [
    'dashboard' => [
        'original' => $templateDir . 'dashboard-backup.tpl',
        'modern' => $templateDir . 'dashboard-modern.tpl',
        'active' => $templateDir . 'dashboard.tpl'
    ],
    'header' => [
        'original' => $sectionsDir . 'header.tpl',
        'modern' => $sectionsDir . 'header-modern.tpl'
    ]
];

function checkTemplateStatus($templates) {
    $dashboardContent = file_get_contents($templates['dashboard']['active']);
    
    if (strpos($dashboardContent, 'header-modern.tpl') !== false) {
        return 'modern';
    } else {
        return 'original';
    }
}

function switchToModern($templates) {
    echo "Switching to modern template...\n";
    
    // Check if required files exist
    if (!file_exists($templates['dashboard']['modern'])) {
        echo "Error: Modern dashboard template not found!\n";
        return false;
    }
    
    if (!file_exists($templates['header']['modern'])) {
        echo "Error: Modern header template not found!\n";
        return false;
    }
    
    // Check if menu-items.tpl exists
    $menuItemsFile = dirname($templates['header']['modern']) . '/menu-items.tpl';
    if (!file_exists($menuItemsFile)) {
        echo "Error: Menu items template not found at $menuItemsFile\n";
        return false;
    }
    
    // Copy modern template to active
    if (copy($templates['dashboard']['modern'], $templates['dashboard']['active'])) {
        echo "Modern template activated successfully!\n";
        return true;
    } else {
        echo "Error: Failed to activate modern template!\n";
        return false;
    }
}

function switchToOriginal($templates) {
    echo "Switching to original template...\n";
    
    // Check if backup exists
    if (!file_exists($templates['dashboard']['original'])) {
        echo "Error: Original dashboard backup not found!\n";
        return false;
    }
    
    // Copy original template to active
    if (copy($templates['dashboard']['original'], $templates['dashboard']['active'])) {
        echo "Original template activated successfully!\n";
        return true;
    } else {
        echo "Error: Failed to activate original template!\n";
        return false;
    }
}

function clearTemplateCache() {
    $cacheDir = __DIR__ . '/ui/compiled/';
    if (is_dir($cacheDir)) {
        $files = glob($cacheDir . '*');
        foreach ($files as $file) {
            if (is_file($file)) {
                unlink($file);
            }
        }
        echo "Template cache cleared successfully!\n";
    }
}

// Main execution
if ($argc < 2) {
    echo "Usage: php switch_template.php [modern|original|status]\n";
    exit(1);
}

$action = $argv[1];

switch ($action) {
    case 'modern':
        if (switchToModern($templates)) {
            clearTemplateCache();
            echo "System ready with modern template!\n";
        }
        break;
        
    case 'original':
        if (switchToOriginal($templates)) {
            clearTemplateCache();
            echo "System ready with original template!\n";
        }
        break;
        
    case 'status':
        $currentTemplate = checkTemplateStatus($templates);
        echo "Current template: $currentTemplate\n";
        
        // Check dependencies
        if ($currentTemplate === 'modern') {
            $menuItemsFile = $sectionsDir . 'menu-items.tpl';
            if (file_exists($menuItemsFile)) {
                echo "Modern template dependencies: OK\n";
            } else {
                echo "Modern template dependencies: MISSING - menu-items.tpl not found\n";
            }
        }
        break;
        
    default:
        echo "Invalid action. Use: modern, original, or status\n";
        exit(1);
}
?>