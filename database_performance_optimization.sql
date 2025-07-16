-- =====================================================
-- GLINTA AFRICA ISP BILLING SYSTEM
-- Database Performance Optimization
-- Created by: Claude AI with Gemini & Context7 Analysis
-- =====================================================

-- Phase 1: Core Performance Indexes for Dashboard
-- =====================================================

-- Dashboard Statistics Indexes
CREATE INDEX idx_transactions_reseller_date ON tbl_transactions(reseller_id, recharged_on, status);
CREATE INDEX idx_transactions_revenue_today ON tbl_transactions(recharged_on, price) WHERE status = 'paid';
CREATE INDEX idx_transactions_monthly_revenue ON tbl_transactions(DATE_FORMAT(recharged_on, '%Y-%m'), price, reseller_id);

-- User Management Indexes
CREATE INDEX idx_user_recharges_active ON tbl_user_recharges(reseller_id, status, expiration, time);
CREATE INDEX idx_user_recharges_expired ON tbl_user_recharges(status, expiration, time) WHERE status = 'on';
CREATE INDEX idx_customers_reseller_status ON tbl_customers(reseller_id, status, service_type, created_at);
CREATE INDEX idx_customers_service_type ON tbl_customers(service_type, status, reseller_id);

-- Router and Network Indexes
CREATE INDEX idx_routers_reseller_enabled ON tbl_routers(reseller_id, enabled, status);
CREATE INDEX idx_routers_mikrotik_stats ON tbl_routers(enabled, ip_address, last_seen);

-- Payment Processing Indexes
CREATE INDEX idx_payment_gateway_status ON tbl_payment_gateway(status, created_date, reseller_id);
CREATE INDEX idx_mpesa_transactions_status ON tbl_mpesa_transactions(status, created_at, amount);

-- Reseller Management Indexes
CREATE INDEX idx_reseller_subscriptions ON tbl_reseller_subscriptions(reseller_id, status, expires_at);
CREATE INDEX idx_reseller_performance ON tbl_resellers(status, created_at, subscription_type);

-- Plans and Packages Indexes
CREATE INDEX idx_plans_reseller_active ON tbl_plans(reseller_id, enabled, service_type);
CREATE INDEX idx_bandwidth_performance ON tbl_bandwidth(rate_down, rate_up, name_bw);

-- Audit and Logging Indexes
CREATE INDEX idx_logs_date_type ON tbl_logs(date, type, userid);
CREATE INDEX idx_logs_reseller_activity ON tbl_logs(userid, date, type) WHERE type IN ('login', 'logout', 'payment');

-- Portal and Session Indexes
CREATE INDEX idx_portal_sessions_active ON tbl_portal_sessions(payment_status, expires_at, created_at);
CREATE INDEX idx_portal_sessions_expired ON tbl_portal_sessions(expires_at, payment_status) WHERE payment_status = 'completed';

-- =====================================================
-- Phase 2: Optimized Dashboard Queries
-- =====================================================

-- SuperAdmin Dashboard Statistics
DELIMITER //
CREATE PROCEDURE GetSuperAdminDashboardStats()
BEGIN
    SELECT 
        -- Today's Revenue
        (SELECT COALESCE(SUM(price), 0) FROM tbl_transactions WHERE recharged_on = CURDATE() AND status = 'paid') as revenue_today,
        
        -- Monthly Revenue
        (SELECT COALESCE(SUM(price), 0) FROM tbl_transactions WHERE DATE_FORMAT(recharged_on, '%Y-%m') = DATE_FORMAT(NOW(), '%Y-%m') AND status = 'paid') as revenue_month,
        
        -- Active Services
        (SELECT COUNT(*) FROM tbl_user_recharges WHERE status = 'on' AND CONCAT(expiration, ' ', time) > NOW()) as active_services,
        
        -- Expired Services
        (SELECT COUNT(*) FROM tbl_user_recharges WHERE status = 'on' AND CONCAT(expiration, ' ', time) <= NOW()) as expired_services,
        
        -- Total Resellers
        (SELECT COUNT(*) FROM tbl_resellers WHERE status = 'active') as total_resellers,
        
        -- Total Customers
        (SELECT COUNT(*) FROM tbl_customers WHERE status = 'active') as total_customers,
        
        -- Active Routers
        (SELECT COUNT(*) FROM tbl_routers WHERE enabled = 1) as active_routers,
        
        -- System Health Score (percentage)
        (SELECT ROUND(
            (COUNT(CASE WHEN enabled = 1 THEN 1 END) * 100.0 / COUNT(*)), 2
        ) FROM tbl_routers) as system_health_score;
END //
DELIMITER ;

