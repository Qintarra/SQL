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

-- ROW_NUMBER vs RANK vs DENSE_RANK

-- RANK on Multiple Expressions
SELECT	 ch.channel_desc,
         t.calendar_month_desc,
         TO_CHAR (SUM (quantity_sold), '9,999,999,999') AS sales_count,
         RANK () OVER (ORDER BY calendar_month_desc, SUM (s.quantity_sold) DESC) AS col_rank
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
--

-- RANK vs DENSE_RANK
SELECT	 ch.channel_desc,
         t.calendar_month_desc,
         TO_CHAR (TRUNC (SUM (amount_sold), -5), '9,999,999,999') AS sales$,
         RANK () OVER (ORDER BY TRUNC (SUM (amount_sold), -5) DESC) AS rank, 
         DENSE_RANK () OVER (ORDER BY TRUNC (SUM (amount_sold), -5) DESC) AS dense_rank
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
|channel_desc|calendar_month_desc|sales$        |rank|dense_rank|
|------------|-------------------|--------------|----|----------|
|Direct Sales|2000-09            |     1,200,000|1   |1         |
|Direct Sales|2000-10            |     1,200,000|1   |1         |
|Partners    |2000-09            |       600,000|3   |2         |
|Partners    |2000-10            |       600,000|3   |2         |
|Internet    |2000-09            |       200,000|5   |3         |
|Internet    |2000-10            |       200,000|5   |3         |
*/
--

-- RANK + PARTITION BY
SELECT	 ch.channel_desc,
         t.calendar_month_desc,
         TO_CHAR (SUM (amount_sold), '9,999,999,999') AS sales$,
         RANK () OVER (PARTITION BY ch.channel_desc ORDER BY SUM (amount_sold) DESC) AS rank_by_channel
FROM 	 sh.sales s 
 JOIN	 sh.products p ON p.prod_id = s.prod_id 
 JOIN	 sh.customers cust ON cust.cust_id = s.cust_id 
 JOIN 	 sh.times t ON t.time_id = s.time_id 
 JOIN 	 sh.channels ch ON ch.channel_id = s.channel_id 
 JOIN 	 sh.countries cn ON cn.country_id = cust.country_id
WHERE	 t.calendar_month_desc IN ('2000-08', '2000-09', '2000-10', '2000-11')
AND      ch.channel_desc IN ('Direct Sales', 'Internet')
GROUP BY ch.channel_desc,
         calendar_month_desc;
/*
|channel_desc|calendar_month_desc|sales$        |rank_by_channel|
|------------|-------------------|--------------|---------------|
|Direct Sales|2000-08            |     1,236,104|1              |
|Direct Sales|2000-10            |     1,225,584|2              |
|Direct Sales|2000-09            |     1,217,808|3              |
|Direct Sales|2000-11            |     1,115,239|4              |
|Internet    |2000-11            |       284,742|1              |
|Internet    |2000-10            |       239,236|2              |
|Internet    |2000-09            |       228,241|3              |
|Internet    |2000-08            |       215,107|4              |
*/
--

-- Per Group Ranking
SELECT	 ch.channel_desc,
         t.calendar_month_desc,
         TO_CHAR (SUM (amount_sold), '9,999,999,999') AS sales$,
         RANK () OVER (PARTITION BY calendar_month_desc ORDER BY SUM (amount_sold) DESC) AS rank_within_month,
         RANK () OVER (PARTITION BY ch.channel_desc ORDER BY SUM (amount_sold) DESC) AS rank_within_channel
FROM 	 sh.sales s 
 JOIN 	 sh.times t ON t.time_id = s.time_id 
 JOIN 	 sh.channels ch ON ch.channel_id = s.channel_id 
WHERE	 t.calendar_month_desc IN ('2000-08', '2000-09', '2000-10', '2000-11')
AND      ch.channel_desc IN ('Direct Sales', 'Internet')
GROUP BY ch.channel_desc,
         calendar_month_desc
ORDER BY 1, 4, 5;
/*
|channel_desc|calendar_month_desc|sales$        |rank_within_month|rank_within_channel|
|------------|-------------------|--------------|-----------------|-------------------|
|Direct Sales|2000-08            |     1,236,104|1                |1                  |
|Direct Sales|2000-10            |     1,225,584|1                |2                  |
|Direct Sales|2000-09            |     1,217,808|1                |3                  |
|Direct Sales|2000-11            |     1,115,239|1                |4                  |
|Internet    |2000-11            |       284,742|2                |1                  |
|Internet    |2000-10            |       239,236|2                |2                  |
|Internet    |2000-09            |       228,241|2                |3                  |
|Internet    |2000-08            |       215,107|2                |4                  |
*/
-- rewrite this example with an alternative syntax
SELECT	 ch.channel_desc,
         t.calendar_month_desc,
         TO_CHAR (SUM (amount_sold), '9,999,999,999') AS sales$,
         RANK () OVER month_w AS rank_within_month,
         RANK () OVER channel_w AS rank_within_channel
FROM 	 sh.sales s 
 JOIN 	 sh.times t ON t.time_id = s.time_id 
 JOIN 	 sh.channels ch ON ch.channel_id = s.channel_id 
WHERE	 t.calendar_month_desc IN ('2000-08', '2000-09', '2000-10', '2000-11')
AND      ch.channel_desc IN ('Direct Sales', 'Internet')
GROUP BY ch.channel_desc,
         calendar_month_desc
WINDOW	 month_w AS (PARTITION BY calendar_month_desc ORDER BY SUM (amount_sold) DESC),
         channel_w AS (PARTITION BY ch.channel_desc ORDER BY SUM (amount_sold) DESC)
ORDER BY 1, 4, 5;
--

-- Threatment of NULLs
SELECT	 t.time_id, sold,
         RANK () OVER (ORDER BY sold DESC NULLS LAST) AS nlast_desc,
         RANK () OVER (ORDER BY sold DESC NULLS FIRST) AS nfirst_desc,
         RANK () OVER (ORDER BY sold ASC NULLS FIRST) AS nfirst,
         RANK () OVER (ORDER BY sold ASC NULLS LAST) AS nlast
FROM 
  (SELECT time_id,
          SUM (amount_sold) AS sold 
   FROM	  sh.sales s 
    JOIN	 sh.products p ON (p.prod_id = s.prod_id) 
    JOIN	 sh.customers cust ON (cust.cust_id = s.cust_id) 
    JOIN  sh.countries cn ON (cn.country_id = cust.country_id)
   WHERE  prod_name IN ('Envoy Ambassador', 'Mouse Pad')
   GROUP BY time_id 
  ) tab 
 RIGHT JOIN sh.times t ON tab.time_id = t.time_id 
WHERE	t.calendar_year = 1999
AND		t.calendar_month_number = 1
ORDER BY sold DESC NULLS LAST;