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

-- Add reseller_id to customers table
ALTER TABLE `tbl_customers` ADD COLUMN `reseller_id` int(11) DEFAULT NULL AFTER `id`;
ALTER TABLE `tbl_customers` ADD KEY `reseller_id` (`reseller_id`);

-- Add reseller_id to routers table  
ALTER TABLE `tbl_routers` ADD COLUMN `reseller_id` int(11) DEFAULT NULL AFTER `id`;
ALTER TABLE `tbl_routers` ADD KEY `reseller_id` (`reseller_id`);

-- Add reseller_id to transactions table
ALTER TABLE `tbl_transactions` ADD COLUMN `reseller_id` int(11) DEFAULT NULL AFTER `id`;
ALTER TABLE `tbl_transactions` ADD KEY `reseller_id` (`reseller_id`);

-- Add reseller_id to user_recharges table
ALTER TABLE `tbl_user_recharges` ADD COLUMN `reseller_id` int(11) DEFAULT NULL AFTER `id`;
ALTER TABLE `tbl_user_recharges` ADD KEY `reseller_id` (`reseller_id`);

-- Add reseller_id to portal_sessions table (if exists)
ALTER TABLE `tbl_portal_sessions` ADD COLUMN `reseller_id` int(11) DEFAULT NULL AFTER `id`;
ALTER TABLE `tbl_portal_sessions` ADD KEY `reseller_id` (`reseller_id`);

-- Add reseller_id to mpesa_transactions table (if exists)
ALTER TABLE `tbl_mpesa_transactions` ADD COLUMN `reseller_id` int(11) DEFAULT NULL AFTER `id`;
ALTER TABLE `tbl_mpesa_transactions` ADD KEY `reseller_id` (`reseller_id`);

-- Add reseller_id to plans table
ALTER TABLE `tbl_plans` ADD COLUMN `reseller_id` int(11) DEFAULT NULL AFTER `id`;
ALTER TABLE `tbl_plans` ADD KEY `reseller_id` (`reseller_id`);

-- Add reseller_id to bandwidth table
ALTER TABLE `tbl_bandwidth` ADD COLUMN `reseller_id` int(11) DEFAULT NULL AFTER `id`;
ALTER TABLE `tbl_bandwidth` ADD KEY `reseller_id` (`reseller_id`);

-- Create default system reseller (ID=1 for existing data)
INSERT INTO `tbl_resellers` (`id`, `name`, `email`, `password`, `status`, `subscription_plan`, `max_customers`, `max_routers`, `commission_rate`, `expires_at`) 
VALUES (1, 'System Admin', 'admin@glintaafrica.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'active', 'unlimited', 999999, 999999, 0.00, '2030-12-31 23:59:59')
ON DUPLICATE KEY UPDATE `name` = 'System Admin';

-- Update existing data to belong to system reseller (ID=1)
UPDATE `tbl_customers` SET `reseller_id` = 1 WHERE `reseller_id` IS NULL;
UPDATE `tbl_routers` SET `reseller_id` = 1 WHERE `reseller_id` IS NULL;
UPDATE `tbl_transactions` SET `reseller_id` = 1 WHERE `reseller_id` IS NULL;
UPDATE `tbl_user_recharges` SET `reseller_id` = 1 WHERE `reseller_id` IS NULL;
UPDATE `tbl_portal_sessions` SET `reseller_id` = 1 WHERE `reseller_id` IS NULL;
UPDATE `tbl_mpesa_transactions` SET `reseller_id` = 1 WHERE `reseller_id` IS NULL;
UPDATE `tbl_plans` SET `reseller_id` = 1 WHERE `reseller_id` IS NULL;
UPDATE `tbl_bandwidth` SET `reseller_id` = 1 WHERE `reseller_id` IS NULL;

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

-- Create indexes for better performance
CREATE INDEX `idx_reseller_customers` ON `tbl_customers` (`reseller_id`, `service_type`);
CREATE INDEX `idx_reseller_transactions` ON `tbl_transactions` (`reseller_id`, `recharged_on`);
CREATE INDEX `idx_reseller_recharges` ON `tbl_user_recharges` (`reseller_id`, `status`, `expiration`);
CREATE INDEX `idx_reseller_routers` ON `tbl_routers` (`reseller_id`, `enabled`);