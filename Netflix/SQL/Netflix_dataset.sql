
----------------------------------------------------------Netflix case study----------------------------------------------------------


-- creating databas as Netflix
create database Netflix;

-- using Netflix
use Netflix;


-- printing datasets
select * from movies;
select * from category;
select * from countries;
select * from directors;
select * from cast;

-----------------------------------------------------------------------------------------------


-- Find the average duration of movies in minutes.

select 
	avg(m.duration_minutes) as [average duration of movies] 
from movies as m;

-----------------------------------------------------------------------------------------------


-- List the titles of movies released after 2010.

select distinct
	m.title 
from movies as m
where 
	m.release_year > 2010;

-----------------------------------------------------------------------------------------------


-- Find the titles of movies where the description contains the word 'mystery'.

select 
	m.title 
from movies as m
where 
	LOWER(m.description) like '%mystery%';


-- List the directors who have directed more than 5 movies.

with cte as (
			select 
				d.director,	
				count(*) as cnt_of_movies_directed
			from directors as d
			left join movies as m
			on m.show_id = d.show_id
			group by
				d.director
			)
select 
	 director
from cte
where
	cnt_of_movies_directed > 5;

-----------------------------------------------------------------------------------------------


-- Find the average duration of movies for each director.

select 
	d.director, 
	AVG(coalesce(m.duration_minutes, 0)) as average_duration_of_movies 
from directors as d
left join movies as m
on m.show_id = d.show_id
group by
	d.director;

-----------------------------------------------------------------------------------------------

-- Count the number of movies in each genre.

select 
	c.listed_in as genre, 
	count(*) num_of_movies 
from category as c
group by 
	c.listed_in;

-----------------------------------------------------------------------------------------------


-- Find the top 5 countries with the most movies released.

with cte as (
			select 
				c.country, 
				count(*) no_of_release,
				dense_rank() over(order by count(c.country) desc) as rn
			from countries as c
			group by 
				c.country
			)
select 
	country,
	no_of_release
from cte
where rn < 6;


-----------------------------------------------------------------------------------------------


-- List the titles of movies where the cast includes 'Tom Hanks'.


select 
	m.title
from movies as m
left join cast as c
on c.show_id = m.show_id
where
	c.cast = 'Tom Hanks';


-----------------------------------------------------------------------------------------------


-- Find the movies with the highest and lowest durations.

select  
	m.title, 
	m.duration_minutes
from movies as m
where
	m.duration_minutes = (select min(duration_minutes) from movies)
	or
	m.duration_minutes = (select max(duration_minutes) from movies);


-----------------------------------------------------------------------------------------------


-- List the titles of movies added in February.


select 
	m.title
from movies as m
where
	m.added_month = 2;


-----------------------------------------------------------------------------------------------


-- Find the most common rating among movies.


with cte as (
				select
					m.rating,
					count(*) rat_freq,
					DENSE_RANK() over(order by count(m.rating) desc) as rn
				from movies as m
				group by
					m.rating
			)
select 
	rating 
from cte
where
	rn = 1;


-----------------------------------------------------------------------------------------------


-- Count the number of movies added in each year.


select 
	m.added_year,
	count(*) as no_of_movies
from movies as m
group by 
	m.added_year;

-----------------------------------------------------------------------------------------------


-- List the movies with the word 'love' in the description.


select 
	m.show_id, 
	m.title 
from movies as m
where 
	lower(m.description) like '%love%';


-----------------------------------------------------------------------------------------------


-- List the top 5 genres with the most movies.

with cte as (
			select 
				c.listed_in as genres, 
				count(*) cnt_of_movies,
				DENSE_RANK() over(order by count(*) desc) rn
			from category as c
			group by c.listed_in
			)
select 
	genres,
	cnt_of_movies
from cte
where rn < 6;


-----------------------------------------------------------------------------------------------


-- Find the movies with a duration within the range of 90 to 120 minutes.

select 
	m.show_id, 
	m.title, 
	m.release_year 
from movies as m
where 
	m.duration_minutes between 90 and 120;


-----------------------------------------------------------------------------------------------


-- List the countries where more than 10 movies have been released.


select 
	c.country
from countries as c
group by
	c.country
having 
	count(*) > 10;











