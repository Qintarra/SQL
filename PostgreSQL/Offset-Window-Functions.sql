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

