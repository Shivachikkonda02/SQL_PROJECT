use movies;

drop table movies;

CREATE TABLE movies (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    year INT,
    rankscore FLOAT
);

INSERT INTO movies (id, name, year, rankscore)
VALUES
(1, 'The Shawshank Redemption', 1994, 9.3),
(2, 'The Godfather', 1972, 9.2),
(3, 'The Dark Knight', 2008, 9.0),
(4, '12 Angry Men', 1957, 8.9),
(5, 'Schindler\'s List', 1993, 8.9),
(6, 'The Lord of the Rings: The Return of the King', 2003, 8.9),
(7, 'Pulp Fiction', 1994, 8.9),
(8, 'The Good, the Bad and the Ugly', 1966, 8.8),
(9, 'Fight Club', 1999, 8.8),
(10, 'Forrest Gump', 1994, 8.8);


describe movies;

select * from movies;

-- Display the name and year columns from the movies table.
select name,year from  movies;

-- Display the rankscore and name columns from the movies table.
select rankscore,name from movies;

-- Display the first 20 name and rankscore pairs from the movies table.
select name,rankscore from movies
limit   20;

-- Display the 4 name and rankscore pairs, starting from the 7th row, from the movies table.
select name,rankscore from movies
limit 4 offset 6;

-- Display the name, rankscore, and year columns from the movies table, ordered by year in descending order, and limit the result to the top 5 rows.
select  name,rankscore,year
from movies
order by year desc
limit 5;

-- Display the name, rankscore, and year columns from the movies table, ordered by year in ascending order, and limit the result to the top 5 rows.
select name,rankscore,year
from movies
order by year
limit 5;

-- Display the unique rankscore values from the movies table.
select distinct rankscore from movies;

-- Display all columns and rows from the movies table where the rankscore is greater than 9.
select * from movies
where rankscore > 9;

-- Display the name, year, and rankscore columns from the movies table where the rankscore is greater than 9, ordered by rankscore in ascending order, and limit the result to the top 20 rows.
select name,year,rankscore from movies
where rankscore >9
order by rankscore
limit 20;

-- Display all columns and rows from the movies table where the rankscore is exactly 8.8.
select * from movies
where rankscore=8.8;

-- Display all columns and rows from the movies table where the rankscore is greater than 8.
select  *  from movies
where rankscore >8;

-- Display all columns and rows from the movies table where the rankscore is not equal to 8.
select  *from movies
where rankscore!=8;

-- Display all columns and rows from the movies table where the rankscore is NULL.
SELECT  * FROM MOVIES
WHERE RANKSCORE=NULL;

-- Display all columns and rows from the movies table where the rankscore is NULL, ordered by rankscore (which will have no effect as all values are NULL), and limit the result to the top 20 rows.
SELECT * FROM MOVIES
WHERE RANKSCORE = NULL
ORDER BY RANKSCORE 
LIMIT 20;

-- Display all columns and rows from the movies table where the rankscore is greater than 8 and the year is greater than 2000.
SELECT * FROM MOVIES
WHERE RANKSCORE >8
AND
YEAR > 2000;

-- Display all columns and rows from the movies table where the year is greater than 2000.
SELECT * FROM MOVIES
WHERE YEAR >2000;

-- Display all columns and rows from the movies table where the rankscore is greater than 8.6 or the year is 2007.
SELECT  *FROM MOVIES
WHERE RANKSCORE > 8.6
OR
YEAR=2007;

-- Display all columns and rows from the movies table where the year is between 1999 and 2000 (inclusive)
SELECT * FROM MOVIES
WHERE YEAR BETWEEN 1999 AND 2000;

-- Display all movies with a rankscore of 8.8 or 8.9.
SELECT * FROM MOVIES
WHERE RANKSCORE IN  (8.8,8.9);

-- Display all movies released in the years 1999 or 2010.
SELECT * FROM MOVIES
WHERE YEAR IN (1999,2010);

-- Display all movies whose name starts with the letter 'T'.
SELECT * FROM MOVIES
WHERE NAME LIKE "T%";

-- Display all movies whose name contains the word 'SHAW'.
SELECT * FROM MOVIES
WHERE NAME LIKE '%SHAW%';

-- What is the earliest year of a movie in the dataset?
SELECT MIN(YEAR) FROM MOVIES;

-- What is the latest year of a movie in the dataset?
SELECT MAX(YEAR) FROM MOVIES;

-- How many movies are there in total?
SELECT COUNT(*) FROM MOVIES;

-- How many movies were released after the year 2000?
SELECT COUNT(*) FROM MOVIES
WHERE YEAR > 2000;

-- How many movies were released after the year 2008?
SELECT COUNT(*) FROM MOVIES
WHERE YEAR > 2008;

-- How many movies have a NULL value for the year column?
SELECT COUNT(*) FROM MOVIES
WHERE YEAR IS NULL;

SELECT YEAR ,COUNT(YEAR)
FROM MOVIES
group by YEAR;

SELECT YEAR,COUNT(YEAR)
FROM MOVIES
GROUP BY YEAR;

-- How many movies were released in each year, sorted by year in ascending order?
SELECT YEAR,COUNT(YEAR) FROM MOVIES
GROUP BY year
ORDER BY YEAR;

-- How many movies were released in each year, sorted by the number of movies released in each year in ascending order?
SELECT YEAR,COUNT(YEAR) AS YEAR_COUNT
FROM MOVIES
GROUP BY YEAR
ORDER BY YEAR_COUNT;

-- How many years have more than 2 movies released?
SELECT COUNT(YEAR) AS CNT
FROM MOVIES
WHERE CNT > 2;

SELECT YEAR,COUNT(YEAR) AS TOTAL_COUNT FROM MOVIES
GROUP BY YEAR
HAVING TOTAL_COUNT > 2;

-- Which years have more than 20 movies with a rankscore greater than 9?
SELECT YEAR,COUNT(YEAR) AS TOTAL_COUNT
FROM MOVIES
WHERE RANKSCORE>9
group by YEAR
HAVING TOTAL_COUNT > 20


