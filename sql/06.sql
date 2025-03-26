/*
 * This question and the next one are inspired by the Bacon Number:
 * https://en.wikipedia.org/wiki/Six_Degrees_of_Kevin_Bacon#Bacon_numbers
 *
 * List all actors with Bacall Number 1.
 * That is, list all actors that have appeared in a film with 'RUSSELL BACALL'.
 * Do not list 'RUSSELL BACALL', since he has a Bacall Number of 0.
 */

SELECT DISTINCT a.first_name || ' ' || a.last_name AS "Actor Name"
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.film_id IN (
    SELECT f2.film_id
    FROM film f2
    JOIN film_actor fa2 ON f2.film_id = fa2.film_id
    JOIN actor a2 ON fa2.actor_id = a2.actor_id
    WHERE a2.first_name = 'RUSSELL' AND a2.last_name = 'BACALL'
)
  AND NOT (a.first_name = 'RUSSELL' AND a.last_name = 'BACALL')
ORDER BY "Actor Name";
