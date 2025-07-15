-- Fix Test Reseller Subscription Data
-- Updates the test reseller to have correct expiry fields

UPDATE tbl_resellers 
SET 
    expires_at = DATE_ADD(NOW(), INTERVAL 30 DAY),
    subscription_status = 'trial'
WHERE name = 'Test Reseller';

-- Verify the update
SELECT 
    id,
    name, 
    subscription_status,
    expires_at,
    DATEDIFF(expires_at, NOW()) as days_remaining
FROM tbl_resellers 
WHERE name = 'Test Reseller';