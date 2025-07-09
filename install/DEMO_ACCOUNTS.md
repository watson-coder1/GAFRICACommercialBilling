# Demo Accounts for Glinta Hotspot Billing System

This document provides information about demo accounts created for testing the Glinta Hotspot Billing System.

## Demo Account Credentials

### Admin Users
- **Username:** admin
- **Password:** admin
- **Type:** SuperAdmin
- **Access:** Full system administration

- **Username:** demo_admin
- **Password:** admin
- **Type:** SuperAdmin
- **Access:** Full system administration (backup admin account)

### Customer Users
- **Username:** demo
- **Password:** demo
- **Type:** Personal account
- **Balance:** KES 100.00
- **Service Type:** Hotspot

## Installation Instructions

### Method 1: Using SQL Script
1. Navigate to the install directory
2. Run the demo_accounts.sql script:
   ```bash
   mysql -u your_username -p your_database_name < demo_accounts.sql
   ```

### Method 2: Manual Database Entry
Execute the following SQL commands in your database:

```sql
-- Update existing admin account
UPDATE `tbl_users` SET 
    `username` = 'admin',
    `password` = 'd033e22ae348aeb5660fc2140aec35850c4da997',
    `user_type` = 'SuperAdmin',
    `status` = 'Active'
WHERE `id` = 1;

-- Create demo customer
INSERT INTO `tbl_customers` (
    `username`, `password`, `fullname`, `email`, `phonenumber`, 
    `address`, `city`, `service_type`, `account_type`, `balance`, 
    `status`, `created_by`, `created_at`
) VALUES (
    'demo', 'demo', 'Demo Customer', 'demo@example.com', '+1234567890',
    'Demo Address', 'Demo City', 'Hotspot', 'Personal', 100.00,
    'Active', 1, NOW()
);
```

## User Database Structure

### Admin Users Table (`tbl_users`)
- **ID:** Primary key
- **Username:** Login username
- **Password:** Hashed password (SHA1/bcrypt)
- **User Types:** SuperAdmin, Admin, Agent, Sales, Report
- **Status:** Active, Inactive

### Customer Users Table (`tbl_customers`)
- **ID:** Primary key
- **Username:** Login username
- **Password:** Plain text password (for hotspot authentication)
- **Service Types:** Hotspot, PPPoE, Others
- **Account Types:** Personal, Business
- **Balance:** Available balance for purchases

## Password Hashing Information

### Admin Passwords
- **New installations:** Use bcrypt (`password_hash()` with `PASSWORD_DEFAULT`)
- **Legacy support:** SHA1 hashes supported for backward compatibility
- **Password verification:** Uses `Password::_verify()` method

### Customer Passwords
- **Storage:** Plain text (required for hotspot authentication)
- **Verification:** Direct comparison for customer portal
- **Security:** Passwords are transmitted securely and stored as needed for network authentication

## Access URLs

### Admin Portal
- **URL:** `https://your-domain.com/admin`
- **Login:** admin/admin or demo_admin/admin

### Customer Portal
- **URL:** `https://your-domain.com/`
- **Login:** demo/demo

## Security Considerations

### Production Environment
1. **Change default passwords** immediately after installation
2. **Remove demo accounts** in production
3. **Use strong passwords** for all accounts
4. **Enable SSL/TLS** for all communications
5. **Regular password updates** for admin accounts

### Demo Environment
- These accounts are for testing purposes only
- Do not use in production environments
- Default passwords are publicly known

## Troubleshooting

### Login Issues
1. **Check database connection**
2. **Verify user exists** in correct table
3. **Check password hash** format and encoding
4. **Ensure account status** is 'Active'

### Admin Login Problems
- Check `tbl_users` table for admin accounts
- Verify password hash matches expected format
- Ensure `user_type` is properly set

### Customer Login Problems
- Check `tbl_customers` table for customer accounts
- Verify password is stored correctly
- Ensure `status` is 'Active'

## Database Maintenance

### Regular Tasks
1. **Clean up old sessions**
2. **Monitor user activity**
3. **Update expired accounts**
4. **Backup user data**

### Demo Account Cleanup
```sql
-- Remove demo accounts (for production)
DELETE FROM tbl_customers WHERE username = 'demo';
DELETE FROM tbl_users WHERE username IN ('demo_admin');
```

## Support

For issues with demo accounts or user management:
1. Check database connection and permissions
2. Review system logs for authentication errors
3. Verify password hashing configuration
4. Ensure proper user types and permissions

## File Locations

- **Password handling:** `system/autoload/Password.php`
- **User management:** `system/autoload/User.php`
- **Admin management:** `system/autoload/Admin.php`
- **Customer controller:** `system/controllers/customers.php`
- **Settings controller:** `system/controllers/settings.php`
- **Database schema:** `install/phpnuxbill.sql`