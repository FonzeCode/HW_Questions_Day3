-- Week 5 - Wednesday Questions

-- 1. List all customers who live in Texas (use JOINs)
SELECT first_name, last_name, district
FROM customer c 
JOIN address a 
ON c.address_id = a.address_id 
WHERE district = 'Texas';

--first_name|last_name|district|
----------+---------+--------+
--Kim       |Cruz     |Texas   |
--Jennifer  |Davis    |Texas   |
--Richard   |Mccrary  |Texas   |
--Bryan     |Hardison |Texas   |
--Ian       |Still    |Texas   |

-- 2. List all payments of more than $7.00 with the customer’s first and last name
SELECT first_name, last_name, amount
FROM customer c 
JOIN payment p 
ON c.customer_id = p.customer_id 
WHERE amount > 7;

--first_name|last_name   |amount|
----------+------------+------+
-- Peter     |Menard      |  7.99|
-- Peter     |Menard      |  7.99|
-- Peter     |Menard      |  7.99|
-- Douglas   |Graf        |  8.99|
-- Ryan      |Salisbury   |  8.99|
-- Ryan      |Salisbury   |  8.99|
-- Ryan      |Salisbury   |  7.99|
-- Roger     |Quintanilla |  8.99|
-- Joe       |Gilliland   |  8.99|
-- Jonathan  |Scarborough |  7.99|
-- ...

-- 3. Show all customer names who have made over $175 in payments (use
-- subqueries)
SELECT customer_id, store_id, first_name, last_name, email, address_id, activebool, create_date, last_update
FROM customer c 
WHERE customer_id IN ( 
         SELECT customer_id
         FROM payment p
         GROUP BY customer_id
         HAVING SUM(amount) > 175
);

--customer_id|store_id|first_name|last_name|email                            |address_id|activebool|create_date|last_update            |
-----------+--------+----------+---------+---------------------------------+----------+----------+-----------+-----------------------+
 --       526|       2|Karl      |Seal     |karl.seal@sakilacustomer.org     |       532|true      | 2006-02-14|2023-03-16 10:01:03.026|
 --       137|       2|Rhonda    |Kennedy  |rhonda.kennedy@sakilacustomer.org|       141|true      | 2006-02-14|2023-03-16 10:01:03.026|
 --      144|       1|Clara     |Shaw     |clara.shaw@sakilacustomer.org    |       148|true      | 2006-02-14|2023-03-16 10:01:03.026|
 --       148|       1|Eleanor   |Hunt     |eleanor.hunt@sakilacustomer.org  |       152|true      | 2006-02-14|2023-03-16 10:01:03.026|
 --       178|       2|Marion    |Snyder   |marion.snyder@sakilacustomer.org |       182|true      | 2006-02-14|2023-03-16 10:01:03.026|
 --       459|       1|Tommy     |Collazo  |tommy.collazo@sakilacustomer.org |       464|true      | 2006-02-14|2023-03-16 10:01:03.026|

-- 4. List all customers that live in Argentina (use the city table)
SELECT first_name, last_name, district, city, country
FROM customer c 
JOIN address a 
ON c.address_id = a.address_id
JOIN  city ci 
ON a.city_id = ci.city_id 
JOIN  country co 
ON ci.country_id = co.country_id 
WHERE country = 'Argentina';

-- first_name|last_name|district    |city                |country  |
----------+---------+------------+--------------------+---------+
-- Willie    |Markham  |Buenos Aires|Almirante Brown     |Argentina|
--Jordan    |Archuleta|Buenos Aires|Avellaneda          |Argentina|
--Jason     |Morrissey|Buenos Aires|Baha Blanca         |Argentina|
--Kimberly  |Lee      |Crdoba      |Crdoba              |Argentina|
--Micheal   |Forman   |Buenos Aires|Escobar             |Argentina|
--Darryl    |Ashcraft |Buenos Aires|Ezeiza              |Argentina|
--Julia     |Flores   |Buenos Aires|La Plata            |Argentina|
--Florence  |Woods    |Buenos Aires|Merlo               |Argentina|
--Perry     |Swafford |Buenos Aires|Quilmes             |Argentina|
--Lydia     |Burke    |Tucumn      |San Miguel de Tucumn|Argentina|
--Eric      |Robert   |Santa F     |Santa F             |Argentina|
--Leonard   |Schofield|Buenos Aires|Tandil              |Argentina|
--Willie    |Howell   |Buenos Aires|Vicente Lpez        |Argentina|

-- 5. Show all the film categories with their count in descending order
SELECT c.category_id, name, COUNT(*) AS num_movies_in_cat
FROM category c 
JOIN film_category fc 
ON c.category_id = fc.category_id 
GROUP BY c.category_id 
ORDER BY COUNT(*) DESC;

--category_id|name       |num_movies_in_cat|
-----------+-----------+-----------------+
--         15|Sports     |               74|
--          9|Foreign    |               73|
--          8|Family     |               69|
--          6|Documentary|               68|
--          2|Animation  |               66|
--          1|Action     |               64|
--         13|New        |               63|
--          7|Drama      |               62|
--        14|Sci-Fi     |               61|
--         10|Games      |               61|
--          3|Children   |               60|
--          5|Comedy     |               58|
--          4|Classics   |               57|
--        16|Travel     |               57|
--         11|Horror     |               56|         12|Music      |               51|

-- 6. What film had the most actors in it (show film info)?
SELECT f.film_id, title, COUNT(*) AS num_actors
FROM film f 
JOIN film_actor fa 
ON f.film_id = fa.film_id 
GROUP BY f.film_id 
ORDER BY COUNT(*) DESC 
LIMIT 1;
--film_id|title           |num_actors|
-------+----------------+----------+
--    508|Lambs Cincinatti|        15|


-- 7. Which actor has been in the least movies?
SELECT a.actor_id, first_name, last_name, COUNT(*) AS num_films
FROM actor a 
JOIN film_actor fa 
ON a.actor_id = fa.actor_id 
GROUP BY a.actor_id 
ORDER BY COUNT(*)
LIMIT 1;
--actor_id|first_name|last_name|num_films|
--------+----------+---------+---------+
--     148|Emily     |Dee      |       14|



-- 8. Which country has the most cities?
SELECT c.country_id, country, COUNT(*) AS num_cities
FROM country c 
JOIN city c2 
ON c.country_id = c2.country_id 
GROUP BY c.country_id 
ORDER BY COUNT(*) DESC 
LIMIT 1;

--country_id|country|num_cities|
---------+-------+----------+
--       44|India  |        60|

-- 9. List the actors who have been in between 20 and 25 films.
SELECT a.actor_id, first_name, last_name, COUNT(*)
FROM actor a 
JOIN film_actor fa 
ON a.actor_id = fa.actor_id 
GROUP BY a.actor_id 
HAVING COUNT(*) BETWEEN 20 AND 25;
--actor_id|first_name |last_name  |count|
--------+-----------+-----------+-----+
--       8|Matthew    |Johansson  |   20|
--     116|Dan        |Streep     |   24|
--      87|Spencer    |Peck       |   21|
--      51|Gary       |Phoenix    |   25|
--      70|Michelle   |Mcconaughey|   23|
--     162|Oprah      |Kilmer     |   25|
--     132|Adam       |Hopper     |   22|

