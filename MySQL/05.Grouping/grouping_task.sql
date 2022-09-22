-- Find the number of customers for each discount (customer_count) and their discount (discount), sorted ascending by discount.
SELECT COUNT (person_id) AS customer_count, discount
FROM customer
GROUP BY discount
ORDER BY discount;
