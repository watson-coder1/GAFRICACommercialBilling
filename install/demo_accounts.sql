-- Demo accounts for Glinta Hotspot Billing System
-- This script creates demo admin and customer accounts for testing purposes

-- Demo Admin User: admin/admin (already exists, updating to ensure it's working)
-- Password: admin (SHA1: d033e22ae348aeb5660fc2140aec35850c4da997)
UPDATE `tbl_users` SET 
    `username` = 'admin',
    `fullname` = 'Administrator',
    `password` = 'd033e22ae348aeb5660fc2140aec35850c4da997',
    `user_type` = 'SuperAdmin',
    `status` = 'Active',
    `last_login` = NULL,
    `creationdate` = NOW()
WHERE `id` = 1;

-- Demo Customer User: demo/demo
-- Password: demo (plain text as stored in tbl_customers)
INSERT INTO `tbl_customers` (
    `username`,
    `password`,
    `fullname`,
    `email`,
    `phonenumber`,
    `address`,
    `city`,
    `service_type`,
    `account_type`,
    `balance`,
    `status`,
    `created_by`,
    `created_at`
) VALUES (
    'demo',
    'demo',
    'Demo Customer',
    'demo@example.com',
    '+1234567890',
    'Demo Address',
    'Demo City',
    'Hotspot',
    'Personal',
    100.00,
    'Active',
    1,
    NOW()
) ON DUPLICATE KEY UPDATE
    `password` = 'demo',
    `fullname` = 'Demo Customer',
    `email` = 'demo@example.com',
    `phonenumber` = '+1234567890',
    `address` = 'Demo Address',
    `city` = 'Demo City',
    `service_type` = 'Hotspot',
    `account_type` = 'Personal',
    `balance` = 100.00,
    `status` = 'Active',
    `created_by` = 1,
    `created_at` = NOW();

-- Alternative Demo Admin User: demo_admin/admin (in case main admin account is modified)
INSERT INTO `tbl_users` (
    `username`,
    `fullname`,
    `password`,
    `user_type`,
    `status`,
    `phone`,
    `email`,
    `city`,
    `creationdate`
) VALUES (
    'demo_admin',
    'Demo Administrator',
    'd033e22ae348aeb5660fc2140aec35850c4da997',
    'SuperAdmin',
    'Active',
    '+1234567890',
    'admin@demo.com',
    'Demo City',
    NOW()
) ON DUPLICATE KEY UPDATE
    `password` = 'd033e22ae348aeb5660fc2140aec35850c4da997',
    `fullname` = 'Demo Administrator',
    `user_type` = 'SuperAdmin',
    `status` = 'Active',
    `phone` = '+1234567890',
    `email` = 'admin@demo.com',
    `city` = 'Demo City';

-- Display created accounts
SELECT 'Admin Users:' as Info;
SELECT id, username, fullname, user_type, status, creationdate 
FROM tbl_users 
WHERE username IN ('admin', 'demo_admin');

SELECT 'Customer Users:' as Info;
SELECT id, username, fullname, email, service_type, account_type, balance, status, created_at 
FROM tbl_customers 
WHERE username = 'demo';