-- ===================================================================
-- REAL-TIME MONITORING SYSTEM FOR ISP BILLING
-- Gemini & Context7 Analysis - Professional Multi-Reseller Dashboard
-- ===================================================================

-- This script creates a comprehensive real-time monitoring system for:
-- 1. Live session monitoring
-- 2. Bandwidth usage tracking
-- 3. Router health monitoring
-- 4. Payment processing monitoring
-- 5. System performance monitoring
-- 6. Alert and notification system

-- ===================================================================
-- 1. REAL-TIME SESSION MONITORING
-- ===================================================================

-- Create table for session monitoring cache
CREATE TABLE IF NOT EXISTS `tbl_session_monitoring` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `reseller_id` int(11) NOT NULL,
    `username` varchar(64) NOT NULL,
    `session_id` varchar(64) NOT NULL,
    `router_ip` varchar(15) NOT NULL,
    `client_ip` varchar(15) NOT NULL,
    `session_start` datetime NOT NULL,
    `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `bytes_in` bigint(20) DEFAULT 0,
    `bytes_out` bigint(20) DEFAULT 0,
    `session_time` int(11) DEFAULT 0,
    `status` enum('active','inactive','expired') DEFAULT 'active',
    PRIMARY KEY (`id`),
    UNIQUE KEY `session_id` (`session_id`),
    KEY `reseller_id` (`reseller_id`),
    KEY `username` (`username`),
    KEY `status` (`status`),
    KEY `last_update` (`last_update`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Real-time session update procedure
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_update_session_monitoring()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_username VARCHAR(64);
    DECLARE v_session_id VARCHAR(64);
    DECLARE v_router_ip VARCHAR(15);
    DECLARE v_client_ip VARCHAR(15);
    DECLARE v_session_start DATETIME;
    DECLARE v_bytes_in BIGINT;
    DECLARE v_bytes_out BIGINT;
    DECLARE v_session_time INT;
    DECLARE v_reseller_id INT;
    
    DECLARE session_cursor CURSOR FOR
        SELECT 
            ra.username,
            ra.acctsessionid,
            ra.nasipaddress,
            ra.framedipaddress,
            ra.dateAdded,
            ra.acctinputoctets,
            ra.acctoutputoctets,
            ra.acctsessiontime,
            c.reseller_id
        FROM rad_acct ra
        INNER JOIN tbl_customers c ON ra.username = c.username
        WHERE ra.dateAdded >= DATE_SUB(NOW(), INTERVAL 1 HOUR);
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- Clear old inactive sessions
    DELETE FROM tbl_session_monitoring 
    WHERE last_update < DATE_SUB(NOW(), INTERVAL 5 MINUTE);
    
    OPEN session_cursor;
    
    read_loop: LOOP
        FETCH session_cursor INTO v_username, v_session_id, v_router_ip, v_client_ip, 
                                 v_session_start, v_bytes_in, v_bytes_out, v_session_time, v_reseller_id;
        
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        INSERT INTO tbl_session_monitoring 
        (reseller_id, username, session_id, router_ip, client_ip, session_start, 
         bytes_in, bytes_out, session_time, status)
        VALUES 
        (v_reseller_id, v_username, v_session_id, v_router_ip, v_client_ip, 
         v_session_start, v_bytes_in, v_bytes_out, v_session_time, 'active')
        ON DUPLICATE KEY UPDATE
            bytes_in = VALUES(bytes_in),
            bytes_out = VALUES(bytes_out),
            session_time = VALUES(session_time),
            status = VALUES(status),
            last_update = CURRENT_TIMESTAMP;
    END LOOP;
    
    CLOSE session_cursor;
    
    SELECT 'Session monitoring updated' as status;
END$$
DELIMITER ;

-- Get live sessions for a reseller
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_get_live_sessions(IN p_reseller_id INT)
BEGIN
    SELECT 
        sm.username,
        sm.session_id,
        sm.router_ip,
        sm.client_ip,
        sm.session_start,
        sm.last_update,
        sm.bytes_in,
        sm.bytes_out,
        sm.session_time,
        sm.status,
        c.fullname as customer_name,
        c.phonenumber,
        ur.namebp as plan_name,
        ur.expiration,
        r.name as router_name,
        ROUND(sm.bytes_in / 1024 / 1024, 2) as mb_downloaded,
        ROUND(sm.bytes_out / 1024 / 1024, 2) as mb_uploaded,
        ROUND((sm.bytes_in + sm.bytes_out) / 1024 / 1024, 2) as total_mb,
        SEC_TO_TIME(sm.session_time) as session_duration
    FROM tbl_session_monitoring sm
    INNER JOIN tbl_customers c ON sm.username = c.username
    LEFT JOIN tbl_user_recharges ur ON c.id = ur.customer_id AND ur.status = 'on'
    LEFT JOIN tbl_routers r ON sm.router_ip = r.ip_address
    WHERE sm.reseller_id = p_reseller_id
    AND sm.status = 'active'
    ORDER BY sm.last_update DESC;
END$$
DELIMITER ;

-- ===================================================================
-- 2. BANDWIDTH USAGE TRACKING
-- ===================================================================

-- Create bandwidth usage summary table
CREATE TABLE IF NOT EXISTS `tbl_bandwidth_usage` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `reseller_id` int(11) NOT NULL,
    `username` varchar(64) NOT NULL,
    `date` date NOT NULL,
    `hour` tinyint(4) NOT NULL,
    `bytes_in` bigint(20) DEFAULT 0,
    `bytes_out` bigint(20) DEFAULT 0,
    `session_count` int(11) DEFAULT 0,
    `session_time` int(11) DEFAULT 0,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_usage` (`reseller_id`, `username`, `date`, `hour`),
    KEY `date_hour` (`date`, `hour`),
    KEY `reseller_id` (`reseller_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Update bandwidth usage summary
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_update_bandwidth_usage()
BEGIN
    INSERT INTO tbl_bandwidth_usage 
    (reseller_id, username, date, hour, bytes_in, bytes_out, session_count, session_time)
    SELECT 
        c.reseller_id,
        ra.username,
        DATE(ra.dateAdded) as date,
        HOUR(ra.dateAdded) as hour,
        SUM(ra.acctinputoctets) as bytes_in,
        SUM(ra.acctoutputoctets) as bytes_out,
        COUNT(*) as session_count,
        SUM(ra.acctsessiontime) as session_time
    FROM rad_acct ra
    INNER JOIN tbl_customers c ON ra.username = c.username
    WHERE ra.dateAdded >= DATE_SUB(NOW(), INTERVAL 2 HOUR)
    GROUP BY c.reseller_id, ra.username, DATE(ra.dateAdded), HOUR(ra.dateAdded)
    ON DUPLICATE KEY UPDATE
        bytes_in = VALUES(bytes_in),
        bytes_out = VALUES(bytes_out),
        session_count = VALUES(session_count),
        session_time = VALUES(session_time);
        
    SELECT 'Bandwidth usage updated' as status;
END$$
DELIMITER ;

-- Get bandwidth usage report
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_get_bandwidth_report(
    IN p_reseller_id INT,
    IN p_start_date DATE,
    IN p_end_date DATE
)
BEGIN
    SELECT 
        bu.date,
        bu.hour,
        COUNT(DISTINCT bu.username) as active_users,
        SUM(bu.bytes_in) as total_download,
        SUM(bu.bytes_out) as total_upload,
        SUM(bu.bytes_in + bu.bytes_out) as total_bandwidth,
        ROUND(SUM(bu.bytes_in) / 1024 / 1024 / 1024, 2) as gb_downloaded,
        ROUND(SUM(bu.bytes_out) / 1024 / 1024 / 1024, 2) as gb_uploaded,
        ROUND(SUM(bu.bytes_in + bu.bytes_out) / 1024 / 1024 / 1024, 2) as total_gb,
        SUM(bu.session_time) as total_session_time,
        AVG(bu.session_time) as avg_session_time
    FROM tbl_bandwidth_usage bu
    WHERE bu.reseller_id = p_reseller_id
    AND bu.date BETWEEN p_start_date AND p_end_date
    GROUP BY bu.date, bu.hour
    ORDER BY bu.date DESC, bu.hour DESC;
END$$
DELIMITER ;

-- Get top bandwidth users
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_get_top_bandwidth_users(
    IN p_reseller_id INT,
    IN p_days INT DEFAULT 7,
    IN p_limit INT DEFAULT 20
)
BEGIN
    SELECT 
        bu.username,
        c.fullname as customer_name,
        c.phonenumber,
        ur.namebp as plan_name,
        SUM(bu.bytes_in + bu.bytes_out) as total_bandwidth,
        ROUND(SUM(bu.bytes_in) / 1024 / 1024 / 1024, 2) as gb_downloaded,
        ROUND(SUM(bu.bytes_out) / 1024 / 1024 / 1024, 2) as gb_uploaded,
        ROUND(SUM(bu.bytes_in + bu.bytes_out) / 1024 / 1024 / 1024, 2) as total_gb,
        SUM(bu.session_count) as total_sessions,
        SEC_TO_TIME(SUM(bu.session_time)) as total_online_time,
        COUNT(DISTINCT bu.date) as active_days
    FROM tbl_bandwidth_usage bu
    INNER JOIN tbl_customers c ON bu.username = c.username
    LEFT JOIN tbl_user_recharges ur ON c.id = ur.customer_id AND ur.status = 'on'
    WHERE bu.reseller_id = p_reseller_id
    AND bu.date >= DATE_SUB(CURDATE(), INTERVAL p_days DAY)
    GROUP BY bu.username, c.fullname, c.phonenumber, ur.namebp
    ORDER BY total_bandwidth DESC
    LIMIT p_limit;
END$$
DELIMITER ;

-- ===================================================================
-- 3. ROUTER HEALTH MONITORING
-- ===================================================================

-- Create router health monitoring table
CREATE TABLE IF NOT EXISTS `tbl_router_health` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `reseller_id` int(11) NOT NULL,
    `router_id` int(11) NOT NULL,
    `router_ip` varchar(15) NOT NULL,
    `status` enum('online','offline','warning') NOT NULL,
    `response_time` float DEFAULT NULL,
    `active_users` int(11) DEFAULT 0,
    `cpu_usage` float DEFAULT NULL,
    `memory_usage` float DEFAULT NULL,
    `uptime` int(11) DEFAULT NULL,
    `last_check` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `error_message` text,
    PRIMARY KEY (`id`),
    KEY `reseller_id` (`reseller_id`),
    KEY `router_id` (`router_id`),
    KEY `last_check` (`last_check`),
    KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Monitor router health
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_monitor_router_health()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_reseller_id INT;
    DECLARE v_router_id INT;
    DECLARE v_router_ip VARCHAR(15);
    DECLARE v_active_users INT;
    DECLARE v_status VARCHAR(10);
    
    DECLARE router_cursor CURSOR FOR
        SELECT 
            r.reseller_id,
            r.id,
            r.ip_address,
            COUNT(DISTINCT sm.username) as active_users,
            CASE 
                WHEN r.last_seen >= DATE_SUB(NOW(), INTERVAL 2 MINUTE) THEN 'online'
                WHEN r.last_seen >= DATE_SUB(NOW(), INTERVAL 10 MINUTE) THEN 'warning'
                ELSE 'offline'
            END as status
        FROM tbl_routers r
        LEFT JOIN tbl_session_monitoring sm ON r.ip_address = sm.router_ip 
            AND sm.status = 'active'
        WHERE r.enabled = 1
        GROUP BY r.reseller_id, r.id, r.ip_address, r.last_seen;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN router_cursor;
    
    read_loop: LOOP
        FETCH router_cursor INTO v_reseller_id, v_router_id, v_router_ip, v_active_users, v_status;
        
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        INSERT INTO tbl_router_health 
        (reseller_id, router_id, router_ip, status, active_users, last_check)
        VALUES 
        (v_reseller_id, v_router_id, v_router_ip, v_status, v_active_users, NOW());
    END LOOP;
    
    CLOSE router_cursor;
    
    -- Clean old health data (keep last 24 hours)
    DELETE FROM tbl_router_health 
    WHERE last_check < DATE_SUB(NOW(), INTERVAL 24 HOUR);
    
    SELECT 'Router health monitoring updated' as status;
END$$
DELIMITER ;

-- Get router health status
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_get_router_health(IN p_reseller_id INT)
BEGIN
    SELECT 
        r.name as router_name,
        r.ip_address,
        r.description,
        rh.status,
        rh.active_users,
        rh.response_time,
        rh.cpu_usage,
        rh.memory_usage,
        rh.uptime,
        rh.last_check,
        rh.error_message,
        r.last_seen as router_last_seen,
        CASE 
            WHEN rh.status = 'online' THEN 'success'
            WHEN rh.status = 'warning' THEN 'warning'
            ELSE 'danger'
        END as alert_level
    FROM tbl_routers r
    LEFT JOIN tbl_router_health rh ON r.id = rh.router_id 
        AND rh.id = (SELECT MAX(id) FROM tbl_router_health WHERE router_id = r.id)
    WHERE r.reseller_id = p_reseller_id
    ORDER BY rh.last_check DESC;
END$$
DELIMITER ;

-- ===================================================================
-- 4. PAYMENT PROCESSING MONITORING
-- ===================================================================

-- Create payment monitoring table
CREATE TABLE IF NOT EXISTS `tbl_payment_monitoring` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `reseller_id` int(11) NOT NULL,
    `payment_method` varchar(50) NOT NULL,
    `total_transactions` int(11) DEFAULT 0,
    `successful_payments` int(11) DEFAULT 0,
    `failed_payments` int(11) DEFAULT 0,
    `pending_payments` int(11) DEFAULT 0,
    `total_amount` decimal(10,2) DEFAULT 0.00,
    `success_rate` decimal(5,2) DEFAULT 0.00,
    `avg_processing_time` int(11) DEFAULT 0,
    `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `reseller_method` (`reseller_id`, `payment_method`),
    KEY `last_updated` (`last_updated`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Update payment monitoring
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_update_payment_monitoring()
BEGIN
    -- Update payment gateway stats
    INSERT INTO tbl_payment_monitoring 
    (reseller_id, payment_method, total_transactions, successful_payments, 
     failed_payments, pending_payments, total_amount, success_rate)
    SELECT 
        COALESCE(c.reseller_id, 1) as reseller_id,
        pg.gateway as payment_method,
        COUNT(*) as total_transactions,
        COUNT(CASE WHEN pg.status = 2 THEN 1 END) as successful_payments,
        COUNT(CASE WHEN pg.status = 3 THEN 1 END) as failed_payments,
        COUNT(CASE WHEN pg.status = 1 THEN 1 END) as pending_payments,
        SUM(CASE WHEN pg.status = 2 THEN pg.price ELSE 0 END) as total_amount,
        ROUND(COUNT(CASE WHEN pg.status = 2 THEN 1 END) * 100.0 / COUNT(*), 2) as success_rate
    FROM tbl_payment_gateway pg
    LEFT JOIN tbl_customers c ON pg.username = c.username
    WHERE pg.created_date >= DATE_SUB(NOW(), INTERVAL 1 HOUR)
    GROUP BY COALESCE(c.reseller_id, 1), pg.gateway
    ON DUPLICATE KEY UPDATE
        total_transactions = VALUES(total_transactions),
        successful_payments = VALUES(successful_payments),
        failed_payments = VALUES(failed_payments),
        pending_payments = VALUES(pending_payments),
        total_amount = VALUES(total_amount),
        success_rate = VALUES(success_rate);
        
    -- Update M-Pesa stats
    INSERT INTO tbl_payment_monitoring 
    (reseller_id, payment_method, total_transactions, successful_payments, 
     failed_payments, pending_payments, total_amount, success_rate)
    SELECT 
        COALESCE(ps.reseller_id, 1) as reseller_id,
        'M-Pesa' as payment_method,
        COUNT(*) as total_transactions,
        COUNT(CASE WHEN mt.status = 'completed' THEN 1 END) as successful_payments,
        COUNT(CASE WHEN mt.status = 'failed' THEN 1 END) as failed_payments,
        COUNT(CASE WHEN mt.status = 'pending' THEN 1 END) as pending_payments,
        SUM(CASE WHEN mt.status = 'completed' THEN mt.amount ELSE 0 END) as total_amount,
        ROUND(COUNT(CASE WHEN mt.status = 'completed' THEN 1 END) * 100.0 / COUNT(*), 2) as success_rate
    FROM tbl_mpesa_transactions mt
    LEFT JOIN tbl_portal_sessions ps ON mt.session_id = ps.session_id
    WHERE mt.created_at >= DATE_SUB(NOW(), INTERVAL 1 HOUR)
    GROUP BY COALESCE(ps.reseller_id, 1)
    ON DUPLICATE KEY UPDATE
        total_transactions = VALUES(total_transactions),
        successful_payments = VALUES(successful_payments),
        failed_payments = VALUES(failed_payments),
        pending_payments = VALUES(pending_payments),
        total_amount = VALUES(total_amount),
        success_rate = VALUES(success_rate);
        
    SELECT 'Payment monitoring updated' as status;
END$$
DELIMITER ;

-- Get payment monitoring dashboard
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_get_payment_monitoring(IN p_reseller_id INT)
BEGIN
    SELECT 
        pm.payment_method,
        pm.total_transactions,
        pm.successful_payments,
        pm.failed_payments,
        pm.pending_payments,
        pm.total_amount,
        pm.success_rate,
        pm.avg_processing_time,
        pm.last_updated,
        CASE 
            WHEN pm.success_rate >= 95 THEN 'success'
            WHEN pm.success_rate >= 80 THEN 'warning'
            ELSE 'danger'
        END as health_status
    FROM tbl_payment_monitoring pm
    WHERE pm.reseller_id = p_reseller_id
    ORDER BY pm.total_amount DESC;
END$$
DELIMITER ;

-- ===================================================================
-- 5. SYSTEM PERFORMANCE MONITORING
-- ===================================================================

-- Create system performance monitoring table
CREATE TABLE IF NOT EXISTS `tbl_system_performance` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `metric_name` varchar(50) NOT NULL,
    `metric_value` decimal(10,2) NOT NULL,
    `metric_unit` varchar(20) NOT NULL,
    `alert_threshold` decimal(10,2) DEFAULT NULL,
    `status` enum('normal','warning','critical') DEFAULT 'normal',
    `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `metric_name` (`metric_name`),
    KEY `timestamp` (`timestamp`),
    KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Monitor system performance
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_monitor_system_performance()
BEGIN
    DECLARE db_size DECIMAL(10,2);
    DECLARE table_count INT;
    DECLARE slow_queries INT;
    
    -- Get database size
    SELECT ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) 
    INTO db_size
    FROM information_schema.tables 
    WHERE table_schema = DATABASE();
    
    -- Get table count
    SELECT COUNT(*) 
    INTO table_count
    FROM information_schema.tables 
    WHERE table_schema = DATABASE();
    
    -- Get slow queries count
    SELECT COUNT(*) 
    INTO slow_queries
    FROM information_schema.processlist 
    WHERE command = 'Query' AND time > 5;
    
    -- Insert performance metrics
    INSERT INTO tbl_system_performance (metric_name, metric_value, metric_unit, alert_threshold, status)
    VALUES 
    ('database_size', db_size, 'MB', 10240, 
     CASE WHEN db_size > 10240 THEN 'critical' WHEN db_size > 5120 THEN 'warning' ELSE 'normal' END),
    ('table_count', table_count, 'count', 100, 'normal'),
    ('slow_queries', slow_queries, 'count', 10, 
     CASE WHEN slow_queries > 10 THEN 'critical' WHEN slow_queries > 5 THEN 'warning' ELSE 'normal' END);
     
    -- Clean old performance data (keep last 24 hours)
    DELETE FROM tbl_system_performance 
    WHERE timestamp < DATE_SUB(NOW(), INTERVAL 24 HOUR);
    
    SELECT 'System performance monitoring updated' as status;
END$$
DELIMITER ;

-- ===================================================================
-- 6. ALERT AND NOTIFICATION SYSTEM
-- ===================================================================

-- Create alerts table
CREATE TABLE IF NOT EXISTS `tbl_alerts` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `reseller_id` int(11) NOT NULL,
    `alert_type` enum('router_down','payment_failed','bandwidth_exceeded','service_expired','system_error') NOT NULL,
    `severity` enum('low','medium','high','critical') NOT NULL,
    `title` varchar(100) NOT NULL,
    `message` text NOT NULL,
    `data` text,
    `status` enum('open','acknowledged','resolved') DEFAULT 'open',
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `resolved_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `reseller_id` (`reseller_id`),
    KEY `alert_type` (`alert_type`),
    KEY `status` (`status`),
    KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Generate alerts based on monitoring data
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_generate_alerts()
BEGIN
    -- Router down alerts
    INSERT INTO tbl_alerts (reseller_id, alert_type, severity, title, message, data)
    SELECT 
        rh.reseller_id,
        'router_down' as alert_type,
        'high' as severity,
        CONCAT('Router ', r.name, ' is offline') as title,
        CONCAT('Router ', r.name, ' (', r.ip_address, ') has been offline for more than 10 minutes') as message,
        JSON_OBJECT('router_id', r.id, 'ip_address', r.ip_address, 'last_seen', r.last_seen) as data
    FROM tbl_router_health rh
    INNER JOIN tbl_routers r ON rh.router_id = r.id
    WHERE rh.status = 'offline'
    AND rh.last_check >= DATE_SUB(NOW(), INTERVAL 5 MINUTE)
    AND NOT EXISTS (
        SELECT 1 FROM tbl_alerts 
        WHERE reseller_id = rh.reseller_id 
        AND alert_type = 'router_down'
        AND JSON_EXTRACT(data, '$.router_id') = r.id
        AND status = 'open'
    );
    
    -- Payment failed alerts
    INSERT INTO tbl_alerts (reseller_id, alert_type, severity, title, message, data)
    SELECT 
        pm.reseller_id,
        'payment_failed' as alert_type,
        'medium' as severity,
        CONCAT('High payment failure rate for ', pm.payment_method) as title,
        CONCAT('Payment failure rate for ', pm.payment_method, ' is ', pm.success_rate, '%') as message,
        JSON_OBJECT('payment_method', pm.payment_method, 'success_rate', pm.success_rate) as data
    FROM tbl_payment_monitoring pm
    WHERE pm.success_rate < 80
    AND pm.last_updated >= DATE_SUB(NOW(), INTERVAL 30 MINUTE)
    AND NOT EXISTS (
        SELECT 1 FROM tbl_alerts 
        WHERE reseller_id = pm.reseller_id 
        AND alert_type = 'payment_failed'
        AND JSON_EXTRACT(data, '$.payment_method') = pm.payment_method
        AND status = 'open'
    );
    
    -- Service expiring alerts
    INSERT INTO tbl_alerts (reseller_id, alert_type, severity, title, message, data)
    SELECT 
        c.reseller_id,
        'service_expired' as alert_type,
        'medium' as severity,
        'Services expiring soon' as title,
        CONCAT(COUNT(*), ' services are expiring within 24 hours') as message,
        JSON_OBJECT('count', COUNT(*), 'expiration_date', DATE_ADD(CURDATE(), INTERVAL 1 DAY)) as data
    FROM tbl_customers c
    INNER JOIN tbl_user_recharges ur ON c.id = ur.customer_id
    WHERE ur.status = 'on'
    AND ur.expiration <= DATE_ADD(CURDATE(), INTERVAL 1 DAY)
    AND NOT EXISTS (
        SELECT 1 FROM tbl_alerts 
        WHERE reseller_id = c.reseller_id 
        AND alert_type = 'service_expired'
        AND DATE(created_at) = CURDATE()
        AND status = 'open'
    )
    GROUP BY c.reseller_id
    HAVING COUNT(*) > 5;
    
    SELECT 'Alerts generated' as status;
END$$
DELIMITER ;

-- Get active alerts for reseller
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_get_active_alerts(IN p_reseller_id INT)
BEGIN
    SELECT 
        id,
        alert_type,
        severity,
        title,
        message,
        data,
        status,
        created_at,
        CASE 
            WHEN severity = 'critical' THEN 'danger'
            WHEN severity = 'high' THEN 'warning'
            WHEN severity = 'medium' THEN 'info'
            ELSE 'secondary'
        END as alert_class
    FROM tbl_alerts
    WHERE reseller_id = p_reseller_id
    AND status = 'open'
    ORDER BY 
        CASE severity
            WHEN 'critical' THEN 1
            WHEN 'high' THEN 2
            WHEN 'medium' THEN 3
            ELSE 4
        END,
        created_at DESC;
END$$
DELIMITER ;

-- ===================================================================
-- 7. AUTOMATED MONITORING EVENTS
-- ===================================================================

-- Create events for automated monitoring
CREATE EVENT IF NOT EXISTS `e_update_session_monitoring`
ON SCHEDULE EVERY 1 MINUTE
DO CALL sp_update_session_monitoring();

CREATE EVENT IF NOT EXISTS `e_update_bandwidth_usage`
ON SCHEDULE EVERY 5 MINUTE
DO CALL sp_update_bandwidth_usage();

CREATE EVENT IF NOT EXISTS `e_monitor_router_health`
ON SCHEDULE EVERY 2 MINUTE
DO CALL sp_monitor_router_health();

CREATE EVENT IF NOT EXISTS `e_update_payment_monitoring`
ON SCHEDULE EVERY 5 MINUTE
DO CALL sp_update_payment_monitoring();

CREATE EVENT IF NOT EXISTS `e_monitor_system_performance`
ON SCHEDULE EVERY 10 MINUTE
DO CALL sp_monitor_system_performance();

CREATE EVENT IF NOT EXISTS `e_generate_alerts`
ON SCHEDULE EVERY 5 MINUTE
DO CALL sp_generate_alerts();

-- Enable event scheduler
SET GLOBAL event_scheduler = ON;

-- ===================================================================
-- 8. MONITORING DASHBOARD VIEWS
-- ===================================================================

-- Create comprehensive monitoring dashboard view
CREATE OR REPLACE VIEW v_reseller_monitoring_dashboard AS
SELECT 
    r.id as reseller_id,
    r.name as reseller_name,
    r.status as reseller_status,
    
    -- Session statistics
    COUNT(DISTINCT sm.username) as active_sessions,
    ROUND(SUM(sm.bytes_in + sm.bytes_out) / 1024 / 1024, 2) as current_bandwidth_mb,
    
    -- Router health
    COUNT(DISTINCT rt.id) as total_routers,
    COUNT(DISTINCT CASE WHEN rh.status = 'online' THEN rt.id END) as online_routers,
    COUNT(DISTINCT CASE WHEN rh.status = 'offline' THEN rt.id END) as offline_routers,
    
    -- Payment health
    ROUND(AVG(pm.success_rate), 2) as avg_payment_success_rate,
    
    -- Alerts
    COUNT(DISTINCT CASE WHEN a.status = 'open' AND a.severity = 'critical' THEN a.id END) as critical_alerts,
    COUNT(DISTINCT CASE WHEN a.status = 'open' AND a.severity = 'high' THEN a.id END) as high_alerts,
    COUNT(DISTINCT CASE WHEN a.status = 'open' THEN a.id END) as total_open_alerts,
    
    -- Last update
    MAX(sm.last_update) as last_session_update,
    MAX(rh.last_check) as last_router_check,
    MAX(pm.last_updated) as last_payment_check
    
FROM tbl_resellers r
LEFT JOIN tbl_session_monitoring sm ON r.id = sm.reseller_id AND sm.status = 'active'
LEFT JOIN tbl_routers rt ON r.id = rt.reseller_id
LEFT JOIN tbl_router_health rh ON rt.id = rh.router_id 
    AND rh.id = (SELECT MAX(id) FROM tbl_router_health WHERE router_id = rt.id)
LEFT JOIN tbl_payment_monitoring pm ON r.id = pm.reseller_id
LEFT JOIN tbl_alerts a ON r.id = a.reseller_id
WHERE r.id > 1  -- Exclude system admin
GROUP BY r.id, r.name, r.status;

-- ===================================================================
-- USAGE EXAMPLES
-- ===================================================================

-- Example usage of monitoring procedures:
/*
-- Get live sessions for reseller 1
CALL sp_get_live_sessions(1);

-- Get bandwidth report for last 7 days
CALL sp_get_bandwidth_report(1, DATE_SUB(CURDATE(), INTERVAL 7 DAY), CURDATE());

-- Get router health status
CALL sp_get_router_health(1);

-- Get payment monitoring dashboard
CALL sp_get_payment_monitoring(1);

-- Get active alerts
CALL sp_get_active_alerts(1);

-- View monitoring dashboard
SELECT * FROM v_reseller_monitoring_dashboard;
*/

SELECT 'Real-time monitoring system created successfully!' as Status,
       'All monitoring procedures, events, and views are active' as Message,
       'Events will run automatically to update monitoring data' as Info;