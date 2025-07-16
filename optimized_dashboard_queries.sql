-- ===================================================================
-- OPTIMIZED DASHBOARD QUERIES FOR ISP BILLING SYSTEM
-- Gemini & Context7 Analysis - Professional Multi-Reseller Dashboard
-- ===================================================================

-- This script contains optimized queries for:
-- 1. Dashboard statistics and metrics
-- 2. Real-time monitoring queries
-- 3. Reseller-specific data retrieval
-- 4. MikroTik integration queries
-- 5. Payment processing queries
-- 6. Reporting and analytics queries

-- ===================================================================
-- 1. DASHBOARD STATISTICS QUERIES
-- ===================================================================

-- Get comprehensive dashboard statistics for a reseller
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_get_reseller_dashboard_stats(IN p_reseller_id INT)
BEGIN
    SELECT 
        -- Customer Statistics
        COUNT(DISTINCT c.id) as total_customers,
        COUNT(DISTINCT CASE WHEN ur.status = 'on' THEN c.id END) as active_customers,
        COUNT(DISTINCT CASE WHEN c.status = 'Active' THEN c.id END) as enabled_customers,
        COUNT(DISTINCT CASE WHEN c.created_at >= CURDATE() THEN c.id END) as new_customers_today,
        COUNT(DISTINCT CASE WHEN c.created_at >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) THEN c.id END) as new_customers_week,
        
        -- Service Statistics
        COUNT(DISTINCT CASE WHEN ur.status = 'on' AND ur.expiration <= DATE_ADD(CURDATE(), INTERVAL 7 DAY) THEN ur.id END) as expiring_soon,
        COUNT(DISTINCT CASE WHEN ur.status = 'on' AND ur.expiration <= CURDATE() THEN ur.id END) as expired_services,
        COUNT(DISTINCT CASE WHEN ur.status = 'on' AND ur.type = 'Hotspot' THEN ur.id END) as hotspot_users,
        COUNT(DISTINCT CASE WHEN ur.status = 'on' AND ur.type = 'PPPOE' THEN ur.id END) as pppoe_users,
        
        -- Revenue Statistics
        COALESCE(SUM(CASE WHEN t.recharged_on = CURDATE() THEN t.price END), 0) as today_revenue,
        COALESCE(SUM(CASE WHEN t.recharged_on >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) THEN t.price END), 0) as week_revenue,
        COALESCE(SUM(CASE WHEN t.recharged_on >= DATE_SUB(CURDATE(), INTERVAL 30 DAY) THEN t.price END), 0) as month_revenue,
        COALESCE(SUM(t.price), 0) as total_revenue,
        
        -- Router Statistics
        COUNT(DISTINCT r.id) as total_routers,
        COUNT(DISTINCT CASE WHEN r.status = 'Online' THEN r.id END) as online_routers,
        COUNT(DISTINCT CASE WHEN r.enabled = 1 THEN r.id END) as enabled_routers
        
    FROM tbl_resellers res
    LEFT JOIN tbl_customers c ON res.id = c.reseller_id
    LEFT JOIN tbl_user_recharges ur ON c.id = ur.customer_id
    LEFT JOIN tbl_transactions t ON res.id = t.reseller_id
    LEFT JOIN tbl_routers r ON res.id = r.reseller_id
    WHERE res.id = p_reseller_id;
END$$
DELIMITER ;

-- Get today's transaction summary for dashboard
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_get_today_transactions(IN p_reseller_id INT)
BEGIN
    SELECT 
        COUNT(*) as total_transactions,
        SUM(price) as total_amount,
        COUNT(CASE WHEN type = 'Hotspot' THEN 1 END) as hotspot_count,
        COUNT(CASE WHEN type = 'PPPOE' THEN 1 END) as pppoe_count,
        COUNT(CASE WHEN type = 'Balance' THEN 1 END) as balance_count,
        COUNT(CASE WHEN method LIKE 'M-Pesa%' THEN 1 END) as mpesa_count,
        COUNT(CASE WHEN method LIKE 'Cash%' THEN 1 END) as cash_count
    FROM tbl_transactions 
    WHERE reseller_id = p_reseller_id 
    AND recharged_on = CURDATE();
END$$
DELIMITER ;

