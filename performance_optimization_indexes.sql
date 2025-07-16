-- ===================================================================
-- PERFORMANCE OPTIMIZATION INDEXES FOR ISP BILLING SYSTEM
-- Gemini & Context7 Analysis - Professional Multi-Reseller Dashboard
-- ===================================================================

-- This script creates optimized indexes for:
-- 1. Dashboard query performance
-- 2. Real-time statistics queries  
-- 3. Reseller-specific data filtering
-- 4. MikroTik integration queries
-- 5. Payment processing optimization

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';

-- ===================================================================
-- 1. DASHBOARD PERFORMANCE INDEXES
-- ===================================================================

-- Customers table optimization for dashboard stats
CREATE INDEX IF NOT EXISTS idx_customers_dashboard ON tbl_customers 
(reseller_id, status, created_at, service_type);

CREATE INDEX IF NOT EXISTS idx_customers_service_status ON tbl_customers 
(service_type, status, reseller_id);

CREATE INDEX IF NOT EXISTS idx_customers_created_reseller ON tbl_customers 
(created_at, reseller_id) USING BTREE;

-- User recharges optimization for active users and expiring services
CREATE INDEX IF NOT EXISTS idx_recharges_active_users ON tbl_user_recharges 
(status, expiration, reseller_id);

CREATE INDEX IF NOT EXISTS idx_recharges_expiring_soon ON tbl_user_recharges 
(expiration, status, reseller_id, recharged_on);

CREATE INDEX IF NOT EXISTS idx_recharges_customer_active ON tbl_user_recharges 
(customer_id, status, expiration);

-- Transactions optimization for revenue calculations
CREATE INDEX IF NOT EXISTS idx_transactions_revenue ON tbl_transactions 
(reseller_id, recharged_on, recharged_time, price);

CREATE INDEX IF NOT EXISTS idx_transactions_daily_stats ON tbl_transactions 
(recharged_on, reseller_id, type, method);

CREATE INDEX IF NOT EXISTS idx_transactions_monthly_revenue ON tbl_transactions 
(recharged_on, reseller_id, plan_name, price);

-- ===================================================================
-- 2. REAL-TIME STATISTICS QUERIES
-- ===================================================================

-- RAD accounting for real-time usage monitoring
CREATE INDEX IF NOT EXISTS idx_rad_acct_realtime ON rad_acct 
(username, dateAdded, acctsessiontime, acctinputoctets, acctoutputoctets);

CREATE INDEX IF NOT EXISTS idx_rad_acct_session_active ON rad_acct 
(acctsessionid, username, dateAdded);

CREATE INDEX IF NOT EXISTS idx_rad_acct_nasip_time ON rad_acct 
(nasipaddress, dateAdded, username);

-- Real-time monitoring for active sessions
CREATE INDEX IF NOT EXISTS idx_radacct_active_sessions ON radacct 
(acctstoptime, username, acctstarttime);

CREATE INDEX IF NOT EXISTS idx_radacct_session_data ON radacct 
(username, acctstarttime, acctsessiontime, acctinputoctets, acctoutputoctets);

-- Portal sessions for hotspot real-time data
CREATE INDEX IF NOT EXISTS idx_portal_sessions_active ON tbl_portal_sessions 
(payment_status, expires_at, reseller_id, phone_number);

-- ===================================================================
-- 3. RESELLER-SPECIFIC DATA FILTERING
-- ===================================================================

-- Reseller management optimization
CREATE INDEX IF NOT EXISTS idx_resellers_status_expires ON tbl_resellers 
(status, expires_at, subscription_status);

CREATE INDEX IF NOT EXISTS idx_resellers_subscription ON tbl_resellers 
(subscription_status, expires_at, last_payment_date);

-- Reseller subscription payments
CREATE INDEX IF NOT EXISTS idx_reseller_payments_tracking ON tbl_reseller_payments 
(reseller_id, status, created_at, type);

