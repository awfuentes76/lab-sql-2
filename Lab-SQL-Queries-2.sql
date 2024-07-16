-- Lab | SQL Queries 2
-- In this lab, you will be using the Sakila database of movie rentals. You can follow the steps listed here to get the data locally: Sakila sample database - installation.
-- The database is structured as follows:

USE sakila;

-- 1. Select all the actors with the first name ‘Scarlett’.
SELECT 
*
FROM actor 
WHERE first_name="Scarlett";

-- 2. Select all the actors with the last name ‘Johansson’.
SELECT
*
FROM actor
WHERE last_name="Johansson";

-- 3. How many films (movies) are available for rent?
SELECT 
DISTINCT i.film_id
FROM inventory i
LEFT JOIN rental r 
ON i.inventory_id = r.inventory_id
WHERE r.return_date IS NOT NULL;


-- 4. How many films have been rented?
SELECT 
*
FROM film WHERE film_id IN (SELECT 
DISTINCT film_id 
FROM inventory WHERE inventory_id NOT IN (SELECT DISTINCT inventory_id FROM rental WHERE return_date IS NULL));

SELECT COUNT( rental.inventory_id) total_alquileres
FROM rental;

-- 5. What is the shortest and longest rental period?
-- Shortest:
SELECT 
MIN(rental_duration) min_rental
FROM film;

-- Longest:
SELECT 
MAX(rental_duration) max_rental
FROM film;

-- 6. What are the shortest and longest movie duration? Name the values max_duration and min_duration.
-- Longest:
SELECT 
MAX(length) max_duration
FROM film;

-- Shortest:
SELECT 
MIN(length) min_duration
FROM film;

-- 7. What's the average movie duration?
SELECT 
AVG(length) avg_duration
FROM film;

-- 8. What's the average movie duration expressed in format (hours, minutes)?
SELECT 
    TRUNCATE(AVG(length) / 60, 0) AS horas,
    TRUNCATE(AVG(length) % 60, 0) AS minutos
FROM 
    film;
    
-- 9. How many movies longer than 3 hours?
SELECT COUNT(film_id) longer_3
FROM film
WHERE length > 180;


-- 10. Get the name and email formatted. Example: Mary SMITH - mary.smith@sakilacustomer.org.
SELECT 
    CONCAT(first_name, ' ', UPPER(last_name), ' - ', LOWER(CONCAT(first_name, '.', last_name, '@sakilacustomer.org'))) AS formatted_name_email
FROM customer;

-- 11. What's the length of the longest film title?
SELECT 
title, length, length(title),
RANK() OVER(ORDER BY length(title) DESC) ranking
FROM film
LIMIT 1
;