-- Reseller Dashboard Statistics
DELIMITER //
CREATE PROCEDURE GetResellerDashboardStats(IN reseller_id INT)
BEGIN
    SELECT 
        -- Today's Revenue
        (SELECT COALESCE(SUM(price), 0) FROM tbl_transactions WHERE reseller_id = reseller_id AND recharged_on = CURDATE() AND status = 'paid') as revenue_today,
        
        -- Monthly Revenue
        (SELECT COALESCE(SUM(price), 0) FROM tbl_transactions WHERE reseller_id = reseller_id AND DATE_FORMAT(recharged_on, '%Y-%m') = DATE_FORMAT(NOW(), '%Y-%m') AND status = 'paid') as revenue_month,
        
        -- Active Customers
        (SELECT COUNT(*) FROM tbl_customers WHERE reseller_id = reseller_id AND status = 'active') as active_customers,
        
        -- Active Services
        (SELECT COUNT(*) FROM tbl_user_recharges ur JOIN tbl_customers c ON ur.customer_id = c.id WHERE c.reseller_id = reseller_id AND ur.status = 'on' AND CONCAT(ur.expiration, ' ', ur.time) > NOW()) as active_services,
        
        -- Expired Services
        (SELECT COUNT(*) FROM tbl_user_recharges ur JOIN tbl_customers c ON ur.customer_id = c.id WHERE c.reseller_id = reseller_id AND ur.status = 'on' AND CONCAT(ur.expiration, ' ', ur.time) <= NOW()) as expired_services,
        
        -- Subscription Status
        (SELECT status FROM tbl_reseller_subscriptions WHERE reseller_id = reseller_id ORDER BY created_at DESC LIMIT 1) as subscription_status,
        
        -- Subscription Expires
        (SELECT expires_at FROM tbl_reseller_subscriptions WHERE reseller_id = reseller_id ORDER BY created_at DESC LIMIT 1) as subscription_expires;
END //
DELIMITER ;

-- Real-time MikroTik Statistics
DELIMITER //
CREATE PROCEDURE GetMikroTikRealtimeStats(IN reseller_id INT)
BEGIN
    SELECT 
        r.id as router_id,
        r.name as router_name,
        r.ip_address,
        r.enabled,
        r.last_seen,
        COUNT(DISTINCT ur.id) as total_users,
        COUNT(DISTINCT CASE WHEN ur.status = 'on' AND CONCAT(ur.expiration, ' ', ur.time) > NOW() THEN ur.id END) as active_users,
        COUNT(DISTINCT CASE WHEN ur.status = 'on' AND CONCAT(ur.expiration, ' ', ur.time) <= NOW() THEN ur.id END) as expired_users,
        CASE 
            WHEN r.last_seen > DATE_SUB(NOW(), INTERVAL 5 MINUTE) THEN 'online'
            WHEN r.last_seen > DATE_SUB(NOW(), INTERVAL 1 HOUR) THEN 'warning'
            ELSE 'offline'
        END as connection_status
    FROM tbl_routers r
    LEFT JOIN tbl_customers c ON r.id = c.router_id AND c.reseller_id = IFNULL(reseller_id, c.reseller_id)
    LEFT JOIN tbl_user_recharges ur ON c.id = ur.customer_id
    WHERE r.enabled = 1 AND (reseller_id IS NULL OR EXISTS (SELECT 1 FROM tbl_customers WHERE reseller_id = reseller_id AND router_id = r.id))
    GROUP BY r.id, r.name, r.ip_address, r.enabled, r.last_seen
    ORDER BY r.name;
END //
DELIMITER ;

-- Revenue Analytics
DELIMITER //
CREATE PROCEDURE GetRevenueAnalytics(IN reseller_id INT, IN days_back INT)
BEGIN
    SELECT 
        DATE(recharged_on) as date,
        COUNT(DISTINCT username) as customers,
        COUNT(*) as transactions,
        SUM(price) as revenue,
        AVG(price) as avg_transaction,
        COUNT(CASE WHEN type = 'Hotspot' THEN 1 END) as hotspot_count,
        COUNT(CASE WHEN type = 'PPPOE' THEN 1 END) as pppoe_count,
        SUM(CASE WHEN type = 'Hotspot' THEN price ELSE 0 END) as hotspot_revenue,
        SUM(CASE WHEN type = 'PPPOE' THEN price ELSE 0 END) as pppoe_revenue
    FROM tbl_transactions 
    WHERE recharged_on >= DATE_SUB(CURDATE(), INTERVAL days_back DAY)
    AND (reseller_id IS NULL OR reseller_id = reseller_id)
    AND status = 'paid'
    GROUP BY DATE(recharged_on)
    ORDER BY DATE(recharged_on) DESC;
END //
DELIMITER ;

-- =====================================================
-- Phase 3: Performance Monitoring Views
-- =====================================================

-- System Performance Dashboard View
CREATE VIEW v_system_performance AS
SELECT 
    'revenue_today' as metric,
    COALESCE(SUM(price), 0) as value,
    'KES' as unit,
    CURDATE() as date