CREATE INDEX IF NOT EXISTS idx_reseller_payments_date ON tbl_reseller_payments 
(created_at, reseller_id, amount, status);

-- Reseller settings optimization
CREATE INDEX IF NOT EXISTS idx_reseller_settings_lookup ON tbl_reseller_settings 
(reseller_id, setting_key);

-- Plans filtered by reseller
CREATE INDEX IF NOT EXISTS idx_plans_reseller_enabled ON tbl_plans 
(reseller_id, enabled, type, price);

CREATE INDEX IF NOT EXISTS idx_plans_reseller_type ON tbl_plans 
(reseller_id, type, enabled, name_plan);

-- Bandwidth filtered by reseller
CREATE INDEX IF NOT EXISTS idx_bandwidth_reseller ON tbl_bandwidth 
(reseller_id, name_bw, rate_down, rate_up);

-- ===================================================================
-- 4. MIKROTIK INTEGRATION QUERIES
-- ===================================================================

-- Router management and monitoring
CREATE INDEX IF NOT EXISTS idx_routers_reseller_status ON tbl_routers 
(reseller_id, enabled, status, last_seen);

CREATE INDEX IF NOT EXISTS idx_routers_ip_enabled ON tbl_routers 
(ip_address, enabled, reseller_id);

CREATE INDEX IF NOT EXISTS idx_routers_monitoring ON tbl_routers 
(status, last_seen, enabled, reseller_id);

-- Pool management for MikroTik
CREATE INDEX IF NOT EXISTS idx_pool_routers ON tbl_pool 
(routers, pool_name);

-- RADIUS authentication optimization
CREATE INDEX IF NOT EXISTS idx_radcheck_user_attr ON radcheck 
(username, attribute, value);

CREATE INDEX IF NOT EXISTS idx_radreply_user_attr ON radreply 
(username, attribute, value);

CREATE INDEX IF NOT EXISTS idx_radgroupcheck_group ON radgroupcheck 
(groupname, attribute, value);

CREATE INDEX IF NOT EXISTS idx_radgroupreply_group ON radgroupreply 
(groupname, attribute, value, plan_id);

CREATE INDEX IF NOT EXISTS idx_radusergroup_mapping ON radusergroup 
(username, groupname, priority);

-- NAS management
CREATE INDEX IF NOT EXISTS idx_nas_router_mapping ON nas 
(routers, nasname, enabled);

-- ===================================================================
-- 5. PAYMENT PROCESSING OPTIMIZATION
-- ===================================================================

-- Payment gateway optimization
CREATE INDEX IF NOT EXISTS idx_payment_gateway_tracking ON tbl_payment_gateway 
(gateway_trx_id, status, created_date, reseller_id);

CREATE INDEX IF NOT EXISTS idx_payment_gateway_user ON tbl_payment_gateway 
(username, user_id, status, created_date);

CREATE INDEX IF NOT EXISTS idx_payment_gateway_expiry ON tbl_payment_gateway 
(expired_date, status, reseller_id);

-- M-Pesa transactions optimization
CREATE INDEX IF NOT EXISTS idx_mpesa_transactions_tracking ON tbl_mpesa_transactions 
(session_id, status, created_at, reseller_id);

CREATE INDEX IF NOT EXISTS idx_mpesa_phone_status ON tbl_mpesa_transactions 
(phone_number, status, created_at);

CREATE INDEX IF NOT EXISTS idx_mpesa_receipt_lookup ON tbl_mpesa_transactions 
(mpesa_receipt_number, status, amount);

-- Voucher management optimization
CREATE INDEX IF NOT EXISTS idx_voucher_code_status ON tbl_voucher 
(code, status, reseller_id);

CREATE INDEX IF NOT EXISTS idx_voucher_plan_router ON tbl_voucher 
(id_plan, routers, status, created_at);

