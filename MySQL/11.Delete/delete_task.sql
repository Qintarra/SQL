-- From table "contact_type" delete record with type of "viber".
DELETE FROM contact_type
WHERE name = 'viber';

-- From table "customer_order" delete orders 1, 7 and 10.
DELETE FROM customer_order
WHERE id IN (1, 7, 10);

-- From table "customer_order" delete orders that was processed until 2014-01-01.
DELETE FROM customer_order
WHERE operation_time <= '2014-01-01';