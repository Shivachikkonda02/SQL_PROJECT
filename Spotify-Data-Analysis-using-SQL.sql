CREATE DATABASE APP;
USE APP;
SELECT * FROM app.spotify;

SELECT COUNT(*) FROM APP.SPOTIFY;

-- EDA

SELECT COUNT(DISTINCT ARTIST) FROM APP.SPOTIFY;

SELECT DISTINCT ALBUM_TYPE FROM SPOTIFY;

SELECT MAX(DURATION_MIN) FROM APP.SPOTIFY;

SELECT ROUND(MAX(DURATION_MIN),2) FROM SPOTIFY;

SELECT MIN(DURATION_MIN) FROM SPOTIFY;

SELECT * FROM SPOTIFY
WHERE DURATION_MIN =0;

-- -----------------------------------------------
-- Data Analysis -Easy Category
-- -----------------------------------------------

-- 1.Retrive the names of all tracks that have more than 1billion streams
SELECT * FROM SPOTIFY 
WHERE STREAM > 1000000000;

-- 2.List all albums along with their respective artists
SELECT DISTINCT ALBUM,ARTIST FROM SPOTIFY
ORDER BY 1;

-- 3.Get the total number of comments for tracks where licensed=True
SELECT SUM(COMMENTS) AS TOTAL_COMMENTS
FROM SPOTIFY WHERE LICENSED='true';

-- 4.Find all tracks that belong to the album type single
SELECT * FROM SPOTIFY
WHERE ALBUM_TYPE='single';



-- 5.Count total numnber of tracks by each artist
SELECT ARTIST,COUNT(*) AS TOTAL_NO_SONGS
FROM SPOTIFY
GROUP BY ARTIST;

-- 6.Calculate the average danceability in each album
SELECT ALBUM,AVG(DANCEABILITY) AS AVG_DANCEABILITY
FROM SPOTIFY
GROUP BY 1;

-- 7.Find the top 5 tracks with the highest energy values
SELECT TRACK,MAX(ENERGY) FROM SPOTIFY
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


-- 8.List all tracks along with their views and likes where official_video =TRUE
SELECT TRACK,
SUM(VIEWS) AS TOTAL_VIEWS,
SUM(LIKES) AS TOTAL_LIKES
FROM SPOTIFY
where OFFICIAL_VIDEO = 'true'
group by 1
order by 2 desc
limit 5;

-- 9.For each album, caluculate the total views of all associated tracks
SELECT ALBUM,TRACK,SUM(VIEWS)
FROM SPOTIFY
GROUP BY 1,2
ORDER BY 3 DESC;


SELECT * FROM SPOTIFY;
