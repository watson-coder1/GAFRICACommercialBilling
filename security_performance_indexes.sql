-- Security and Performance Indexes for Glinta Hotspot Billing System
-- Run this script to add critical indexes for better performance

-- Add indexes for tbl_customers
ALTER TABLE tbl_customers ADD INDEX idx_username (username);
ALTER TABLE tbl_customers ADD INDEX idx_phonenumber (phonenumber);
ALTER TABLE tbl_customers ADD INDEX idx_email (email);
ALTER TABLE tbl_customers ADD INDEX idx_created_at (created_at);

-- Add indexes for tbl_user_recharges
ALTER TABLE tbl_user_recharges ADD INDEX idx_customer_id (customer_id);
ALTER TABLE tbl_user_recharges ADD INDEX idx_username (username);
ALTER TABLE tbl_user_recharges ADD INDEX idx_expiration_status (expiration, status);
ALTER TABLE tbl_user_recharges ADD INDEX idx_customer_status (customer_id, status);
ALTER TABLE tbl_user_recharges ADD INDEX idx_plan_id (plan_id);

-- Add indexes for tbl_transactions
ALTER TABLE tbl_transactions ADD INDEX idx_username (username);
ALTER TABLE tbl_transactions ADD INDEX idx_recharged_datetime (recharged_on, recharged_time);
ALTER TABLE tbl_transactions ADD INDEX idx_method (method);
ALTER TABLE tbl_transactions ADD INDEX idx_type (type);
ALTER TABLE tbl_transactions ADD INDEX idx_routers (routers);
ALTER TABLE tbl_transactions ADD INDEX idx_plan_name (plan_name);

-- Add indexes for tbl_logs
ALTER TABLE tbl_logs ADD INDEX idx_date (date);
ALTER TABLE tbl_logs ADD INDEX idx_userid (userid);
ALTER TABLE tbl_logs ADD INDEX idx_type (type);
ALTER TABLE tbl_logs ADD INDEX idx_date_userid (date, userid);

-- Add indexes for tbl_voucher
ALTER TABLE tbl_voucher ADD INDEX idx_code (code);
ALTER TABLE tbl_voucher ADD INDEX idx_status (status);
ALTER TABLE tbl_voucher ADD INDEX idx_routers (routers);
ALTER TABLE tbl_voucher ADD INDEX idx_id_plan (id_plan);

-- Add indexes for tbl_plans
ALTER TABLE tbl_plans ADD INDEX idx_name_plan (name_plan);
ALTER TABLE tbl_plans ADD INDEX idx_enabled (enabled);
ALTER TABLE tbl_plans ADD INDEX idx_type (type);
ALTER TABLE tbl_plans ADD INDEX idx_routers (routers);

-- Add indexes for tbl_message_logs (if exists)
ALTER TABLE tbl_message_logs ADD INDEX idx_message_type (message_type);
ALTER TABLE tbl_message_logs ADD INDEX idx_status (status);
ALTER TABLE tbl_message_logs ADD INDEX idx_sent_at (sent_at);

-- Add indexes for RADIUS tables (if exists)
ALTER TABLE radpostauth ADD INDEX idx_username (username);
ALTER TABLE radpostauth ADD INDEX idx_authdate (authdate);
ALTER TABLE radpostauth ADD INDEX idx_reply (reply);

-- Add indexes for radacct table (if exists)
ALTER TABLE radacct ADD INDEX idx_username (username);
ALTER TABLE radacct ADD INDEX idx_acctsessionid (acctsessionid);
ALTER TABLE radacct ADD INDEX idx_acctstarttime (acctstarttime);
ALTER TABLE radacct ADD INDEX idx_acctstoptime (acctstoptime);
ALTER TABLE radacct ADD INDEX idx_acctstatustype (acctstatustype);

-- Add composite indexes for better query performance
ALTER TABLE tbl_user_recharges ADD INDEX idx_username_expiration (username, expiration);
ALTER TABLE tbl_customers ADD INDEX idx_username_password (username, password);
ALTER TABLE tbl_transactions ADD INDEX idx_username_datetime (username, recharged_on, recharged_time);