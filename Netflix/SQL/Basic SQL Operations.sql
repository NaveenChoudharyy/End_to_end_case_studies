
----------------------------------------------------------Netflix Movies and TV Shows----------------------------------------------------------

/*
________________________________Questions on Basic SQL Operations________________________________
1.	List the titles of all movies released in the 21st century.
2.	How many TV shows have a rating of 'TV-MA'?
3.	Find the top 5 countries with the most movies or shows added in 2023.
4.	List all directors who have worked on more than 5 movies or shows.
5.	Calculate the average duration of movies released in the 1990s.
*/


-- 1.	List the titles of all movies released in the 21st century.


select 
m.title as Title 
from movies_shows as m
where m.release_year > 2000 and m.type = 'Movie';


-- 2.	How many TV shows have a rating of 'TV-MA'?


select 
count(*) as count_of_TV_shows_have_a_rating_of_TV_MA
from movies_shows as m
where m.rating = 'TV-MA' and m.type = 'TV Show';


-- 3.	Find the top 5 countries with the most movies or shows produced in 2023 (also include count).


with cte as (
select 
c.country , count(*) as count_of_movies_produced, 
DENSE_RANK() over(order by count(*) desc) as rn
from countries as c
group by c.country
) select country, count_of_movies_produced from cte
where rn < 6;


-- 4.	List all directors who have worked on more than 1 TV Show.


select 
d.director, count(m.show_id) as count_of_shows_directed
from directors as d
left join movies_shows as m
on m.show_id = d.show_id
group by d.director, m.type 
having count(m.show_id) > 1 and m.type = 'TV Show';


-- 5.	Calculate the average duration of movies released in the 1990s.


select 
avg(m.duration) as average_duration_of_movie_in_year_1990
from movies_shows as m
where m.type = 'Movie' and m.release_year = 1990;


--______________________________________________________________________________________________________________________________________________