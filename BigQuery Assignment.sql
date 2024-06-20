CREATE OR REPLACE TABLE `hybrid-matrix-425011-p9.imdb_new_dataset.movies_details` AS (
  SELECT 
    tb.tconst, tb.original_title as movie_name,tr.num_votes as total_votes, tb.start_year as release_year, tb.genres, tr.average_rating, tp.nconst, nb.primary_name as director_name, tp.characters as Main_Character, tp.category as Profession
  FROM
    `bigquery-public-data.imdb.title_basics` AS tb
  JOIN
    `bigquery-public-data.imdb.title_ratings` AS tr
  USING
    (tconst)
  JOIN
    `bigquery-public-data.imdb.title_crew` AS tc
  USING
    (tconst)
  JOIN
    `bigquery-public-data.imdb.title_principals` AS tp
  USING
    (tconst)
  JOIN
    `bigquery-public-data.imdb.name_basics` AS nb
  ON
    tp.nconst = nb.nconst
  WHERE 
    tb.title_type = 'movie' AND tb.genres IS NOT NULL AND tc.directors IS NOT NULL AND tp.characters IS NOT NULL 
);

select distinct * from `hybrid-matrix-425011-p9.imdb_new_dataset.movies_details`;

select distinct movie_name,total_votes,average_rating,release_year,genres from `hybrid-matrix-425011-p9.imdb_new_dataset.movies_details` ORDER BY average_rating DESC, total_votes DESC limit 10;

select genres, count(*) as total_movie_count
from
  `hybrid-matrix-425011-p9.imdb_new_dataset.movies_details`
group by genres order by total_movie_count desc;

select
  director_name, count(*) as total_movies_directed
from
  `hybrid-matrix-425011-p9.imdb_new_dataset.movies_details`
group by director_name order by total_movies_directed desc;

CREATE OR REPLACE VIEW `hybrid-matrix-425011-p9.imdb_new_dataset.movies_details_view` AS (
  SELECT 
    tb.tconst, tb.original_title as movie_name,tr.num_votes as total_votes, tb.start_year as release_year, tb.genres, tr.average_rating, tp.nconst, nb.primary_name as director_name, tp.characters as Main_Character, tp.category as Profession
  FROM
    `bigquery-public-data.imdb.title_basics` AS tb
  JOIN
    `bigquery-public-data.imdb.title_ratings` AS tr
  USING
    (tconst)
  JOIN
    `bigquery-public-data.imdb.title_crew` AS tc
  USING
    (tconst)
  JOIN
    `bigquery-public-data.imdb.title_principals` AS tp
  USING
    (tconst)
  JOIN
    `bigquery-public-data.imdb.name_basics` AS nb
  ON
    tp.nconst = nb.nconst
  WHERE 
    tb.title_type = 'movie' AND tb.genres IS NOT NULL AND tc.directors IS NOT NULL AND tp.characters IS NOT NULL 
);
