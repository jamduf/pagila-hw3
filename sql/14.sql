/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */

SELECT ranked.name, ranked.title, ranked."total rentals"
FROM (
    SELECT fc.category_id,
           c.name AS name,
           f.film_id,
           f.title,
           COUNT(r.rental_id) AS "total rentals",
      ROW_NUMBER() OVER (
      PARTITION BY fc.category_id
      ORDER BY COUNT(r.rental_id) DESC, f.film_id DESC
    ) AS rn
    FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    LEFT JOIN inventory i ON f.film_id = i.film_id
    LEFT JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY fc.category_id, c.name, f.film_id, f.title
) AS ranked
WHERE ranked.rn <= 5
ORDER BY ranked.name, ranked."total rentals" DESC, ranked.title ASC;
