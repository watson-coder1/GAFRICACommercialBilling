-- M-Pesa transactions table
CREATE TABLE IF NOT EXISTS `tbl_mpesa_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(255) NOT NULL,
  `transaction_id` varchar(255) DEFAULT NULL,
  `phone_number` varchar(20) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` enum('pending','completed','failed','cancelled') DEFAULT 'pending',
  `mpesa_receipt_number` varchar(255) DEFAULT NULL,
  `callback_response` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `session_id` (`session_id`),
  KEY `transaction_id` (`transaction_id`),
  KEY `phone_number` (`phone_number`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Portal sessions table (if doesn't exist)
CREATE TABLE IF NOT EXISTS `tbl_portal_sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(255) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `package_id` int(11) DEFAULT NULL,
  `payment_status` enum('pending','completed','failed') DEFAULT 'pending',
  `mikrotik_user` varchar(255) DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `session_id` (`session_id`),
  KEY `phone_number` (`phone_number`),
  KEY `payment_status` (`payment_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Hotspot packages table (if doesn't exist)
CREATE TABLE IF NOT EXISTS `tbl_hotspot_packages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `duration_hours` int(11) NOT NULL,
  `data_limit_mb` int(11) DEFAULT NULL,
  `speed_limit` varchar(50) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert sample packages
INSERT IGNORE INTO `tbl_hotspot_packages` (`name`, `description`, `price`, `duration_hours`, `data_limit_mb`, `speed_limit`) VALUES
('1 Hour Basic', '1 hour internet access', 20.00, 1, 500, '1M/1M'),
('3 Hours Standard', '3 hours internet access', 50.00, 3, 1500, '2M/2M'),
('Daily Premium', '24 hours internet access', 100.00, 24, 5000, '5M/5M'),
('Weekly Plus', '7 days internet access', 500.00, 168, 20000, '10M/10M');

-- Add M-Pesa configuration settings
INSERT IGNORE INTO `tbl_appconfig` (`setting`, `value`) VALUES
('mpesa_consumer_key', ''),
('mpesa_consumer_secret', ''),
('mpesa_passkey', ''),
('mpesa_shortcode', ''),
('mpesa_environment', 'sandbox');