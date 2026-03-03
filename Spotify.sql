create database spotify_tracks;
use spotify_tracks;

create table spotify(
	id varchar(50),
    name varchar(1000),
    genre varchar(50),
    album varchar(2500),
    popularity int,
    duration bigint,
    explicit varchar(25),
    Artist_1 varchar(500),
    Artist_2 varchar(500),
    Artist_3 varchar(500),
    Artist_4 varchar(500),
    Artist_5 varchar(500),
    Artist_6 varchar(500),
    Artist_7 varchar(500),
    Artist_8 varchar(500),
    Artist_9 varchar(500),
    Artist_10 varchar(500),
    Artist_11 varchar(500)
);


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/spotify.csv'
INTO TABLE spotify
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- /--  🎧 I. Market Overview (Foundation Layer)  --/
## 1. What is the overall average, median, and distribution of popularity?
select avg(popularity) from spotify;

WITH ordered AS (
  SELECT popularity,
         ROW_NUMBER() OVER (ORDER BY popularity) rn,
         COUNT(*) OVER () total
  FROM spotify
)
SELECT AVG(popularity) AS median_popularity
FROM ordered
WHERE rn IN (FLOOR((total+1)/2), CEIL((total+1)/2));

select count(*), case when popularity<20 then 'First' when popularity<40 then 'Second' when popularity<60 then 'Third' when popularity<80 then 'Fourth' else 'Fifth' end as popularity_bucket from spotify group by popularity_bucket;

## 2. How many tracks exist per genre, and what % share does each hold?
select genre, count(*)*100/ (select count(*) from spotify) as tracks_pct from spotify group by genre;

## 3. What is the average duration overall and by genre?
select avg(duration) from spotify;

select genre, avg(duration) from spotify group by genre;

## 4. What % of tracks are explicit?
select round(sum(explicit='TRUE')*100/count(*),2) as explicit_pct from spotify;

## 5. What is the collaboration rate (single vs multi-artist)?
select round(sum(artist_2='None')*100/count(*),2) as collab_rate from spotify;




-- / -- 🎼 II. Genre Intelligence (Competitive Landscape)  --/
## 6. Which genre has the highest average popularity?
select genre, avg(popularity) from spotify group by genre;

## 7. Which genre has the highest median popularity (to remove skew effect)?
WITH ordered AS (
  SELECT popularity, genre,
         ROW_NUMBER() OVER (partition by genre ORDER BY popularity) rn,
         COUNT(*) OVER (partition by genre) total
  FROM spotify
)
SELECT AVG(popularity) AS median_popularity, genre
FROM ordered
WHERE rn IN (FLOOR((total+1)/2), CEIL((total+1)/2)) group by genre order by median_popularity desc;

## 8. Which genre is most consistent (lowest variance in popularity)?
select round(variance(popularity),2) as var, genre from spotify group by genre order by var asc limit 1;

## 9. Which genre shows highest volatility (high risk, high reward)?
select genre, round(variance(popularity),2) as var from spotify group by genre order by var desc limit 1;

## 10. Which genre has high volume but low performance (oversupply)?
select genre, count(*) as total, avg(popularity) as performance from spotify group by genre order by performance asc, total desc limit 1;

## 11. Which genre has low volume but high performance (undervalued niche)?
select genre, count(*) as total, avg(popularity) as performance from spotify group by genre order by performance desc, total asc limit 1;



-- / -- 🎤 III. Artist Power Analysis (Performance Layer)  --/
## 12. Top 10 artists by track count.
with all_artist as (
select artist_1 as artist, popularity from spotify 
union all
select artist_2, popularity from spotify where artist_2 is not null
union all
select artist_3, popularity from spotify where artist_3 is not null
union all
select artist_4, popularity from spotify where artist_4 is not null
union all
select artist_5, popularity from spotify where artist_5 is not null
union all
select artist_6, popularity from spotify where artist_6 is not null
union all
select artist_7, popularity from spotify where artist_7 is not null
union all
select artist_8, popularity from spotify where artist_8 is not null
union all
select artist_9, popularity from spotify where artist_9 is not null
union all
select artist_10, popularity from spotify where artist_10 is not null
union all
select artist_11, popularity from spotify where artist_11 is not null
)
select artist, count(*) as total from all_artist group by artist order by total desc limit 10 offset 2;

