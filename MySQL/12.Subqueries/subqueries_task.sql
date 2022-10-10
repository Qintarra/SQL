-- Get product list, which price is two  times higher or more then minimum price (id, product, price), sorted ascending by price, product.
SELECT product.id, title AS product, product.price
FROM product
LEFT JOIN order_details ON  product_id = product.id
INNER JOIN product_title ON product_title_id = product_title.id
WHERE product.price > 
		(SELECT MIN (price * 2)
		FROM product)
GROUP BY product.id
ORDER BY 3, 2;

-- Get a list of customers with birthday date range inclusive 1 Jan 2000 – 31 Dec 2010 (date format is YYYY-MM-DD), whom total sum of purchases is higher then average total purchase sum of all authorized customers (last name, first name, total expenses). Sort ascending by total expenses, last name.
SELECT surname, name, SUM (price_with_discount * product_amount) AS total_expenses
FROM order_details
INNER JOIN customer_order ON customer_order_id = customer_order.id
INNER JOIN customer ON person_id = customer_id
INNER JOIN person ON person_id = person.id
WHERE birth_date BETWEEN '2000-01-01' AND '2010-12-31'
GROUP BY person.id
HAVING SUM (price_with_discount * product_amount) >
		(SELECT AVG (purchases.sum) FROM
				(SELECT SUM (price_with_discount * product_amount) AS sum
				FROM order_details
				INNER JOIN customer_order ON customer_order_id = customer_order.id
				INNER JOIN customer ON person_id = customer_id
				INNER JOIN person ON person_id = person.id
				GROUP BY person_id) AS purchases)
ORDER BY 3, 1;
