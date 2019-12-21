#1*What are the names of all the languages in the database
SELECT name FROM language ORDER BY name ASC;
+----------+
| name     |
+----------+
| English  |
| French   |
| German   |
| Italian  |
| Japanese |
| Mandarin |
+----------+
#2 Return the full names (first and last) of all actors with "BER" in their last name. Sort the returned names by their first name. 
#(Hint: use the CONCAT() function to add two or more strings together.)
SELECT CONCAT (first_name, ' ',last_name) AS names 
FROM Actor WHERE last_name like "%ber%" ORDER BY first_name;
+-------------------+
| names             |
+-------------------+
| CHRISTOPHER BERRY |
| DARYL WAHLBERG    |
| HENRY BERRY       |
| KARL BERRY        |
| LIZA BERGMAN      |
| NICK WAHLBERG     |
| PARKER GOLDBERG   |
| VIVIEN BERGEN     |
+-------------------+
#3 How many last names are not repeated in the actor table?
 SELECT COUNT(distinct last_name) 
 FROM actor;
+---------------------------+
| COUNT(distinct last_name) |
+---------------------------+
|                       121 |
+---------------------------+

#4 How many films involve a "Crocodile" and a "Shark"?
SELECT COUNT(description) 
FROM film 
WHERE description LIKE "%Crocodile%" AND description LIKE "%Shark%";
+--------------------+
| COUNT(description) |
+--------------------+
|                 10 |
+--------------------+

#5 Return the full names of the actors who played in a film involving
# a "Crocodile" and a "Shark", along with the release year of the movie,
# sorted by the actors' last names.

SELECT CONCAT(a.first_name,' ',a.last_name) as Full_Name, f.release_year
FROM film f 
INNER JOIN film_actor fa 
ON f.film_id = fa.film_id 
INNER JOIN actor a 
ON fa.actor_id = a.actor_id 
WHERE f.description LIKE '%Crocodile%' AND f.description LIKE '%Shark%'
ORDER by a.last_name;

+------------------+--------------+
| Full_Name        | release_year |
+------------------+--------------+
| KIRSTEN AKROYD   |         2006 |
| KIM ALLEN        |         2006 |
| AUDREY BAILEY    |         2006 |
| JULIA BARRYMORE  |         2006 |
| VIVIEN BASINGER  |         2006 |
| VIVIEN BERGEN    |         2006 |
| KARL BERRY       |         2006 |
| KARL BERRY       |         2006 |
| HENRY BERRY      |         2006 |
| LAURA BRODY      |         2006 |
| JOHNNY CAGE      |         2006 |
| ZERO CAGE        |         2006 |
| JON CHASE        |         2006 |
| FRED COSTNER     |         2006 |
| FRED COSTNER     |         2006 |
| JENNIFER DAVIS   |         2006 |
| SUSAN DAVIS      |         2006 |
| GINA DEGENERES   |         2006 |
| JULIANNE DENCH   |         2006 |
| ROCK DUKAKIS     |         2006 |
| HUMPHREY GARLAND |         2006 |
| AL GARLAND       |         2006 |
| EWAN GOODING     |         2006 |
| PENELOPE GUINESS |         2006 |
| WILLIAM HACKMAN  |         2006 |
| MEG HAWKE        |         2006 |
| WOODY HOFFMAN    |         2006 |
| MORGAN HOPKINS   |         2006 |
| JANE JACKMAN     |         2006 |
| ALBERT JOHANSSON |         2006 |
| RAY JOHANSSON    |         2006 |
| RAY JOHANSSON    |         2006 |
| ALBERT JOHANSSON |         2006 |
| MILLA KEITEL     |         2006 |
| FAY KILMER       |         2006 |
| MATTHEW LEIGH    |         2006 |
| GENE MCKELLEN    |         2006 |
| GRACE MOSTEL     |         2006 |
| GRACE MOSTEL     |         2006 |
| CHRISTIAN NEESON |         2006 |
| JAYNE NOLTE      |         2006 |
| ALBERT NOLTE     |         2006 |
| KENNETH PALTROW  |         2006 |
| KIRSTEN PALTROW  |         2006 |
| SANDRA PECK      |         2006 |
| PENELOPE PINKETT |         2006 |
| CAMERON STREEP   |         2006 |
| JOHN SUVARI      |         2006 |
| KENNETH TORN     |         2006 |
| HELEN VOIGHT     |         2006 |
| MORGAN WILLIAMS  |         2006 |
| GROUCHO WILLIAMS |         2006 |
| GENE WILLIS      |         2006 |
| HUMPHREY WILLIS  |         2006 |
| WILL WILSON      |         2006 |
| FAY WOOD         |         2006 |
| UMA WOOD         |         2006 |
| MINNIE ZELLWEGER |         2006 |
+------------------+--------------+
58 rows in set (0.00 sec)

#6 Find all the film categories in which there are between 40 and 60 films.
# Return the names of these categories and the number of films in 
#each category, sorted in descending order of the number of films.

SELECT category, count(*) AS FilmsCount
From film_list
Group by category
Having Count(*) Between 40 and 60
Order by FilmsCount;
+----------+------------+
| category | FilmsCount |
+----------+------------+
| Music    |         51 |
| Horror   |         56 |
| Travel   |         56 |
| Classics |         57 |
| Comedy   |         58 |
| Children |         60 |
+----------+------------+

#7 Return the full names of all the actors whose
# first name is the same as the first name of the actor with ID 24.

SELECT CONCAT(first_name, " " ,last_name) AS Names 
FROM actor
WHERE first_name= (SELECT first_name FROM actor WHERE actor_id= 24);

-------------------+
| Names             |
+-------------------+
| CAMERON STREEP    |
| CAMERON WRAY      |
| CAMERON ZELLWEGER |
+-------------------+


#8 Return the full name of the actor who has appeared in the most films.
Select fs.actor_id as "Actor ID" , CONCAT(first_name, " " , last_name) as Names, Count(fs.actor_id) as "# of films"
From film f 
JOIN Film_actor fs on fs.film_id=f.film_id 
JOIN actor a on a.actor_id =fs.actor_id
Group by fs.actor_id, CONCAT(first_name, " " , last_name) 
Order by count(fs.actor_id) DESC
 LIMIT 0,1;

----------+----------------+------------+
| Actor ID | Names          | # of films |
+----------+----------------+------------+
|      107 | GINA DEGENERES |         42 |
+----------+----------------+------------+

#9 Return the film categories with an average movie length
#longer than the average length of all movies in the sakila database.

SELECT category, AVG(length) As "film length"
From film f
Join len
GROUP BY category
HAVING AVG(length) > (SELECT AVG(length) From film);


+----------+-------------+
| category | film length |
+----------+-------------+
| Foreign  |    121.6986 |
| Comedy   |    115.8276 |
| Sports   |    127.5068 |
| Drama    |    119.8852 |
| Games    |    127.8361 |
+----------+-------------+
5 rows in set, 1 warning (0.03 sec)


#10 Return the total sales of each store.
SELECT Store, total_sales 
FROM sales_by_store;
+---------------------+-------------+
| Store               | total_sales |
+---------------------+-------------+
| Woodridge,Australia |    33726.77 |
| Lethbridge,Canada   |    33679.79 |
+---------------------+-------------+