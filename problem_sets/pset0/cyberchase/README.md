## Link to detailed description of the exercise : 

https://cs50.harvard.edu/sql/psets/0/cyberchase/


## Each database has some “schema”—the tables and columns into which the data is organized. In cyberchase.db you’ll find a single table, episodes. In the episodes table, you’ll find the following columns:

1. id, which uniquely identifies each row (episode) in the table
2. season, which is the season number in which the episode aired
3. episode_in_season, which is the episode’s number within its given season
4. title, which is the episode’s title
5. topic, which identifies the ideas the episode aimed to teach
6. air_date, which is the date (expressed as YYYY-MM-DD) on which the episode “aired” (i.e., was published)
7. production_code, which is the unique ID used by PBS to refer to each episode internally


## You can optionally attempt the below queries, which may require some advanced knowledge!

1. Write a SQL query to find the titles of episodes that have aired during the holiday season, usually in December in the United States.
    - Your query should output a table with a single column for the title of each episode.
    - Try to find a better solution than LIKE if you can!

2. Write a SQL query to find, for each year, the first day of the year that PBS released a Cyberchase episode.
    - Your query should output a table with two columns, one for the year and one for the earliest month and day an episode was released that year.
