-- Fix for time_limit column to accept NULL or default to 0
ALTER TABLE `tbl_plans` MODIFY COLUMN `time_limit` int(11) DEFAULT 0;

-- Update any NULL values to 0
UPDATE `tbl_plans` SET `time_limit` = 0 WHERE `time_limit` IS NULL;