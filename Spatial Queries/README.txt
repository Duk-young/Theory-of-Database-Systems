4. (1 point) Drop all indexes and perform the two queries again, and compare the query performance in terms of execution time for above two queries. 

Query time for nearester.sql (without indexes)
2023-11-01 18:35:00.711000 - 2023-11-01 18:35:00.356000
= 0.355 seconds

Query time for nearester.sql (with indexes)
2023-11-01 18:31:07.546000 - 2023-11-01 18:31:07.460000
= 0.086 seconds

Query time for noerzips.sql (without indexes)
2023-11-01 19:14:20.327000 - 2023-11-01 19:13:20.028000
= 60.299 seconds

Query time for noerzips.sql (with indexes)
2023-11-01 19:11:01.591000 - 2023-11-01 19:10:23.504000
= 38.087 seconds


Here we can observe the fact that proper index reduced querytime significantly, meaning it is important to set up the indexes
for efficient data access. This fact also highlights the importance of indexing for queries that are run on large datasets or run frequently.
