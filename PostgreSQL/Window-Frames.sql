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
AND      t.calendar_year = 2000
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
AND      t.calendar_year = 2000
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

-- Centerd moving average
SELECT	 t.time_id,
         TO_CHAR (SUM (amount_sold), '9,999,999,999') AS sales,
         TO_CHAR (AVG(SUM (amount_sold)) OVER (ORDER BY t.time_id RANGE BETWEEN
                                               INTERVAL '1' DAY PRECEDING AND 
                                               INTERVAL '1' DAY FOLLOWING), '9,999,999,999') AS cent_3_day_avg
FROM	 sh.sales s 
 JOIN 	 sh.times t ON t.time_id = s.time_id  
WHERE 	 t.calendar_week_number IN (51)
AND      t.calendar_year = 1999
GROUP BY t.time_id
ORDER BY t.time_id;
/*
|time_id   |sales         |cent_3_day_avg|
|----------|--------------|--------------|
|1999-12-20|       134,337|       106,676|
|1999-12-21|        79,015|       102,539|
|1999-12-22|        94,264|        85,342|
|1999-12-23|        82,746|        93,322|
|1999-12-24|       102,957|        82,937|
|1999-12-25|        63,107|        87,062|
|1999-12-26|        95,123|        79,115|
*/
-- Shows the number of sales by day for one week
-- The last column shows average sales of the previous day, the current day, and the next day
--

-- Show the number of sales by the quarter for the year 2000
SELECT      calendar_quarter_desc, q_sales,
            CASE WHEN RIGHT (calendar_quarter_desc, 1) = '1' THEN 'N/A'
                 ELSE TO_CHAR (prev_q, '9,999,999,990.99')
            END AS prev_q,
            CASE WHEN RIGHT (calendar_quarter_desc, 1) = '1' THEN 'N/A'
                 ELSE TO_CHAR (q_sales - prev_q, '9,999,999,990.99')
            END AS delta_q,
            CASE WHEN RIGHT (calendar_quarter_desc, 1) = '1' THEN 'N/A'
                 ELSE TO_CHAR ((q_sales - prev_q) / prev_q * 100, '9,999,999,990.99') || '%'
            END AS delta_q_prc