-- Get popular plans for dashboard
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_get_popular_plans(IN p_reseller_id INT, IN p_limit INT DEFAULT 10)
BEGIN
    SELECT 
        plan_name,
        COUNT(*) as usage_count,
        SUM(price) as total_revenue,
        AVG(price) as avg_price,
        type
    FROM tbl_transactions 
    WHERE reseller_id = p_reseller_id 
    AND recharged_on >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
    GROUP BY plan_name, type
    ORDER BY usage_count DESC
    LIMIT p_limit;
END$$
DELIMITER ;

-- ===================================================================
-- 2. REAL-TIME MONITORING QUERIES
-- ===================================================================

-- Get active sessions for real-time monitoring
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_get_active_sessions(IN p_reseller_id INT)
BEGIN
    SELECT 
        ra.username,
        ra.acctsessionid,
        ra.nasipaddress,
        ra.framedipaddress,
        ra.acctsessiontime,
        ra.acctinputoctets,
        ra.acctoutputoctets,
        ra.dateAdded as session_start,
        c.fullname as customer_name,
        ur.namebp as plan_name,
        ur.expiration
    FROM rad_acct ra
    INNER JOIN tbl_customers c ON ra.username = c.username
    INNER JOIN tbl_user_recharges ur ON c.id = ur.customer_id AND ur.status = 'on'
    WHERE c.reseller_id = p_reseller_id
    AND ra.acctsessionid IS NOT NULL
    ORDER BY ra.dateAdded DESC;
END$$
DELIMITER ;

-- Get bandwidth usage statistics
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_get_bandwidth_usage(IN p_reseller_id INT, IN p_hours INT DEFAULT 24)
BEGIN
    SELECT 
        DATE_FORMAT(ra.dateAdded, '%Y-%m-%d %H:00:00') as hour_period,
        COUNT(DISTINCT ra.username) as active_users,
        SUM(ra.acctinputoctets) as total_download,
        SUM(ra.acctoutputoctets) as total_upload,
        SUM(ra.acctinputoctets + ra.acctoutputoctets) as total_bandwidth,
        AVG(ra.acctsessiontime) as avg_session_time
    FROM rad_acct ra
    INNER JOIN tbl_customers c ON ra.username = c.username
    WHERE c.reseller_id = p_reseller_id
    AND ra.dateAdded >= DATE_SUB(NOW(), INTERVAL p_hours HOUR)
    GROUP BY hour_period
    ORDER BY hour_period DESC;
END$$
DELIMITER ;

-- Monitor router status
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_monitor_router_status(IN p_reseller_id INT)
BEGIN
    SELECT 
        r.name as router_name,
        r.ip_address,
        r.status,
        r.last_seen,
        r.coverage,
        COUNT(DISTINCT c.id) as connected_customers,
        COUNT(DISTINCT ur.id) as active_services,
        CASE 
            WHEN r.last_seen >= DATE_SUB(NOW(), INTERVAL 5 MINUTE) THEN 'Online'
            WHEN r.last_seen >= DATE_SUB(NOW(), INTERVAL 15 MINUTE) THEN 'Warning'
            ELSE 'Offline'
        END as connection_status
    FROM tbl_routers r
    LEFT JOIN tbl_customers c ON r.name = c.service_type AND c.reseller_id = p_reseller_id
    LEFT JOIN tbl_user_recharges ur ON c.id = ur.customer_id AND ur.status = 'on'
    WHERE r.reseller_id = p_reseller_id
    GROUP BY r.id, r.name, r.ip_address, r.status, r.last_seen, r.coverage
    ORDER BY r.last_seen DESC;
END$$
DELIMITER ;

-- ===================================================================
-- 3. RESELLER-SPECIFIC DATA RETRIEVAL
-- ===================================================================

