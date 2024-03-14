
----------------------------------------------------------Netflix Movies and TV Shows----------------------------------------------------------


/*
________________________________________________________________ Joins and Aggregations ________________________________________________________________

1.	List the titles of all movies with their respective genres.
2.	Find the number of movies for each rating category ('G', 'PG', 'R', etc.).
3.	Which country has produced the most 'TV-MA' rated shows?
4.	List all actors who have appeared in more than 10 movies or shows.
5.	Calculate the average duration of movies for each rating category.

*/


-- 1.	List the titles of all movies with their respective genres.


select 
m.title, c.listed_in as genre 
from category as c
inner join movies_shows as m
on m.show_id = c.show_id
where m.type = 'Movie'
order by m.title;


-- 2.	Find the number of movies for each rating category.


select 
m.rating, count(*) as count_of_movies 
from movies_shows as m
where m.type = 'Movie'
group by m.rating;


-- 3.	Which country has produced the most 'TV-MA' rated shows?


with cte as (
select 
c.country as Country_which_produced_the_most_TV_MA_rated_shows, 
dense_rank() over(order by count(*) desc) as rn
from countries as c
inner join movies_shows as m
on m.show_id = c.show_id
where m.type = 'TV Show' and m.rating = 'TV-MA'
group by c.country)
select 
Country_which_produced_the_most_TV_MA_rated_shows
from cte
where rn = 1;


-- 4.	List all actors who have appeared in more than 10 movies or shows.


select 
c.cast, count(*) as count_of_movies_and_shows
from [cast] as c
group by c.cast
having count(*) > 10;


-- 5.	Calculate the average duration of movies for each rating category.


select 
m.rating, avg(m.duration) as average_duration_in_minutes 
from movies_shows as m
where m.type = 'Movie'
group by m.rating;


--______________________________________________________________________________________________________________________________________________