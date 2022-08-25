-- Ranking Window Functions

-- ROW_NUMBER

--Display the sales amount by the channels for 09.2000 - 10.2000 and rank all rows of the data set by the sales amount
SELECT	 ch.channel_desc,
		 t.calendar_month_desc,
		 TO_CHAR (TRUNC (SUM (amount_sold), -5), '9,999,999,999') AS sales$,
		 ROW_NUMBER () OVER (ORDER BY TRUNC (SUM (amount_sold), -5) DESC) AS row_number -- the function TRUNC was applied to the sales amount to analyze how the function handles the same values 
FROM 	 sh.sales s 
 JOIN	 sh.products p ON p.prod_id = s.prod_id 
 JOIN	 sh.customers cust ON cust.cust_id = s.cust_id 
 JOIN 	 sh.times t ON t.time_id = s.time_id 
 JOIN 	 sh.channels ch ON ch.channel_id = s.channel_id 
 JOIN 	 sh.countries cn ON cn.country_id = cust.country_id
WHERE	 t.calendar_month_desc IN ('2000-09', '2000-10')
GROUP BY ch.channel_desc,
		 calendar_month_desc;
/*
|channel_desc|calendar_month_desc|sales_count   |col_rank|
|------------|-------------------|--------------|--------|
|Direct Sales|2000-09            |        11,995|1       |
|Partners    |2000-09            |         6,165|2       |
|Internet    |2000-09            |         1,887|3       |
|Direct Sales|2000-10            |        12,584|4       |
|Partners    |2000-10            |         7,508|5       |
|Internet    |2000-10            |         1,450|6       |
*/

-- Now rank the rows not whithin the entire data set, but within the partition by channels
SELECT	 ch.channel_desc,
		 t.calendar_month_desc,
		 TO_CHAR (TRUNC (SUM (amount_sold), -5), '9,999,999,999') AS sales$,
		 ROW_NUMBER () OVER (PARTITION BY ch.channel_desc ORDER BY TRUNC (SUM (amount_sold), -5) DESC) AS row_number
FROM 	 sh.sales s 
 JOIN	 sh.products p ON p.prod_id = s.prod_id 
 JOIN	 sh.customers cust ON cust.cust_id = s.cust_id 
 JOIN 	 sh.times t ON t.time_id = s.time_id 
 JOIN 	 sh.channels ch ON ch.channel_id = s.channel_id 
 JOIN 	 sh.countries cn ON cn.country_id = cust.country_id
WHERE	 t.calendar_month_desc IN ('2000-09', '2000-10')
GROUP BY ch.channel_desc,
		 calendar_month_desc;
/*
|channel_desc|calendar_month_desc|sales$        |row_number|
|------------|-------------------|--------------|----------|
|Direct Sales|2000-09            |     1,200,000|1         |
|Direct Sales|2000-10            |     1,200,000|2         |
|Partners    |2000-09            |       600,000|3         |
|Partners    |2000-10            |       600,000|4         |
|Internet    |2000-09            |       200,000|5         |
|Internet    |2000-10            |       200,000|6         |
*/
--