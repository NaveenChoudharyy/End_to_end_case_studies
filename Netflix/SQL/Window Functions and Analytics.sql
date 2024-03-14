
----------------------------------------------------------Netflix Movies and TV Shows----------------------------------------------------------


/*
_____________________________________________________________ Window Functions and Analytics _____________________________________________________________


1.	Rank directors based on the number of movies they have directed.
2.	Calculate the cumulative duration of movies released each year.
3.	List the top 5 most common genres among movies and TV shows.
4.	Find the cast member who has appeared in the most movies.
5.	Identify the top 3 actors who have appeared in the most diverse genres of movies or TV shows. 
	For each actor, list the count of unique genres they have appeared in, along with their names. 
	Order the results by the count of unique genres in descending order.


*/

-- 1.	Rank directors based on the number of movies they have directed.


select d.director, rank() over(order by count(*) desc) as rank_of_director from directors as d
inner join movies_shows as m
on m.show_id = d.show_id
where m.type = 'Movie'
group by d.director;


-- 2.	Calculate the cumulative duration of movies by released each year.


select m.release_year, sum(m.duration) over(order by m.release_year asc) from movies_shows as m
where m.type = 'Movie';


-- 3.	List the top 5 most common genres among movies and TV shows.


with cte as (
select c.listed_in as gerne, dense_rank() over(order by count(*)) as rn from category as c
inner join movies_shows as m
on m.show_id = c.show_id
group by c.listed_in)
select * from cte where rn < 6;


-- 4.	Find the cast member who has appeared in the most movies.


select actor from 
				(select c.cast as actor, row_number() over(order by count(*) desc) as rn from [cast] as c
				group by c.cast) as t
where rn = 1;


-- 5.	Identify the top 3 actors who have appeared in the most diverse genres of movies or TV shows. 
--		For each actor, list the count of unique genres they have appeared in, along with their names. 
--		Order the results by the count of unique genres in descending order.


with cte as (
select   
actor, count(gerne) as count_of_gerne, 
row_number() over(order by count(gerne) desc) rank_ from (
select distinct m.cast as actor, c.listed_in as gerne from category as c
inner join cast as m
on m.show_id = c.show_id) as t
group by actor)
select actor, count_of_gerne from cte where rank_ <= 3;
 

--______________________________________________________________________________________________________________________________________________