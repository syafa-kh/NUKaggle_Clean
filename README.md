# NovelUpdates Data Cleaning in SQL

This repository is made based on data from [NovelUpdates](novelupdates.com), an archive for international fan-translated novels, accessed from [this kaggle dataset](https://www.kaggle.com/datasets/debanganthakuria/novelupdates-dataset). The codes posted here aim to standardize and clean the data provided, explore which features are necessary to make various analysis about these novels, and ultimately showcase my data cleaning skill both in SQL (and Python).


# Files

This repository provides 1 Python Notebook code, 3 SQL Scripts, and 8 CSV files. 

## novelupdates_table.ipynb

Since the raw dataset (**novels_2022-02.csv**) has 3 fields which originally consisted of string arrays but was stored in local MSSQL database as strings, it would be quite hard to do the cleaning entirely in native SQL without any help. This notebook will produce 3 CSVs which list every unique string in authors (**authors.csv**), genres (**genres.csv**), and tags (**tags.csv**). Those files then would be inserted as tables into the database and used to construct many-to-many fact tables between each tables' ids and novel's ids.

## novelupdates_setup table.sql

This SQL script records the queries used to create the necessary tables and import the CSV files using BULK INSERT command.

## novelupdates_init explore.sql

Initial exploration detailed in this script was done to see whether there are any *nulls* in each columns and what can be done with it in the next step: whether it's better to delete the rows with missing values, drop the entire field, or maybe manageable enough to fill in manually.

## novelupdates_clean.sql

This script was used to implement the cleaning steps and methods decided upon initial exploration. The cleaning procedures resulted in 4 tables which later exported as CSV files: **author_fact_table.csv**, **genres_fact_table.csv**, **tags_fact_table.csv**, and **novels_clean_table**. 


# Visualization

The CSV files in this repository then used to create a visual report about romance novels (which is one of the most common genres in NovelUpdates) using Tableau Public Desktop and can be access [here](https://public.tableau.com/app/profile/syafaatulkhayati/viz/ReportsonRomanceNovelStatusastheMostTranslatedGenreinNovelUpdates/Dashboard1).
