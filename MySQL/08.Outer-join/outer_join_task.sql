-- Get all products (category name, product name) that are not presented in orders, sorted ascending by product id.
SELECT name AS category, title AS product
FROM product
LEFT JOIN order_details ON product_id = product.id
INNER JOIN product_title ON product_title_id = product_title.id
INNER JOIN product_category ON product_category_id = product_category.id
WHERE product_id IS NULL
ORDER BY product_category.id;

