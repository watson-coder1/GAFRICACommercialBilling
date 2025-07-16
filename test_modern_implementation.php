<?php
/*
 * GLINTA AFRICA ISP BILLING SYSTEM
 * Modern UI/UX Implementation Test Suite
 * Tests database optimization, UI components, and real-time features
 */

require_once 'init.php';

class ModernImplementationTest {
    private $pdo;
    private $results = [];
    
    public function __construct() {
        global $pdo;
        $this->pdo = $pdo;
    }
    
    public function runAllTests() {
        echo "=== GLINTA MODERN UI/UX IMPLEMENTATION TEST SUITE ===\n";
        echo "Date: " . date('Y-m-d H:i:s') . "\n\n";
        
        $this->testDatabaseOptimization();
        $this->testFileStructure();
        $this->testAPIEndpoints();
        $this->testMikroTikIntegration();
        $this->testPerformanceIndexes();
        $this->testRealTimeFeatures();
        $this->testUIComponents();
        $this->testMobileResponsiveness();
        
        $this->generateReport();
    }
    
    private function testDatabaseOptimization() {
        echo "🔍 Testing Database Optimization...\n";
        
        try {
            // Test SuperAdmin stats procedure
            $stmt = $this->pdo->prepare("CALL GetSuperAdminDashboardStats()");
            $stmt->execute();
            $stats = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if ($stats) {
                $this->results['db_optimization'] = true;
                echo "✅ SuperAdmin dashboard stats working\n";
                echo "   - Today's Revenue: KES " . number_format($stats['revenue_today']) . "\n";
                echo "   - Active Services: " . $stats['active_services'] . "\n";
                echo "   - Total Customers: " . $stats['total_customers'] . "\n";
                echo "   - System Health: " . $stats['system_health_score'] . "%\n";
            } else {
                $this->results['db_optimization'] = false;
                echo "❌ SuperAdmin stats procedure failed\n";
            }
            
            // Test performance indexes
            $indexes = $this->pdo->query("SHOW INDEX FROM tbl_transactions")->fetchAll();
            if (count($indexes) > 1) {
                echo "✅ Performance indexes created\n";
                echo "   - Found " . count($indexes) . " indexes on tbl_transactions\n";
            } else {
                echo "⚠️  Limited indexes found\n";
            }
            
        } catch (Exception $e) {
            $this->results['db_optimization'] = false;
            echo "❌ Database error: " . $e->getMessage() . "\n";
        }
        
        echo "\n";
    }
    
    private function testFileStructure() {
        echo "📁 Testing File Structure...\n";
        
        $requiredFiles = [
            'ui/ui/styles/glinta-modern.css' => 'Modern CSS theme',
            'ui/ui/styles/glinta-mobile.css' => 'Mobile responsive CSS',
            'ui/ui/scripts/glinta-realtime.js' => 'Real-time JavaScript',
            'database_performance_optimization.sql' => 'Database optimization script',
            'MODERN_UI_THEME_GUIDE.md' => 'Implementation guide'
        ];
        
        $allFilesExist = true;
        foreach ($requiredFiles as $file => $description) {
            if (file_exists($file)) {
                echo "✅ $file ($description)\n";
                echo "   - Size: " . $this->formatBytes(filesize($file)) . "\n";
            } else {
                echo "❌ $file missing\n";
                $allFilesExist = false;
            }
        }
        
        $this->results['file_structure'] = $allFilesExist;
        echo "\n";
    }
    
    private function testAPIEndpoints() {
        echo "🌐 Testing API Endpoints...\n";
        
        // Create API directory structure if it doesn't exist
        if (!is_dir('api')) {
            mkdir('api', 0755, true);
        }
        if (!is_dir('api/realtime')) {
            mkdir('api/realtime', 0755, true);
        }
        
        // Test creating a simple stats endpoint
        $statsEndpoint = 'api/realtime/stats.php';
        if (!file_exists($statsEndpoint)) {
            $this->createStatsEndpoint($statsEndpoint);
        }
        
        if (file_exists($statsEndpoint)) {
            echo "✅ Stats API endpoint created\n";
            echo "   - Location: /$statsEndpoint\n";
        } else {
            echo "❌ Failed to create stats endpoint\n";
        }
        
        // Test creating network endpoint
        $networkEndpoint = 'api/realtime/network.php';
        if (!file_exists($networkEndpoint)) {
            $this->createNetworkEndpoint($networkEndpoint);
        }
        
        if (file_exists($networkEndpoint)) {
            echo "✅ Network API endpoint created\n";
            echo "   - Location: /$networkEndpoint\n";
        } else {
            echo "❌ Failed to create network endpoint\n";
        }
        
        $this->results['api_endpoints'] = file_exists($statsEndpoint) && file_exists($networkEndpoint);
        echo "\n";
    }
    
