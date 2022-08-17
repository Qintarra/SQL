-- DML: INSERT Statement

INSERT INTO city (city, country_id)

VALUES ('Kyiv', 100); -- 100 is the id of Ukraine in the country TABLE

SELECT * -- to check if city was added
FROM city c
WHERE c.country_id = 100;
--

INSERT INTO city (city, country_id)

SELECT 'Kharkiv', cnt.country_id
FROM country cnt
WHERE UPPER (cnt.country) = 'UKRAINE';
--

INSERT INTO city (city, country_id)

SELECT 'Dnipro', cnt.country_id
FROM country cnt
WHERE UPPER (cnt.country) = 'UKRAINE'
RETURNING city_id;
--

-- DML: UPDATE Statement
SELECT * 
FROM city c
WHERE c.country_id = 100
ORDER BY 1;

UPDATE city 
SET city = 'Shostka'
WHERE city_id = 385;
--

UPDATE city 
SET city = cr.new_name 
FROM city_rename cr 
WHERE cr.city_id = city.city_id 
RETURNING *;
--

-- DELETE & TRUNCATE Statements
SELECT * 
FROM city c
WHERE UPPER (c.city) = 'Dnipro'; -- city id 607

DELETE FROM city 
WHERE city_id = 607;
--