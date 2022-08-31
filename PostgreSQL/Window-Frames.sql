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
/*
|cust_id|calendar_quarter_desc|q_sales |cum_sales|
|-------|---------------------|--------|---------|
|2,595  |2000-01              |659.92  |659.92   |
|2,595  |2000-02              |224.79  |884.71   |
|2,595  |2000-03              |313.9   |1,198.61 |
|2,595  |2000-04              |6,015.08|7,213.69 |
|9,646  |2000-01              |1,337.09|1,337.09 |
|9,646  |2000-02              |185.67  |1,522.76 |
|9,646  |2000-03              |203.86  |1,726.62 |
|9,646  |2000-04              |458.29  |2,184.91 |
|11,111 |2000-01              |43.18   |43.18    |
|11,111 |2000-02              |33.33   |76.51    |
|11,111 |2000-03              |579.73  |656.24   |
|11,111 |2000-04              |307.58  |963.82   |
*/
--

-- Cumulative amount_sold + Array_AGG
SELECT	 c.cust_id, t.calendar_quarter_desc,
         SUM (amount_sold) AS q_sales,
         SUM (SUM (amount_sold)) OVER w AS cum_sales,
         ARRAY_AGG (SUM (amount_sold)) OVER w AS array_agg -- the ARRAY_AGG function show which values are included in the cumulative sum calculation
FROM	 sh.sales s
 JOIN	 sh.customers c ON c.cust_id = s.cust_id 
 JOIN 	 sh.times t ON t.time_id = s.time_id  
WHERE 	 c.cust_id IN (2959, 9646, 11111)
AND		 t.calendar_year = 2000
GROUP BY c.cust_id, 
         t.calendar_quarter_desc
WINDOW   w AS (PARTITION BY c.cust_id ORDER BY t.calendar_quarter_desc
               RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
ORDER BY c.cust_id, 
         t.calendar_quarter_desc;
/*
|cust_id|calendar_quarter_desc|q_sales |cum_sales|array_agg                      |
|-------|---------------------|--------|---------|-------------------------------|
|9,646  |2000-01              |1,337.09|1,337.09 |{1,337.09}                     |
|9,646  |2000-02              |185.67  |1,522.76 |{1,337.09,185.67}              |
|9,646  |2000-03              |203.86  |1,726.62 |{1,337.09,185.67,203.86}       |
|9,646  |2000-04              |458.29  |2,184.91 |{1,337.09,185.67,203.86,458.29}|
|11,111 |2000-01              |43.18   |43.18    |{43.18}                        |
|11,111 |2000-02              |33.33   |76.51    |{43.18,33.33}                  |
|11,111 |2000-03              |579.73  |656.24   |{43.18,33.33,579.73}           |
|11,111 |2000-04              |307.58  |963.82   |{43.18,33.33,579.73,307.58}    |
*/
--