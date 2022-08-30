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
/*
|channel_desc|calendar_month_number|sales$      |min_sales_month|
|------------|---------------------|------------|---------------|
|Internet    |1                    |679,299.05  |679,299.05     |
|Partners    |1                    |2,092,590.24|679,299.05     |
|Direct Sales|1                    |5,703,058.55|679,299.05     |
|Internet    |2                    |1,018,813.31|1,018,813.31   |
|Partners    |2                    |2,410,599.08|1,018,813.31   |
|Direct Sales|2                    |5,522,651.25|1,018,813.31   |
|Tele Sales  |3                    |53,395.37   |53,395.37      |
|Internet    |3                    |1,069,167.19|53,395.37      |
|Partners    |3                    |1,876,050.63|53,395.37      |
|Direct Sales|3                    |4,680,793.47|53,395.37      |
|Tele Sales  |4                    |42,712.02   |42,712.02      |
|Internet    |4                    |981,296.96  |42,712.02      |
|Partners    |4                    |2,091,816.42|42,712.02      |
|Direct Sales|4                    |4,578,892.91|42,712.02      |
*/
--

SELECT	 channel_desc,
         calendar_month_number,
         SUM (amount_sold) AS sales$,
         LAST_VALUE (SUM (amount_sold)) OVER (PARTITION BY calendar_month_number ORDER BY SUM (amount_sold))
         AS miax_sales_month
FROM	 sh.sales s
 JOIN 	 sh.times t ON t.time_id = s.time_id 
 JOIN 	 sh.channels ch ON ch.channel_id = s.channel_id 
WHERE 	 calendar_month_number IN (1, 2, 3, 4)
GROUP BY channel_desc,
         calendar_month_number
ORDER BY 2;
/*
|channel_desc|calendar_month_number|sales$      |max_sales_month|
|------------|---------------------|------------|---------------|
|Internet    |1                    |679,299.05  |679,299.05     |
|Partners    |1                    |2,092,590.24|2,092,590.24   |
|Direct Sales|1                    |5,703,058.55|5,703,058.55   |
|Internet    |2                    |1,018,813.31|1,018,813.31   |
|Partners    |2                    |2,410,599.08|2,410,599.08   |
|Direct Sales|2                    |5,522,651.25|5,522,651.25   |
|Tele Sales  |3                    |53,395.37   |53,395.37      |
|Internet    |3                    |1,069,167.19|1,069,167.19   |
|Partners    |3                    |1,876,050.63|1,876,050.63   |
|Direct Sales|3                    |4,680,793.47|4,680,793.47   |
|Tele Sales  |4                    |42,712.02   |42,712.02      |
|Internet    |4                    |981,296.96  |981,296.96     |
|Partners    |4                    |2,091,816.42|2,091,816.42   |
|Direct Sales|4                    |4,578,892.91|4,578,892.91   |
*/