-- Get reseller customer summary
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_get_reseller_customers(IN p_reseller_id INT, IN p_limit INT DEFAULT 50, IN p_offset INT DEFAULT 0)
BEGIN
    SELECT 
        c.id,
        c.username,
        c.fullname,
        c.email,
        c.phonenumber,
        c.service_type,
        c.status as customer_status,
        c.balance,
        c.created_at,
        c.last_login,
        ur.namebp as current_plan,
        ur.status as service_status,
        ur.expiration,
        ur.recharged_on,
        CASE 
            WHEN ur.expiration <= CURDATE() THEN 'Expired'
            WHEN ur.expiration <= DATE_ADD(CURDATE(), INTERVAL 7 DAY) THEN 'Expiring Soon'
            ELSE 'Active'
        END as service_alert
    FROM tbl_customers c
    LEFT JOIN tbl_user_recharges ur ON c.id = ur.customer_id AND ur.status = 'on'
    WHERE c.reseller_id = p_reseller_id
    ORDER BY c.created_at DESC
    LIMIT p_limit OFFSET p_offset;
END$$
DELIMITER ;

-- Get reseller transaction history
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_get_reseller_transactions(
    IN p_reseller_id INT, 
    IN p_start_date DATE, 
    IN p_end_date DATE,
    IN p_limit INT DEFAULT 100,
    IN p_offset INT DEFAULT 0
)
BEGIN
    SELECT 
        t.id,
        t.invoice,
        t.username,
        t.plan_name,
        t.price,
        t.recharged_on,
        t.recharged_time,
        t.expiration,
        t.method,
        t.type,
        t.note,
        c.fullname as customer_name,
        c.phonenumber,
        u.username as admin_name
    FROM tbl_transactions t
    INNER JOIN tbl_customers c ON t.username = c.username
    LEFT JOIN tbl_users u ON t.admin_id = u.id
    WHERE t.reseller_id = p_reseller_id
    AND t.recharged_on BETWEEN p_start_date AND p_end_date
    ORDER BY t.recharged_on DESC, t.recharged_time DESC
    LIMIT p_limit OFFSET p_offset;
END$$
DELIMITER ;

-- ===================================================================
-- 4. MIKROTIK INTEGRATION QUERIES
-- ===================================================================

-- Get MikroTik user management data
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_get_mikrotik_users(IN p_reseller_id INT, IN p_router_name VARCHAR(32))
BEGIN
    SELECT 
        c.username,
        c.password,
        c.pppoe_username,
        c.pppoe_password,
        c.pppoe_ip,
        c.fullname,
        c.service_type,
        c.status,
        ur.namebp as plan_name,
        ur.status as service_status,
        ur.expiration,
        p.name_plan,
        p.type as plan_type,
        b.name_bw as bandwidth_profile,
        b.rate_down,
        b.rate_up,
        b.rate_down_unit,
        b.rate_up_unit
    FROM tbl_customers c
    INNER JOIN tbl_user_recharges ur ON c.id = ur.customer_id AND ur.status = 'on'
    INNER JOIN tbl_plans p ON ur.plan_id = p.id
    INNER JOIN tbl_bandwidth b ON p.id_bw = b.id
    WHERE c.reseller_id = p_reseller_id
    AND p.routers = p_router_name
    AND c.status = 'Active'
    ORDER BY c.username;
END$$
DELIMITER ;

-- Get RADIUS accounting data for MikroTik
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_get_radius_accounting(IN p_reseller_id INT, IN p_username VARCHAR(64))
BEGIN
    SELECT 
        ra.acctsessionid,
        ra.username,
        ra.nasipaddress,
        ra.framedipaddress,
        ra.acctsessiontime,
        ra.acctinputoctets,
        ra.acctoutputoctets,
        ra.dateAdded,
        r.name as router_name,
        r.description as router_description
    FROM radacct ra
    INNER JOIN tbl_customers c ON ra.username = c.username
    INNER JOIN tbl_routers r ON ra.nasipaddress = r.ip_address
    WHERE c.reseller_id = p_reseller_id
    AND (p_username IS NULL OR ra.username = p_username)
    ORDER BY ra.acctstarttime DESC
    LIMIT 1000;
END$$
DELIMITER ;

-- ===================================================================
-- 5. PAYMENT PROCESSING QUERIES
-- ===================================================================

