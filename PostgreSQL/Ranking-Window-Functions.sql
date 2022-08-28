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
/*
|time_id   |sold     |nlast_desc|nfirst_desc|nfirst|nlast|
|----------|---------|----------|-----------|------|-----|
|1999-01-14|25,241.48|1         |13         |31    |19   |
|1999-01-21|24,365.05|2         |14         |30    |18   |
|1999-01-10|22,901.24|3         |15         |29    |17   |
|1999-01-20|16,578.19|4         |16         |28    |16   |
|1999-01-16|15,881.12|5         |17         |27    |15   |
|1999-01-30|15,637.49|6         |18         |26    |14   |
|1999-01-17|13,262.87|7         |19         |25    |13   |
|1999-01-25|13,227.08|8         |20         |24    |12   |
|1999-01-03|9,885.74 |9         |21         |23    |11   |
|1999-01-28|4,471.08 |10        |22         |22    |10   |
|1999-01-27|3,453.66 |11        |23         |21    |9    |
|1999-01-23|925.45   |12        |24         |20    |8    |
|1999-01-07|756.87   |13        |25         |19    |7    |
|1999-01-08|571.8    |14        |26         |18    |6    |
|1999-01-13|569.21   |15        |27         |17    |5    |
|1999-01-02|316.87   |16        |28         |16    |4    |
|1999-01-12|195.54   |17        |29         |15    |3    |
|1999-01-26|92.96    |18        |30         |14    |2    |
|1999-01-19|86.04    |19        |31         |13    |1    |
|1999-01-15|         |20        |1          |1     |20   |
|1999-01-04|         |20        |1          |1     |20   |
|1999-01-06|         |20        |1          |1     |20   |
|1999-01-24|         |20        |1          |1     |20   |
|1999-01-11|         |20        |1          |1     |20   |
|1999-01-01|         |20        |1          |1     |20   |
|1999-01-09|         |20        |1          |1     |20   |
|1999-01-05|         |20        |1          |1     |20   |
|1999-01-29|         |20        |1          |1     |20   |
|1999-01-22|         |20        |1          |1     |20   |
|1999-01-18|         |20        |1          |1     |20   |
|1999-01-31|         |20        |1          |1     |20   |
*/
--

-- NTILE Function
SELECT	 calendar_month_desc,
         TO_CHAR (SUM (s.amount_sold), '9,999,999,999') AS sales$,
         NTILE (4) OVER (ORDER BY SUM (amount_sold)) AS tile4,
         NTILE (5) OVER (ORDER BY SUM (amount_sold)) AS tile5,
         NTILE (15) OVER (ORDER BY SUM (amount_sold)) AS tile15
FROM sh.sales s 
 JOIN	 sh.products p ON p.prod_id = s.prod_id 
 JOIN	 sh.customers cust ON cust.cust_id = s.cust_id 
 JOIN 	 sh.times t ON t.time_id = s.time_id 
 JOIN 	 sh.channels ch ON ch.channel_id = s.channel_id 
WHERE	 t.calendar_year = 2000
AND 	 prod_category = 'Electronics'
GROUP BY calendar_month_desc;
/*
|calendar_month_desc|sales$        |tile4|tile5|tile15|
|-------------------|--------------|-----|-----|------|
|2000-02            |       242,416|1    |1    |1     |
|2000-01            |       257,286|1    |1    |2     |
|2000-03            |       280,011|1    |1    |3     |
|2000-06            |       315,951|2    |2    |4     |
|2000-05            |       316,824|2    |2    |5     |
|2000-04            |       318,106|2    |2    |6     |
|2000-07            |       433,824|3    |3    |7     |
|2000-08            |       477,833|3    |3    |8     |
|2000-12            |       553,534|3    |4    |9     |
|2000-10            |       652,225|4    |4    |10    |
|2000-11            |       661,147|4    |5    |11    |
|2000-09            |       691,449|4    |5    |12    |
*/
--

-- CUME_DIST
SELECT	 calendar_month_desc,
         p.prod_category,
         TO_CHAR (SUM (s.amount_sold), '9,999,999,999') AS sales$,
         CUME_DIST() OVER (PARTITION BY calendar_month_desc ORDER BY SUM(s.amount_sold)) AS cume_dist_prod_cat
FROM sh.sales s 
 JOIN	 sh.products p ON p.prod_id = s.prod_id 
 JOIN	 sh.customers cust ON cust.cust_id = s.cust_id 
 JOIN 	 sh.times t ON t.time_id = s.time_id 
 JOIN 	 sh.channels ch ON ch.channel_id = s.channel_id 
WHERE	 t.calendar_month_desc IN ('2000-09', '2000-07', '2000-08')
GROUP BY calendar_month_desc,
         p.prod_category;
/*
|calendar_month_desc|prod_category              |sales$        |cume_dist_prod_cat|
|-------------------|---------------------------|--------------|------------------|
|2000-07            |Software/Other             |       295,419|0.2               |
|2000-07            |Hardware                   |       323,381|0.4               |
|2000-07            |Photo                      |       345,301|0.6               |
|2000-07            |Electronics                |       433,824|0.8               |
|2000-07            |Peripherals and Accessories|       498,838|1                 |
|2000-08            |Software/Other             |       316,150|0.2               |
|2000-08            |Hardware                   |       338,568|0.4               |
|2000-08            |Photo                      |       411,670|0.6               |
|2000-08            |Electronics                |       477,833|0.8               |
|2000-08            |Peripherals and Accessories|       568,034|1                 |
|2000-09            |Software/Other             |       245,110|0.2               |
|2000-09            |Photo                      |       324,898|0.4               |
|2000-09            |Hardware                   |       339,536|0.6               |
|2000-09            |Peripherals and Accessories|       511,227|0.8               |
|2000-09            |Electronics                |       691,449|1                 |
*/
--

-- TASK. Find the 5 top-selling products for each product subcategory that contributes more than 20% of the sales within its product category
-- part 1:
SELECT	 prod_category, prod_subcategory, p.prod_id, SUM(amount_sold) AS sales
FROM 	 sh.sales s 
 JOIN	 sh.products p ON p.prod_id = s.prod_id 
 JOIN	 sh.customers cust ON cust.cust_id = s.cust_id 
 JOIN 	 sh.channels ch ON ch.channel_id = s.channel_id 
 JOIN 	 sh.countries cn ON cn.country_id = cust.country_id
WHERE	 time_id = TO_DATE ('11-OCT-2000', 'DD-MON-YYYY')
GROUP BY prod_category, 
         prod_subcategory, 
         p.prod_id
ORDER BY prod_category, 
         prod_subcategory;