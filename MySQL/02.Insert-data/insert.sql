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

INSERT INTO person (id, name, surname, birth_date)
VALUES  (1, 'Yevgen', 'Kojevskiy', '2000-01-01'),
		(2,	'Yan', 'Petrenko', '2001-11-01'),
		(3,	'Janna', 'Ivanova', '2002-12-12'),
		(4,	'Denis', 'Galushko', '1995-10-01'),
		(5,	'Filip', 'Kromvel', '1980-08-08'),
		(6,	'Bogdan', 'Steciuk', '2002-07-01'),
		(7, 'Yeva', 'Krasivaya', '1992-08-08'),
		(8,	'Nadegda', 'Vesela', '1997-05-11'),
		(9,	'Arsen', 'Govorliviy', '1990-11-21'),
		(10, 'Mariya', 'Velikolepnaya', '1988-04-01');
