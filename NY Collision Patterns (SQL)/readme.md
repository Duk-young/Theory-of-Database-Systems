(Total: 10 points; extra credit: 2 points)

In this homework, we will use two datasets:

a) NYPD Motor Vehicle Collisions (collision)

A downloaded copy of 2017 data (48MB) can be downloaded here. 

b) Population data for zip codes in New York State (census)

The data can be downloaded here. (columns: rank, population_density, zip, population)

Create collision table and load data (1 point)
1a. Create a "Collision" table with following information.

cse532.collision (date, time, zip_code, latitude, longitude, contributing_factor_vehicle1, contributing_factor_vehicle2,  unique_key, vehicle_type_code_1, vehicle_type_code_2). unique_key is the primary key. Note that you have to define data types with size big enough to store the data. 

Store the SQL in a file hw1createcollisiontable.sql.

1b. Load data from the 2017 collision file by modifying the loading script hw1collisionloadingscript.sql with correct file path, and running it from db2 command line "db2cmd":

e.g.: db2 -tf  "C:\\Teaching\CSE532Fall2023\homework\homework1\hw1collisionloadingscript.sql"

(Note: Db2 load cmd can't skip CSV header line. It will generate a warning, which can be ignored. Alternatively, you can use Db2 import cmd, which can specify "SKIPCOUNT 1" to skip head line. )

Create census table and load data (1 point)
2a. Create a zipcensustable with following information.

cse532.zipcensus (rank, population_density, zip, population), where zip is the primary key.

Store the SQL in a file hw1createzipcensus.sql.

2b. Load the data from the census file by creating a load script (hw1zipcensusloading.sql).

You can remove the head line from the data file before loading. 

Write following queries (8 points)
3. Write following queries.

3a (2 points). Find hourly (24 hours) and monthly (12 months) counts of collision using CUBE based OLAP query (hw1q1.sql). Identify which hour in the day (based on all days in the year) has the peak of collision (put in readme.txt file). 

3b (3 points). For zip codes with top 10 populations, find if any of them has collision count among top 10 counts too (hw1q2.sql).

(Please DO NOT use FETCH .. ROWS ONLY statement. Use RANK instead. )

3c (3 points). For top 10 most dangerous locations (latitude, longitude) with highest collision counts, find their zip codes. Exclude all records with NULL value for latitude, longitude, or zip code (hw1q3.sql). 

(You can use FETCH .. ROWS ONLY for top 10)

Check if there are mistakes in zip codes (i.e., same location but different zip codes) for the top 10 most dangerous locations. You can verify at https://www.gps-coordinates.net/ to see which one is not correct - put result in readme.txt file. 

Extra Credit (2 points)
Download all the collision data  (420MB) using "Export".  

E1. Create table cse532.collision_all (ecreatecollisiontable.sql) with same fields, and create indexes needed to accelerate the queries (put in the same file).

E2. Run q2 and q3 queries above and check the results remain the same (discuss in readme.txt file). 

For q1 (eq1.sql), the new query is updated to: find hourly (24 hours), monthly (12 months) and yearly counts of collision using CUBE based OLAP query, Identify which hour in the day (based on all days in the year) has the peak of collision (put in readme.txt file).