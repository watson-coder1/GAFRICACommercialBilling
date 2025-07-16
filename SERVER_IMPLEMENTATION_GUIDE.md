# Server Implementation Guide for Modern UI/UX & Database Optimization

## Overview
This guide provides step-by-step instructions for implementing the modern UI/UX theme and database optimizations on your Digital Ocean server.

## Prerequisites
- SSH access to your Digital Ocean server
- Root or sudo privileges
- Existing Glinta billing system running
- MySQL database access

## Step 1: Backup Current System

```bash
# SSH to your server
ssh root@your-server-ip

# Create backup directory
mkdir -p /opt/glinta-backup-$(date +%Y%m%d)
cd /opt/glinta-backup-$(date +%Y%m%d)

# Backup database
mysqldump -u root -p phpnuxbill > database_backup.sql

# Backup website files
cp -r /opt/glinta-hotspot/app ./website_backup

# Backup Apache config
cp /etc/apache2/sites-available/* ./apache_backup/
```

## Step 2: Database Optimization Implementation

```bash
# Navigate to your application directory
cd /opt/glinta-hotspot/app

# Run database optimization script
mysql -u root -p phpnuxbill < database_performance_optimization.sql

# Verify indexes were created
mysql -u root -p phpnuxbill -e "SHOW INDEX FROM tbl_transactions;"
mysql -u root -p phpnuxbill -e "SHOW INDEX FROM tbl_customers;"
```

## Step 3: UI/UX Theme Implementation

### 3.1 Deploy CSS Files
```bash
# Copy modern CSS files
cp ui/ui/styles/glinta-modern.css ui/ui/styles/glinta-modern.css.backup
cp ui/ui/styles/glinta-mobile.css ui/ui/styles/glinta-mobile.css.backup

# The files are already in place, just need to reference them in templates
```

### 3.2 Deploy JavaScript Files
```bash
# Copy real-time JavaScript
cp ui/ui/scripts/glinta-realtime.js ui/ui/scripts/glinta-realtime.js.backup

# The file is already in place
```

### 3.3 Update Template References
```bash
# Create a script to update template references
cat > update_templates.sh << 'EOF'
#!/bin/bash

# Function to update template files
update_template() {
    local file="$1"
    if [ -f "$file" ]; then
        # Backup original
        cp "$file" "$file.backup"
        
        # Add modern CSS references
        sed -i '/<\/head>/i\
<link rel="stylesheet" href="{$app_url}/ui/ui/styles/glinta-modern.css?v={$smarty.now}">\
<link rel="stylesheet" href="{$app_url}/ui/ui/styles/glinta-mobile.css?v={$smarty.now}">\
<script src="{$app_url}/ui/ui/scripts/glinta-realtime.js?v={$smarty.now}"></script>' "$file"
        
        echo "Updated $file"
    fi
}

# Update common template files
update_template "ui/ui/header.tpl"
update_template "ui/ui/admin/header.tpl"
update_template "ui/ui/reseller/header.tpl"

echo "Template updates completed"
EOF

chmod +x update_templates.sh
./update_templates.sh
```

## Step 4: Real-time System Configuration

### 4.1 Create API Endpoints
```bash
# Create API directory structure
mkdir -p api/realtime
mkdir -p api/admin
mkdir -p api/reseller

# Create dashboard stats endpoint
cat > api/realtime/stats.php << 'EOF'
<?php
require_once '../../init.php';

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    exit(0);
}

try {
    $user_type = $_SESSION['user_type'] ?? 'admin';
    $reseller_id = $_SESSION['reseller_id'] ?? null;
    
    if ($user_type == 'reseller' && $reseller_id) {
        // Call reseller stats procedure
        $stmt = $pdo->prepare("CALL GetResellerDashboardStats(?)");
        $stmt->execute([$reseller_id]);
        $stats = $stmt->fetch(PDO::FETCH_ASSOC);
    } else {
        // Call admin stats procedure
        $stmt = $pdo->prepare("CALL GetSuperAdminDashboardStats()");
        $stmt->execute();
        $stats = $stmt->fetch(PDO::FETCH_ASSOC);
    }
    
    echo json_encode([
        'success' => true,
        'data' => $stats,
        'timestamp' => time()
    ]);
    
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage()
    ]);
}
?>
EOF

# Create network status endpoint
cat > api/realtime/network.php << 'EOF'
<?php
require_once '../../init.php';

header('Content-Type: application/json');

try {
    $reseller_id = $_SESSION['reseller_id'] ?? null;
    
    // Call MikroTik stats procedure
    $stmt = $pdo->prepare("CALL GetMikroTikRealtimeStats(?)");
    $stmt->execute([$reseller_id]);
    $routers = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    echo json_encode([
        'success' => true,
        'routers' => $routers,
        'timestamp' => time()
    ]);
    
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage()
    ]);
}
?>
EOF

echo "API endpoints created"
```