-- Get payment gateway transactions
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_get_payment_gateway_stats(IN p_reseller_id INT)
BEGIN
    SELECT 
        pg.gateway,
        COUNT(*) as total_transactions,
        COUNT(CASE WHEN pg.status = 2 THEN 1 END) as successful_payments,
        COUNT(CASE WHEN pg.status = 1 THEN 1 END) as pending_payments,
        COUNT(CASE WHEN pg.status = 3 THEN 1 END) as failed_payments,
        SUM(CASE WHEN pg.status = 2 THEN pg.price END) as total_amount,
        AVG(CASE WHEN pg.status = 2 THEN pg.price END) as avg_amount,
        MIN(pg.created_date) as first_transaction,
        MAX(pg.created_date) as last_transaction
    FROM tbl_payment_gateway pg
    INNER JOIN tbl_customers c ON pg.username = c.username
    WHERE c.reseller_id = p_reseller_id
    GROUP BY pg.gateway
    ORDER BY total_transactions DESC;
END$$
DELIMITER ;

-- Get M-Pesa transaction summary
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_get_mpesa_summary(IN p_reseller_id INT, IN p_days INT DEFAULT 30)
BEGIN
    SELECT 
        DATE(mt.created_at) as transaction_date,
        COUNT(*) as total_transactions,
        COUNT(CASE WHEN mt.status = 'completed' THEN 1 END) as successful_count,
        COUNT(CASE WHEN mt.status = 'pending' THEN 1 END) as pending_count,
        COUNT(CASE WHEN mt.status = 'failed' THEN 1 END) as failed_count,
        SUM(CASE WHEN mt.status = 'completed' THEN mt.amount END) as total_amount,
        AVG(CASE WHEN mt.status = 'completed' THEN mt.amount END) as avg_amount
    FROM tbl_mpesa_transactions mt
    INNER JOIN tbl_portal_sessions ps ON mt.session_id = ps.session_id
    WHERE ps.reseller_id = p_reseller_id
    AND mt.created_at >= DATE_SUB(CURDATE(), INTERVAL p_days DAY)
    GROUP BY DATE(mt.created_at)
    ORDER BY transaction_date DESC;
END$$
DELIMITER ;

-- ===================================================================
-- 6. REPORTING AND ANALYTICS QUERIES
-- ===================================================================

-- Monthly revenue report
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_monthly_revenue_report(IN p_reseller_id INT, IN p_year INT, IN p_month INT)
BEGIN
    SELECT 
        DAY(t.recharged_on) as day_of_month,
        COUNT(*) as transaction_count,
        SUM(t.price) as daily_revenue,
        COUNT(DISTINCT t.username) as unique_customers,
        COUNT(CASE WHEN t.type = 'Hotspot' THEN 1 END) as hotspot_sales,
        COUNT(CASE WHEN t.type = 'PPPOE' THEN 1 END) as pppoe_sales,
        COUNT(CASE WHEN t.type = 'Balance' THEN 1 END) as balance_sales,
        GROUP_CONCAT(DISTINCT t.plan_name ORDER BY t.plan_name SEPARATOR ', ') as plans_sold
    FROM tbl_transactions t
    WHERE t.reseller_id = p_reseller_id
    AND YEAR(t.recharged_on) = p_year
    AND MONTH(t.recharged_on) = p_month
    GROUP BY DAY(t.recharged_on)
    ORDER BY day_of_month;
END$$
DELIMITER ;

-- Customer growth analysis
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_customer_growth_analysis(IN p_reseller_id INT, IN p_months INT DEFAULT 12)
BEGIN
    SELECT 
        YEAR(c.created_at) as year,
        MONTH(c.created_at) as month,
        COUNT(*) as new_customers,
        COUNT(CASE WHEN c.service_type = 'Hotspot' THEN 1 END) as hotspot_customers,
        COUNT(CASE WHEN c.service_type = 'PPPoE' THEN 1 END) as pppoe_customers,
        COUNT(CASE WHEN c.account_type = 'Business' THEN 1 END) as business_customers,
        COUNT(CASE WHEN c.account_type = 'Personal' THEN 1 END) as personal_customers,
        COUNT(CASE WHEN c.status = 'Active' THEN 1 END) as active_customers
    FROM tbl_customers c
    WHERE c.reseller_id = p_reseller_id
    AND c.created_at >= DATE_SUB(CURDATE(), INTERVAL p_months MONTH)
    GROUP BY YEAR(c.created_at), MONTH(c.created_at)
    ORDER BY year DESC, month DESC;
END$$
DELIMITER ;

