/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */

WITH recent_rentals AS (
  SELECT r.customer_id, r.rental_date, f.film_id,
         ROW_NUMBER() OVER (PARTITION BY r.customer_id ORDER BY r.rental_date DESC) AS rn
  FROM rental r
  JOIN inventory i ON r.inventory_id = i.inventory_id
  JOIN film f ON i.film_id = f.film_id
),
action_rentals AS (
  SELECT rr.customer_id
  FROM recent_rentals rr
  JOIN film_category fc ON rr.film_id = fc.film_id
  JOIN category c ON fc.category_id = c.category_id
  WHERE c.name = 'Action' AND rr.rn <= 5
  GROUP BY rr.customer_id
  HAVING COUNT(*) >= 4
)
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN action_rentals ar ON c.customer_id = ar.customer_id;