### 4.2 Configure Real-time JavaScript
```bash
# Create configuration file
cat > ui/ui/scripts/glinta-config.js << 'EOF'
window.glintaConfig = {
    refreshInterval: 30000, // 30 seconds
    enableWebSocket: false, // Disable WebSocket for now
    enableNotifications: true,
    baseUrl: window.location.origin,
    apiEndpoints: {
        stats: '/api/realtime/stats.php',
        network: '/api/realtime/network.php',
        revenue: '/api/realtime/revenue.php'
    }
};
EOF
```

## Step 5: Dashboard Widget Updates

### 5.1 Update Dashboard Templates
```bash
# Update admin dashboard
cat > ui/ui/admin/dashboard-modern.tpl << 'EOF'
{extends file="admin/layout.tpl"}

{block name="content"}
<div class="dashboard-container">
    <div class="dashboard-header">
        <h1>SuperAdmin Dashboard</h1>
        <div class="real-time-status">
            <div class="real-time-indicator"></div>
            <span>Live System</span>
            <span class="last-update-time">{$smarty.now|date_format:'H:i:s'}</span>
        </div>
    </div>

    <div class="stats-grid">
        <div class="stat-widget revenue-card" id="revenue-today">
            <div class="stat-header">
                <h3 class="stat-title">Today's Revenue</h3>
                <div class="stat-icon">💰</div>
            </div>
            <div class="stat-value">KES <span class="amount">0</span></div>
            <div class="stat-change positive">+0% from yesterday</div>
        </div>

        <div class="stat-widget service-card" id="active-services">
            <div class="stat-header">
                <h3 class="stat-title">Active Services</h3>
                <div class="stat-icon">🟢</div>
            </div>
            <div class="stat-value"><span class="amount">0</span></div>
            <div class="stat-change neutral">Real-time count</div>
        </div>

        <div class="stat-widget customer-card" id="total-customers">
            <div class="stat-header">
                <h3 class="stat-title">Total Customers</h3>
                <div class="stat-icon">👥</div>
            </div>
            <div class="stat-value"><span class="amount">0</span></div>
            <div class="stat-change positive">Growing</div>
        </div>

        <div class="stat-widget health-card" id="system-health">
            <div class="stat-header">
                <h3 class="stat-title">System Health</h3>
                <div class="stat-icon">⚡</div>
            </div>
            <div class="stat-value"><span class="amount">0</span>%</div>
            <div class="progress-bar">
                <div class="progress-fill" style="width: 0%"></div>
            </div>
        </div>
    </div>

    <div class="dashboard-card">
        <div class="dashboard-card-header">
            <h2 class="dashboard-card-title">Network Status</h2>
            <button class="btn-modern btn-primary refresh-btn">
                <span class="loading-spinner" style="display: none;"></span>
                Refresh
            </button>
        </div>
        <div class="network-status" id="network-status">
            <!-- Router status cards will be populated here -->
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Initialize real-time system
    if (typeof GlintaRealTime !== 'undefined') {
        window.glintaRealTime = new GlintaRealTime(window.glintaConfig);
    }
});
</script>
{/block}
EOF

echo "Dashboard template updated"
```

## Step 6: Test Implementation

### 6.1 Create Test Script
```bash
cat > test_implementation.php << 'EOF'
<?php
require_once 'init.php';

echo "=== GLINTA MODERN UI/UX IMPLEMENTATION TEST ===\n\n";

// Test 1: Database Optimization
echo "1. Testing Database Optimization...\n";
try {
    $stmt = $pdo->prepare("CALL GetSuperAdminDashboardStats()");
    $stmt->execute();
    $stats = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if ($stats) {
        echo "✓ Database optimization working\n";
        echo "  - Today's Revenue: KES " . number_format($stats['revenue_today']) . "\n";
        echo "  - Active Services: " . $stats['active_services'] . "\n";
        echo "  - Total Customers: " . $stats['total_customers'] . "\n";
        echo "  - System Health: " . $stats['system_health_score'] . "%\n";
    } else {
        echo "✗ Database optimization failed\n";
    }
} catch (Exception $e) {
    echo "✗ Database error: " . $e->getMessage() . "\n";
}

// Test 2: File Structure
echo "\n2. Testing File Structure...\n";
$files = [
    'ui/ui/styles/glinta-modern.css',
    'ui/ui/styles/glinta-mobile.css',
    'ui/ui/scripts/glinta-realtime.js',
    'database_performance_optimization.sql'
];

foreach ($files as $file) {
    if (file_exists($file)) {
        echo "✓ $file exists\n";
    } else {
        echo "✗ $file missing\n";
    }
}

// Test 3: API Endpoints
echo "\n3. Testing API Endpoints...\n";
$endpoints = [
    'api/realtime/stats.php',
    'api/realtime/network.php'
];

foreach ($endpoints as $endpoint) {
    if (file_exists($endpoint)) {
        echo "✓ $endpoint exists\n";
    } else {
        echo "✗ $endpoint missing\n";
    }
}

// Test 4: MikroTik Connection
echo "\n4. Testing MikroTik Connection...\n";
try {
    $stmt = $pdo->prepare("CALL GetMikroTikRealtimeStats(NULL)");
    $stmt->execute();
    $routers = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    if ($routers) {
        echo "✓ MikroTik data retrieval working\n";
        foreach ($routers as $router) {
            echo "  - Router: " . $router['router_name'] . " (" . $router['ip_address'] . ")\n";
            echo "    Status: " . $router['connection_status'] . "\n";
            echo "    Users: " . $router['active_users'] . " active, " . $router['total_users'] . " total\n";
        }
    } else {
        echo "✗ No MikroTik data found\n";
    }
} catch (Exception $e) {
    echo "✗ MikroTik error: " . $e->getMessage() . "\n";
}

echo "\n=== TEST COMPLETED ===\n";
?>
EOF

php test_implementation.php
```

