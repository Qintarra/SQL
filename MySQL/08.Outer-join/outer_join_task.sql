-- Get all products (category name, product name) that are not presented in orders, sorted ascending by product id.
SELECT name AS category, title AS product
FROM product
LEFT JOIN order_details ON product_id = product.id
INNER JOIN product_title ON product_title_id = product_title.id
INNER JOIN product_category ON product_category_id = product_category.id
WHERE product_id IS NULL
ORDER BY product_category.id;

-- Get a list of authorized customers (last name, first name, date of birth) who has no orders in retailer stores. Sort ascending by last name, and birth date.
SELECT surname, name, birth_date
FROM person
LEFT JOIN customer ON person_id = person.id
LEFT JOIN customer_order ON customer_id = person_id
LEFT JOIN order_details ON customer_order_id = customer_order.id
WHERE customer_order_id IS NULL AND person_id = person.id
ORDER BY 1, 3;

