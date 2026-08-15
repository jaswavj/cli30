-- Tamil product name — REQUIRED for Tamil text save
-- Option A: Run this SQL in phpMyAdmin / MySQL
-- Option B: Open in browser (while logged in):
--   /billing/product/master/product/fixTamilNameCharset.jsp

ALTER TABLE `prod_product`
MODIFY COLUMN `tamil_name` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL;

-- If column does not exist yet:
-- ALTER TABLE `prod_product`
-- ADD COLUMN `tamil_name` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL AFTER `name`;
