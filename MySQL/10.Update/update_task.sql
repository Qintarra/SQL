-- Rename supermarkets by replacing the old name "Your Choice" or "kramnichka" with the new "Your Friend".
UPDATE supermarket
SET name = 'Your Friend'
WHERE name IN ('Your Choice', 'kramnichka');

-- In the products table, all fruits and vegetables should fall in price by 25% of their current value.
UPDATE product 
SET price = price * 0.75
WHERE id IN
        (SELECT product.id
        FROM product
        INNER JOIN product_title ON product_title.id = product_title_id
        INNER JOIN product_category ON product_category.id = product_category_id
        WHERE product_category.id IN (1, 3));
