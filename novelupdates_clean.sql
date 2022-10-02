-- Cleaning data

----------------------------------------------------------------------

-- Alter Table's Inaccurate Data Type

-- For activity_all_time_rank
ALTER TABLE dbo.NUTable
ALTER COLUMN activity_all_time_rank INT 
GO

-- For activity_month_rank
ALTER TABLE dbo.NUTable
ALTER COLUMN activity_month_rank INT 
GO

-- For activity_week_rank
ALTER TABLE dbo.NUTable
ALTER COLUMN activity_week_rank INT 
GO

-- For on_reading_lists
ALTER TABLE dbo.NUTable
ALTER COLUMN on_reading_lists INT 
GO

-- For rating_votes
ALTER TABLE dbo.NUTable
ALTER COLUMN rating_votes INT 
GO

-- For reading_list_all_time_rank
ALTER TABLE dbo.NUTable
ALTER COLUMN reading_list_all_time_rank INT 
GO

-- For reading_list_month_rank
ALTER TABLE dbo.NUTable
ALTER COLUMN reading_list_month_rank INT 
GO

----------------------------------------------------------------------

-- Store relevant fields in a view and correct errors

 -- Create a new view called 'NUTable_Clean1' in schema 'dbo'
 -- Drop the view if it already exists
 IF EXISTS (
 SELECT *
    FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
    WHERE sys.schemas.name = N'dbo'
    AND sys.views.name = N'NUTable_Clean1'
 )
 DROP VIEW dbo.NUTable_Clean1
 GO
 -- Create the view in the specified schema
 CREATE VIEW dbo.NUTable_Clean1
 AS
    SELECT id, name, authors, 
        CASE WHEN original_language IS NULL THEN 'chinese'      --fills null values with chinese
            ELSE original_language
            END
            AS original_language,
        genres, tags,
        rating, rating_votes, release_freq,
        activity_all_time_rank, activity_month_rank, activity_week_rank,
        on_reading_lists, reading_list_all_time_rank, reading_list_month_rank
    FROM dbo.NUTable
    WHERE release_freq IS NOT NULL                              --delete the data points with no release_freq
        AND NOT (authors='[]')                                  --delete the data points with no authors
 GO

SELECT *
FROM NUTable_Clean1
GO

----------------------------------------------------------------------

-- Create normalized novel.id - author.id table

CREATE TABLE AuthFactTable (novel_id INT, author_id INT)
GO
INSERT INTO AuthFactTable(novel_id, author_id)
    SELECT novel.id AS novel_id, auth.id AS author_id 
    FROM NUTable_Clean1 novel
    LEFT JOIN dbo.AuthorTable auth 
    ON REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(novel.authors,'"',''''),', ','.'),'''', ''),'[','.'),']','.') LIKE N'%.'+auth.author+'.%'
GO

SELECT *
FROM dbo.AuthFactTable
GO

----------------------------------------------------------------------

-- Create normalized novel.id - genre.id table

CREATE TABLE GenreFactTable (novel_id INT, genre_id INT)
GO
INSERT INTO GenreFactTable(novel_id, genre_id)
    SELECT novel.id AS novel_id, gen.id AS genre_id
    FROM NUTable_Clean1 novel
    LEFT JOIN dbo.GenreTable gen
    ON REPLACE(REPLACE(REPLACE(REPLACE(CAST(novel.genres AS NVARCHAR(2000)),', ','.'),'''',''),'[','.'),']','.') LIKE '%.'+gen.genre+'.%'
GO

SELECT *
FROM dbo.GenreFactTable
GO

----------------------------------------------------------------------

-- Create normalized novel.id - tags.id table

CREATE TABLE TagsFactTable (novel_id INT, tags_id INT)
GO
INSERT INTO TagsFactTable(novel_id, tags_id)
    SELECT novel.id AS novel_id, tag.id AS tags_id
    FROM NUTable_Clean1 novel
    LEFT JOIN dbo.TagsTable tag
    ON REPLACE(REPLACE(REPLACE(REPLACE(CAST(novel.tags AS NVARCHAR(4000)),', ','.'),'''',''),'[','.'),']','.') LIKE '%.'+tag.tags+'.%'
GO

SELECT *
FROM dbo.TagsFactTable
GO

----------------------------------------------------------------------

-- Drop Authors, Genres, Tags
-- Then save the query result as csv

SELECT id, name, original_language, rating, rating_votes, release_freq, activity_all_time_rank, activity_month_rank, activity_week_rank,on_reading_lists,reading_list_all_time_rank,reading_list_month_rank
FROM NUTable_Clean1