/* 
 * Finding movies with similar categories still gives you too many options.
 *
 * Write a SQL query that lists all movies that share 2 categories with AMERICAN CIRCUS and 1 actor.
 *
 * HINT:
 * It's possible to complete this problem both with and without set operations,
 * but I find the version using set operations much more intuitive.
 */
SELECT f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fc.category_id IN (
    SELECT category_id
    FROM film_category
    JOIN film ON film_category.film_id = film.film_id
    WHERE film.title = 'AMERICAN CIRCUS'
)
  AND fa.actor_id IN (
    SELECT actor_id
    FROM film_actor
    JOIN film ON film_actor.film_id = film.film_id
    WHERE film.title = 'AMERICAN CIRCUS'
)
GROUP BY f.film_id, f.title
HAVING COUNT(DISTINCT fc.category_id) >= 2
ORDER BY f.title;