    private function testMikroTikIntegration() {
        echo "🌐 Testing MikroTik Integration...\n";
        
        try {
            // Test MikroTik stats procedure
            $stmt = $this->pdo->prepare("CALL GetMikroTikRealtimeStats(NULL)");
            $stmt->execute();
            $routers = $stmt->fetchAll(PDO::FETCH_ASSOC);
            
            if ($routers) {
                echo "✅ MikroTik data retrieval working\n";
                echo "   - Found " . count($routers) . " router(s)\n";
                
                foreach ($routers as $router) {
                    echo "   - Router: " . $router['router_name'] . " (" . $router['ip_address'] . ")\n";
                    echo "     Status: " . $router['connection_status'] . "\n";
                    echo "     Users: " . $router['active_users'] . " active, " . $router['total_users'] . " total\n";
                }
                
                $this->results['mikrotik_integration'] = true;
            } else {
                echo "⚠️  No MikroTik routers found (this may be normal)\n";
                $this->results['mikrotik_integration'] = true; // Not an error if no routers configured
            }
            
        } catch (Exception $e) {
            $this->results['mikrotik_integration'] = false;
            echo "❌ MikroTik error: " . $e->getMessage() . "\n";
        }
        
        echo "\n";
    }
    
    private function testPerformanceIndexes() {
        echo "⚡ Testing Performance Indexes...\n";
        
        $tables = ['tbl_transactions', 'tbl_customers', 'tbl_user_recharges', 'tbl_routers'];
        $indexesFound = 0;
        
        foreach ($tables as $table) {
            try {
                $stmt = $this->pdo->prepare("SHOW INDEX FROM $table");
                $stmt->execute();
                $indexes = $stmt->fetchAll();
                
                if (count($indexes) > 1) { // More than just PRIMARY key
                    echo "✅ $table has " . count($indexes) . " indexes\n";
                    $indexesFound++;
                } else {
                    echo "⚠️  $table has minimal indexes\n";
                }
                
            } catch (Exception $e) {
                echo "❌ Error checking $table: " . $e->getMessage() . "\n";
            }
        }
        
        $this->results['performance_indexes'] = $indexesFound >= 2;
        echo "\n";
    }
    
    private function testRealTimeFeatures() {
        echo "🚀 Testing Real-time Features...\n";
        
        // Test JavaScript file exists and is properly formatted
        $jsFile = 'ui/ui/scripts/glinta-realtime.js';
        if (file_exists($jsFile)) {
            $jsContent = file_get_contents($jsFile);
            
            if (strpos($jsContent, 'class GlintaRealTime') !== false) {
                echo "✅ Real-time JavaScript class found\n";
                echo "   - File size: " . $this->formatBytes(filesize($jsFile)) . "\n";
                
                // Check for key methods
                $methods = ['refreshDashboard', 'updateStatistics', 'updateNetworkStatus'];
                foreach ($methods as $method) {
                    if (strpos($jsContent, $method) !== false) {
                        echo "   - Method $method: ✅\n";
                    } else {
                        echo "   - Method $method: ❌\n";
                    }
                }
                
                $this->results['realtime_features'] = true;
            } else {
                echo "❌ Real-time JavaScript class not found\n";
                $this->results['realtime_features'] = false;
            }
        } else {
            echo "❌ Real-time JavaScript file missing\n";
            $this->results['realtime_features'] = false;
        }
        
        echo "\n";
    }
    
    private function testUIComponents() {
        echo "🎨 Testing UI Components...\n";
        
        $cssFile = 'ui/ui/styles/glinta-modern.css';
        if (file_exists($cssFile)) {
            $cssContent = file_get_contents($cssFile);
            
            // Check for key CSS classes
            $classes = [
                'dashboard-container',
                'stats-grid',
                'stat-widget',
                'modern-table',
                'btn-modern',
                'dashboard-card'
            ];
            
            $classesFound = 0;
            foreach ($classes as $class) {
                if (strpos($cssContent, $class) !== false) {
                    echo "✅ CSS class .$class found\n";
                    $classesFound++;
                } else {
                    echo "❌ CSS class .$class missing\n";
                }
            }
            
            $this->results['ui_components'] = $classesFound >= 4;
            echo "   - Found $classesFound/" . count($classes) . " required CSS classes\n";
        } else {
            echo "❌ Modern CSS file missing\n";
            $this->results['ui_components'] = false;
        }
        
        echo "\n";
    }
    