-- Plan performance analysis
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_plan_performance_analysis(IN p_reseller_id INT, IN p_days INT DEFAULT 30)
BEGIN
    SELECT 
        p.name_plan,
        p.type,
        p.price as plan_price,
        COUNT(t.id) as total_sales,
        SUM(t.price) as total_revenue,
        COUNT(DISTINCT t.username) as unique_customers,
        AVG(t.price) as avg_sale_price,
        COUNT(CASE WHEN t.recharged_on >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) THEN 1 END) as week_sales,
        COUNT(CASE WHEN t.recharged_on >= CURDATE() THEN 1 END) as today_sales,
        b.name_bw as bandwidth_profile,
        b.rate_down,
        b.rate_up
    FROM tbl_plans p
    LEFT JOIN tbl_transactions t ON p.name_plan = t.plan_name AND t.reseller_id = p_reseller_id
        AND t.recharged_on >= DATE_SUB(CURDATE(), INTERVAL p_days DAY)
    LEFT JOIN tbl_bandwidth b ON p.id_bw = b.id
    WHERE p.reseller_id = p_reseller_id
    AND p.enabled = 1
    GROUP BY p.id, p.name_plan, p.type, p.price, b.name_bw, b.rate_down, b.rate_up
    ORDER BY total_sales DESC, total_revenue DESC;
END$$
DELIMITER ;

-- ===================================================================
-- 7. MAINTENANCE AND CLEANUP QUERIES
-- ===================================================================

-- Clean old session data
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_cleanup_old_sessions(IN p_days INT DEFAULT 30)
BEGIN
    -- Clean old portal sessions
    DELETE FROM tbl_portal_sessions 
    WHERE created_at < DATE_SUB(NOW(), INTERVAL p_days DAY)
    AND payment_status != 'pending';
    
    -- Clean old M-Pesa transactions
    DELETE FROM tbl_mpesa_transactions 
    WHERE created_at < DATE_SUB(NOW(), INTERVAL p_days DAY)
    AND status != 'pending';
    
    -- Clean old logs
    DELETE FROM tbl_logs 
    WHERE date < DATE_SUB(NOW(), INTERVAL p_days DAY);
    
    -- Clean old RADIUS accounting
    DELETE FROM radacct 
    WHERE acctstoptime < DATE_SUB(NOW(), INTERVAL p_days DAY);
    
    SELECT 
        'Cleanup completed' as status,
        CONCAT('Removed data older than ', p_days, ' days') as message;
END$$
DELIMITER ;

-- ===================================================================
-- 8. PERFORMANCE MONITORING QUERIES
-- ===================================================================

-- Check query performance
DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS sp_check_query_performance()
BEGIN
    SELECT 
        'Query Performance Check' as check_type,
        COUNT(*) as slow_queries,
        AVG(query_time) as avg_query_time
    FROM information_schema.PROCESSLIST 
    WHERE command = 'Query' 
    AND time > 2;
    
    -- Check table sizes
    SELECT 
        table_name,
        ROUND(((data_length + index_length) / 1024 / 1024), 2) as size_mb,
        table_rows,
        ROUND((index_length / 1024 / 1024), 2) as index_size_mb
    FROM information_schema.TABLES 
    WHERE table_schema = DATABASE()
    AND table_name LIKE 'tbl_%'
    ORDER BY size_mb DESC;
END$$
DELIMITER ;

-- ===================================================================
-- USAGE EXAMPLES
-- ===================================================================

-- Example usage of the procedures:
/*
-- Get dashboard stats for reseller ID 1
CALL sp_get_reseller_dashboard_stats(1);

-- Get today's transactions for reseller ID 1
CALL sp_get_today_transactions(1);

-- Get active sessions for reseller ID 1
CALL sp_get_active_sessions(1);

-- Get monthly revenue report for reseller ID 1, year 2024, month 1
CALL sp_monthly_revenue_report(1, 2024, 1);

-- Clean up old data (30 days)
CALL sp_cleanup_old_sessions(30);

-- Check query performance
CALL sp_check_query_performance();
*/

SELECT 'Optimized dashboard queries created successfully!' as Status,
       'All stored procedures and queries are ready for use' as Message,
       'Use CALL procedure_name(parameters) to execute' as Usage;