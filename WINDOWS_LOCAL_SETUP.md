# Windows Local Setup Guide - Glinta Hotspot Billing System

## 🚀 Prerequisites

Before starting, ensure you have:
- **Docker Desktop** installed and running
- **Git** installed (or just download the files)
- **Web browser** for testing

## 📁 Method 1: Using Docker Desktop (Recommended)

### 1. **Install Docker Desktop**
1. Download from: https://www.docker.com/products/docker-desktop/
2. Install and start Docker Desktop
3. Make sure WSL 2 integration is enabled in Docker Desktop settings

### 2. **Open Command Prompt or PowerShell**
```cmd
cd "D:\Glinta Hotspot\Glinta-Hotspot-Billing-System"
```

### 3. **Run the Setup**
```cmd
# For Windows Command Prompt
docker-compose -f docker-compose.local.yml up -d --build

# Wait for containers to start (about 30-60 seconds)
docker-compose -f docker-compose.local.yml ps
```

### 4. **Import Database**
```cmd
# Wait for MySQL to be ready, then import schema
docker exec -i mysql-local mysql -u nuxbill -pSecureP@ssw0rd123! nuxbill_local < install/phpnuxbill.sql

# Apply performance indexes
docker exec -i mysql-local mysql -u nuxbill -pSecureP@ssw0rd123! nuxbill_local < security_performance_indexes.sql
```

### 5. **Access Application**
- **Web Interface**: http://localhost:8080
- **Admin Panel**: http://localhost:8080/admin

## 📁 Method 2: Using XAMPP (Alternative)

If Docker doesn't work, use XAMPP:

### 1. **Install XAMPP**
1. Download from: https://www.apachefriends.org/
2. Install and start Apache + MySQL

### 2. **Copy Files**
```cmd
# Copy project to XAMPP htdocs
copy "D:\Glinta Hotspot\Glinta-Hotspot-Billing-System\*" "C:\xampp\htdocs\glinta\"
```

### 3. **Create Database**
1. Open http://localhost/phpmyadmin
2. Create database: `nuxbill_local`
3. Import: `install/phpnuxbill.sql`
4. Import: `security_performance_indexes.sql`

### 4. **Update Config**
Edit `C:\xampp\htdocs\glinta\config.php`:
```php
$db_host = "localhost";
$db_user = "root";
$db_pass = ""; // Empty for XAMPP
$db_name = "nuxbill_local";
```

### 5. **Access Application**
- **Web Interface**: http://localhost/glinta
- **Admin Panel**: http://localhost/glinta/admin

## 🔧 Troubleshooting

### **Docker Issues**

#### Port Already in Use
```cmd
# Check what's using port 8080
netstat -ano | findstr :8080

# Kill process if needed (replace PID)
taskkill /PID [PID] /F

# Or use different port
docker-compose -f docker-compose.local.yml down
# Edit docker-compose.local.yml to change port to 8081
docker-compose -f docker-compose.local.yml up -d
```

#### WSL Integration Issues
1. Open Docker Desktop
2. Go to Settings → Resources → WSL Integration
3. Enable integration with your WSL distro
4. Restart Docker Desktop

#### Container Won't Start
```cmd
# Check container status
docker-compose -f docker-compose.local.yml ps

# View logs
docker-compose -f docker-compose.local.yml logs

# Restart everything
docker-compose -f docker-compose.local.yml down
docker-compose -f docker-compose.local.yml up -d
```

### **Database Connection Issues**
```cmd
# Test MySQL connection
docker exec -it mysql-local mysql -u nuxbill -pSecureP@ssw0rd123! -e "SELECT 1"

# Check MySQL logs
docker-compose -f docker-compose.local.yml logs mysql-local
```

### **Website Not Loading**
1. **Check Docker Desktop** is running
2. **Check containers** are running:
   ```cmd
   docker ps
   ```
3. **Try different port** if 8080 is busy:
   ```cmd
   # Edit docker-compose.local.yml
   # Change "8080:80" to "8081:80"
   # Then restart
   docker-compose -f docker-compose.local.yml up -d
   ```

## 🧪 Testing Steps

### 1. **Basic Access Test**
- Navigate to http://localhost:8080
- Should see the login page

### 2. **Database Test**
- Try logging in (will fail initially - that's normal)
- Check for proper error messages (not database errors)

### 3. **Admin Test**
- Go to http://localhost:8080/admin
- Should see admin login page

### 4. **Security Test**
- Try SQL injection in login: `admin' OR '1'='1' --`
- Should fail safely without exposing database info

## 📊 Performance Testing

### **Run Security Verification**
```cmd
# If you have PHP installed
php verify_security_fixes.php

# Or manually check the files listed in SECURITY_FIXES_REPORT.md
```

### **Database Performance**
1. Access phpMyAdmin (if using XAMPP) or MySQL directly
2. Check that indexes exist:
   ```sql
   SHOW INDEX FROM tbl_customers;
   SHOW INDEX FROM tbl_user_recharges;
   ```

## 🔄 Common Commands

### **Docker Commands**
```cmd
# Start local environment
docker-compose -f docker-compose.local.yml up -d

# Stop local environment
docker-compose -f docker-compose.local.yml down

# View logs
docker-compose -f docker-compose.local.yml logs -f

# Restart specific service
docker-compose -f docker-compose.local.yml restart nuxbill-local

# Access MySQL directly
docker exec -it mysql-local mysql -u nuxbill -pSecureP@ssw0rd123! nuxbill_local
```

### **File Locations**
- **Project Files**: `D:\Glinta Hotspot\Glinta-Hotspot-Billing-System\`
- **Config File**: `config.local.php` (for Docker) or `config.php` (for XAMPP)
- **Database**: `nuxbill_local`

## 🚨 Security Notes

- **Local environment only** - uses development settings
- **Default credentials** are changed but still for testing only
- **Production deployment** requires additional security measures
- **Database** is separate from production (`nuxbill_local`)

## 📞 Still Having Issues?

1. **Check Windows Firewall** - ensure it's not blocking ports
2. **Check antivirus** - temporarily disable to test
3. **Try different browser** - some browsers cache connection errors
4. **Check Docker Desktop logs** - in Docker Desktop → Troubleshoot
5. **Use XAMPP alternative** - if Docker continues to have issues

---

**Next Steps**: Once you have it running locally, follow the testing checklist in `LOCAL_TESTING_GUIDE.md`