-- Ranking Window Functions

-- ROW_NUMBER

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