#!/bin/bash

# GLINTA AFRICA ISP BILLING SYSTEM
# Modern UI/UX Deployment Script
# This script deploys the modern theme and database optimizations

set -e

echo "========================================"
echo "GLINTA MODERN UI/UX DEPLOYMENT SCRIPT"
echo "========================================"
echo "Date: $(date)"
echo

# Configuration
APP_DIR="/opt/glinta-hotspot/app"
BACKUP_DIR="/opt/glinta-backup-$(date +%Y%m%d_%H%M%S)"
DB_NAME="phpnuxbill"
DB_USER="root"

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root (use sudo)"
   exit 1
fi

# Step 1: Create backup
echo "📦 Creating backup..."
mkdir -p $BACKUP_DIR
echo "Backup directory: $BACKUP_DIR"

# Backup database
echo "Backing up database..."
mysqldump -u $DB_USER -p $DB_NAME > $BACKUP_DIR/database_backup.sql
echo "✅ Database backup created"

# Backup files
echo "Backing up files..."
cp -r $APP_DIR $BACKUP_DIR/app_backup
echo "✅ Files backup created"

# Step 2: Deploy database optimization
echo
echo "🗄️  Deploying database optimization..."
cd $APP_DIR

if [ -f "database_performance_optimization.sql" ]; then
    echo "Running database optimization script..."
    mysql -u $DB_USER -p $DB_NAME < database_performance_optimization.sql
    echo "✅ Database optimization completed"
else
    echo "❌ Database optimization script not found!"
    exit 1
fi

# Step 3: Deploy CSS and JavaScript files
echo
echo "🎨 Deploying modern UI files..."

# Check if CSS files exist
if [ -f "ui/ui/styles/glinta-modern.css" ]; then
    echo "✅ Modern CSS file found"
else
    echo "❌ Modern CSS file not found!"
    exit 1
fi

if [ -f "ui/ui/styles/glinta-mobile.css" ]; then
    echo "✅ Mobile CSS file found"
else
    echo "❌ Mobile CSS file not found!"
    exit 1
fi

if [ -f "ui/ui/scripts/glinta-realtime.js" ]; then
    echo "✅ Real-time JavaScript file found"
else
    echo "❌ Real-time JavaScript file not found!"
    exit 1
fi

# Step 4: Create API endpoints
echo
echo "🌐 Creating API endpoints..."
mkdir -p api/realtime

