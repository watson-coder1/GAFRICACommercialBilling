-- ===================================================================
-- PERFORMANCE TUNING AND MAINTENANCE SCRIPT
-- Gemini & Context7 Analysis - Professional Multi-Reseller Dashboard
-- ===================================================================

-- This script provides comprehensive performance tuning and maintenance for:
-- 1. Database optimization and tuning
-- 2. Query performance analysis
-- 3. Index optimization
-- 4. Data archival and cleanup
-- 5. System health monitoring
-- 6. Backup and recovery optimization

-- ===================================================================
-- 1. DATABASE OPTIMIZATION AND TUNING
-- ===================================================================

-- MySQL configuration optimization recommendations
-- Add these to your my.cnf file for better performance:
/*
[mysqld]
# General performance settings
innodb_buffer_pool_size = 70% of available RAM
innodb_log_file_size = 256M
innodb_flush_log_at_trx_commit = 2
innodb_flush_method = O_DIRECT
query_cache_size = 128M
query_cache_type = 1
tmp_table_size = 64M
max_heap_table_size = 64M
key_buffer_size = 128M
max_connections = 200
thread_cache_size = 16
table_open_cache = 2048
open_files_limit = 65535

# Logging
slow_query_log = 1
slow_query_log_file = /var/log/mysql/slow.log
long_query_time = 2
log_queries_not_using_indexes = 1
*/

