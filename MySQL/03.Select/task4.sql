SELECT name, surname
FROM person
WHERE surname LIKE 'Kra%'
ORDER BY surname, birth_date DESC;