# Create stats endpoint
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
        $stmt = $pdo->prepare("CALL GetResellerDashboardStats(?)");
        $stmt->execute([$reseller_id]);
        $stats = $stmt->fetch(PDO::FETCH_ASSOC);
    } else {
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

# Create network endpoint
cat > api/realtime/network.php << 'EOF'
<?php
require_once '../../init.php';

header('Content-Type: application/json');

try {
    $reseller_id = $_SESSION['reseller_id'] ?? null;
    
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

echo "✅ API endpoints created"

# Step 5: Create JavaScript configuration
echo
echo "⚙️  Creating JavaScript configuration..."
cat > ui/ui/scripts/glinta-config.js << 'EOF'
window.glintaConfig = {
    refreshInterval: 30000,
    enableWebSocket: false,
    enableNotifications: true,
    baseUrl: window.location.origin,
    apiEndpoints: {
        stats: '/api/realtime/stats.php',
        network: '/api/realtime/network.php'
    }
};
EOF

echo "✅ JavaScript configuration created"

# Step 6: Update template files
echo
echo "📄 Updating template files..."

# Function to update header template
update_header_template() {
    local header_file="$1"
    if [ -f "$header_file" ]; then
        # Create backup
        cp "$header_file" "$header_file.backup"
        
        # Add CSS and JS references before closing head tag
        sed -i '/<\/head>/i\
<link rel="stylesheet" href="{$app_url}/ui/ui/styles/glinta-modern.css?v={$smarty.now}">\
<link rel="stylesheet" href="{$app_url}/ui/ui/styles/glinta-mobile.css?v={$smarty.now}">\
<script src="{$app_url}/ui/ui/scripts/glinta-config.js?v={$smarty.now}"></script>\
<script src="{$app_url}/ui/ui/scripts/glinta-realtime.js?v={$smarty.now}"></script>' "$header_file"
        
        echo "✅ Updated $header_file"
    else
        echo "⚠️  $header_file not found"
    fi
}

# Update various header templates
update_header_template "ui/ui/header.tpl"
update_header_template "ui/ui/admin/header.tpl"
update_header_template "ui/ui/sections/header.tpl"

# Step 7: Set permissions
echo
echo "🔐 Setting permissions..."
chown -R www-data:www-data $APP_DIR
chmod -R 755 $APP_DIR
chmod -R 664 $APP_DIR/ui/ui/styles/
chmod -R 664 $APP_DIR/ui/ui/scripts/
chmod -R 755 $APP_DIR/api/

echo "✅ Permissions set"

# Step 8: Update Apache configuration
echo
echo "🌐 Updating Apache configuration..."

# Enable required modules
a2enmod rewrite
a2enmod headers
a2enmod expires
a2enmod deflate

# Add performance optimizations to .htaccess
cat >> .htaccess << 'EOF'

# Modern UI Performance Optimizations
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/css text/javascript application/javascript application/json
</IfModule>

<IfModule mod_expires.c>
    ExpiresActive on
    ExpiresByType text/css "access plus 1 month"
    ExpiresByType application/javascript "access plus 1 month"
    ExpiresByType application/json "access plus 1 hour"
</IfModule>

# API routing
RewriteRule ^api/(.*)$ api/$1 [L,QSA]
EOF

echo "✅ Apache configuration updated"

# Step 9: Restart services
echo
echo "🔄 Restarting services..."
systemctl restart apache2
systemctl restart mysql

echo "✅ Services restarted"

# Step 10: Run tests
echo
echo "🧪 Running implementation tests..."
cd $APP_DIR
php test_modern_implementation.php

# Step 11: Final checks
echo
echo "🔍 Final system checks..."

# Check if database procedures exist
mysql -u $DB_USER -p $DB_NAME -e "SHOW PROCEDURE STATUS WHERE Db = '$DB_NAME';" | grep -q "GetSuperAdminDashboardStats"
if [ $? -eq 0 ]; then
    echo "✅ Database procedures installed"
else
    echo "❌ Database procedures missing"
fi

# Check if files are accessible
if curl -s -f "http://localhost/ui/ui/styles/glinta-modern.css" > /dev/null; then
    echo "✅ Modern CSS accessible"
else
    echo "❌ Modern CSS not accessible"
fi

if curl -s -f "http://localhost/ui/ui/scripts/glinta-realtime.js" > /dev/null; then
    echo "✅ Real-time JavaScript accessible"
else
    echo "❌ Real-time JavaScript not accessible"
fi

# Check API endpoints
if curl -s -f "http://localhost/api/realtime/stats.php" > /dev/null; then
    echo "✅ Stats API accessible"
else
    echo "❌ Stats API not accessible"
fi

echo
echo "========================================"
echo "🎉 DEPLOYMENT COMPLETED!"
echo "========================================"
echo
echo "Backup created at: $BACKUP_DIR"
echo "Modern UI/UX theme deployed successfully!"
echo
echo "Next steps:"
echo "1. Test the dashboard at: http://your-domain.com"
echo "2. Check browser console for any JavaScript errors"
echo "3. Test mobile responsiveness"
echo "4. Monitor system performance"
echo
echo "If you encounter issues, you can restore from backup:"
echo "1. Restore database: mysql -u $DB_USER -p $DB_NAME < $BACKUP_DIR/database_backup.sql"
echo "2. Restore files: cp -r $BACKUP_DIR/app_backup/* $APP_DIR/"
echo
echo "========================================"