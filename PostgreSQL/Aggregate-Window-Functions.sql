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

-- SUM() + PARTITION BY
-- Get the sales amount by channels and countries for 09.2000 - 10.2000 and the total sales amount by countries
SELECT	 cn.country_name,
         ch.channel_desc,
         SUM (amount_sold) AS sales$,
         SUM (SUM (amount_sold)) OVER (PARTITION BY cn.country_name) AS all_channels_sales$ 
FROM 	 sh.sales s 
 JOIN	 sh.products p ON p.prod_id = s.prod_id 
 JOIN	 sh.customers cust ON cust.cust_id = s.cust_id 
 JOIN 	 sh.times t ON t.time_id = s.time_id 
 JOIN 	 sh.channels ch ON ch.channel_id = s.channel_id 
 JOIN 	 sh.countries cn ON cn.country_id = cust.country_id
WHERE	 t.calendar_month_desc IN ('2000-09', '2000-10')
AND 	 cn.country_iso_code IN ('AU', 'BR', 'CA', 'DE')
GROUP BY cn.country_name,
         ch.channel_desc 
ORDER BY country_name;
-- Note: the window function can take as an argument not only the name of the columns but also expressions (the Sum function in this case)
/*
|country_name|channel_desc|sales$    |all_channels_sales$|
|------------|------------|----------|-------------------|
|Australia   |Direct Sales|97,052.66 |172,636.47         |
|Australia   |Internet    |12,903.02 |172,636.47         |
|Australia   |Partners    |62,680.79 |172,636.47         |
|Brazil      |Direct Sales|8.46      |1,564.48           |
|Brazil      |Partners    |1,556.02  |1,564.48           |
|Canada      |Direct Sales|52,323.4  |103,413.28         |
|Canada      |Internet    |13,547.6  |103,413.28         |
|Canada      |Partners    |37,542.28 |103,413.28         |
|Germany     |Direct Sales|274,535.59|406,232.18         |
|Germany     |Internet    |36,865.38 |406,232.18         |
|Germany     |Partners    |94,831.21 |406,232.18         |
*/
--

-- TASK. For each product category, find the region in which it had maximum sales
--part 1:
SELECT	 prod_category,
         country_region,
         SUM (s.amount_sold) AS sales,
         MAX (SUM (amount_sold)) OVER (PARTITION BY p.prod_category) AS max_reg_sales -- window function MAX will find the maximum value of sales for each product category
FROM 	 sh.sales s 
 JOIN	 sh.products p ON p.prod_id = s.prod_id 
 JOIN	 sh.customers cust ON cust.cust_id = s.cust_id  
 JOIN 	 sh.channels ch ON ch.channel_id = s.channel_id 
 JOIN 	 sh.countries cn ON cn.country_id = cust.country_id
WHERE	 time_id = TO_DATE ('11-OCT-2001', 'DD-MON-YYYY')
GROUP BY prod_category,
         country_region;
/*
|prod_category              |country_region|sales   |max_reg_sales|
|---------------------------|--------------|--------|-------------|
|Electronics                |Americas      |581.92  |581.92       |
|Hardware                   |Americas      |925.93  |925.93       |
|Peripherals and Accessories|Americas      |3,084.48|4,290.38     |
|Peripherals and Accessories|Asia          |2,616.51|4,290.38     |
|Peripherals and Accessories|Europe        |4,290.38|4,290.38     |
|Peripherals and Accessories|Oceania       |940.43  |4,290.38     |
|Software/Other             |Americas      |4,445.7 |4,445.7      |
|Software/Other             |Asia          |1,408.19|4,445.7      |
|Software/Other             |Europe        |3,288.83|4,445.7      |
|Software/Other             |Oceania       |890.25  |4,445.7      |
*/
-- part 2:
SELECT 	prod_category,
        country_region,
        sales
FROM	(
        SELECT	 prod_category,
                 country_region,
                 SUM (s.amount_sold) AS sales,
                 MAX (SUM (amount_sold)) OVER (PARTITION BY p.prod_category) AS max_reg_sales
        FROM 	 sh.sales s 
         JOIN	 sh.products p ON p.prod_id = s.prod_id 
         JOIN	 sh.customers cust ON cust.cust_id = s.cust_id  
         JOIN 	 sh.channels ch ON ch.channel_id = s.channel_id 
         JOIN 	 sh.countries cn ON cn.country_id = cust.country_id
        WHERE	 time_id = TO_DATE ('11-OCT-2001', 'DD-MON-YYYY')
        GROUP BY prod_category,
                 country_region
        ) tab
WHERE 	sales = max_reg_sales;
/*
|prod_category              |country_region|sales   |
|---------------------------|--------------|--------|
|Electronics                |Americas      |581.92  |
|Hardware                   |Americas      |925.93  |
|Peripherals and Accessories|Europe        |4,290.38|
|Software/Other             |Americas      |4,445.7 |
*/
--