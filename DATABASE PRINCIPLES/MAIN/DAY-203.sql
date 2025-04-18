SELECT MIN(payment_date) AS 'FIRST PAYMENT', MAX(payment_date) AS 'LAST PAYMENT'
FROM payment;

SELECT 
  YEAR(payment_date) AS YEAR,
  MONTH(payment_date) AS MONTH,
  SUM(amount) AS TOTAL
FROM payment
GROUP BY YEAR(payment_date), MONTH(payment_date)
ORDER BY YEAR, MONTH;

SELECT f.title, SUM(p.amount) AS 'TOTAL EARNED'
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.film_id
ORDER BY 'TOTAL EARNED' DESC
LIMIT 1;

SELECT a.first_name, a.last_name, SUM(p.amount) AS 'TOTAL EARNED'
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_actor fa ON i.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
GROUP BY a.actor_id
ORDER BY 'TOTAL EARNED' DESC
LIMIT 1;

SELECT ci.city, SUM(p.amount) AS 'TOTAL PAID'
FROM payment p
JOIN customer c ON p.customer_id = c.customer_id
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
GROUP BY ci.city
ORDER BY 'TOTAL PAID' DESC
LIMIT 1;

SELECT 
  YEAR(p.payment_date) AS YEAR,
  MONTH(p.payment_date) AS MONTH,
  f.title,
  SUM(p.amount) AS TOTAL
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY YEAR, MONTH, f.film_id
HAVING TOTAL = (
  SELECT MAX(SUB.TOTAL)
  FROM (
    SELECT 
      YEAR(p2.payment_date) AS YEAR,
      MONTH(p2.payment_date) AS MONTH,
      f2.film_id,
      SUM(p2.amount) AS TOTAL
    FROM payment p2
    JOIN rental r2 ON p2.rental_id = r2.rental_id
    JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
    JOIN film f2 ON i2.film_id = f2.film_id
    GROUP BY YEAR, MONTH, f2.film_id
  ) AS SUB
  WHERE SUB.YEAR = YEAR AND SUB.MONTH = MONTH
)
ORDER BY YEAR, MONTH;

SELECT MAX(last_update) AS 'THE LATEST UPDATE'
FROM (
  SELECT last_update FROM actor
  UNION ALL
  SELECT last_update FROM address
  UNION ALL
  SELECT last_update FROM category
  UNION ALL
  SELECT last_update FROM city
  UNION ALL
  SELECT last_update FROM country
  UNION ALL
  SELECT last_update FROM customer
  UNION ALL
  SELECT last_update FROM film
  UNION ALL
  SELECT last_update FROM inventory
  UNION ALL
  SELECT last_update FROM language
  UNION ALL
  SELECT last_update FROM rental
  UNION ALL
  SELECT last_update FROM staff
  UNION ALL
  SELECT last_update FROM store
) AS all_updates;

SELECT 'actor' AS table_name, COUNT(*) AS updates FROM actor
UNION ALL
SELECT 'address', COUNT(*) FROM address
UNION ALL
SELECT 'category', COUNT(*) FROM category
UNION ALL
SELECT 'city', COUNT(*) FROM city
UNION ALL
SELECT 'country', COUNT(*) FROM country
UNION ALL
SELECT 'customer', COUNT(*) FROM customer
UNION ALL
SELECT 'film', COUNT(*) FROM film
UNION ALL
SELECT 'inventory', COUNT(*) FROM inventory
UNION ALL
SELECT 'language', COUNT(*) FROM language
UNION ALL
SELECT 'rental', COUNT(*) FROM rental
UNION ALL
SELECT 'staff', COUNT(*) FROM staff
UNION ALL
SELECT 'store', COUNT(*) FROM store;