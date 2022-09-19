-- Select product categories (id, name), sorted ascending by name.
SELECT id, name
FROM product_category
ORDER BY name;

-- Select customers (person_id, discount) with discount more then 0, sorted ascending by person_id.
SELECT person_id, discount
FROM customer
WHERE discount > 0
ORDER BY person_id;

--Select persons list (surname, name, birth_date) with birthday date range inclusive Jan 2000 – 31 Dec 2010 (date format is YYYY-MM-DD), sorted ascending by surname.
SELECT surname, name, birth_date
FROM person
WHERE birth_date BETWEEN '2000-01-01' AND '2010-12-31'
ORDER BY surname;

-- Select persons (name, surname) whose last name begins with "Kra", sorted by surname  ascending. Customers with the same surnames should be sorted descending by birthday date.
SELECT name, surname
FROM person
WHERE surname LIKE 'Kra%'
ORDER BY surname, birth_date DESC;

-- Select persons (surname), sorted ascending by surname. The surnames must be different.
SELECT DISTINCT surname
FROM person
ORDER BY surname;