-- Reseller Multi-Tenancy Database Schema
-- Run this to add reseller support to your existing system

-- Main resellers table
CREATE TABLE IF NOT EXISTS `tbl_resellers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL UNIQUE,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `status` enum('active','suspended','expired','pending') DEFAULT 'pending',
  `subscription_plan` varchar(50) DEFAULT 'basic',
  `max_customers` int(11) DEFAULT 100,
  `max_routers` int(11) DEFAULT 2,
  `commission_rate` decimal(5,2) DEFAULT 10.00,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  `expires_at` datetime DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `settings` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `expires_at` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Reseller subscription history
CREATE TABLE IF NOT EXISTS `tbl_reseller_subscriptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reseller_id` int(11) NOT NULL,
  `plan_name` varchar(50) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `currency` varchar(3) DEFAULT 'KSH',
  `starts_at` datetime NOT NULL,
  `expires_at` datetime NOT NULL,
  `status` enum('active','expired','cancelled') DEFAULT 'active',
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `reseller_id` (`reseller_id`),
  KEY `status` (`status`),
  KEY `expires_at` (`expires_at`),
  FOREIGN KEY (`reseller_id`) REFERENCES `tbl_resellers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Reseller payment history
CREATE TABLE IF NOT EXISTS `tbl_reseller_payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reseller_id` int(11) NOT NULL,
  `type` enum('subscription','commission','refund') NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `currency` varchar(3) DEFAULT 'KSH',
  `method` varchar(50) DEFAULT 'M-Pesa',
  `reference` varchar(100) DEFAULT NULL,
  `status` enum('pending','completed','failed','cancelled') DEFAULT 'pending',
  `description` text DEFAULT NULL,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `reseller_id` (`reseller_id`),
  KEY `type` (`type`),
  KEY `status` (`status`),
  KEY `created_at` (`created_at`),
  FOREIGN KEY (`reseller_id`) REFERENCES `tbl_resellers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Reseller settings and configuration
CREATE TABLE IF NOT EXISTS `tbl_reseller_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reseller_id` int(11) NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text DEFAULT NULL,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reseller_setting` (`reseller_id`, `setting_key`),
  KEY `reseller_id` (`reseller_id`),
  FOREIGN KEY (`reseller_id`) REFERENCES `tbl_resellers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Add reseller_id to existing tables (ALTER TABLE statements)
-- Using ALTER TABLE with IF NOT EXISTS for columns and checking before adding indexes

-- Add reseller_id to customers table
ALTER TABLE `tbl_customers` ADD COLUMN IF NOT EXISTS `reseller_id` int(11) DEFAULT NULL AFTER `id`;
-- Check if index exists before creating
SET @exists = (SELECT COUNT(*) FROM information_schema.statistics WHERE table_schema = DATABASE() AND table_name = 'tbl_customers' AND index_name = 'reseller_id');
SET @sql = IF(@exists = 0, 'ALTER TABLE `tbl_customers` ADD KEY `reseller_id` (`reseller_id`)', 'SELECT "Index already exists"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add reseller_id to routers table  
ALTER TABLE `tbl_routers` ADD COLUMN IF NOT EXISTS `reseller_id` int(11) DEFAULT NULL AFTER `id`;
-- Check if index exists before creating
SET @exists = (SELECT COUNT(*) FROM information_schema.statistics WHERE table_schema = DATABASE() AND table_name = 'tbl_routers' AND index_name = 'reseller_id');
SET @sql = IF(@exists = 0, 'ALTER TABLE `tbl_routers` ADD KEY `reseller_id` (`reseller_id`)', 'SELECT "Index already exists"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add reseller_id to transactions table
ALTER TABLE `tbl_transactions` ADD COLUMN IF NOT EXISTS `reseller_id` int(11) DEFAULT NULL AFTER `id`;
-- Check if index exists before creating
SET @exists = (SELECT COUNT(*) FROM information_schema.statistics WHERE table_schema = DATABASE() AND table_name = 'tbl_transactions' AND index_name = 'reseller_id');
SET @sql = IF(@exists = 0, 'ALTER TABLE `tbl_transactions` ADD KEY `reseller_id` (`reseller_id`)', 'SELECT "Index already exists"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add reseller_id to user_recharges table
ALTER TABLE `tbl_user_recharges` ADD COLUMN IF NOT EXISTS `reseller_id` int(11) DEFAULT NULL AFTER `id`;
-- Check if index exists before creating
SET @exists = (SELECT COUNT(*) FROM information_schema.statistics WHERE table_schema = DATABASE() AND table_name = 'tbl_user_recharges' AND index_name = 'reseller_id');
SET @sql = IF(@exists = 0, 'ALTER TABLE `tbl_user_recharges` ADD KEY `reseller_id` (`reseller_id`)', 'SELECT "Index already exists"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add reseller_id to portal_sessions table (if exists)
SET @table_exists = (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = DATABASE() AND table_name = 'tbl_portal_sessions');
SET @sql = IF(@table_exists > 0, 'ALTER TABLE `tbl_portal_sessions` ADD COLUMN IF NOT EXISTS `reseller_id` int(11) DEFAULT NULL AFTER `id`', 'SELECT "Table does not exist"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
-- Add index if table exists
SET @sql = IF(@table_exists > 0, 'ALTER TABLE `tbl_portal_sessions` ADD KEY IF NOT EXISTS `reseller_id` (`reseller_id`)', 'SELECT "Table does not exist"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add reseller_id to mpesa_transactions table (if exists)
SET @table_exists = (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = DATABASE() AND table_name = 'tbl_mpesa_transactions');
SET @sql = IF(@table_exists > 0, 'ALTER TABLE `tbl_mpesa_transactions` ADD COLUMN IF NOT EXISTS `reseller_id` int(11) DEFAULT NULL AFTER `id`', 'SELECT "Table does not exist"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
-- Add index if table exists
SET @sql = IF(@table_exists > 0, 'ALTER TABLE `tbl_mpesa_transactions` ADD KEY IF NOT EXISTS `reseller_id` (`reseller_id`)', 'SELECT "Table does not exist"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add reseller_id to plans table
ALTER TABLE `tbl_plans` ADD COLUMN IF NOT EXISTS `reseller_id` int(11) DEFAULT NULL AFTER `id`;
-- Check if index exists before creating
SET @exists = (SELECT COUNT(*) FROM information_schema.statistics WHERE table_schema = DATABASE() AND table_name = 'tbl_plans' AND index_name = 'reseller_id');
SET @sql = IF(@exists = 0, 'ALTER TABLE `tbl_plans` ADD KEY `reseller_id` (`reseller_id`)', 'SELECT "Index already exists"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add reseller_id to bandwidth table
ALTER TABLE `tbl_bandwidth` ADD COLUMN IF NOT EXISTS `reseller_id` int(11) DEFAULT NULL AFTER `id`;
-- Check if index exists before creating
SET @exists = (SELECT COUNT(*) FROM information_schema.statistics WHERE table_schema = DATABASE() AND table_name = 'tbl_bandwidth' AND index_name = 'reseller_id');
SET @sql = IF(@exists = 0, 'ALTER TABLE `tbl_bandwidth` ADD KEY `reseller_id` (`reseller_id`)', 'SELECT "Index already exists"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Create default system reseller (ID=1 for existing data)
INSERT INTO `tbl_resellers` (`id`, `name`, `email`, `password`, `status`, `subscription_plan`, `max_customers`, `max_routers`, `commission_rate`, `expires_at`) 
VALUES (1, 'System Admin', 'admin@glintaafrica.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'active', 'unlimited', 999999, 999999, 0.00, '2030-12-31 23:59:59')
ON DUPLICATE KEY UPDATE `name` = 'System Admin';

-- Update existing data to belong to system reseller (ID=1) - only if columns exist
-- Update customers table
SET @col_exists = (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema = DATABASE() AND table_name = 'tbl_customers' AND column_name = 'reseller_id');
SET @sql = IF(@col_exists > 0, 'UPDATE `tbl_customers` SET `reseller_id` = 1 WHERE `reseller_id` IS NULL', 'SELECT "Column does not exist"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Update routers table
SET @col_exists = (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema = DATABASE() AND table_name = 'tbl_routers' AND column_name = 'reseller_id');
SET @sql = IF(@col_exists > 0, 'UPDATE `tbl_routers` SET `reseller_id` = 1 WHERE `reseller_id` IS NULL', 'SELECT "Column does not exist"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Update transactions table
SET @col_exists = (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema = DATABASE() AND table_name = 'tbl_transactions' AND column_name = 'reseller_id');
SET @sql = IF(@col_exists > 0, 'UPDATE `tbl_transactions` SET `reseller_id` = 1 WHERE `reseller_id` IS NULL', 'SELECT "Column does not exist"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Update user_recharges table
SET @col_exists = (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema = DATABASE() AND table_name = 'tbl_user_recharges' AND column_name = 'reseller_id');
SET @sql = IF(@col_exists > 0, 'UPDATE `tbl_user_recharges` SET `reseller_id` = 1 WHERE `reseller_id` IS NULL', 'SELECT "Column does not exist"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Update portal_sessions table (if table and column exist)
SET @table_exists = (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = DATABASE() AND table_name = 'tbl_portal_sessions');
SET @col_exists = (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema = DATABASE() AND table_name = 'tbl_portal_sessions' AND column_name = 'reseller_id');
SET @sql = IF(@table_exists > 0 AND @col_exists > 0, 'UPDATE `tbl_portal_sessions` SET `reseller_id` = 1 WHERE `reseller_id` IS NULL', 'SELECT "Table or column does not exist"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Update mpesa_transactions table (if table and column exist)
SET @table_exists = (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = DATABASE() AND table_name = 'tbl_mpesa_transactions');
SET @col_exists = (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema = DATABASE() AND table_name = 'tbl_mpesa_transactions' AND column_name = 'reseller_id');
SET @sql = IF(@table_exists > 0 AND @col_exists > 0, 'UPDATE `tbl_mpesa_transactions` SET `reseller_id` = 1 WHERE `reseller_id` IS NULL', 'SELECT "Table or column does not exist"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Update plans table
SET @col_exists = (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema = DATABASE() AND table_name = 'tbl_plans' AND column_name = 'reseller_id');
SET @sql = IF(@col_exists > 0, 'UPDATE `tbl_plans` SET `reseller_id` = 1 WHERE `reseller_id` IS NULL', 'SELECT "Column does not exist"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Update bandwidth table
SET @col_exists = (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema = DATABASE() AND table_name = 'tbl_bandwidth' AND column_name = 'reseller_id');
SET @sql = IF(@col_exists > 0, 'UPDATE `tbl_bandwidth` SET `reseller_id` = 1 WHERE `reseller_id` IS NULL', 'SELECT "Column does not exist"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Create reseller subscription plans lookup table
CREATE TABLE IF NOT EXISTS `tbl_reseller_plans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `currency` varchar(3) DEFAULT 'KSH',
  `duration_days` int(11) NOT NULL,
  `max_customers` int(11) NOT NULL,
  `max_routers` int(11) NOT NULL,
  `commission_rate` decimal(5,2) NOT NULL,
  `features` text DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert default reseller plans
