# Local Testing Guide - Glinta Hotspot Billing System

## 🚀 Quick Start

### 1. **Run the Local Setup**
```bash
./setup_local_testing.sh
```

This will:
- Start Docker containers on different ports (8080 for web, 3308 for MySQL)
- Create a separate local database (`nuxbill_local`)
- Import the schema and apply security indexes
- Run security verification

### 2. **Access the Application**
- **Web Interface**: http://localhost:8080
- **Admin Panel**: http://localhost:8080/admin

### 3. **Database Access**
- **Host**: localhost
- **Port**: 3308
- **Database**: nuxbill_local
- **Username**: nuxbill
- **Password**: SecureP@ssw0rd123!

## 🧪 Testing Checklist

### **Security Tests**

#### ✅ **SQL Injection Test**
1. Go to login page: http://localhost:8080/login
2. Try malicious inputs:
   - Username: `admin' OR '1'='1' --`
   - Password: `anything`
3. **Expected**: Should fail safely, no database errors exposed

#### ✅ **Password Security Test**
1. Create a new admin user through the interface
2. Check database to verify password is hashed with bcrypt (starts with `$2y$`)
3. Try logging in with the new user
4. **Expected**: Login should work, password should be properly hashed

#### ✅ **Widget Security Test**
1. Go to Admin > Settings > Widgets
2. Create a new "HTML/PHP" widget
3. Try adding content like: `<?php echo "test"; ?>`
4. **Expected**: PHP code should be displayed as text, not executed

#### ✅ **SSL Verification Test**
1. Check the M-Pesa integration code
2. Verify SSL verification is enabled
3. **Expected**: `CURLOPT_SSL_VERIFYPEER` should be `true`

### **Functionality Tests**

#### ✅ **Admin Panel**
1. Access: http://localhost:8080/admin
2. Test login with default credentials
3. Navigate through all menu items
4. **Expected**: No errors, all pages load correctly

#### ✅ **Customer Portal**
1. Access: http://localhost:8080
2. Test customer registration
3. Test customer login
4. **Expected**: Registration and login work properly

#### ✅ **Database Operations**
1. Create new customers
2. Create new plans
3. Generate vouchers
4. **Expected**: All operations complete without errors

#### ✅ **Reporting**
1. Go to Admin > Reports
2. Generate various reports
3. **Expected**: Reports load quickly (thanks to indexes)

## 🔧 Troubleshooting

### **Common Issues**

#### **Container Won't Start**
```bash
# Check container status
docker-compose -f docker-compose.local.yml ps

# View logs
docker-compose -f docker-compose.local.yml logs -f
```

#### **Database Connection Error**
```bash
# Check MySQL container
docker exec -it mysql-local mysql -u nuxbill -pSecureP@ssw0rd123! -e "SELECT 1"

# Restart MySQL if needed
docker-compose -f docker-compose.local.yml restart mysql-local
```

#### **Permission Errors**
```bash
# Fix file permissions
chmod +x setup_local_testing.sh
chmod +x verify_security_fixes.sh
```

### **Reset Environment**
```bash
# Stop and remove containers
docker-compose -f docker-compose.local.yml down -v

# Remove local database volume
docker volume rm glinta-hotspot-billing-system_mysql_local_data

# Start fresh
./setup_local_testing.sh
```

## 📊 Performance Testing

### **Database Performance**
1. Create test data (customers, transactions, logs)
2. Run queries to check index usage:
   ```sql
   EXPLAIN SELECT * FROM tbl_customers WHERE username = 'test';
   EXPLAIN SELECT * FROM tbl_user_recharges WHERE expiration < NOW();
   ```
3. **Expected**: Queries should use indexes (no full table scans)

### **Load Testing**
1. Test multiple concurrent logins
2. Test report generation with large datasets
3. Monitor response times
4. **Expected**: Improved performance compared to before

## 🔄 Development Workflow

### **Making Changes**
1. Edit code in your local directory
2. Changes are automatically reflected (volume mount)
3. Test changes immediately
4. No need to rebuild containers for code changes

### **Database Changes**
1. Make schema changes in local environment
2. Export changes to SQL file
3. Test with fresh database import
4. Document changes for production

## 📋 Pre-Production Checklist

Before deploying to production, ensure:

- [ ] All security tests pass
- [ ] All functionality tests pass
- [ ] No errors in application logs
- [ ] Database performance is acceptable
- [ ] SSL certificates are properly configured
- [ ] Production passwords are set
- [ ] Backup procedures are in place

## 🚨 Security Verification

Run the security verification script regularly:
```bash
./verify_security_fixes.sh
```

This should always show **10/10 checks passed** before production deployment.

## 📞 Support

### **Useful Commands**
```bash
# View application logs
docker-compose -f docker-compose.local.yml logs nuxbill-local

# View database logs
docker-compose -f docker-compose.local.yml logs mysql-local

# Access MySQL directly
docker exec -it mysql-local mysql -u nuxbill -pSecureP@ssw0rd123! nuxbill_local

# Restart specific service
docker-compose -f docker-compose.local.yml restart nuxbill-local
```

### **Log Locations**
- Application logs: Available through database (tbl_logs)
- Docker logs: `docker-compose logs`
- MySQL logs: Inside container at `/var/log/mysql/`

---

**Remember**: This is a local testing environment. Always test thoroughly before deploying to production!