USE sakila;

-- QEUSTION 1: List the number of films per category.

SELECT c.name as category_name, COUNT(f.film_id) as number_of_films
FROM  sakila.category as c 
JOIN sakila.film_category as f
ON c.category_id = f.category_id
GROUP BY c.name
ORDER BY number_of_films DESC;


-- QUESTION 2:  Retrieve the store ID, city, and country for each store.
SELECT store.store_id, city.city, country.country
FROM store
JOIN address ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id;


-- QUESTION 3:  Calculate the total revenue generated by each store in dollars.

SELECT store.store_id, SUM(payment.amount) AS total_revenue
FROM store
JOIN staff ON store.manager_staff_id = staff.staff_id
JOIN payment ON staff.staff_id = payment.staff_id
GROUP BY store.store_id;
    
-- QUESTION 4: Determine the average running time of films for each category.

SELECT  category.name AS category_name, AVG(film.length) AS average_running_time
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name
ORDER BY average_running_time DESC;

-- QUESTION 5: Identify the film categories with the longest average running time.

SELECT category.name AS category_name, AVG(film.length) AS average_running_time
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name
ORDER BY average_running_time DESC
LIMIT 1;

-- QUESTION 6: Display the top 10 most frequently rented movies in descending order.

SELECT film.title AS movie_title, COUNT(rental.rental_id) AS rental_count
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY rental_count DESC
LIMIT 10;

-- QUESTION 7: Determine if "Academy Dinosaur" can be rented from Store 1.

SELECT film.title AS movie_title, store.store_id, COUNT(rental.rental_id) AS rental_count
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN store ON inventory.store_id = store.store_id
WHERE film.title = 'Academy Dinosaur' AND store.store_id = 1
GROUP BY film.title, store.store_id;

-- QUESTION 8: Provide a list of all distinct film titles, along with their availability status in the inventory.  
SELECT film.title AS movie_title,
    IFNULL(CASE WHEN COUNT(inventory.inventory_id) > 0 THEN 'Available' ELSE 'NOT available' END, 'NOT available') AS availability_status
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id
GROUP BY film.title;
