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

-- Add M-Pesa configuration settings (only the settings, skip packages for now)
INSERT IGNORE INTO `tbl_appconfig` (`setting`, `value`) VALUES
('mpesa_consumer_key', ''),
('mpesa_consumer_secret', ''),
('mpesa_passkey', ''),
('mpesa_shortcode', ''),
('mpesa_environment', 'sandbox');