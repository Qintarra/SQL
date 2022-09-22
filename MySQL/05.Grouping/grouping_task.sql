-- Find the number of customers for each discount (customer_count) and their discount (discount), sorted ascending by discount.
SELECT COUNT (person_id) AS customer_count, discount
FROM customer
GROUP BY discount
ORDER BY discount;

-- Find for which orders (customer_order_id) the total price (total cost) of products (to_pay) is more than 100, sorted ascending by customer_order_id.
SELECT customer_order_id, SUM (price * product_amount) AS to_pay
FROM order_details
GROUP BY customer_order_id
HAVING SUM (price * product_amount) > 100
ORDER BY customer_order_id;

-- Find the order with the highest total discount value among all orders and get its discount value (max_order_discount).
SELECT SUM((price - price_with_discount) * product_amount) AS max_order_discount
FROM order_details
GROUP BY customer_order_id
ORDER BY max_order_discount DESC
LIMIT 1;