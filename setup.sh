#!/bin/bash

echo "=== Glinta Hotspot Billing System Setup ==="
echo ""

# Check if Docker is available
if command -v docker >/dev/null 2>&1 && command -v docker-compose >/dev/null 2>&1; then
    echo "✓ Docker and Docker Compose found"
    echo ""
    
    echo "1. Starting with Docker (Recommended for development)"
    echo "2. Manual setup"
    echo ""
    read -p "Choose setup method (1 or 2): " choice
    
    if [ "$choice" = "1" ]; then
        echo ""
        echo "=== Docker Setup ==="
        
        # Copy Docker config
        if [ -f "config.docker.php" ]; then
            cp config.docker.php config.php
            echo "✓ Docker configuration applied"
        fi
        
        # Start services
        echo "Starting Docker services..."
        docker-compose up -d
        
        echo ""
        echo "✓ Setup complete!"
        echo ""
        echo "Services started:"
        echo "- Web Application: http://localhost:8080"
        echo "- phpMyAdmin: http://localhost:8081"
        echo "- MySQL Database: localhost:3306"
        echo ""
        echo "Database credentials:"
        echo "- Host: localhost (or 'db' from within containers)"
        echo "- Database: phpnuxbill"
        echo "- Username: glinta"
        echo "- Password: glintapass"
        echo "- Root password: rootpass"
        echo ""
        echo "Visit http://localhost:8080/test-install.php to verify installation"
        echo "Visit http://localhost:8080/install/ to run the installation wizard"
        
    else
        echo ""
        echo "=== Manual Setup ==="
        echo "Please ensure you have the following installed:"
        echo "- PHP 8.2+ with extensions: pdo, pdo_mysql, gd, curl, zip, mbstring"
        echo "- MySQL 5.7+ or MariaDB"
        echo "- Apache or Nginx web server"
        echo ""
        echo "Steps:"
        echo "1. Configure your web server to serve this directory"
        echo "2. Create a MySQL database named 'phpnuxbill'"
        echo "3. Import the schema: mysql -u root -p phpnuxbill < install/phpnuxbill.sql"
        echo "4. Update config.php with your database credentials"
        echo "5. Visit your site's /install/ directory to complete setup"
    fi
    
else
    echo "Docker not found. Using manual setup..."
    echo ""
    echo "=== Manual Setup Required ==="
    echo "Please ensure you have the following installed:"
    echo "- PHP 8.2+ with extensions: pdo, pdo_mysql, gd, curl, zip, mbstring"
    echo "- MySQL 5.7+ or MariaDB"
    echo "- Apache or Nginx web server"
    echo ""
    echo "Steps:"
    echo "1. Configure your web server to serve this directory"
    echo "2. Create a MySQL database named 'phpnuxbill'"
    echo "3. Import the schema: mysql -u root -p phpnuxbill < install/phpnuxbill.sql"
    echo "4. Update config.php with your database credentials"
    echo "5. Visit your site's /install/ directory to complete setup"
fi

echo ""
echo "=== Additional Notes ==="
echo "- Default admin credentials will be set during installation"
echo "- Make sure system/uploads, system/cache, ui/compiled, and ui/cache directories are writable"
echo "- For production, change \$_app_stage to 'Live' in config.php"
echo ""
echo "For support, visit: https://github.com/hotspotbilling/phpnuxbill"