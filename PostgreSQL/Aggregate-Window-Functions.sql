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