FROM (
        SELECT	 t.calendar_quarter_desc,
                 SUM (amount_sold) AS q_sales,
                 FIRST_VALUE (SUM (amount_sold)) OVER (ORDER BY t.calendar_quarter_desc
                                                       ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS prev_q
        FROM	 sh.sales s 
         JOIN	 sh.products p ON p.prod_id = s.prod_id 
         JOIN	 sh.customers c ON c.cust_id = s.cust_id 
         JOIN 	 sh.times t ON t.time_id = s.time_id   
        WHERE 	 t.calendar_year = 2000
        AND      c.cust_id IN (2595, 9646, 11111)
        GROUP BY t.calendar_quarter_desc
        ) tab
ORDER BY 1;
/*
|calendar_quarter_desc|q_sales |prev_q           |delta_q          |delta_q_prc       |
|---------------------|--------|-----------------|-----------------|------------------|
|2000-01              |2,040.19|N/A              |N/A              |N/A               |
|2000-02              |443.79  |         2,040.19|        -1,596.40|           -78.25%|
|2000-03              |1,097.49|           443.79|           653.70|           147.30%|
|2000-04              |6,780.95|         1,097.49|         5,683.46|           517.86%|
*/
--

-- RANGE vs GROUPS
SELECT	 t.calendar_month_number,
         SUM (amount_sold) AS m_sales,
         FIRST_VALUE (SUM (amount_sold)) OVER (ORDER BY t.calendar_month_number
                                               RANGE BETWEEN 1 PRECEDING AND CURRENT ROW) AS range_first_value,
         FIRST_VALUE (SUM (amount_sold)) OVER (ORDER BY t.calendar_month_number
                                               GROUPS BETWEEN 1 PRECEDING AND CURRENT ROW) AS groups_first_value
FROM	 sh.sales s
 JOIN	 sh.customers c ON c.cust_id = s.cust_id 
 JOIN 	 sh.times t ON t.time_id = s.time_id 
 JOIN 	 sh.channels ch ON ch.channel_id = s.channel_id
WHERE 	 t.calendar_year = 1998
AND      ch.channel_desc = 'Tele Sales'
GROUP BY t.calendar_month_number
ORDER BY t.calendar_month_number;
/*
|calendar_month_number|m_sales  |range_first_value|groups_first_value|
|---------------------|---------|-----------------|------------------|
|3                    |53,395.37|53,395.37        |53,395.37         |
|4                    |42,712.02|53,395.37        |53,395.37         |
|5                    |21,446.08|42,712.02        |42,712.02         |
|10                   |59,726.93|59,726.93        |21,446.08         |
|11                   |50,884.91|59,726.93        |59,726.93         |
|12                   |49,260.95|50,884.91        |50,884.91         |
*/
--

-- NTH_VALUE Function
-- Provide quarterly sales information before the year 2000 for three custumers
SELECT	 c.cust_id,
         t.calendar_quarter_desc,
         SUM (amount_sold) AS q_sales,
         FIRST_VALUE (SUM (amount_sold)) OVER w AS q1,
         NTH_VALUE (SUM (amount_sold), 2) OVER w AS q2,
         NTH_VALUE (SUM (amount_sold), 3) OVER w AS q3,
         LAST_VALUE (SUM (amount_sold)) OVER w AS q4		 
FROM	 sh.sales s
 JOIN	 sh.customers c ON c.cust_id = s.cust_id 
 JOIN 	 sh.times t ON t.time_id = s.time_id 
WHERE 	 t.calendar_year = 2000
AND      c.cust_id IN (2595, 9646, 11111)
GROUP BY c.cust_id,
         t.calendar_quarter_desc,
         t.calendar_quarter_number 
WINDOW   w AS (PARTITION BY c.cust_id ORDER BY c.cust_id, t.calendar_quarter_desc
               ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) -- first row of the frame 
ORDER BY c.cust_id,
         t.calendar_quarter_desc;
/*
|cust_id|calendar_quarter_desc|q_sales |q1      |q2    |q3    |q4      |
|-------|---------------------|--------|--------|------|------|--------|
|2,595  |2000-01              |659.92  |659.92  |224.79|313.9 |6,015.08|
|2,595  |2000-02              |224.79  |659.92  |224.79|313.9 |6,015.08|
|2,595  |2000-03              |313.9   |659.92  |224.79|313.9 |6,015.08|
|2,595  |2000-04              |6,015.08|659.92  |224.79|313.9 |6,015.08|
|9,646  |2000-01              |1,337.09|1,337.09|185.67|203.86|458.29  |
|9,646  |2000-02              |185.67  |1,337.09|185.67|203.86|458.29  |
|9,646  |2000-03              |203.86  |1,337.09|185.67|203.86|458.29  |
|9,646  |2000-04              |458.29  |1,337.09|185.67|203.86|458.29  |
|11,111 |2000-01              |43.18   |43.18   |33.33 |579.73|307.58  |
|11,111 |2000-02              |33.33   |43.18   |33.33 |579.73|307.58  |
|11,111 |2000-03              |579.73  |43.18   |33.33 |579.73|307.58  |
|11,111 |2000-04              |307.58  |43.18   |33.33 |579.73|307.58  |
*/

-- Same, but in a more readable form:
SELECT	cust_id, MAX(q1) AS q1,	MAX(q2) AS q2, MAX(q3) AS q3, MAX(q4) AS q4 -- apply the MAX function for the columns with sales by quarters
FROM (
        SELECT	 c.cust_id,
                 t.calendar_quarter_desc,
                 SUM (amount_sold) AS q_sales,
                 FIRST_VALUE (SUM (amount_sold)) OVER w AS q1,
                 NTH_VALUE (SUM (amount_sold), 2) OVER w AS q2,
                 NTH_VALUE (SUM (amount_sold), 3) OVER w AS q3,
                 LAST_VALUE (SUM (amount_sold)) OVER w AS q4		 
        FROM	 sh.sales s
         JOIN	 sh.customers c ON c.cust_id = s.cust_id 
         JOIN 	 sh.times t ON t.time_id = s.time_id 
        WHERE 	 t.calendar_year = 2000
        AND      c.cust_id IN (2595, 9646, 11111)
        GROUP BY c.cust_id,
                 t.calendar_quarter_desc,
                 t.calendar_quarter_number 
        WINDOW   w AS (PARTITION BY c.cust_id 
                 ORDER BY c.cust_id, t.calendar_quarter_desc
                 ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
        ) tab
GROUP BY cust_id
ORDER BY 1;