# Glinta Hotspot Billing System - Setup Guide

This guide will help you set up the Glinta Hotspot Billing System on your local machine or server.

## Quick Start with Docker (Recommended)

The easiest way to get started is using Docker. This will set up all required services automatically.

### Prerequisites
- Docker and Docker Compose installed on your system

### Setup Steps

1. **Run the setup script:**
   ```bash
   ./setup.sh
   ```
   Choose option 1 for Docker setup.

2. **Access the application:**
   - Main application: http://localhost:8080
   - phpMyAdmin: http://localhost:8081
   - Test installation: http://localhost:8080/test-install.php

3. **Complete installation:**
   - Visit http://localhost:8080/install/ to run the installation wizard
   - Use the provided database credentials

### Docker Services

- **Web Server:** Apache with PHP 8.2
- **Database:** MySQL 8.0
- **Database Management:** phpMyAdmin

### Database Credentials (Docker)
- Host: db (from within containers) or localhost:3306 (from host)
- Database: phpnuxbill
- Username: glinta
- Password: glintapass
- Root Password: rootpass

## Manual Installation

If you prefer to set up the system manually or don't have Docker available:

### Prerequisites

- PHP 8.2+ with extensions:
  - PDO and PDO MySQL
  - GD (for image processing)
  - cURL
  - ZIP
  - Mbstring
  - XML
- MySQL 5.7+ or MariaDB
- Apache or Nginx web server

### Setup Steps

1. **Configure Web Server:**
   - Point your web server document root to this directory
   - Ensure URL rewriting is enabled (mod_rewrite for Apache)

2. **Database Setup:**
   ```bash
   mysql -u root -p
   CREATE DATABASE phpnuxbill;
   CREATE USER 'glinta'@'localhost' IDENTIFIED BY 'your_password';
   GRANT ALL PRIVILEGES ON phpnuxbill.* TO 'glinta'@'localhost';
   FLUSH PRIVILEGES;
   EXIT;
   
   mysql -u glinta -p phpnuxbill < install/phpnuxbill.sql
   ```

3. **Configuration:**
   - Update `config.php` with your database credentials
   - Ensure these directories are writable:
     - `system/uploads/`
     - `system/cache/`
     - `ui/compiled/`
     - `ui/cache/`

4. **Installation:**
   - Visit your site's `/install/` directory
   - Follow the installation wizard

## Testing Installation

Run the installation test script to verify your setup:
```
http://your-domain/test-install.php
```

This will check:
- PHP version and extensions
- Directory permissions
- Configuration files
- Database connection

## Security Notes

### For Production Deployment:

1. **Change app stage to Live:**
   ```php
   $_app_stage = 'Live';
   ```

2. **Secure database credentials:**
   - Use strong passwords
   - Create dedicated database user with minimal privileges

3. **Enable HTTPS:**
   - Uncomment HTTPS redirect in `.htaccess`
   - Configure SSL certificate

4. **File permissions:**
   - Set restrictive permissions on config files
   - Ensure web server can only write to necessary directories

5. **Remove test files:**
   - Delete `test-install.php` after setup
   - Remove `SETUP.md` from web-accessible directory

## Default Features

Once installed, the system includes:

- **User Management:** Customer registration and management
- **Hotspot Control:** Integration with Mikrotik routers
- **Billing System:** Automated billing and payment processing
- **Voucher System:** Generate and manage access vouchers
- **Reporting:** Comprehensive usage and financial reports
- **Multi-language Support:** Interface available in multiple languages

## Troubleshooting

### Common Issues:

1. **Permission Errors:**
   ```bash
   chmod -R 755 system/uploads system/cache ui/compiled ui/cache
   ```

2. **Database Connection Issues:**
   - Verify credentials in `config.php`
   - Check MySQL service status
   - Ensure database exists and user has privileges

3. **Apache URL Rewriting:**
   ```apache
   a2enmod rewrite
   systemctl restart apache2
   ```

4. **PHP Extensions Missing:**
   ```bash
   # Ubuntu/Debian
   sudo apt install php-mysql php-gd php-curl php-zip php-mbstring php-xml
   
   # CentOS/RHEL
   sudo yum install php-mysql php-gd php-curl php-zip php-mbstring php-xml
   ```

## Support

- **Documentation:** Check the original PHPNuxBill documentation
- **Community:** Join the Telegram group for community support
- **Issues:** Report issues on the GitHub repository

## Next Steps

After successful installation:

1. **Configure Mikrotik Integration:** Set up your router connections
2. **Customize Templates:** Modify UI templates as needed
3. **Set up Payment Gateways:** Configure your preferred payment methods
4. **Create Service Plans:** Define your internet service packages
5. **Configure Notifications:** Set up SMS/email notifications

---

**Note:** This is based on PHPNuxBill and customized for Glinta Hotspot Billing System. Make sure to review all configurations for your specific use case.