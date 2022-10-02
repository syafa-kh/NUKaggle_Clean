-- Create a new database called 'ProjectDatabase'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Create the new database if it does not exist already
IF NOT EXISTS (
    SELECT name
        FROM sys.databases
        WHERE name = N'ProjectDatabase'
)
CREATE DATABASE ProjectDatabase
GO

----------------------------------------------------------------------

-- Create a new table called 'NUTable' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.NUTable', 'U') IS NOT NULL
DROP TABLE dbo.NUTable
GO
-- Create the table in the specified schema
CREATE TABLE dbo.NUTable
(
    id INT NOT NULL PRIMARY KEY, -- primary key column
    activity_all_time_rank FLOAT,
    activity_month_rank FLOAT,
    activity_week_rank FLOAT,
    assoc_names NTEXT,
    authors NVARCHAR(500),
    chapter_latest_translated NVARCHAR(50),
    chapters_original_current NVARCHAR(50),
    complete_original FLOAT,
    complete_translated FLOAT,
    english_publisher NVARCHAR(100),
    genres TEXT,
    licensed FLOAT,
    name NTEXT,
    on_reading_lists FLOAT,
    original_language NVARCHAR(100),
    original_publisher NVARCHAR(100),
    rating FLOAT,
    rating_votes FLOAT,
    reading_list_all_time_rank FLOAT,
    reading_list_month_rank FLOAT,
    recommendation_list_ids NVARCHAR(100),
    recommended_series_ids NVARCHAR(100),
    related_series_ids NVARCHAR(100),
    release_freq FLOAT,
    start_year NVARCHAR(50),
    tags TEXT
);
GO

-- Import the file
BULK INSERT dbo.NUTable
FROM 'D:\Portfolio Project\SQL\novelupdates\novels_2022-02.csv'
WITH
(
    FORMAT = 'CSV', 
    FIRSTROW = 2,
    FIELDQUOTE  = '"',
    CODEPAGE = '65001',        -- Added so mssql can read non-alphanumerical standard like chinese characters
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '0x0a',
    TABLOCK
)
GO

-- Select rows from a Table or View 'NUTable' in schema 'dbo'
SELECT * FROM dbo.NUTable       --returns 11953 rows
GO

----------------------------------------------------------------------

-- Create a new table called 'GenreTable' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.GenreTable', 'U') IS NOT NULL
DROP TABLE dbo.GenreTable
GO
-- Create the table in the specified schema
CREATE TABLE dbo.GenreTable
(
    id INT NOT NULL PRIMARY KEY, -- primary key column
    genre NVARCHAR(100)
);
GO

-- Import the file
BULK INSERT dbo.GenreTable
FROM 'D:\Portfolio Project\SQL\novelupdates\genres.csv'
WITH
(
    FORMAT = 'CSV', 
    FIRSTROW = 2,
    FIELDQUOTE  = '"',
    CODEPAGE = '65001',        
    FIELDTERMINATOR = ',',     
    TABLOCK
)
GO

SELECT * FROM dbo.GenreTable
GO

----------------------------------------------------------------------

-- Create a new table called 'TagsTable' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.TagsTable', 'U') IS NOT NULL
DROP TABLE dbo.TagsTable
GO
-- Create the table in the specified schema
CREATE TABLE dbo.TagsTable
(
    id INT NOT NULL PRIMARY KEY, -- primary key column
    tags NVARCHAR(100)
);
GO

-- Import the file
BULK INSERT dbo.TagsTable
FROM 'D:\Portfolio Project\SQL\novelupdates\tags.csv'
WITH
(
    FORMAT = 'CSV', 
    FIRSTROW = 2,
    FIELDQUOTE  = '"',
    CODEPAGE = '65001',        
    FIELDTERMINATOR = ',', 
    TABLOCK
)
GO

SELECT * FROM dbo.TagsTable
GO

----------------------------------------------------------------------

-- Create a new table called 'AuthorTable' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.AuthorTable', 'U') IS NOT NULL
DROP TABLE dbo.AuthorTable
GO
-- Create the table in the specified schema
CREATE TABLE dbo.AuthorTable
(
    id INT NOT NULL PRIMARY KEY, -- primary key column
    author NVARCHAR(400)
);
GO

-- Import the file
BULK INSERT dbo.AuthorTable
FROM 'D:\Portfolio Project\SQL\novelupdates\authors.csv'
WITH
(
    FORMAT = 'CSV', 
    FIRSTROW = 2,
    FIELDQUOTE  = '"',
    CODEPAGE = '65001',        
    FIELDTERMINATOR = ',', 
    TABLOCK
)
GO

-- Select rows from a Table or View 'TableOrViewName' in schema 'SchemaName'
SELECT * FROM dbo.AuthorTable
GO