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