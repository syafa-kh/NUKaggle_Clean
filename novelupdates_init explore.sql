-- Checking null values and noting what needs to be done to clean the data
-- and which fields are necessary

----------------------------------------------------------------------

-- For activity_all_time_rank
-- Issue: for some reason mssql wont accept it as int, so we need to know why

SELECT COUNT(*) FROM dbo.NUTable        --returns 0 row
WHERE activity_all_time_rank IS NULL
GO

SELECT COUNT(*) FROM dbo.NUTable
WHERE activity_all_time_rank!=FLOOR(activity_all_time_rank)     --returns 0 row
GO

-- Therfore we can later on change the data type to int
-- to better reflect the field data

----------------------------------------------------------------------

-- For activity_month_rank

SELECT COUNT(*) FROM dbo.NUTable        --returns 0 row
WHERE activity_month_rank IS NULL
GO

SELECT COUNT(*) FROM dbo.NUTable
WHERE activity_month_rank!=FLOOR(activity_month_rank)     --returns 0 row
GO

----------------------------------------------------------------------

-- For activity_month_rank

SELECT COUNT(*) FROM dbo.NUTable        --returns 0 row
WHERE activity_week_rank IS NULL
GO

SELECT COUNT(*) FROM dbo.NUTable
WHERE activity_week_rank!=FLOOR(activity_week_rank)     --returns 0 row
GO

----------------------------------------------------------------------

-- For assoc_names

SELECT COUNT(*) FROM dbo.NUTable        --returns 161 rows
WHERE assoc_names IS NULL
GO

SELECT * FROM dbo.NUTable 
WHERE assoc_names IS NULL
GO

-- There are nulls, need quite complicated cleaning, and not useful
-- Better to be dropped

----------------------------------------------------------------------

-- For authors

SELECT COUNT(*) FROM dbo.NUTable        --returns 0 row
WHERE authors IS NULL
GO

SELECT authors FROM dbo.NUTable      
GO

SELECT authors FROM dbo.NUTable
WHERE authors='[]'                      --returns 47 rows
GO

-- There are nulls but not many, so we will eliminate the rows
-- and some multi-values which need to be cleaned

----------------------------------------------------------------------

-- For chapter_latest_translated

SELECT COUNT(*) FROM dbo.NUTable        --returns 1038 rows
WHERE chapter_latest_translated IS NULL
GO

SELECT rating,rating_votes FROM dbo.NUTable 
WHERE chapter_latest_translated IS NULL
    AND (rating IS NULL OR rating_votes IS NULL)
GO

-- The nulls are mostly likely caused by the translation group deleting their submission to NU,
-- but their ratings are still usable
-- Either drop the field or the null rows

----------------------------------------------------------------------

-- For chapters_original_current

SELECT COUNT(*) FROM dbo.NUTable        --returns 1553 rows
WHERE chapters_original_current IS NULL
GO

SELECT * FROM dbo.NUTable
WHERE chapters_original_current IS NOT NULL
GO

-- There are quite a lot of nulls and the non-null values also need complicated cleaning
-- Better to drop this field

----------------------------------------------------------------------

-- For complete_original

SELECT COUNT(*) FROM dbo.NUTable        --returns 494 rows
WHERE complete_original IS NULL
GO

SELECT name, complete_original, chapters_original_current, complete_translated, chapter_latest_translated 
FROM dbo.NUTable       
WHERE complete_original IS NULL         --returns 494 rows
    AND chapters_original_current IS NULL
GO

SELECT name, complete_original, chapters_original_current, complete_translated, chapter_latest_translated 
FROM dbo.NUTable       
WHERE complete_original IS NULL         --returns 0 rows
    AND chapters_original_current IS NOT NULL
GO

-- complete_original null -> chapters_original_current null
-- Better off dropping this field

----------------------------------------------------------------------

-- For complete_translated

SELECT COUNT(*) FROM dbo.NUTable        --returns 2513 rows
WHERE complete_translated IS NULL
GO

SELECT name, complete_original, chapters_original_current, complete_translated, chapter_latest_translated 
FROM dbo.NUTable       
WHERE complete_translated IS NULL         --returns 189 rows
    AND chapter_latest_translated IS NULL
GO

SELECT name, complete_original, chapters_original_current, complete_translated, chapter_latest_translated 
FROM dbo.NUTable       
WHERE complete_translated IS NULL         --returns 2324 rows
    AND chapter_latest_translated IS NOT NULL
GO

-- There are too many nulls
-- And without the 3 fields before it wouldnt give much insight
-- Better be dropped

----------------------------------------------------------------------

-- For complete_translated

SELECT COUNT(*) FROM dbo.NUTable        --returns 10513 rows
WHERE english_publisher IS NULL
GO

