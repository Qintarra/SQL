# Database design and SQL (DQL). Subqueries

## Task  

1. Get a product list, which price is two times higher or more than the minimum price (id, product, price), sorted ascending by price, product. Scheme of result data set: **id| product | price**

2. Get a list of customers with a birthday date range inclusive 1 Jan 2000 – 31 Dec 2010 (the date format is YYYY-MM-DD), whose total sum of purchases is higher than the average total purchase sum of all authorized customers (last name, first name, total expenses). Sort ascending by total expenses, and last name. Scheme of result data set: **surname | name | total_expenses**
 
3. Get orders for the 2021 year, which contain more items per order (not items’ product amount) than the average number of items across all orders. Sort ascending by order items amount and order id. Scheme of result data set: **order_id | items_count**
