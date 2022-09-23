-- Select non-empty categories with the total product number for each one (category name, count), sorted ascending by name.
SELECT product_category.name AS category, COUNT (product.id) AS count
FROM product_category
INNER JOIN product_title ON product_category_id = product_category.id
INNER JOIN product ON product_title_id = product_title.id
WHERE category IS NOT NULL
GROUP BY name
ORDER BY name;
