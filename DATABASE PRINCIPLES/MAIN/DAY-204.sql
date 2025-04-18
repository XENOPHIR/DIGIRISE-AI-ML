SELECT f.film_id AS ID, f.title AS TITLE
FROM film f
WHERE f.film_id NOT IN (
  SELECT DISTINCT i.film_id
  FROM rental r
  JOIN inventory i ON r.inventory_id = i.inventory_id
  WHERE YEAR(r.rental_date) = 2006
);

SELECT title AS TITLE, length AS LENGTH FROM film
WHERE length = (SELECT MAX(length) FROM film)
   OR length = (SELECT MIN(length) FROM film);

SELECT customer_id AS ID, ROUND(AVG(amount), 2) AS 'AVERAGE PAYMENT'
FROM payment
GROUP BY customer_id;

SELECT s.store_id, COUNT(r.rental_id) AS 'TOTAL RENTALS'
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN rental r ON st.staff_id = r.staff_id
GROUP BY s.store_id;

SELECT fa1.actor_id AS actor1, fa2.actor_id AS actor2, COUNT(*) AS 'MOVIE COUNT'
FROM film_actor fa1
JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id <> fa2.actor_id
GROUP BY fa1.actor_id, fa2.actor_id
HAVING 'MOVIE COUNT' > 1;