INSERT INTO city (id, name)
VALUES  (1, 'Dnipro'), (2, 'Kyiv'), (3, 'Lviv');

INSERT INTO street (id, name, city_id)
VALUES  (1, 'Shevchenko', 1), 
		(2, 'Volkova', 2), 
		(3, 'Kioto', 2), 
		(4, 'Garmatna', 2), 
		(5, 'Naukova', 3);
