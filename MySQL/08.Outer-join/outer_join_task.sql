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

-- Get a list of customers with their total amount of purchases (last name, first name, total expenses). The list includes buyers with and without purchases in retailer stores. The list also includes one anonymous buyer. Sort ascending by customer expenses and surname.
SELECT surname, name, SUM (price_with_discount * product_amount) AS sum
FROM order_details
INNER JOIN customer_order ON customer_order_id = customer_order.id
LEFT JOIN person ON customer_id = person.id
GROUP BY surname, name
UNION
SELECT surname, name, 0
FROM customer
INNER JOIN person ON person_id = person.id
LEFT JOIN customer_order ON customer_id = person_id
WHERE customer_id IS NULL
ORDER BY sum, surname;