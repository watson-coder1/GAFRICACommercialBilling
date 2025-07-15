-- Reseller Subscription Payment Tracking System
-- This is separate from customer internet payments

-- Table for tracking reseller subscription payments
CREATE TABLE IF NOT EXISTS `tbl_reseller_subscription_payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reseller_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_date` datetime NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `transaction_reference` varchar(255) DEFAULT NULL,
  `mpesa_receipt` varchar(255) DEFAULT NULL,
  `subscription_period` varchar(20) NOT NULL COMMENT 'monthly, quarterly, yearly',
  `extends_to` date NOT NULL COMMENT 'New expiry date after payment',
  `status` enum('pending','completed','failed','reversed') DEFAULT 'pending',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `reseller_id` (`reseller_id`),
  KEY `payment_date` (`payment_date`),
  KEY `status` (`status`),
  CONSTRAINT `fk_subscription_payment_reseller` FOREIGN KEY (`reseller_id`) REFERENCES `tbl_resellers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Add subscription tracking fields to resellers table
ALTER TABLE `tbl_resellers` 
ADD COLUMN IF NOT EXISTS `subscription_status` enum('trial','active','grace_period','suspended','expired') DEFAULT 'trial',
ADD COLUMN IF NOT EXISTS `last_payment_date` datetime DEFAULT NULL,
ADD COLUMN IF NOT EXISTS `next_payment_due` date DEFAULT NULL,
ADD COLUMN IF NOT EXISTS `auto_suspend` tinyint(1) DEFAULT 1 COMMENT 'Auto suspend on expiry',
ADD COLUMN IF NOT EXISTS `grace_days` int(11) DEFAULT 3 COMMENT 'Days before suspension';

-- Create indexes if they don't exist
SET @dbname = DATABASE();
SET @tablename = 'tbl_resellers';
SET @indexname = 'idx_subscription_status';
SET @columnname = 'subscription_status';

SELECT COUNT(1) INTO @index_exists 
FROM INFORMATION_SCHEMA.STATISTICS
WHERE table_schema = @dbname 
AND table_name = @tablename 
AND index_name = @indexname;

SET @sqlstmt = IF(@index_exists = 0, 
    CONCAT('CREATE INDEX ', @indexname, ' ON ', @tablename, '(', @columnname, ')'),
    'SELECT ''Index already exists''');

PREPARE stmt FROM @sqlstmt;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Widget for super admin to track reseller subscriptions
CREATE TABLE IF NOT EXISTS `tbl_widgets_reseller_subscriptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `widget_name` varchar(100) DEFAULT 'reseller_subscriptions',
  `active_resellers` int(11) DEFAULT 0,
  `expiring_soon` int(11) DEFAULT 0,
  `suspended_resellers` int(11) DEFAULT 0,
  `monthly_revenue` decimal(10,2) DEFAULT 0,
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create view for easy reseller subscription monitoring
CREATE OR REPLACE VIEW `v_reseller_subscription_status` AS
SELECT 
    r.id,
    r.name,
    r.company,
    r.email,
    r.phone,
    r.subscription_status,
    r.subscription_plan,
    r.expires_at,
    r.last_payment_date,
    r.next_payment_due,
    DATEDIFF(r.expires_at, CURDATE()) as days_until_expiry,
    CASE 
        WHEN r.subscription_status = 'active' AND DATEDIFF(r.expires_at, CURDATE()) <= 7 THEN 'warning'
        WHEN r.subscription_status = 'active' AND DATEDIFF(r.expires_at, CURDATE()) <= 0 THEN 'expired'
        WHEN r.subscription_status = 'grace_period' THEN 'grace'
        WHEN r.subscription_status = 'suspended' THEN 'suspended'
        ELSE 'ok'
    END as alert_status,
    (SELECT COUNT(*) FROM tbl_customers WHERE reseller_id = r.id) as customer_count,
    (SELECT COUNT(*) FROM tbl_routers WHERE reseller_id = r.id) as router_count,
    (SELECT SUM(amount) FROM tbl_reseller_subscription_payments 
     WHERE reseller_id = r.id AND status = 'completed' 
     AND YEAR(payment_date) = YEAR(CURDATE()) 
     AND MONTH(payment_date) = MONTH(CURDATE())) as current_month_paid
FROM tbl_resellers r
WHERE r.id > 1; -- Exclude super admin

-- Stored procedure to check and update reseller subscription status
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS `sp_check_reseller_subscriptions`()
BEGIN
    -- Update resellers in grace period
    UPDATE tbl_resellers 
    SET subscription_status = 'grace_period'
    WHERE id > 1 
    AND subscription_status = 'active' 
    AND expires_at < NOW()
    AND DATEDIFF(NOW(), expires_at) <= grace_days;
    
    -- Suspend resellers past grace period
    UPDATE tbl_resellers 
    SET subscription_status = 'suspended'
    WHERE id > 1 
    AND auto_suspend = 1
    AND (
        (subscription_status = 'grace_period' AND DATEDIFF(NOW(), expires_at) > grace_days)
        OR 
        (subscription_status = 'active' AND expires_at < NOW() AND DATEDIFF(NOW(), expires_at) > grace_days)
    );
    
    -- Log status changes
    INSERT INTO tbl_logs (date, type, description, userid, ip)
    SELECT 
        NOW(),
        'System',
        CONCAT('Reseller ', name, ' subscription status changed to ', subscription_status),
        1,
        '127.0.0.1'
    FROM tbl_resellers
    WHERE updated_at >= DATE_SUB(NOW(), INTERVAL 1 MINUTE)
    AND id > 1;
END$$
DELIMITER ;

-- Create event to run subscription check daily
CREATE EVENT IF NOT EXISTS `e_daily_subscription_check`
ON SCHEDULE EVERY 1 DAY
STARTS (TIMESTAMP(CURRENT_DATE) + INTERVAL 1 DAY + INTERVAL 2 HOUR)
DO CALL sp_check_reseller_subscriptions();

-- Sample reseller subscription plans with pricing
INSERT IGNORE INTO `tbl_appconfig` (`setting`, `value`) VALUES
('reseller_plan_starter_price', '5000'),
('reseller_plan_starter_customers', '50'),
('reseller_plan_starter_routers', '2'),
('reseller_plan_professional_price', '10000'),
('reseller_plan_professional_customers', '200'),
('reseller_plan_professional_routers', '5'),
('reseller_plan_enterprise_price', '25000'),
('reseller_plan_enterprise_customers', '1000'),
('reseller_plan_enterprise_routers', '20'),
('reseller_subscription_reminder_days', '7'),
('reseller_subscription_grace_days', '3');