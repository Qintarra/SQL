-- Window Frames

-- Cumulative amount_sold
-- Show the cumulative sales amount for each customer by quarter for the year 2000
SELECT	 c.cust_id, t.calendar_quarter_desc,
		 SUM (amount_sold) AS q_sales,
		 SUM (SUM (amount_sold)) OVER (PARTITION BY c.cust_id ORDER BY t.calendar_quarter_desc
		 							   RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cum_sales
FROM	 sh.sales s
 JOIN	 sh.customers c ON c.cust_id = s.cust_id 
 JOIN 	 sh.times t ON t.time_id = s.time_id  
WHERE 	 c.cust_id IN (2595, 9646, 11111)
AND		 t.calendar_year = 2000
GROUP BY c.cust_id, 
		 t.calendar_quarter_desc
ORDER BY c.cust_id, 
		 t.calendar_quarter_desc;