# Database design and SQL (DQL). Outer join

## Task  

1. Get all products (category name, product name) that are not presented in orders, sorted ascending by product id. Scheme of result data set:  **category | product**
 
2. Get a list of authorized customers (last name, first name, date of birth) who has no orders in retailer stores. Sort ascending by last name, and birth date. Scheme of result data set: **surname | name | birth_date**

3. Get a list of customers with their total amount of purchases (last name, first name, total expenses). The list includes buyers with and without purchases in retailer stores. The list also includes one anonymous buyer. Sort ascending by customer expenses and surname. Scheme of result data set: **surname | name | sum**