## 13. Top 10 artists by average popularity.
with all_artist as (
select artist_1 as artist, popularity from spotify 
union all
select artist_2, popularity from spotify where artist_2 is not null
union all
select artist_3, popularity from spotify where artist_3 is not null
union all
select artist_4, popularity from spotify where artist_4 is not null
union all
select artist_5, popularity from spotify where artist_5 is not null
union all
select artist_6, popularity from spotify where artist_6 is not null
union all
select artist_7, popularity from spotify where artist_7 is not null
union all
select artist_8, popularity from spotify where artist_8 is not null
union all
select artist_9, popularity from spotify where artist_9 is not null
union all
select artist_10, popularity from spotify where artist_10 is not null
union all
select artist_11, popularity from spotify where artist_11 is not null
)
select artist, count(*) as total, avg(popularity) as performance from all_artist group by artist order by performance desc limit 10 offset 2;


## 14. Which artists are consistent vs one-hit wonders? (variance check)
with all_artist as (
select artist_1 as artist, popularity from spotify 
union all
select artist_2, popularity from spotify where artist_2 is not null
union all
select artist_3, popularity from spotify where artist_3 is not null
union all
select artist_4, popularity from spotify where artist_4 is not null
union all
select artist_5, popularity from spotify where artist_5 is not null
union all
select artist_6, popularity from spotify where artist_6 is not null
union all
select artist_7, popularity from spotify where artist_7 is not null
union all
select artist_8, popularity from spotify where artist_8 is not null
union all
select artist_9, popularity from spotify where artist_9 is not null
union all
select artist_10, popularity from spotify where artist_10 is not null
union all
select artist_11, popularity from spotify where artist_11 is not null
)
select artist, count(*) as total, variance(popularity) as var from all_artist group by artist order by var desc;

## 15. Which artists dominate top 10% tracks?
with ranked as (select *, ntile(10) over (order by popularity desc) as track_decile from spotify),
all_artist as (
select artist_1 as artist, track_decile from ranked 
union all
select artist_2, track_decile from ranked where artist_2 is not null
union all
select artist_3, track_decile from ranked where artist_3 is not null
union all
select artist_4, track_decile from ranked where artist_4 is not null
union all
select artist_5, track_decile from ranked where artist_5 is not null
union all
select artist_6, track_decile from ranked where artist_6 is not null
union all
select artist_7, track_decile from ranked where artist_7 is not null
union all
select artist_8, track_decile from ranked where artist_8 is not null
union all
select artist_9, track_decile from ranked where artist_9 is not null
union all
select artist_10, track_decile from ranked where artist_10 is not null
union all
select artist_11, track_decile from ranked where artist_11 is not null
)
select artist, count(*) as top10 from all_artist where track_decile=1 group by artist order by top10 desc;

## 16. Pareto test: Do 20% of artists drive 80% of hits?
with artist_hits as (
select artist_1 as artist, count(*) as hits from spotify group by artist_1
union all
select artist_2, count(*) from spotify where artist_2 is not null group by artist_2
union all
select artist_3, count(*) from spotify where artist_3 is not null group by artist_3
union all
select artist_4, count(*) from spotify where artist_4 is not null group by artist_4
union all
select artist_5, count(*) from spotify where artist_5 is not null group by artist_5
union all
select artist_6, count(*) from spotify where artist_6 is not null group by artist_6
union all
select artist_7, count(*) from spotify where artist_7 is not null group by artist_7
union all
select artist_8, count(*) from spotify where artist_8 is not null group by artist_8
union all
select artist_9, count(*) from spotify where artist_9 is not null group by artist_9
union all
select artist_10, count(*) from spotify where artist_10 is not null group by artist_10
union all
select artist_11, count(*) from spotify where artist_11 is not null group by artist_11
),
combined as (select artist, sum(hits)as total from artist_hits group by artist),
ranked as (select artist, total, sum(total) over(order by total desc) cum_hits,
sum(total) over() as nett from combined)
select * from ranked where cum_hits<=nett*0.8;

