-- Set the app URL and M-Pesa callback URL
INSERT INTO `tbl_appconfig` (`setting`, `value`) VALUES 
('app_url', 'https://glintaafrica.com')
ON DUPLICATE KEY UPDATE `value` = 'https://glintaafrica.com';

-- Add specific M-Pesa callback URL setting
INSERT INTO `tbl_appconfig` (`setting`, `value`) VALUES 
('mpesa_callback_url', 'https://glintaafrica.com/portal/callback')
ON DUPLICATE KEY UPDATE `value` = 'https://glintaafrica.com/portal/callback';