-- Too many nulls
-- Better be dropped

----------------------------------------------------------------------

-- For genres

SELECT COUNT(*) FROM dbo.NUTable        --returns 0 row
WHERE genres IS NULL
GO

SELECT genres FROM dbo.NUTable
GO

-- No nulls but some multi-values which need to be cleaned

----------------------------------------------------------------------

-- For licensed

SELECT COUNT(*) FROM dbo.NUTable        --return 5992 rows
WHERE licensed IS NULL
GO

-- Too much nulls and not necessary for analysis
-- Better dropped

----------------------------------------------------------------------

-- For name

SELECT COUNT(*) FROM dbo.NUTable        --return 0 rows
WHERE name IS NULL
GO

----------------------------------------------------------------------

-- For on_reading_lists

SELECT COUNT(*) FROM dbo.NUTable        --return 0 rows
WHERE on_reading_lists IS NULL
GO

SELECT * FROM dbo.NUTable
WHERE on_reading_lists!=FLOOR(on_reading_lists) --return 0 row
GO

-- Data type needs to be changed into int

----------------------------------------------------------------------

-- For original_language

SELECT COUNT(*) FROM dbo.NUTable        --return 45 rows
WHERE original_language IS NULL
GO

SELECT name,authors FROM dbo.NUTable
WHERE original_language IS NULL
GO

-- There are nulls, but based on title and authors it seems
-- like all of them are chinese novels

----------------------------------------------------------------------

-- For original_publisher

SELECT COUNT(*) FROM dbo.NUTable        --return 1130 rows
WHERE original_publisher IS NULL
GO

SELECT name,authors,original_language FROM dbo.NUTable
WHERE original_publisher IS NULL
GO

-- Quite a lot of missing values
-- Maybe better be dropped

----------------------------------------------------------------------

-- For rating

SELECT COUNT(*) FROM dbo.NUTable        --return 0 rows
WHERE rating IS NULL
GO

----------------------------------------------------------------------

-- For rating_votes

SELECT COUNT(*) FROM dbo.NUTable        --return 0 rows
WHERE rating_votes IS NULL
GO

SELECT * FROM dbo.NUTable
WHERE rating_votes!=FLOOR(rating_votes) --return 0 row
GO

-- Data type needs to be changed into int

----------------------------------------------------------------------

-- For reading_list_all_time_rank

SELECT COUNT(*) FROM dbo.NUTable        --return 0 rows
WHERE reading_list_all_time_rank IS NULL
GO

SELECT * FROM dbo.NUTable
WHERE reading_list_all_time_rank!=FLOOR(reading_list_all_time_rank) --return 0 row
GO

-- Data type needs to be changed into int

----------------------------------------------------------------------

-- For reading_list_month_rank

SELECT COUNT(*) FROM dbo.NUTable        --return 0 rows
WHERE reading_list_month_rank IS NULL
GO

SELECT * FROM dbo.NUTable
WHERE reading_list_month_rank!=FLOOR(reading_list_month_rank) --return 0 row
GO

-- Data type needs to be changed into int

----------------------------------------------------------------------

-- For recommendation_list_ids
-- We dont have the recommendation list table for NU, so this is useless
-- and better be dropped

----------------------------------------------------------------------

-- For recommended_series_ids
-- Not necessary
-- Better be dropped

----------------------------------------------------------------------

-- For related_series_ids
-- Not necessary
-- Better be dropped

----------------------------------------------------------------------

-- For release_freq

SELECT COUNT(*) FROM dbo.NUTable        --return 14 rows
WHERE release_freq IS NULL
GO

SELECT name,chapter_latest_translated from dbo.NUTable
WHERE release_freq IS NULL
    -- AND chapter_latest_translated IS NOT NULL
GO

-- Some null values: Novels are either hidden, deleted, or only has 1 chapter uploaded (oneshot or abandoned)
-- Drop rows

----------------------------------------------------------------------

-- For start_year

SELECT COUNT(*) FROM dbo.NUTable        --return 1793 rows
WHERE start_year IS NULL
GO

SELECT * FROM dbo.NUTable
WHERE start_year IS NULL
GO

-- Quite a lot of nulls and not quite necessary
-- Drop field

----------------------------------------------------------------------

-- For tags

SELECT COUNT(*) FROM dbo.NUTable        --return 0 rows
WHERE tags IS NULL
GO

----------------------------------------------------------------------

-- So the data which will be included in the final table is:
-- id
-- name
-- authors
-- original_language
-- genres
-- tags
-- rating
-- rating_votes
-- release_freq
-- activity_all_time_rank
-- activity_month_rank
-- activity_week_rank
-- on_reading_lists
-- reading_list_all_time_rank
-- reading_list_month_rank