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

INSERT INTO product (id, product_title_id, manufacturer_id, price, comment)
VALUES  (1,  1,	1,	10.11,	'Dark beer'),
		(2,	 1,	2,	5.05,	'Light beer'),
		(3,	 2,	3,	15,		'African Banana'),
		(4,  2,	4,	20,		'Brazilian Banana'),
		(5,  3,	1,	16.2,	'Mexican Orange'),
		(6,	 3,	2,	12,		'Italian Orange'),
		(7,	 4,	3,	13,		'Clear water'),
		(8,	 4,	4,	50,		'Sweet water'),
		(9,	 5,	1,	100,	'range Juice'),
		(10, 5,	2,	120,	'Banana Juice'),
		(11, 6,	3,	60,		'Coca Cola'),
		(12, 6, 4,	5.5,	'Pepsi Cola'),
		(13, 7,	1,	12.23,	'Smoked Salmon'),
		(14, 7,	2,	10.02,	'Spicy Salmon'),
		(15, 8,	2,	89,		'Red apple'),
		(16, 8,	1,	88.99,	'Sweet apple'),
		(17, 9,	2,	32,		'Fresh Snapper'),
		(18, 9,	1,	33.33,	'Frozen Snaper'),
		(19, 10, 2,	44.44,	'Canned Tuna'),
		(20, 10, 2,	55.55,	'Fried Tuna');

INSERT INTO customer_order (id, operation_time, supermarket_id, customer_id)
VALUES  (1,	 '2020-01-01',	1,	1),
		(2,	 '2020-02-02',	2,	2),
		(3,  '2020-02-02',	3,	3),
		(4,	 '2020-03-03',	4,	4),
		(5,	 '2020-04-04',	5,	5),
		(6,	 '2020-05-05',	6,	6),
		(7,  '2020-06-06',	7,	7),
		(8,	 '2020-07-07',	1,	8),
		(9,	 '2020-08-08',	2,	9),
		(10, '2020-09-11',	3,	10),
		(11, '2020-10-10',	4,	1),
		(12, '2020-11-11',	5,	2),
		(13, '2021-01-01',	6,	3),
		(14, '2021-01-01',	7,	4),
		(15, '2022-01-01',	1,	5),
		(16, '2022-01-01',	2,  1),
		(17, '2021-01-01',	3,	2),
		(18, '2019-01-01',	4,	3),
		(19, '2017-01-01',	5,	4),
		(20, '2018-01-01',	6,	5);

INSERT INTO order_details (id, customer_order_id, product_id, price, price_with_discount, product_amount)
VALUES  (1,	 1,  1,	 20,	18,	   4),
		(2,	 2,	 2,	 80,	78.4,  5),
		(3,	 3,	 3,	 90,	81,	   6),
		(4,	 4,  4,	 30,	29.4,  2),
		(5,	 5,	 5,  40,	36,    1),
		(6,	 6,	 6,	 50,	49,	   3),
		(7,	 7,  7,	 60,	57,	   11),
		(8,	 8,	 8,	 70,	66.5,  13),
		(9,	 9,	 9,	 80,	80,	   14),
		(10, 10, 10, 90,	90,	   2),
		(11, 11, 11, 120,	120,   1),
		(12, 12, 12, 130,	130,   5),
		(13, 13, 13, 40,	36,	   6),
		(14, 14, 14, 50,	45,	   7),
		(15, 15, 15, 33,	31.35, 8),
		(16, 16, 16, 44,	39.6,  10),
		(17, 16, 16, 55,	49.5,  4),
		(18, 17, 18, 88,	79.2,  5),
		(19, 17, 20, 77,	75.46, 3),
		(20, 18, 19, 88,	79.2,  4);