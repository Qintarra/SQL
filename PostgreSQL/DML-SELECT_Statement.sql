-- DML: SELECT Statement

SELECT * 
FROM film;
--

SELECT title, release_year
FROM film;
ORDER BY title;
--

SELECT title, release_year
FROM film;
ORDER BY release_year DESC;
--

SELECT title, release_year
FROM film;
ORDER BY release_year, title;
--

SELECT title, release_year  
FROM film 
ORDER BY 2, 1;
--

SELECT title AS movie_title, release_year AS movie_release_year  
FROM film 
ORDER BY 1;
--

SELECT title AS movie_title, release_year AS movie_release_year  
FROM film 
ORDER BY movie_release_year DESC;
--

SELECT DISTINCT rating  
FROM film 
ORDER BY 1;
--

SELECT actor_id, first_name, last_name  
FROM actor  
ORDER BY 2, 3;
--

SELECT actor_id, first_name || ' ' || last_name AS actor_full_name
FROM actor  
ORDER BY 2;
--

SELECT actor_id, first_name || ' ' || last_name AS actor_full_name
FROM actor  
WHERE last_name = 'Cruise' 
ORDER BY 2;
--

SELECT actor_id, first_name || ' ' || last_name AS actor_full_name
FROM actor  
WHERE UPPER (last_name) = 'CRUISE' 
ORDER BY 2;
--

SELECT actor_id, first_name || ' ' || last_name AS actor_full_name
FROM actor  
WHERE UPPER (last_name) LIKE ('BRA%') 
ORDER BY 2;
--

SELECT actor_id, first_name || ' ' || last_name AS actor_full_name
FROM actor  
WHERE UPPER (last_name) IN ('CRUISE', 'BRANDO', 'STREEP') 
ORDER BY 2;
--

SELECT SUBSTRING ('Leonardo', 1, 3); -- Leo
--

SELECT POSITION ('L' IN 'Leonardo'); -- 1
--

SELECT POSITION ('l' IN 'Leonardo'); -- 0
--