## Step 7: Enable Real-time Features

### 7.1 Apache Configuration
```bash
# Enable required Apache modules
a2enmod rewrite
a2enmod headers
a2enmod expires

# Add to Apache config or .htaccess
cat >> .htaccess << 'EOF'

# Enable compression
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/css text/javascript application/javascript
</IfModule>

# Enable caching
<IfModule mod_expires.c>
    ExpiresActive on
    ExpiresByType text/css "access plus 1 month"
    ExpiresByType application/javascript "access plus 1 month"
</IfModule>

# API routes
RewriteRule ^api/(.*)$ api/$1 [L,QSA]
EOF

systemctl restart apache2
```

### 7.2 Permissions
```bash
# Set proper permissions
chown -R www-data:www-data /opt/glinta-hotspot/app
chmod -R 755 /opt/glinta-hotspot/app
chmod -R 664 /opt/glinta-hotspot/app/ui/ui/styles/
chmod -R 664 /opt/glinta-hotspot/app/ui/ui/scripts/
```

## Step 8: Monitoring and Maintenance

### 8.1 Performance Monitoring
```bash
# Create monitoring script
cat > monitor_performance.sh << 'EOF'
#!/bin/bash

echo "=== GLINTA PERFORMANCE MONITOR ==="
echo "Date: $(date)"
echo

# Check MySQL performance
echo "Database Performance:"
mysql -u root -p phpnuxbill -e "
SELECT 
    table_name,
    round(((data_length + index_length) / 1024 / 1024), 2) as 'Size (MB)',
    table_rows as 'Rows'
FROM information_schema.tables 
WHERE table_schema = 'phpnuxbill' 
ORDER BY (data_length + index_length) DESC 
LIMIT 10;
"

# Check disk usage
echo -e "\nDisk Usage:"
df -h /opt/glinta-hotspot/

# Check memory usage
echo -e "\nMemory Usage:"
free -h

# Check active connections
echo -e "\nActive Connections:"
netstat -an | grep :80 | wc -l

echo -e "\n=== MONITORING COMPLETED ==="
EOF

chmod +x monitor_performance.sh
```

### 8.2 Automated Backup
```bash
# Create automated backup script
cat > backup_system.sh << 'EOF'
#!/bin/bash

BACKUP_DIR="/opt/glinta-backups"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_PATH="$BACKUP_DIR/backup_$DATE"

mkdir -p $BACKUP_PATH

# Backup database
mysqldump -u root -p phpnuxbill > $BACKUP_PATH/database.sql

# Backup files
tar -czf $BACKUP_PATH/files.tar.gz /opt/glinta-hotspot/app

# Remove old backups (keep last 7 days)
find $BACKUP_DIR -name "backup_*" -mtime +7 -exec rm -rf {} \;

echo "Backup completed: $BACKUP_PATH"
EOF

chmod +x backup_system.sh

# Add to crontab for daily backups
(crontab -l 2>/dev/null; echo "0 2 * * * /opt/glinta-hotspot/app/backup_system.sh") | crontab -
```

## Step 9: Final Testing

```bash
# Run comprehensive test
php test_implementation.php

# Test web interface
curl -s "http://your-domain.com/api/realtime/stats.php" | python -m json.tool

# Check Apache logs
tail -f /var/log/apache2/access.log
tail -f /var/log/apache2/error.log
```

## Troubleshooting

### Common Issues:

1. **Database Connection Issues**
   ```bash
   # Check MySQL status
   systemctl status mysql
   
   # Check database connectivity
   mysql -u root -p -e "SHOW DATABASES;"
   ```

2. **Permission Issues**
   ```bash
   # Fix permissions
   chown -R www-data:www-data /opt/glinta-hotspot/app
   chmod -R 755 /opt/glinta-hotspot/app
   ```

3. **Apache Issues**
   ```bash
   # Check Apache status
   systemctl status apache2
   
   # Check configuration
   apache2ctl configtest
   ```

4. **JavaScript Issues**
   ```bash
   # Check browser console for errors
   # Verify file paths are correct
   # Test API endpoints directly
   ```

## Success Indicators

✅ Database optimization procedures working
✅ Modern UI theme loading correctly
✅ Real-time JavaScript functioning
✅ API endpoints responding
✅ MikroTik data displaying
✅ Performance improvements visible
✅ Mobile responsiveness working

## Next Steps

After successful implementation:
1. Monitor system performance
2. Train users on new interface
3. Set up automated backups
4. Plan for additional features
5. Regular maintenance schedule

---

**Implementation completed successfully!** 
The Glinta Africa ISP billing system now has modern UI/UX and optimized performance.