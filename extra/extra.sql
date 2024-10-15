
/**********************************************************************
 * NAME: Tony Nguyen
 * CLASS: CPSC 321
 * DATE: 12/15/2023
 * HOMEWORK: Extra Credit
 * DESCRIPTION: 
 **********************************************************************/


-- TODO: Implement the queries below. For each feel free to copy in
--       the problem statements.



-- Quesiton 1: 
SELECT f.title 
FROM film f
WHERE NOT EXISTS (
    SELECT s.store_id 
    FROM store s
    WHERE NOT EXISTS (
        SELECT i.inventory_id 
        FROM inventory i 
        WHERE i.film_id = f.film_id AND i.store_id = s.store_id
    )
);


-- Question 2:
WITH film_update AS (
    -- Select actor updates
    SELECT fa.film_id, 'actor' AS type, MAX(fa.last_update) AS last_update
    FROM film_actor fa
    JOIN film f ON fa.film_id = f.film_id
    GROUP BY fa.film_id

    UNION

    -- Select category updates
    SELECT fc.film_id, 'category' AS type, MAX(fc.last_update) AS last_update
    FROM film_category fc
    JOIN film f ON fc.film_id = f.film_id
    GROUP BY fc.film_id

    UNION

    -- Select inventory updates
    SELECT i.film_id, 'inventory' AS type, MAX(i.last_update) AS last_update
    FROM inventory i
    JOIN film f ON i.film_id = f.film_id
    GROUP BY i.film_id
)

SELECT fu.film_id, f.title, fu.type, fu.last_update
FROM film_update fu
JOIN film f ON fu.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Action'
ORDER BY f.title, fu.last_update;



-- Question 3:
SELECT 
    film_id, 
    title,
    rating,  
    length, 
    CASE
        WHEN length <= 50 THEN 'short'
        WHEN length >= 80 THEN 'feature'
        ELSE 'featurette'
    END AS movie_type
FROM film;




-- Question 4:


-- Question 5:


-- Question 6:


-- Question 7:


-- Question 8:


-- Question 9:


