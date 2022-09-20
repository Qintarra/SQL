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
