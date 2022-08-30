-- Offset Window Functions

-- LAG / LEAD
SELECT   time_id,
         TO_CHAR (SUM (amount_sold), '9,999,999,999') AS sales$,
         TO_CHAR (LAG(SUM (amount_sold), 1) OVER (ORDER BY time_id), '9,999,999,999') AS LAG1,
         TO_CHAR (LEAD(SUM (amount_sold), 1) OVER (ORDER BY time_id), '9,999,999,999') AS LEAD1
FROM	 sh.sales s
WHERE 	 time_id >= TO_DATE('10-OCT-2000', 'DD-MON-YYYY')
AND 	 time_id <= TO_DATE('17-OCT-2000', 'DD-MON-YYYY')
GROUP BY time_id;
/*
|time_id   |sales$        |lag1          |lead1         |
|----------|--------------|--------------|--------------|
|2000-10-10|       238,479|              |        23,183|
|2000-10-11|        23,183|       238,479|        24,616|
|2000-10-12|        24,616|        23,183|        76,516|
|2000-10-13|        76,516|        24,616|        29,795|
|2000-10-14|        29,795|        76,516|        32,647|
|2000-10-15|        32,647|        29,795|        63,257|
|2000-10-16|        63,257|        32,647|       207,437|
|2000-10-17|       207,437|        63,257|              |
*/
--

-- FIRST_VALUE / LAST_VALUE
SELECT	 channel_desc,
         calendar_month_number,
         SUM (amount_sold) AS sales$,
         FIRST_VALUE (SUM (amount_sold)) OVER (PARTITION BY calendar_month_number ORDER BY SUM (amount_sold))
         AS min_sales_month
FROM	 sh.sales s
 JOIN 	 sh.times t ON t.time_id = s.time_id 
 JOIN 	 sh.channels ch ON ch.channel_id = s.channel_id 
WHERE 	 calendar_month_number IN (1, 2, 3, 4)
GROUP BY channel_desc,
         calendar_month_number
ORDER BY 2;