INSERT INTO `tbl_reseller_plans` (`name`, `price`, `duration_days`, `max_customers`, `max_routers`, `commission_rate`, `features`) VALUES
('Basic', 5000.00, 30, 100, 2, 10.00, 'Basic dashboard, Customer management, 2 MikroTik routers'),
('Standard', 10000.00, 30, 300, 5, 8.00, 'Advanced dashboard, Multi-router support, Priority support'),
('Premium', 20000.00, 30, 1000, 10, 5.00, 'Full dashboard, Unlimited features, White-label options'),
('Enterprise', 50000.00, 30, 5000, 25, 3.00, 'Enterprise features, API access, Custom integrations');

-- Create indexes for better performance (only if columns exist)
-- Check and create index for customers table
SET @col_exists = (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema = DATABASE() AND table_name = 'tbl_customers' AND column_name = 'reseller_id');
SET @idx_exists = (SELECT COUNT(*) FROM information_schema.statistics WHERE table_schema = DATABASE() AND table_name = 'tbl_customers' AND index_name = 'idx_reseller_customers');
SET @sql = IF(@col_exists > 0 AND @idx_exists = 0, 'CREATE INDEX `idx_reseller_customers` ON `tbl_customers` (`reseller_id`, `service_type`)', 'SELECT "Index not created"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Check and create index for transactions table
SET @col_exists = (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema = DATABASE() AND table_name = 'tbl_transactions' AND column_name = 'reseller_id');
SET @idx_exists = (SELECT COUNT(*) FROM information_schema.statistics WHERE table_schema = DATABASE() AND table_name = 'tbl_transactions' AND index_name = 'idx_reseller_transactions');
SET @sql = IF(@col_exists > 0 AND @idx_exists = 0, 'CREATE INDEX `idx_reseller_transactions` ON `tbl_transactions` (`reseller_id`, `recharged_on`)', 'SELECT "Index not created"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Check and create index for user_recharges table
SET @col_exists = (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema = DATABASE() AND table_name = 'tbl_user_recharges' AND column_name = 'reseller_id');
SET @idx_exists = (SELECT COUNT(*) FROM information_schema.statistics WHERE table_schema = DATABASE() AND table_name = 'tbl_user_recharges' AND index_name = 'idx_reseller_recharges');
SET @sql = IF(@col_exists > 0 AND @idx_exists = 0, 'CREATE INDEX `idx_reseller_recharges` ON `tbl_user_recharges` (`reseller_id`, `status`, `expiration`)', 'SELECT "Index not created"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Check and create index for routers table
SET @col_exists = (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema = DATABASE() AND table_name = 'tbl_routers' AND column_name = 'reseller_id');
SET @idx_exists = (SELECT COUNT(*) FROM information_schema.statistics WHERE table_schema = DATABASE() AND table_name = 'tbl_routers' AND index_name = 'idx_reseller_routers');
SET @sql = IF(@col_exists > 0 AND @idx_exists = 0, 'CREATE INDEX `idx_reseller_routers` ON `tbl_routers` (`reseller_id`, `enabled`)', 'SELECT "Index not created"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;