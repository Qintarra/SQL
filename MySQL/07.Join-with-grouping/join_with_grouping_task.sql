﻿-- Select non-empty categories with the total product number for each one (category name, count), sorted ascending by name.
SELECT product_category.name AS category, COUNT (product.id) AS count
FROM product_category
INNER JOIN product_title ON product_category_id = product_category.id
INNER JOIN product ON product_title_id = product_title.id
WHERE category IS NOT NULL
GROUP BY name
ORDER BY name;

-- Select sales revenue for each city (city, income) on 1 Nov 2020 – 30 Nov 2020 inclusive (the date format is YYYY-MM-DD), sorted ascending by revenue and city.
SELECT city.name AS city, SUM (order_details.price_with_discount * order_details.product_amount) AS income
FROM order_details
INNER JOIN customer_order ON customer_order_id = customer_order.id
INNER JOIN supermarket ON supermarket_id = supermarket.id
INNER JOIN street ON street_id = street.id
INNER JOIN city ON city_id = city.id
WHERE customer_order.operation_time BETWEEN '2020-11-01' AND '2020-11-30'
GROUP BY city.name
ORDER BY city, income;

