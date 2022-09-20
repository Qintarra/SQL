-- Find the average price from the pricelist (price_average).
SELECT AVG (price) AS price_average
FROM product;

-- Find the total number of supermarkets (supermarket_count).
SELECT COUNT (id) AS supermarket_count
FROM supermarket;

-- Find the total number of customers (customer_count) with discount of more than 0.
SELECT COUNT (person_id) AS customer_count
FROM customer
WHERE discount > 0;

-- Find the number of products sold at a discount (product_total), sales revenue (to_pay_total) and discount amount (discount_total).
SELECT  SUM (product_amount) AS product_total,
		SUM (price_with_discount * product_amount) AS to_pay_total,
		SUM ((price - price_with_discount)* product_amount) AS discount_total
FROM    order_details
WHERE  (price_with_discount < price);