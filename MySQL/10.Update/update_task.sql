-- Rename supermarkets by replacing the old name "Your Choice" or "kramnichka" with the new "Your Friend".
UPDATE supermarket
SET name = 'Your Friend'
WHERE name IN ('Your Choice', 'kramnichka');

