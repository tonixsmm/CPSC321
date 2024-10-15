
/**********************************************************************
 * NAME: Tony Nguyen
 * CLASS: CPSC 321 01
 * DATE: December 7, 2023
 * HOMEWORK: 8
 **********************************************************************/


-- Quesiton 1: 
SELECT COUNT(*) AS num_film, MIN(length) AS min_length, MAX(length) AS max_length, AVG(length) AS avg_length, COUNT(DISTINCT special_features) AS special_features
FROM film;

-- Question 2:
SELECT rating, COUNT(*) AS num_film, ROUND(AVG(length), 2) AS avg_length
FROM film
GROUP BY rating
ORDER BY avg_length DESC;

-- Question 3:
SELECT rating, COUNT(*) AS num_actors
FROM film_actor JOIN film USING (film_id) JOIN actor USING (actor_id)
GROUP BY rating
ORDER BY num_actors DESC;

-- Question 4:
SELECT category.name AS name, COUNT(*) AS num_film, MIN(film.rental_rate) AS min_rate, MAX(film.rental_rate) AS max_rate, ROUND(AVG(film.rental_rate), 2) AS avg_rate,
    MIN(film.replacement_cost) AS min_cost, MAX(film.replacement_cost) AS max_cost, ROUND(AVG(film.replacement_cost), 2) AS avg_cost
FROM category JOIN film_category USING (category_id) JOIN film USING (film_id)
GROUP BY category.name
ORDER BY name ASC;

-- Question 5:
SELECT f.rating, COUNT(*) AS num_rentals
FROM category c JOIN film_category USING (category_id) JOIN film f USING (film_ID) 
    JOIN inventory i USING (film_id) JOIN rental r USING (inventory_id) JOIN staff s USING (staff_id)
WHERE c.name = 'Horror' AND s.store_id = 1
GROUP BY f.rating
ORDER BY num_rentals DESC;

-- Question 6:
SELECT film.title, COUNT(*) AS num_rentals
FROM film JOIN film_category USING (film_id) JOIN category USING (category_id) JOIN inventory USING (film_id) JOIN rental USING (inventory_id) 
WHERE category.name = 'Action' AND film.rating = 'G'
GROUP BY film.title
HAVING COUNT(*) >= 15
ORDER BY num_rentals DESC;

-- Question 7:
SELECT actor.first_name, actor.last_name, COUNT(*) AS num_horror_films
FROM film f JOIN film_category USING (film_id) JOIN category USING (category_id) JOIN film_actor USING (film_id) JOIN actor USING (actor_id)
WHERE category.name = 'Horror'
GROUP BY actor_id
HAVING COUNT(*) >= 4
ORDER BY COUNT(*) DESC, actor.last_name, actor.first_name;

-- Question 8:
SELECT film_id, title, length
FROM film
WHERE length >= ALL(SELECT length FROM film);

-- Question 9:
SELECT film_id, title, length
FROM film
WHERE rating = 'G' and length >= ALL(SELECT length FROM film WHERE rating = 'G');

-- Question 10:
SELECT DISTINCT first_name, last_name
FROM film JOIN film_actor USING (film_id) JOIN actor USING (actor_id)
WHERE actor_id NOT IN (SELECT actor_id FROM film JOIN film_actor USING (film_id) JOIN actor USING (actor_id) WHERE rating = 'R');

-- Question 11:
SELECT category.name, COUNT(*) AS num_g_rated_films
FROM category JOIN film_category USING (category_id) JOIN film USING (film_id) 
WHERE rating = 'G'
GROUP BY category.name
HAVING COUNT(*) >= ALL (SELECT COUNT(*)
                        FROM category JOIN film_category USING (category_id) JOIN film USING (film_id) 
                        WHERE rating = 'G'
                        GROUP BY category.name
                        );

-- Question 12:
SELECT title, COUNT(*) AS num_rentals
FROM category JOIN film_category USING (category_id) JOIN film USING (film_id) JOIN inventory USING (film_id) JOIN rental USING (inventory_id)
WHERE rating = 'PG'
GROUP BY title
HAVING COUNT(*) >= (SELECT AVG(num_rentals) 
                    FROM
                        (SELECT COUNT(*) AS num_rentals
                        FROM category JOIN film_category USING (category_id) JOIN film USING (film_id) JOIN inventory USING (film_id) JOIN rental USING (inventory_id)
                        WHERE rating = 'PG'
                        GROUP BY title
                        ) AverageRentals)
ORDER BY num_rentals DESC;