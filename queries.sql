-- What were the top 10 movies according to IMDB score?

SELECT title,type,imdb_score FROM titles
WHERE imdb_score>=8.0 AND type='MOVIE'
ORDER BY imdb_score DESC
LIMIT 10;




-- What were the top 10 shows according to IMDB score? 

SELECT title,type,imdb_score FROM titles
WHERE imdb_score>=8.0 AND type='SHOW'
ORDER BY imdb_score DESC
LIMIT 10;




-- What were the bottom 10 movies according to IMDB score? 

SELECT title,type,imdb_score FROM titles
WHERE type='MOVIE'
ORDER BY imdb_score 
LIMIT 10;




-- What were the bottom 10 shows according to IMDB score? 

SELECT title,type,imdb_score FROM titles
WHERE type='SHOW'
ORDER BY imdb_score 
LIMIT 10;





-- What were the average IMDB and TMDB scores for shows and movies? 

SELECT DISTINCT type,
ROUND(AVG(imdb_score),2) AS average_IMDB,
ROUND(AVG(tmdb_score),2) AS average_TMDB
FROM titles
GROUP BY type;



-- Count of movies and shows in each decade
SELECT CONCAT(FLOOR(release_year / 10) * 10, 's') AS decade,
	COUNT(*) AS movies_shows_count
FROM titles
WHERE release_year >= 1940
GROUP BY CONCAT(FLOOR(release_year / 10) * 10, 's')
ORDER BY decade;



-- What were the average IMDB and TMDB scores for each production country?
SELECT DISTINCT production_countries,
ROUND(AVG(imdb_score),2) AS average_IMDB,
ROUND(AVG(tmdb_score),2) AS average_TMDB
FROM titles
GROUP BY production_countries
ORDER BY average_IMDB DESC;




-- What were the average IMDB and TMDB scores for each age certification for shows and movies?


SELECT DISTINCT age_certification,
ROUND(AVG(imdb_score),2) AS average_IMDB,
ROUND(AVG(tmdb_score),2) AS average_TMDB
FROM titles
GROUP BY age_certification
ORDER BY average_IMDB DESC;






-- What were the 5 most common age certifications for movies?

SELECT age_certification,
COUNT(*) AS certification_count
FROM titles
WHERE type='MOVIE' AND age_certification<>'N/A'
GROUP BY age_certification
ORDER BY certification_count DESC
LIMIT 5;


-- Who were the top 20 actors that appeared the most in movies/shows?

SELECT DISTINCT name AS actor,
COUNT(*) AS appearances 
FROM credits
WHERE role='ACTOR'
GROUP BY name
ORDER BY appearances DESC
LIMIT 20;



-- Who were the top 20 directors that directed the most movies/shows? 

SELECT DISTINCT name AS director,
COUNT(*) AS appearances 
FROM credits
WHERE role='DIRECTOR'
GROUP BY name
ORDER BY appearances DESC
LIMIT 20;



-- Calculating the average runtime of movies and TV shows separately

SELECT DISTINCT type,
ROUND(AVG(runtime),2) AS average_runtime
FROM titles
GROUP BY type;

SELECT DISTINCT type,
ROUND(AVG(runtime),2) AS avg_runtime_min
FROM titles
WHERE type = 'MOVIE'
GROUP BY type
UNION ALL
SELECT DISTINCT type,
ROUND(AVG(runtime),2) AS avg_runtime_min
FROM titles
WHERE type = 'SHOW'
GROUP BY type;




-- Finding the titles and  directors of movies released on or after 2010

SELECT DISTINCT t.title,c.name AS Director,release_year
FROM titles t
JOIN credits c
ON t.id=c.id   
WHERE t.type='MOVIE'
AND t.release_year>=2010
AND c.role='DIRECTOR'
ORDER BY release_year DESC;



-- Which shows on Netflix have the most seasons?

SELECT title,
SUM(seasons) AS Total_seasons
FROM titles
WHERE type='SHOW'
GROUP BY title
ORDER BY Total_seasons DESC
LIMIT 10;




-- Which genres had the most movies? 

SELECT DISTINCT genres,
COUNT(*) AS NO_OF_MOVIES
FROM titles
WHERE type ='MOVIE'
GROUP BY genres
ORDER BY NO_OF_MOVIES DESC
LIMIT 10;



-- Which genres had the most shows? 

SELECT DISTINCT genres,
COUNT(*) AS NO_OF_SHOWS
FROM titles
WHERE type ='SHOW'
GROUP BY genres
ORDER BY NO_OF_SHOWS DESC
LIMIT 10;



-- Titles and Directors of movies with high IMDB scores (>7.5) and high TMDB popularity scores (>80) 

SELECT t.title,c.name AS director
FROM titles t
JOIN credits c
ON t.id=c.id
WHERE t.type='MOVIE'
AND t.imdb_score>7.5
AND t.tmdb_popularity>80
AND c.role='DIRECTOR';




-- What were the total number of titles for each year? 
SELECT release_year,
COUNT(*) AS no_of_titles
FROM titles
GROUP BY release_year
ORDER BY release_year DESC;



-- Actors who have starred in the most highly rated movies or shows

SELECT c.name AS actor,
COUNT(*) AS Highly_rated_titles
FROM credits c
JOIN titles t
ON c.id=t.id
WHERE c.role='ACTOR'
AND (t.type='MOVIE' OR t.type='SHOW')
AND imdb_score>8.0
AND tmdb_score>8.0
GROUP BY c.name
ORDER BY Highly_rated_titles DESC;



-- Which actors/actresses played the same character in multiple movies or TV shows? 

SELECT c.name AS actor_actress,c.character,
COUNT(DISTINCT t.title) AS num_titles
FROM credits c
JOIN titles t
ON c.id=t.id
WHERE (c.role='ACTOR' OR c.role='ACTRESS')
GROUP BY c.name,c.character
HAVING COUNT(DISTINCT t.title)>1;



-- What were the top 3 most common genres?

SELECT DISTINCT genres,
COUNT(*) AS genre_count
FROM titles
GROUP BY genres
ORDER BY genre_count DESC
LIMIT 3;





-- Average IMDB score for leading actors/actresses in movies or shows 

SELECT c.name AS actor_actress,
ROUND(AVG(t.imdb_score),2) AS avg_imdb_score
FROM credits c
JOIN titles t
ON c.id=t.id
WHERE c.role='ACTOR' or c.role='ACTRESS'
GROUP BY c.name
ORDER BY avg_imdb_score ;
