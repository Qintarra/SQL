INSERT INTO city (id, name)
VALUES  (1, 'Dnipro'), (2, 'Kyiv'), (3, 'Lviv');

INSERT INTO street (id, name, city_id)
VALUES  (1, 'Shevchenko', 1), 
		(2, 'Volkova', 2), 
		(3, 'Kioto', 2), 
		(4, 'Garmatna', 2), 
		(5, 'Naukova', 3);

INSERT INTO supermarket (id, name, street_id, house_number)
VALUES  (1, 'ATB', 2, 15), 
		(2, 'Auchan', 5, 24), 
		(3, 'Fora', 1, 16), 
		(4, 'Metro', 2, 5), 
		(5, 'Novus', 4, 53),
		(6, 'Silpo', 3, 63),
		(7, 'Varus', 3, 21);
