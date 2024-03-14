
----------------------------------------------------------Netflix Movies and TV Shows----------------------------------------------------------


/*
_____________________________________________________________ Conditional Queries _____________________________________________________________


1.	List movies released in the 2000s with a rating of 'PG-13' or 'R'.
2.	Find movies with the word "Love" in their title and a duration over 2 hours.
3.	List all directors who have worked on both movies and TV shows.
4.	Find movies released in February with a duration greater than 120 minutes.
5.	Calculate the percentage of movies that have a 'TV-MA' rating.


*/


-- 1.	List movies released in the 2000s with a rating of 'PG-13' or 'R'.


select * from movies_shows as m 
where (m.rating = 'PG-13' or m.rating = 'R') and 
		m.release_year = 2000 and m.type = 'Movie';


-- 2.	Find TV shows with the word "Love" in their title and a duration less then 1 hours.


select * from movies_shows as m 
where m.title like '%Love%' and m.type = 'TV Show' and m.duration < 60;


-- 3.	List all directors who have worked on both movies and TV shows.


select d.director from directors as d
left join movies_shows as m
on m.show_id = d.show_id
where m.type = 'Movie'
intersect
select d.director from directors as d
left join movies_shows as m
on m.show_id = d.show_id
where m.type = 'TV Show';


-- 4.	Find movies released in February with a duration greater than 120 minutes.


select * from movies_shows as m 
where m.type = 'Movie' and m.duration > 120 and m.added_month = 2;


-- 5.	Calculate the percentage of movies that have a 'TV-MA' rating.


select 
cast(count(*)*1.0/(select count(*)*1.0 
					from movies_shows as m where m.type = 'Movie') as decimal(10,2)) as percentage_of_movies_that_have_a_TV_MA_rating
from movies_shows as m where m.rating = 'TV-MA' and m.type = 'Movie';


--______________________________________________________________________________________________________________________________________________