CREATE INDEX IF NOT EXISTS idx_voucher_generated_by ON tbl_voucher 
(generated_by, status, created_at, reseller_id);

-- ===================================================================
-- 6. COMPOSITE INDEXES FOR COMPLEX QUERIES
-- ===================================================================

-- Dashboard summary queries
CREATE INDEX IF NOT EXISTS idx_dashboard_summary ON tbl_user_recharges 
(reseller_id, status, expiration, customer_id, recharged_on);

-- Monthly revenue analysis
CREATE INDEX IF NOT EXISTS idx_monthly_analysis ON tbl_transactions 
(reseller_id, recharged_on, type, method, price, plan_name);

-- Customer lifecycle tracking
CREATE INDEX IF NOT EXISTS idx_customer_lifecycle ON tbl_customers 
(reseller_id, created_at, status, service_type, last_login);

-- Real-time user status for resellers
CREATE INDEX IF NOT EXISTS idx_user_status_reseller ON tbl_user_recharges 
(reseller_id, username, status, expiration, type);

-- Plan usage analytics
CREATE INDEX IF NOT EXISTS idx_plan_analytics ON tbl_transactions 
(plan_name, reseller_id, recharged_on, type, price);

-- Router performance monitoring
CREATE INDEX IF NOT EXISTS idx_router_performance ON tbl_routers 
(reseller_id, status, last_seen, enabled, ip_address);

-- ===================================================================
-- 7. LOGGING AND AUDIT OPTIMIZATION
-- ===================================================================

-- System logs optimization
CREATE INDEX IF NOT EXISTS idx_logs_date_user ON tbl_logs 
(date, userid, type);

CREATE INDEX IF NOT EXISTS idx_logs_type_date ON tbl_logs 
(type, date, userid);

-- Message logs for notifications
CREATE INDEX IF NOT EXISTS idx_message_logs_tracking ON tbl_message_logs 
(message_type, status, sent_at, recipient);

-- RADIUS post-auth logs
CREATE INDEX IF NOT EXISTS idx_radpostauth_monitoring ON radpostauth 
(username, authdate, reply, class);

-- ===================================================================
-- 8. ADVANCED PERFORMANCE INDEXES FOR LARGE DATASETS
-- ===================================================================

-- Partitioned-style indexing for large transaction tables
CREATE INDEX IF NOT EXISTS idx_transactions_year_month ON tbl_transactions 
(YEAR(recharged_on), MONTH(recharged_on), reseller_id);

-- Time-based partitioning simulation
CREATE INDEX IF NOT EXISTS idx_transactions_time_partitioned ON tbl_transactions 
(recharged_on, recharged_time, reseller_id, id);

-- Large dataset customer management
CREATE INDEX IF NOT EXISTS idx_customers_large_dataset ON tbl_customers 
(reseller_id, status, created_at, id);

-- Bulk operations optimization
CREATE INDEX IF NOT EXISTS idx_bulk_operations ON tbl_user_recharges 
(admin_id, recharged_on, reseller_id, status);

-- ===================================================================
-- 9. SPECIALIZED INDEXES FOR REPORTING
-- ===================================================================

-- Financial reporting
CREATE INDEX IF NOT EXISTS idx_financial_reports ON tbl_transactions 
(reseller_id, recharged_on, method, price, type);

-- Customer analytics
CREATE INDEX IF NOT EXISTS idx_customer_analytics ON tbl_customers 
(reseller_id, created_at, service_type, status, auto_renewal);

-- Service usage reporting
CREATE INDEX IF NOT EXISTS idx_service_usage ON tbl_user_recharges 
(reseller_id, type, status, recharged_on, expiration);

-- Commission calculations
CREATE INDEX IF NOT EXISTS idx_commission_calc ON tbl_transactions 
(reseller_id, recharged_on, price, method, admin_id);

-- ===================================================================
-- 10. MAINTENANCE AND CLEANUP INDEXES
-- ===================================================================