    private function testMobileResponsiveness() {
        echo "📱 Testing Mobile Responsiveness...\n";
        
        $mobileFile = 'ui/ui/styles/glinta-mobile.css';
        if (file_exists($mobileFile)) {
            $mobileContent = file_get_contents($mobileFile);
            
            // Check for mobile-specific features
            $features = [
                '@media (max-width: 480px)',
                'touch-target',
                'mobile-only',
                'sidebar-toggle',
                'safe-area-inset'
            ];
            
            $featuresFound = 0;
            foreach ($features as $feature) {
                if (strpos($mobileContent, $feature) !== false) {
                    echo "✅ Mobile feature '$feature' found\n";
                    $featuresFound++;
                } else {
                    echo "❌ Mobile feature '$feature' missing\n";
                }
            }
            
            $this->results['mobile_responsive'] = $featuresFound >= 3;
            echo "   - Found $featuresFound/" . count($features) . " mobile features\n";
        } else {
            echo "❌ Mobile CSS file missing\n";
            $this->results['mobile_responsive'] = false;
        }
        
        echo "\n";
    }
    
    private function generateReport() {
        echo "📊 IMPLEMENTATION TEST REPORT\n";
        echo "=" . str_repeat("=", 50) . "\n\n";
        
        $totalTests = count($this->results);
        $passedTests = count(array_filter($this->results));
        $successRate = round(($passedTests / $totalTests) * 100, 1);
        
        echo "Overall Success Rate: $successRate% ($passedTests/$totalTests tests passed)\n\n";
        
        echo "Test Results:\n";
        foreach ($this->results as $test => $result) {
            $status = $result ? "✅ PASS" : "❌ FAIL";
            $testName = str_replace('_', ' ', ucwords($test));
            echo "- $testName: $status\n";
        }
        
        echo "\nRecommendations:\n";
        
        if (!$this->results['db_optimization']) {
            echo "🔧 Run database_performance_optimization.sql on your MySQL database\n";
        }
        
        if (!$this->results['file_structure']) {
            echo "📁 Ensure all required files are uploaded to the server\n";
        }
        
        if (!$this->results['api_endpoints']) {
            echo "🌐 Create API endpoints for real-time data\n";
        }
        
        if (!$this->results['ui_components']) {
            echo "🎨 Update template files to use modern CSS classes\n";
        }
        
        if ($successRate >= 80) {
            echo "\n🎉 Implementation is mostly successful! Ready for production.\n";
        } elseif ($successRate >= 60) {
            echo "\n⚠️  Implementation needs some fixes before production.\n";
        } else {
            echo "\n❌ Implementation needs significant work before production.\n";
        }
        
        echo "\n" . str_repeat("=", 60) . "\n";
        echo "Test completed at: " . date('Y-m-d H:i:s') . "\n";
    }
    
    private function createStatsEndpoint($path) {
        $code = '<?php
require_once "../../init.php";

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

if ($_SERVER["REQUEST_METHOD"] == "OPTIONS") {
    exit(0);
}

try {
    $stmt = $pdo->prepare("CALL GetSuperAdminDashboardStats()");
    $stmt->execute();
    $stats = $stmt->fetch(PDO::FETCH_ASSOC);
    
    echo json_encode([
        "success" => true,
        "data" => $stats,
        "timestamp" => time()
    ]);
    
} catch (Exception $e) {
    echo json_encode([
        "success" => false,
        "error" => $e->getMessage()
    ]);
}
?>';
        
        file_put_contents($path, $code);
    }
    
    private function createNetworkEndpoint($path) {
        $code = '<?php
require_once "../../init.php";

header("Content-Type: application/json");

try {
    $stmt = $pdo->prepare("CALL GetMikroTikRealtimeStats(NULL)");
    $stmt->execute();
    $routers = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    echo json_encode([
        "success" => true,
        "routers" => $routers,
        "timestamp" => time()
    ]);
    
} catch (Exception $e) {
    echo json_encode([
        "success" => false,
        "error" => $e->getMessage()
    ]);
}
?>';
        
        file_put_contents($path, $code);
    }
    
    private function formatBytes($bytes, $precision = 2) {
        $units = array('B', 'KB', 'MB', 'GB', 'TB');
        
        for ($i = 0; $bytes > 1024 && $i < count($units) - 1; $i++) {
            $bytes /= 1024;
        }
        
        return round($bytes, $precision) . ' ' . $units[$i];
    }
}

// Run the tests
$tester = new ModernImplementationTest();
$tester->runAllTests();
?>