# Local Testing Setup for Modern UI/UX System

## Overview
You can test the modern UI/UX system locally using Docker or XAMPP before deploying to your Digital Ocean server.

## Option 1: Docker Local Testing (Recommended)

### Prerequisites
- Docker Desktop installed
- WSL2 enabled (for Windows)

### Setup Steps

1. **Navigate to your project directory**
   ```bash
   cd "/mnt/c/Users/user/Desktop/Digital-Ocean-Glinta-Africa Billing System/Glinta-Hotspot-Billing-System-digital ocean with autologin"
   ```

2. **Start Docker containers**
   ```bash
   docker-compose up -d
   ```

3. **Wait for containers to start** (about 30 seconds)

4. **Run database optimization**
   ```bash
   # Access the PHP container
   docker exec -it glinta-php bash
   
   # Inside container, run database optimization
   mysql -h glinta-mysql -u root -p phpnuxbill < database_performance_optimization.sql
   # Password: your_mysql_password
   ```

5. **Run the test suite**
   ```bash
   # Still inside the container
   php test_modern_implementation.php
   ```

6. **Access the system**
   - Open browser: `http://localhost:8080`
   - SuperAdmin login: admin / admin (or your credentials)
   - Test reseller login if you have one

## Option 2: XAMPP Local Testing

### Prerequisites
- XAMPP installed
- PHP 7.4+ with MySQL extensions

### Setup Steps

1. **Copy project to XAMPP**
   ```bash
   cp -r "/mnt/c/Users/user/Desktop/Digital-Ocean-Glinta-Africa Billing System/Glinta-Hotspot-Billing-System-digital ocean with autologin" C:/xampp/htdocs/glinta-billing
   ```

2. **Start XAMPP services**
   - Start Apache
   - Start MySQL

3. **Create database**
   ```sql
   CREATE DATABASE phpnuxbill;
   -- Import your existing database backup
   ```

4. **Update config.php**
   ```php
   $db_host = 'localhost';
   $db_user = 'root';
   $db_pass = '';
   $db_name = 'phpnuxbill';
   ```

5. **Run database optimization**
   ```bash
   # In XAMPP MySQL
   mysql -u root phpnuxbill < database_performance_optimization.sql
   ```

6. **Test the system**
   ```bash
   cd C:/xampp/htdocs/glinta-billing
   php test_modern_implementation.php
   ```

7. **Access via browser**
   - Open: `http://localhost/glinta-billing`

## User Types and Access

### SuperAdmin Access
- **Username**: admin (or your admin username)
- **Password**: admin (or your admin password)
- **Dashboard**: Shows system-wide statistics
- **Features**:
  - All resellers management
  - All customers view
  - System-wide revenue
  - All MikroTik routers
  - Complete analytics

### Reseller Access
- **Username**: Your reseller username
- **Password**: Your reseller password
- **Dashboard**: Shows only their data
- **Features**:
  - Their customers only
  - Their revenue only
  - Their assigned routers
  - Their subscription status

## Testing Both Dashboard Types

### 1. Test SuperAdmin Dashboard
```bash
# Login as SuperAdmin
# You should see:
# - Total system revenue
# - All resellers count
# - All customers count
# - All active services
# - System health metrics
```

### 2. Test Reseller Dashboard
```bash
# Login as Reseller
# You should see:
# - Only their revenue
# - Only their customers
# - Only their services
# - Their subscription status
```

## Local Development Features

### Real-time Updates
- Dashboard updates every 30 seconds
- Live statistics from database
- Network status monitoring
- Revenue tracking

### Mobile Testing
- Test responsive design
- Chrome DevTools mobile view
- Different screen sizes
- Touch interactions

### API Testing
Test API endpoints locally:
```bash
# Test stats API
curl http://localhost:8080/api/realtime/stats.php

# Test network API  
curl http://localhost:8080/api/realtime/network.php
```

## Local Testing Checklist

### ✅ Database Tests
- [ ] Database optimization procedures working
- [ ] Performance indexes created
- [ ] Both SuperAdmin and Reseller stats procedures
- [ ] MikroTik data retrieval

### ✅ UI Tests
- [ ] Modern CSS theme loading
- [ ] Mobile responsive design
- [ ] Real-time JavaScript functioning
- [ ] Dashboard widgets updating

### ✅ User Type Tests
- [ ] SuperAdmin sees all data
- [ ] Reseller sees only their data
- [ ] Proper access control
- [ ] Correct dashboard layout

### ✅ Real-time Tests
- [ ] Auto-refresh working
- [ ] API endpoints responding
- [ ] Live data updates
- [ ] Network status updates

## Common Local Issues and Fixes

### 1. Database Connection Issues
```bash
# Check MySQL is running
sudo systemctl status mysql

# Check database exists
mysql -u root -p -e "SHOW DATABASES;"

# Check config.php has correct credentials
```

### 2. File Permission Issues
```bash
# Set proper permissions
chmod -R 755 /path/to/project
chown -R www-data:www-data /path/to/project
```

### 3. Missing PHP Extensions
```bash
# Install required extensions
sudo apt-get install php-mysql php-curl php-gd php-mbstring
```

### 4. JavaScript Errors
```bash
# Check browser console
# Verify file paths are correct
# Test API endpoints directly
```

## Local vs Server Differences

### Local Environment
- Single user testing
- No real MikroTik connections
- Simulated data
- Development mode

### Server Environment
- Multi-user access
- Real MikroTik connections
- Live customer data
- Production mode

## Next Steps After Local Testing

1. **Verify everything works locally**
2. **Test both SuperAdmin and Reseller dashboards**
3. **Check mobile responsiveness**
4. **Test API endpoints**
5. **Deploy to Digital Ocean server**

## Troubleshooting Local Setup

### Docker Issues
```bash
# Check containers
docker ps

# View logs
docker logs glinta-php
docker logs glinta-mysql

# Restart containers
docker-compose restart
```

### XAMPP Issues
```bash
# Check Apache/MySQL status
# View error logs in XAMPP control panel
# Check PHP version compatibility
```

---

**Ready for local testing!** The system supports both SuperAdmin and Reseller dashboards with complete multi-tier functionality.