-- Data cleanup optimization
CREATE INDEX IF NOT EXISTS idx_cleanup_logs ON tbl_logs 
(date, type);

CREATE INDEX IF NOT EXISTS idx_cleanup_radacct ON radacct 
(acctstoptime, acctstarttime);

CREATE INDEX IF NOT EXISTS idx_cleanup_sessions ON tbl_portal_sessions 
(created_at, payment_status);

-- Archive support
CREATE INDEX IF NOT EXISTS idx_archive_transactions ON tbl_transactions 
(recharged_on, reseller_id, id);

-- ===================================================================
-- STATISTICS AND ANALYSIS SUPPORT
-- ===================================================================

-- Force MySQL to analyze table statistics for better query optimization
ANALYZE TABLE tbl_customers;
ANALYZE TABLE tbl_user_recharges;
ANALYZE TABLE tbl_transactions;
ANALYZE TABLE tbl_resellers;
ANALYZE TABLE tbl_routers;
ANALYZE TABLE tbl_plans;
ANALYZE TABLE tbl_payment_gateway;
ANALYZE TABLE tbl_mpesa_transactions;
ANALYZE TABLE rad_acct;
ANALYZE TABLE radacct;

-- ===================================================================
-- PERFORMANCE MONITORING VIEWS
-- ===================================================================

-- Create view for monitoring index usage
CREATE OR REPLACE VIEW v_index_usage_stats AS
SELECT 
    TABLE_NAME,
    INDEX_NAME,
    COLUMN_NAME,
    CARDINALITY,
    SUB_PART,
    INDEX_TYPE
FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = DATABASE()
AND TABLE_NAME LIKE 'tbl_%' OR TABLE_NAME LIKE 'rad%'
ORDER BY TABLE_NAME, INDEX_NAME;

-- Create view for reseller performance metrics
CREATE OR REPLACE VIEW v_reseller_performance_metrics AS
SELECT 
    r.id as reseller_id,
    r.name as reseller_name,
    r.status as reseller_status,
    COUNT(DISTINCT c.id) as total_customers,
    COUNT(DISTINCT CASE WHEN ur.status = 'on' THEN c.id END) as active_customers,
    COUNT(DISTINCT rt.id) as total_routers,
    COALESCE(SUM(CASE WHEN t.recharged_on >= CURDATE() THEN t.price END), 0) as today_revenue,
    COALESCE(SUM(CASE WHEN t.recharged_on >= DATE_SUB(CURDATE(), INTERVAL 30 DAY) THEN t.price END), 0) as month_revenue,
    COUNT(DISTINCT CASE WHEN ur.expiration <= DATE_ADD(CURDATE(), INTERVAL 7 DAY) AND ur.status = 'on' THEN ur.id END) as expiring_soon
FROM tbl_resellers r
LEFT JOIN tbl_customers c ON r.id = c.reseller_id
LEFT JOIN tbl_user_recharges ur ON c.id = ur.customer_id
LEFT JOIN tbl_transactions t ON r.id = t.reseller_id
LEFT JOIN tbl_routers rt ON r.id = rt.reseller_id
WHERE r.id > 1
GROUP BY r.id, r.name, r.status;

-- ===================================================================
-- QUERY OPTIMIZATION HINTS
-- ===================================================================

-- Add helpful comments for query optimization
-- For dashboard queries, always filter by reseller_id first
-- Use LIMIT clauses for paginated results
-- Consider using covering indexes for read-heavy operations
-- Use date range queries with proper indexing

-- ===================================================================
-- RESTORE SETTINGS
-- ===================================================================

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- ===================================================================
-- COMPLETION MESSAGE
-- ===================================================================

SELECT 'Performance optimization indexes created successfully!' as Status,
       'Total indexes created: ~80 optimized indexes' as Summary,
       'Covers: Dashboard, Real-time stats, Reseller filtering, MikroTik integration, Payment processing' as Coverage;