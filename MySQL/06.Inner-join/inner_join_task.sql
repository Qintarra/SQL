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

-- Select products (title, price) that customers purchased with a birthday date range inclusive 1 Jan 2000 – 31 Dec 2010 (the date format is YYYY-MM-DD), sorted ascending by a title and price.
SELECT DISTINCT product_title.title, product.price
FROM product
INNER JOIN product_title ON product.product_title_id = product_title.id
INNER JOIN order_details ON  product.id = order_details.product_id
INNER JOIN customer_order ON customer_order.id = order_details.customer_order_id
INNER JOIN customer ON customer.person_id = customer_order.customer_id
INNER JOIN person ON customer.person_id = person.id
WHERE birth_date BETWEEN '2000-01-01' AND '2010-12-31'
ORDER BY title, product.price;