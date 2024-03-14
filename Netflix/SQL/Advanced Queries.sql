
----------------------------------------------------------Netflix Movies and TV Shows----------------------------------------------------------


/*
________________________________________________________________ Advanced Queries ________________________________________________________________
1.	Which movie has the longest duration?
2.	List the titles of movies released before 1980 with a 'PG' rating.
3.	Find the month in which the most movies were added.
4.	List the top 10 directors with the most movies or shows.
5.	Calculate the total duration of all TV shows in minutes.

*/


-- 1.	Which movie has the longest duration?


with cte as (
select 
m.title, m.duration 
from movies_shows as m
where m.type = 'Movie'
) 
select 
title 
from cte
where duration =  (select max(duration) max_duration_of_movie from movies_shows where type = 'Movie');


-- 2.	List the titles of movies released before 1980 rating containg 'PG' in begining.


select 
m.title
from movies_shows as m
where m.rating like 'PG%' and m.release_year < 1980 and m.type = 'Movie';


-- 3.	Find the month in which the most movies were added (and how many?).


with cte as (
select
m.added_month_name, count(*) as count_of_movies_added,
DENSE_RANK() over(order by count(*) desc) as rn
from movies_shows as m
group by m.added_month_name)
select 
added_month_name as [Month],
count_of_movies_added
from cte
where rn = 1;


-- 4.	List the top 10 directors with the most movies and shows (return only 10 records).


select top 10
d.director, count(*) as count_of_movies_and_shows
from directors as d
group by d.director
order by count_of_movies_and_shows desc;


-- 5.	Calculate the total seasons of all TV shows.


select
sum(m.duration) Total_seasons
from movies_shows as m
where m.type = 'TV Show';


--______________________________________________________________________________________________________________________________________________