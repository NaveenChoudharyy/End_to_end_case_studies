
/*
#### About this Dataset: 
Netflix is one of the most popular media and video streaming platforms. 
They have over 8000 movies or tv shows available on their platform, as of mid-2021, they have over 200M Subscribers globally. 
This tabular dataset consists of listings of all the movies and tv shows available on Netflix, along with details such as - 
cast, directors, ratings, release year, duration, etc.


#### Interesting Task Ideas

1. Understanding what content is available in different countries
2. Identifying similar content by matching text-based features
3. Network analysis of Actors / Directors and find interesting insights
4. Does Netflix has more focus on TV Shows than movies in recent years.


#### Source of Dataset : https://www.kaggle.com/datasets/shivamb/netflix-shows
*** Data is already cleaned using python.
*** Column "duration" contains duration in minutes for type "Movie" and number of season for type "TV Show"

*/


Create database Netflix;

use Netflix;

-- importing csv files
-- Right click of database Netflix
-- Tasks --> Import flat files --> click on next --> choose file and rename file according to you --> finish



select * from movies_shows;
select * from directors;
select * from category;
select * from countries;
select * from cast;
