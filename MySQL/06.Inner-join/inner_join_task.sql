-- Select products (id, title, price), sorted ascending by title.
SELECT product.id, product_title.title, product.price
FROM product
INNER JOIN product_title ON product.product_title_id = product_title.id
ORDER BY title;