## 17. Do collaborations perform better than solo tracks?
select case when artist_2<>'None' then 'Collab' else 'Solo' end as track_type, avg(popularity) as pop from spotify group by track_type;



-- / -- 💿 IV. Album Strategy (Product Portfolio Thinking)  --/
## 18. Do albums with more tracks have higher or lower average popularity?
select album, count(*) as tracks, avg(popularity) as pop from spotify group by album order by tracks desc;

## 19. Which albums are most consistent in performance?
select round(variance(popularity),2) as var, album from spotify group by album order by var asc;

## 20. Which albums are dependent on one viral track?
select album, max(popularity), avg(popularity) from spotify group by album order by (max(popularity) - avg(popularity)) desc;

## 21. Longest albums vs most popular albums — any relationship?
select sum(duration) as length, avg(popularity) as pop from spotify group by album order by length desc, pop desc;




-- / -- ⏱ V. Duration & Attention Economy  -- /
## 22. What duration range dominates the dataset?
select case when duration < 100000 then 'Short' when duration<200000 then 'Mid' else 'Long' end as duration_range, count(*) as tracks from spotify group by duration_range order by tracks desc; 

## 23. Which duration range produces highest average popularity?
select case when duration < 100000 then 'Short' when duration<200000 then 'Mid' else 'Long' end as duration_range, avg(popularity) as pop from spotify group by duration_range order by pop desc; 

## 24. Are shorter songs statistically more successful?
select case when duration < 100000 then 'Short' when duration<200000 then 'Mid' else 'Long' end as duration_range, avg(popularity) as pop from spotify group by duration_range; 

## 25. Popularity vs duration correlation strength?
select 
(count(*)*sum(duration*popularity) - sum(duration)*sum(popularity)) / 
sqrt((count(*)*sum(pow(duration,2)) - pow(sum(duration),2)) * (count(*)*sum(pow(popularity,2)) - pow(sum(popularity),2)))
 as corr from spotify where duration is not null and popularity is not null;




-- / -- 🔞 VI. Explicit Content Strategy  --/
## 26. Do explicit tracks outperform non-explicit tracks?
select explicit, avg(popularity) as pop from spotify group by explicit;

## 27. Which genres rely most on explicit content?
select genre, round(sum(explicit='TRUE')*100/count(*),2) as explicit_rate from spotify group by genre order by explicit_rate desc;

## 28. Does explicit content work better in certain genres only?
select genre, explicit, avg(popularity) as pop from spotify group by genre, explicit order by pop desc;


select * from spotify;

-- / -- 🧠 VII. Hit Profiling (Advanced Synthesis)  --/
## 29. What defines the Top 10% tracks?
-- * Genre pattern
-- * Avg duration
-- * Explicit rate
-- * Collaboration rate

with ranked as (select *, ntile(10) over(order by popularity desc) as track_decile from spotify)
select genre, avg(duration) as tenure, avg(explicit) as explicit_rate, count(*) as total from ranked where track_decile=1 group by genre order by tenure desc;


## 30. If you had to build a “High Impact Playlist”, which tracks qualify based on multi-factor scoring?
select name, (popularity*0.6) + (case when explicit='TRUE' then 5 else 0 end) + 
(case when duration between 150000 and 250000 then 5 else 0 end) as hit_score from spotify order by hit_score desc limit 10;
