-- Aggregate Window Functions

-- AVG() + PARTITION BY
-- Calculate the average value of the products on product subcategories
SELECT  prod_id,
		prod_name,
		prod_subcategory,
		prod_list_price,
		ROUND (AVG (prod_list_price) OVER (PARTITION BY prod_subcategory), 2) -- OVER keyword signals a window function
FROM 	sh.products
WHERE 	prod_subcategory IN ('Bulk Pack Diskettes', 'Camera Media', 'Printer Supplies');
/*
|prod_id|prod_name                              |prod_subcategory   |prod_list_price|round|
|-------|---------------------------------------|-------------------|---------------|-----|
|125    |3 1/2" Bulk diskettes, Box of 50       |Bulk Pack Diskettes|15.99          |22.49|
|126    |3 1/2" Bulk diskettes, Box of 100      |Bulk Pack Diskettes|28.99          |22.49|
|138    |256MB Memory Card                      |Camera Media       |69.99          |51.99|
|136    |64MB Memory Card                       |Camera Media       |32.99          |51.99|
|137    |128MB Memory Card                      |Camera Media       |52.99          |51.99|
|130    |Model A3827H Black Image Cartridge     |Printer Supplies   |89.99          |86.99|
|127    |Model CD13272 Tricolor Ink Cartridge   |Printer Supplies   |36.99          |86.99|
|128    |Model SM26273 Black Ink Cartridge      |Printer Supplies   |27.99          |86.99|
|129    |Model NM500X High Yield Toner Cartridge|Printer Supplies   |192.99         |86.99|
*/
--