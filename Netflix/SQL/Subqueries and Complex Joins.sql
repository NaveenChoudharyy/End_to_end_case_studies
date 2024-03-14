
----------------------------------------------------------Netflix Movies and TV Shows----------------------------------------------------------


/*
_____________________________________________________________ Subqueries and Complex Joins _____________________________________________________________

1.	Find the titles of movies with the highest number of directors.
2.	List all movies that have a director who also acted in the movie.
3.	Which country has the highest average duration of movies?
4.	Find the titles of movies that have the same title as a TV show.
5.	Calculate the total number of seasons for each genre TV shows.

*/



-- 1.	Find the titles of movies with the highest number of directors.


with cte as(
select 
m.title, 
dense_rank() over(order by count(d.director) desc) as rn
from directors as d
inner join movies_shows as m
on m.show_id = d.show_id
where m.type = 'Movie'
group by m.title)
select title from cte where rn = 1;


-- 2.	List all movies that have a director who also directed a TV show.


select distinct 
d.director, m.show_id, m.title 
from directors as d
inner join movies_shows as m
on m.show_id = d.show_id
where d.director in
(
select d.director from directors as d
inner join movies_shows as m
on m.show_id = d.show_id
where m.type = 'Movie'

INTERSECT

select d.director from directors as d
inner join movies_shows as m
on m.show_id = d.show_id
where m.type = 'TV Show'
)
and m.type = 'Movie';


-- 3.	Which country has the highest average duration of movies produced?


with cte as (
select c.country, DENSE_RANK() over(order by m.duration desc) as rn 
from movies_shows as m 
inner join countries as c on m.show_id = c.show_id
where m.type = 'Movie')
select country from cte where rn = 1;


-- 4.	Find the show_id of movies that have the same title as a TV show released before year 2010.


select m.show_id from movies_shows as m where m.title in (
select m.title from movies_shows as m where m.type = 'Movie'
intersect
select m.title from movies_shows as m where m.type = 'TV Show' )
and m.type = 'Movie';


-- 5.	Calculate the total number of seasons for each genre for TV shows.


select c.listed_in as gerne, sum(m.duration) Total_seasons from movies_shows as m 
inner join category as c on c.show_id = m.show_id
where m.type = 'TV Show'
group by c.listed_in;


--______________________________________________________________________________________________________________________________________________