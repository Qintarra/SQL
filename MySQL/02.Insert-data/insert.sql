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

INSERT INTO contact_type (id, name)
VALUES (1, 'phone'), (2, 'email');

INSERT INTO person_contact (id, person_id, contact_type_id, contact_value)
VALUES  (1, 9,	1,	'+38(099)123-45-67'),
		(2, 9,	2,	'user9@example.com'),
		(3,	10,	1,	'+38(098)123-45-67'),
		(4,	10,	2,	'user10@example.com'),
		(5,	8,	1,	'+38(097)123-45-67'),
		(6,	8,	2,	'user8@example.com'),
		(7,	7,	1,	'+38(067)123-45-67'),
		(8,	7,	2,	'user7@example.com'),
		(9,	6,	1,	'+38(066)123-45-67'),
		(10, 6,	2,	'user6@example.com'),
		(11, 5,	1,	'+38(055)123-45-67'),
		(12, 5,	2,	'user5@example.com'),
		(13, 4,	1,	'+38(044)123-45-67'),
		(14, 4,	2,	'user4@example.com'),
		(15, 3,	1,	'+38(033)123-45-67'),
		(16, 3,	2,	'user3@example.com'),
		(17, 2,	1,	'+38(022)123-45-67'),
		(18, 2,	2,	'user2@example.com'),
		(19, 1,	1,	'+38(011)123-45-67'),
		(20, 1, 2,	'user1@example.com');

INSERT INTO customer (person_id, card_number, discount)
VALUES  (1, 921212121, 0.1),
		(2,	935456021, 0.02),
		(3,	909090283, 0.1),
		(4,	120985320, 0.02),
		(5,	437238943, 0.1),
		(6,	129034871, 0.02),
		(7,	438927489, 0.05),
		(8,	321794012, 0.05),
		(9,	218324131, 0),
		(10, 423443222, 0);

INSERT INTO product_category (id, name)
VALUES (1, 'drinks'), (2, 'fish'), (3, 'fruits');

INSERT INTO product_title (id, title, product_category_id)
VALUES  (1, 'Beer',   1),
		(2, 'Banana', 3),
		(3,	'Orange', 3),
		(4,	'Water',  1),
		(5,	'Juice',  1),
		(6,	'Cola',   1),
		(7,	'Salmon', 2),
		(8,	'Apple',  3),
		(9,	'Snapper', 2),
		(10, 'Tuna',  2);

INSERT INTO manufacturer (id, name)
VALUES (1, 'First'), (2, 'Second'), (3, 'Third'), (4, 'Fourth');