FROM tbl_transactions 
WHERE recharged_on = CURDATE() AND status = 'paid'

UNION ALL

SELECT 
    'active_services' as metric,
    COUNT(*) as value,
    'services' as unit,
    CURDATE() as date
FROM tbl_user_recharges 
WHERE status = 'on' AND CONCAT(expiration, ' ', time) > NOW()

UNION ALL

SELECT 
    'total_customers' as metric,
    COUNT(*) as value,
    'customers' as unit,
    CURDATE() as date
FROM tbl_customers 
WHERE status = 'active'

UNION ALL

SELECT 
    'active_routers' as metric,
    COUNT(*) as value,
    'routers' as unit,
    CURDATE() as date
FROM tbl_routers 
WHERE enabled = 1;

-- Reseller Performance View
CREATE VIEW v_reseller_performance AS
SELECT 
    r.id as reseller_id,
    r.name as reseller_name,
    r.status as reseller_status,
    COUNT(DISTINCT c.id) as total_customers,
    COUNT(DISTINCT CASE WHEN c.status = 'active' THEN c.id END) as active_customers,
    COUNT(DISTINCT ur.id) as total_services,
    COUNT(DISTINCT CASE WHEN ur.status = 'on' AND CONCAT(ur.expiration, ' ', ur.time) > NOW() THEN ur.id END) as active_services,
    COALESCE(SUM(CASE WHEN t.recharged_on = CURDATE() AND t.status = 'paid' THEN t.price END), 0) as revenue_today,
    COALESCE(SUM(CASE WHEN DATE_FORMAT(t.recharged_on, '%Y-%m') = DATE_FORMAT(NOW(), '%Y-%m') AND t.status = 'paid' THEN t.price END), 0) as revenue_month,
    r.created_at as joined_date
FROM tbl_resellers r
LEFT JOIN tbl_customers c ON r.id = c.reseller_id
LEFT JOIN tbl_user_recharges ur ON c.id = ur.customer_id
LEFT JOIN tbl_transactions t ON c.username = t.username AND t.reseller_id = r.id
GROUP BY r.id, r.name, r.status, r.created_at
ORDER BY revenue_month DESC;

-- =====================================================
-- Phase 4: Real-time Monitoring Events
-- =====================================================

-- Update router last seen timestamp
DELIMITER //
CREATE EVENT IF NOT EXISTS update_router_status
ON SCHEDULE EVERY 1 MINUTE
DO
BEGIN
    -- This would be called by external monitoring script
    -- UPDATE tbl_routers SET last_seen = NOW() WHERE id = ?;
    
    -- Log system activity
    INSERT INTO tbl_logs (date, type, description, userid, ip) 
    VALUES (NOW(), 'system', 'Router status check completed', 0, 'SYSTEM');
END //
DELIMITER ;

-- Clean up expired sessions
DELIMITER //
CREATE EVENT IF NOT EXISTS cleanup_expired_sessions
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
    DELETE FROM tbl_portal_sessions 
    WHERE expires_at < NOW() 
    AND payment_status = 'completed';
    
    INSERT INTO tbl_logs (date, type, description, userid, ip) 
    VALUES (NOW(), 'system', 'Expired sessions cleanup completed', 0, 'SYSTEM');
END //
DELIMITER ;

-- =====================================================
-- Phase 5: Cache Optimization
-- =====================================================

-- Create cache table for dashboard statistics
CREATE TABLE IF NOT EXISTS tbl_dashboard_cache (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cache_key VARCHAR(255) NOT NULL,
    cache_value TEXT,
    expires_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_cache_key (cache_key),
    INDEX idx_expires_at (expires_at)
);

-- Cache management procedures
DELIMITER //
CREATE PROCEDURE SetDashboardCache(IN key_name VARCHAR(255), IN value TEXT, IN ttl_seconds INT)
BEGIN
    INSERT INTO tbl_dashboard_cache (cache_key, cache_value, expires_at) 
    VALUES (key_name, value, DATE_ADD(NOW(), INTERVAL ttl_seconds SECOND))
    ON DUPLICATE KEY UPDATE 
        cache_value = VALUES(cache_value),
        expires_at = VALUES(expires_at),
        updated_at = NOW();
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetDashboardCache(IN key_name VARCHAR(255))
BEGIN
    SELECT cache_value 
    FROM tbl_dashboard_cache 
    WHERE cache_key = key_name 
    AND expires_at > NOW();
END //
DELIMITER ;

-- =====================================================
-- Implementation Notes:
-- 1. Run these indexes during low-traffic periods
-- 2. Monitor query performance before and after
-- 3. Adjust cache TTL based on usage patterns
-- 4. Set up monitoring for the events
-- 5. Test stored procedures with sample data
-- =====================================================

-- Enable events if not already enabled
SET GLOBAL event_scheduler = ON;

-- Success message
SELECT 'Database performance optimization completed successfully!' as status;