-- Optimize database tables
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_optimize_database()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE table_name VARCHAR(128);
    DECLARE table_size BIGINT;
    DECLARE fragmentation DECIMAL(5,2);
    
    DECLARE table_cursor CURSOR FOR
        SELECT 
            t.table_name,
            t.data_length + t.index_length as table_size,
            ROUND(t.data_free / (t.data_length + t.index_length) * 100, 2) as fragmentation
        FROM information_schema.tables t
        WHERE t.table_schema = DATABASE()
        AND t.table_type = 'BASE TABLE'
        AND (t.data_length + t.index_length) > 1024 * 1024  -- Tables larger than 1MB
        ORDER BY table_size DESC;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- Create optimization log table
    CREATE TABLE IF NOT EXISTS tbl_optimization_log (
        id INT AUTO_INCREMENT PRIMARY KEY,
        table_name VARCHAR(128),
        operation VARCHAR(50),
        before_size BIGINT,
        after_size BIGINT,
        time_taken INT,
        optimization_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    
    OPEN table_cursor;
    
    optimization_loop: LOOP
        FETCH table_cursor INTO table_name, table_size, fragmentation;
        
        IF done THEN
            LEAVE optimization_loop;
        END IF;
        
        SET @start_time = UNIX_TIMESTAMP();
        
        -- Optimize table if fragmentation > 10%
        IF fragmentation > 10 THEN
            SET @sql = CONCAT('OPTIMIZE TABLE ', table_name);
            PREPARE stmt FROM @sql;
            EXECUTE stmt;
            DEALLOCATE PREPARE stmt;
            
            -- Log optimization
            INSERT INTO tbl_optimization_log (table_name, operation, before_size, time_taken)
            VALUES (table_name, 'OPTIMIZE', table_size, UNIX_TIMESTAMP() - @start_time);
        END IF;
        
        -- Analyze table statistics
        SET @sql = CONCAT('ANALYZE TABLE ', table_name);
        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
        
    END LOOP;
    
    CLOSE table_cursor;
    
    SELECT 'Database optimization completed' as status;
END$$
DELIMITER ;

-- ===================================================================
-- 2. QUERY PERFORMANCE ANALYSIS
-- ===================================================================

-- Create query performance monitoring table
CREATE TABLE IF NOT EXISTS `tbl_query_performance` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `query_type` varchar(50) NOT NULL,
    `query_hash` varchar(64) NOT NULL,
    `query_text` text NOT NULL,
    `execution_count` int(11) DEFAULT 1,
    `avg_execution_time` decimal(10,4) DEFAULT 0.0000,
    `max_execution_time` decimal(10,4) DEFAULT 0.0000,
    `total_execution_time` decimal(10,4) DEFAULT 0.0000,
    `avg_rows_examined` int(11) DEFAULT 0,
    `avg_rows_sent` int(11) DEFAULT 0,
    `first_seen` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `last_seen` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `query_hash` (`query_hash`),
    KEY `query_type` (`query_type`),
    KEY `avg_execution_time` (`avg_execution_time`),
    KEY `last_seen` (`last_seen`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Analyze slow queries
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_analyze_slow_queries()
BEGIN
    -- Get slow queries from performance schema (MySQL 5.7+)
    INSERT INTO tbl_query_performance 
    (query_type, query_hash, query_text, execution_count, avg_execution_time, 
     max_execution_time, total_execution_time, avg_rows_examined, avg_rows_sent)
    SELECT 
        CASE 
            WHEN UPPER(LEFT(TRIM(digest_text), 6)) = 'SELECT' THEN 'SELECT'
            WHEN UPPER(LEFT(TRIM(digest_text), 6)) = 'INSERT' THEN 'INSERT'
            WHEN UPPER(LEFT(TRIM(digest_text), 6)) = 'UPDATE' THEN 'UPDATE'
            WHEN UPPER(LEFT(TRIM(digest_text), 6)) = 'DELETE' THEN 'DELETE'
            ELSE 'OTHER'
        END as query_type,
        digest as query_hash,
        digest_text as query_text,
        count_star as execution_count,
        avg_timer_wait / 1000000000 as avg_execution_time,
        max_timer_wait / 1000000000 as max_execution_time,
        sum_timer_wait / 1000000000 as total_execution_time,
        avg_rows_examined,
        avg_rows_sent
    FROM performance_schema.events_statements_summary_by_digest
    WHERE avg_timer_wait > 1000000000  -- More than 1 second
    AND count_star > 10  -- Executed more than 10 times
    ORDER BY avg_timer_wait DESC
    LIMIT 100
    ON DUPLICATE KEY UPDATE
        execution_count = VALUES(execution_count),
        avg_execution_time = VALUES(avg_execution_time),
        max_execution_time = VALUES(max_execution_time),
        total_execution_time = VALUES(total_execution_time),
        avg_rows_examined = VALUES(avg_rows_examined),
        avg_rows_sent = VALUES(avg_rows_sent);
        
    -- Clean old query performance data
    DELETE FROM tbl_query_performance 
    WHERE last_seen < DATE_SUB(NOW(), INTERVAL 7 DAY);
    
    SELECT 'Slow query analysis completed' as status;
END$$
DELIMITER ;

-- Get query performance report
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_get_query_performance_report()
BEGIN
    SELECT 
        query_type,
        COUNT(*) as query_count,
        AVG(avg_execution_time) as avg_time,
        MAX(max_execution_time) as max_time,
        SUM(total_execution_time) as total_time,
        AVG(avg_rows_examined) as avg_rows_examined,
        AVG(execution_count) as avg_executions
    FROM tbl_query_performance
    WHERE last_seen >= DATE_SUB(NOW(), INTERVAL 24 HOUR)
    GROUP BY query_type
    ORDER BY total_time DESC;
    
    -- Top 10 slowest queries
    SELECT 
        query_type,
        LEFT(query_text, 100) as query_preview,
        execution_count,
        avg_execution_time,
        max_execution_time,
        total_execution_time,
        avg_rows_examined
    FROM tbl_query_performance
    WHERE last_seen >= DATE_SUB(NOW(), INTERVAL 24 HOUR)
    ORDER BY avg_execution_time DESC
    LIMIT 10;
END$$
DELIMITER ;

-- ===================================================================
-- 3. INDEX OPTIMIZATION
-- ===================================================================

-- Analyze index usage
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_analyze_index_usage()
BEGIN
    -- Create index usage analysis table
    CREATE TABLE IF NOT EXISTS tbl_index_analysis (
        id INT AUTO_INCREMENT PRIMARY KEY,
        table_name VARCHAR(128),
        index_name VARCHAR(128),
        column_name VARCHAR(128),
        cardinality BIGINT,
        index_type VARCHAR(16),
        is_unique BOOLEAN,
        usage_count BIGINT DEFAULT 0,
        last_used TIMESTAMP NULL,
        recommendation TEXT,
        analysis_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    
    -- Clear previous analysis
    DELETE FROM tbl_index_analysis WHERE analysis_date < DATE_SUB(NOW(), INTERVAL 1 DAY);
    
    -- Insert current index information
    INSERT INTO tbl_index_analysis 
    (table_name, index_name, column_name, cardinality, index_type, is_unique)
    SELECT 
        table_name,
        index_name,
        column_name,
        cardinality,
        index_type,
        NOT non_unique as is_unique
    FROM information_schema.statistics
    WHERE table_schema = DATABASE()
    AND table_name LIKE 'tbl_%';
    
    -- Analyze unused indexes
    UPDATE tbl_index_analysis 
    SET recommendation = 'Consider dropping - appears unused'
    WHERE cardinality = 0
    AND index_name != 'PRIMARY';
    
    -- Analyze duplicate indexes
    UPDATE tbl_index_analysis t1
    SET recommendation = 'Possible duplicate index'
    WHERE EXISTS (
        SELECT 1 FROM tbl_index_analysis t2
        WHERE t1.table_name = t2.table_name
        AND t1.column_name = t2.column_name
        AND t1.index_name != t2.index_name
        AND t1.id != t2.id
    );
    
    SELECT 'Index analysis completed' as status;
END$$
DELIMITER ;

-- Get index recommendations
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_get_index_recommendations()
BEGIN
    -- Show potentially problematic indexes
    SELECT 
        table_name,
        index_name,
        column_name,
        cardinality,
        index_type,
        recommendation
    FROM tbl_index_analysis
    WHERE recommendation IS NOT NULL
    ORDER BY table_name, index_name;
    
    -- Show index usage statistics
    SELECT 
        table_name,
        COUNT(*) as total_indexes,
        COUNT(CASE WHEN cardinality > 0 THEN 1 END) as used_indexes,
        COUNT(CASE WHEN cardinality = 0 THEN 1 END) as unused_indexes,
        AVG(cardinality) as avg_cardinality
    FROM tbl_index_analysis
    WHERE index_name != 'PRIMARY'
    GROUP BY table_name
    ORDER BY unused_indexes DESC;
END$$
DELIMITER ;

-- ===================================================================
-- 4. DATA ARCHIVAL AND CLEANUP
-- ===================================================================

-- Create archive tables
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_create_archive_tables()
BEGIN
    -- Archive old transactions
    CREATE TABLE IF NOT EXISTS tbl_transactions_archive LIKE tbl_transactions;
    ALTER TABLE tbl_transactions_archive ADD COLUMN archived_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
    
    -- Archive old logs
    CREATE TABLE IF NOT EXISTS tbl_logs_archive LIKE tbl_logs;
    ALTER TABLE tbl_logs_archive ADD COLUMN archived_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
    
    -- Archive old RADIUS accounting
    CREATE TABLE IF NOT EXISTS radacct_archive LIKE radacct;
    ALTER TABLE radacct_archive ADD COLUMN archived_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
    
    -- Archive old payment gateway data
    CREATE TABLE IF NOT EXISTS tbl_payment_gateway_archive LIKE tbl_payment_gateway;
    ALTER TABLE tbl_payment_gateway_archive ADD COLUMN archived_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
    
    SELECT 'Archive tables created' as status;
END$$
DELIMITER ;

-- Archive old data
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_archive_old_data(IN p_archive_days INT DEFAULT 90)
BEGIN
    DECLARE archived_count INT DEFAULT 0;
    
    -- Archive old transactions
    INSERT INTO tbl_transactions_archive 
    SELECT *, NOW() FROM tbl_transactions 
    WHERE recharged_on < DATE_SUB(CURDATE(), INTERVAL p_archive_days DAY);
    
    SET archived_count = ROW_COUNT();
    
    DELETE FROM tbl_transactions 
    WHERE recharged_on < DATE_SUB(CURDATE(), INTERVAL p_archive_days DAY);
    
    -- Archive old logs
    INSERT INTO tbl_logs_archive 
    SELECT *, NOW() FROM tbl_logs 
    WHERE date < DATE_SUB(NOW(), INTERVAL p_archive_days DAY);
    
    DELETE FROM tbl_logs 
    WHERE date < DATE_SUB(NOW(), INTERVAL p_archive_days DAY);
    
    -- Archive old RADIUS accounting
    INSERT INTO radacct_archive 
    SELECT *, NOW() FROM radacct 
    WHERE acctstoptime < DATE_SUB(NOW(), INTERVAL p_archive_days DAY);
    
    DELETE FROM radacct 
    WHERE acctstoptime < DATE_SUB(NOW(), INTERVAL p_archive_days DAY);
    
    -- Archive old payment gateway data
    INSERT INTO tbl_payment_gateway_archive 
    SELECT *, NOW() FROM tbl_payment_gateway 
    WHERE created_date < DATE_SUB(NOW(), INTERVAL p_archive_days DAY)
    AND status IN (2, 3, 4);  -- Completed, failed, or cancelled
    
    DELETE FROM tbl_payment_gateway 
    WHERE created_date < DATE_SUB(NOW(), INTERVAL p_archive_days DAY)
    AND status IN (2, 3, 4);
    
    SELECT 
        'Data archival completed' as status,
        archived_count as transactions_archived,
        p_archive_days as days_archived;
END$$
DELIMITER ;

-- Clean temporary and expired data
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_cleanup_temporary_data()
BEGIN
    -- Clean expired sessions
    DELETE FROM tbl_portal_sessions 
    WHERE expires_at < NOW() 
    AND payment_status != 'pending';
    
    -- Clean old M-Pesa transactions
    DELETE FROM tbl_mpesa_transactions 
    WHERE created_at < DATE_SUB(NOW(), INTERVAL 30 DAY)
    AND status != 'pending';
    
    -- Clean old session monitoring data
    DELETE FROM tbl_session_monitoring 
    WHERE last_update < DATE_SUB(NOW(), INTERVAL 1 HOUR);
    
    -- Clean old router health data
    DELETE FROM tbl_router_health 
    WHERE last_check < DATE_SUB(NOW(), INTERVAL 24 HOUR);
    
    -- Clean old bandwidth usage data (keep 30 days)
    DELETE FROM tbl_bandwidth_usage 
    WHERE date < DATE_SUB(CURDATE(), INTERVAL 30 DAY);
    
    -- Clean resolved alerts older than 7 days
    DELETE FROM tbl_alerts 
    WHERE status = 'resolved' 
    AND resolved_at < DATE_SUB(NOW(), INTERVAL 7 DAY);
    
    SELECT 'Temporary data cleanup completed' as status;
END$$
DELIMITER ;

-- ===================================================================
-- 5. SYSTEM HEALTH MONITORING
-- ===================================================================

-- Create system health monitoring table
CREATE TABLE IF NOT EXISTS `tbl_system_health` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `check_type` varchar(50) NOT NULL,
    `check_name` varchar(100) NOT NULL,
    `status` enum('healthy','warning','critical') NOT NULL,
    `value` decimal(10,2) DEFAULT NULL,
    `threshold` decimal(10,2) DEFAULT NULL,
    `message` text,
    `check_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `check_type` (`check_type`),
    KEY `status` (`status`),
    KEY `check_time` (`check_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- System health check procedure
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_system_health_check()
BEGIN
    DECLARE db_size DECIMAL(10,2);
    DECLARE connection_count INT;
    DECLARE slow_query_count INT;
    DECLARE table_count INT;
    
    -- Clear old health check data
    DELETE FROM tbl_system_health WHERE check_time < DATE_SUB(NOW(), INTERVAL 24 HOUR);
    
    -- Check database size
    SELECT ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) 
    INTO db_size
    FROM information_schema.tables 
    WHERE table_schema = DATABASE();
    
    INSERT INTO tbl_system_health (check_type, check_name, status, value, threshold, message)
    VALUES ('database', 'Database Size (MB)', 
            CASE WHEN db_size > 10240 THEN 'critical' WHEN db_size > 5120 THEN 'warning' ELSE 'healthy' END,
            db_size, 10240, 
            CASE WHEN db_size > 10240 THEN 'Database size exceeds 10GB' ELSE 'Database size is normal' END);
    
    -- Check connection count
    SELECT COUNT(*) INTO connection_count
    FROM information_schema.processlist;
    
    INSERT INTO tbl_system_health (check_type, check_name, status, value, threshold, message)
    VALUES ('connections', 'Active Connections', 
            CASE WHEN connection_count > 150 THEN 'critical' WHEN connection_count > 100 THEN 'warning' ELSE 'healthy' END,
            connection_count, 150, 
            CASE WHEN connection_count > 150 THEN 'Too many active connections' ELSE 'Connection count is normal' END);
    
    -- Check slow queries
    SELECT COUNT(*) INTO slow_query_count
    FROM information_schema.processlist 
    WHERE command = 'Query' AND time > 5;
    
    INSERT INTO tbl_system_health (check_type, check_name, status, value, threshold, message)
    VALUES ('performance', 'Slow Queries', 
            CASE WHEN slow_query_count > 10 THEN 'critical' WHEN slow_query_count > 5 THEN 'warning' ELSE 'healthy' END,
            slow_query_count, 10, 
            CASE WHEN slow_query_count > 10 THEN 'Too many slow queries detected' ELSE 'Query performance is normal' END);
    
    -- Check table count
    SELECT COUNT(*) INTO table_count
    FROM information_schema.tables 
    WHERE table_schema = DATABASE();
    
    INSERT INTO tbl_system_health (check_type, check_name, status, value, threshold, message)
    VALUES ('database', 'Table Count', 'healthy', table_count, 1000, 'Table count is normal');
    
    SELECT 'System health check completed' as status;
END$$
DELIMITER ;

-- Get system health report
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_get_system_health_report()
BEGIN
    SELECT 
        check_type,
        check_name,
        status,
        value,
        threshold,
        message,
        check_time
    FROM tbl_system_health
    WHERE check_time >= DATE_SUB(NOW(), INTERVAL 1 HOUR)
    ORDER BY 
        CASE status 
            WHEN 'critical' THEN 1
            WHEN 'warning' THEN 2
            ELSE 3
        END,
        check_time DESC;
        
    -- Summary by status
    SELECT 
        status,
        COUNT(*) as check_count,
        GROUP_CONCAT(check_name SEPARATOR ', ') as checks
    FROM tbl_system_health
    WHERE check_time >= DATE_SUB(NOW(), INTERVAL 1 HOUR)
    GROUP BY status
    ORDER BY 
        CASE status 
            WHEN 'critical' THEN 1
            WHEN 'warning' THEN 2
            ELSE 3
        END;
END$$
DELIMITER ;

-- ===================================================================
-- 6. BACKUP AND RECOVERY OPTIMIZATION
-- ===================================================================

-- Create backup log table
CREATE TABLE IF NOT EXISTS `tbl_backup_log` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `backup_type` enum('full','incremental','differential') NOT NULL,
    `backup_status` enum('running','completed','failed') NOT NULL,
    `backup_size` bigint(20) DEFAULT NULL,
    `backup_duration` int(11) DEFAULT NULL,
    `backup_path` varchar(255) DEFAULT NULL,
    `error_message` text,
    `started_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `completed_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `backup_type` (`backup_type`),
    KEY `backup_status` (`backup_status`),
    KEY `started_at` (`started_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Backup optimization recommendations
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_backup_recommendations()
BEGIN
    SELECT 
        'Backup Recommendations' as category,
        'Schedule daily full backups during off-peak hours' as recommendation
    UNION ALL
    SELECT 
        'Backup Recommendations' as category,
        'Use incremental backups for large databases' as recommendation
    UNION ALL
    SELECT 
        'Backup Recommendations' as category,
        'Test backup restoration regularly' as recommendation
    UNION ALL
    SELECT 
        'Backup Recommendations' as category,
        'Store backups in multiple locations' as recommendation
    UNION ALL
    SELECT 
        'Performance Tuning' as category,
        'Use --single-transaction for InnoDB tables' as recommendation
    UNION ALL
    SELECT 
        'Performance Tuning' as category,
        'Compress backups to save storage space' as recommendation
    UNION ALL
    SELECT 
        'Performance Tuning' as category,
        'Use --routines --triggers for complete backup' as recommendation;
END$$
DELIMITER ;

-- ===================================================================
-- 7. AUTOMATED MAINTENANCE EVENTS
-- ===================================================================

-- Create maintenance events
CREATE EVENT IF NOT EXISTS `e_daily_optimization`
ON SCHEDULE EVERY 1 DAY
STARTS (TIMESTAMP(CURRENT_DATE) + INTERVAL 1 DAY + INTERVAL 2 HOUR)
DO BEGIN
    CALL sp_optimize_database();
    CALL sp_cleanup_temporary_data();
    CALL sp_system_health_check();
END;

CREATE EVENT IF NOT EXISTS `e_weekly_analysis`
ON SCHEDULE EVERY 1 WEEK
STARTS (TIMESTAMP(CURRENT_DATE) + INTERVAL 1 WEEK + INTERVAL 3 HOUR)
DO BEGIN
    CALL sp_analyze_slow_queries();
    CALL sp_analyze_index_usage();
END;

CREATE EVENT IF NOT EXISTS `e_monthly_archival`
ON SCHEDULE EVERY 1 MONTH
STARTS (TIMESTAMP(CURRENT_DATE) + INTERVAL 1 MONTH + INTERVAL 1 HOUR)
DO BEGIN
    CALL sp_create_archive_tables();
    CALL sp_archive_old_data(90);
END;

-- ===================================================================
-- 8. PERFORMANCE MONITORING DASHBOARD
-- ===================================================================

-- Create performance dashboard view
CREATE OR REPLACE VIEW v_performance_dashboard AS
SELECT 
    -- Database health
    (SELECT ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) 
     FROM information_schema.tables 
     WHERE table_schema = DATABASE()) as db_size_mb,
    
    -- Query performance
    (SELECT COUNT(*) FROM tbl_query_performance 
     WHERE avg_execution_time > 2 AND last_seen >= DATE_SUB(NOW(), INTERVAL 24 HOUR)) as slow_queries_24h,
    
    -- System health
    (SELECT COUNT(*) FROM tbl_system_health 
     WHERE status = 'critical' AND check_time >= DATE_SUB(NOW(), INTERVAL 1 HOUR)) as critical_issues,
    
    -- Active connections
    (SELECT COUNT(*) FROM information_schema.processlist) as active_connections,
    
    -- Recent optimizations
    (SELECT COUNT(*) FROM tbl_optimization_log 
     WHERE optimization_date >= DATE_SUB(NOW(), INTERVAL 24 HOUR)) as recent_optimizations,
    
    -- Archive statistics
    (SELECT COUNT(*) FROM tbl_transactions_archive 
     WHERE archived_date >= DATE_SUB(NOW(), INTERVAL 7 DAY)) as recent_archived_transactions,
    
    NOW() as report_time;

-- ===================================================================
-- USAGE EXAMPLES AND RECOMMENDATIONS
-- ===================================================================

-- Example maintenance schedule:
/*
-- Daily at 2 AM
CALL sp_optimize_database();
CALL sp_cleanup_temporary_data();
CALL sp_system_health_check();

-- Weekly on Sunday at 3 AM
CALL sp_analyze_slow_queries();
CALL sp_analyze_index_usage();

-- Monthly on 1st at 1 AM
CALL sp_create_archive_tables();
CALL sp_archive_old_data(90);

-- Check performance dashboard
SELECT * FROM v_performance_dashboard;

-- Get recommendations
CALL sp_get_index_recommendations();
CALL sp_backup_recommendations();
*/

-- Performance monitoring queries
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_performance_summary()
BEGIN
    SELECT 'Performance Summary Report' as report_type;
    
    -- Database statistics
    SELECT 
        'Database Statistics' as category,
        COUNT(*) as table_count,
        ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) as total_size_mb,
        ROUND(SUM(data_length) / 1024 / 1024, 2) as data_size_mb,
        ROUND(SUM(index_length) / 1024 / 1024, 2) as index_size_mb
    FROM information_schema.tables 
    WHERE table_schema = DATABASE();
    
    -- Query performance summary
    SELECT 
        'Query Performance' as category,
        query_type,
        COUNT(*) as query_count,
        ROUND(AVG(avg_execution_time), 4) as avg_time_seconds,
        ROUND(MAX(max_execution_time), 4) as max_time_seconds
    FROM tbl_query_performance
    WHERE last_seen >= DATE_SUB(NOW(), INTERVAL 24 HOUR)
    GROUP BY query_type
    ORDER BY avg_time_seconds DESC;
    
    -- System health summary
    SELECT 
        'System Health' as category,
        status,
        COUNT(*) as check_count
    FROM tbl_system_health
    WHERE check_time >= DATE_SUB(NOW(), INTERVAL 1 HOUR)
    GROUP BY status;
END$$
DELIMITER ;

SELECT 'Performance tuning and maintenance system created successfully!' as Status,
       'All optimization procedures, events, and monitoring are active' as Message,
       'Run sp_performance_summary() for current system status' as Usage;