#!/bin/bash

echo "🔧 Glinta Africa - MySQLi Extension Fix Script"
echo "=============================================="

# Detect OS
if [ -f /etc/debian_version ]; then
    OS="debian"
    echo "📍 Detected: Ubuntu/Debian system"
elif [ -f /etc/redhat-release ]; then
    OS="redhat"
    echo "📍 Detected: CentOS/RHEL system"
else
    echo "❌ Unsupported OS. Please install MySQLi manually."
    exit 1
fi

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "⚠️ This script requires root privileges. Run with sudo:"
    echo "sudo bash fix_mysqli.sh"
    exit 1
fi

echo ""
echo "🔍 Checking current PHP version..."
php -v

echo ""
echo "🔍 Checking current MySQL extensions..."
php -m | grep -i mysql

echo ""
echo "📦 Installing MySQLi extension..."

if [ "$OS" = "debian" ]; then
    apt update
    apt install -y php-mysqli php-mysql php-pdo
    service apache2 restart
elif [ "$OS" = "redhat" ]; then
    yum install -y php-mysqli php-mysql php-pdo
    service httpd restart
fi

echo ""
echo "✅ Installation complete! Checking status..."
php -m | grep -i mysql

echo ""
echo "🎯 Testing database connection..."
php -r "
if (extension_loaded('mysqli')) {
    echo '✅ MySQLi extension is now loaded!\n';
    
    // Test connection to your database
    \$host = 'glinta-hotspot-db';
    \$user = 'root';
    \$pass = '';
    \$db = 'nuxbill';
    
    \$conn = @new mysqli(\$host, \$user, \$pass, \$db);
    if (\$conn->connect_error) {
        echo '❌ Database connection failed: ' . \$conn->connect_error . '\n';
        echo '💡 Check your database credentials in config.php\n';
    } else {
        echo '✅ Database connection successful!\n';
        \$conn->close();
    }
} else {
    echo '❌ MySQLi extension still not loaded!\n';
}
"

echo ""
echo "🔧 Additional troubleshooting tips:"
echo "1. If still not working, check your php.ini file:"
echo "   sudo nano /etc/php/$(php -r 'echo PHP_MAJOR_VERSION.\".\".PHP_MINOR_VERSION;')/apache2/php.ini"
echo ""
echo "2. Ensure these lines are uncommented:"
echo "   extension=mysqli"
echo "   extension=pdo_mysql"
echo ""
echo "3. Restart your web server:"
echo "   sudo systemctl restart apache2  # or httpd for CentOS"
echo ""
echo "4. Access your test file: http://your-domain/test_mysql.php"
echo ""
echo "✨ Fix complete! Your Glinta Africa platform should now work!"