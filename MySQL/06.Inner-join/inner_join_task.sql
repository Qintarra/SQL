-- Select products (id, title, price), sorted ascending by title.
SELECT product.id, product_title.title, product.price
FROM product
INNER JOIN product_title ON product.product_title_id = product_title.id
ORDER BY title;

-- Select products (id, title, category name, price), sorted ascending by category name and product title.
SELECT product.id, product_title.title, product_category.name AS category, product.price
FROM product
INNER JOIN product_title ON product.product_title_id = product_title.id
INNER JOIN product_category ON product_category_id = product_category.id
ORDER BY category, title;

