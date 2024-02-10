CSE532 A1
Dukyoung Eom 111309287

3a. The query showed that 4pm has the peak of collisions based on all days in the year of 2017.
MONTH		HOUR		COLLISIONS
All Months	All Hours		230992
6		All Hours		21369
5		All Hours		21012
10		All Hours		20358
12		All Hours		19715
11		All Hours		19660
9		All Hours		19604
7		All Hours		19593
3		All Hours		19334
8		All Hours		19133
4		All Hours		17828
1		All Hours		17551
All Months	16		16973	--> This line indicates the peak hour of collisions.
All Months	17		16691
2		All Hours		15835
All Months	14		15753
All Months	15		14675
All Months	18		14280
All Months	13		13612
All Months	8		12955
All Months	12		12634
All Months	9		12348
All Months	11		12092
All Months	10		11662
All Months	19		11570
All Months	20		9410
All Months	0		8379
All Months	21		7952
All Months	7		7348
All Months	22		7318
All Months	23		5893
All Months	6		4954
All Months	1		3586
All Months	5		3127
All Months	4		2765
All Months	2		2663
All Months	3		2352


3c. 
ZIP_CODE	LONGITUDE	LATITUDE		COLLISIONS	COLLISION_RANK
10459	-73.89083	40.820305	115		1
11201	-73.98453	40.696033	107		2
10474	-73.882744	40.816864	89		3
10018	-73.99926	40.759514	86		4
10036	-73.99595	40.75898		84		5		-> this has wrong zipcode. it is supposed to be 10018 based on the geo-coordinates
10453	-73.91282	40.861862	79		6
10012	-73.99404	40.72032		76		7 		-> this has wrong zipcode. it is supposed to be 10002 based on the geo-coordinates
10036	-73.99832	40.760822	76		7
10012	-73.992615	40.724136	75		9		-> this has wrong zipcode. it is supposed to be 10002 based on the geo-coordinates
10022	-73.96434	40.7606		70		10


Extra credit E2.

q2 query output on COLLISION_ALL table :
ZIP	COLLISIONS	COLLISION_RANK	POPULATION	POPULATION_RANK
11385	17430		6		100132		4
11236	18665		3		97714		8
11234	17530		5		95610		10
-> The result is almost same as the collision rank followed the same order through 11236, 11234 and 11385 but, Zipcode 11226 is excluded when query executed on COLLISION_ALL table.

q3 query output on COLLISION_ALL table :
ZIP_CODE	LONGITUDE	LATITUDE		COLLISIONS	COLLISION_RANK
11201	-73.9845292	40.6960346	587		1
11201	-73.98453	40.696033	513		2
10453	-73.91282	40.861862	478		3
10022	-73.9643142	40.7606005	474		4
10036	-73.9897922	40.7572323	456		5
11207	-73.8968533	40.6757357	435		6
10459	-73.89083	40.820305	428		7
11207	-73.8906229	40.6585778	418		8	-> this has wrong zipcode. it is supposed to be 11239 based on the geo-coordinates
10474	-73.882744	40.816864	405		9
10036	-73.99595	40.75898		382		10	-> this has wrong zipcode. it is supposed to be 10018 based on the geo-coordinates
-> The result did not remain the same, The Collision rank has been affected a lot by using a dataset that was collected from 2012 to 2023.
However, some of the places are still in top 10 dangerous location, which are 11201 (-73.98453, 40.696033), 10453 (-73.91282 ,40.861862), 10459 (-73.89083, 40.820305), 10474 (-73.882744, 40.816864), 10036 (-73.99595, 40.75898)

eq1.sql.
YEAR	MONTH		HOUR		COLLISIONS
All Years	All Months	All Hours		2025617
2018	All Months	All Hours		231564
2017	All Months	All Hours		231007
2016	All Months	All Hours		229831
2015	All Months	All Hours		217693
2019	All Months	All Hours		211486
2014	All Months	All Hours		206033
2013	All Months	All Hours		203740
All Years	7		All Hours		184871
All Years	8		All Hours		182200
All Years	10		All Hours		179850
All Years	9		All Hours		177013
All Years	6		All Hours		173737
All Years	5		All Hours		172559
All Years	12		All Hours		171405
All Years	11		All Hours		170691
All Years	3		All Hours		161836
All Years	1		All Hours		156552
All Years	4		All Hours		150227
All Years	All Months	16		146337	-> still 4pm is the peak collision time.
All Years	2		All Hours		144676
All Years	All Months	17		143133
All Years	All Months	14		135457
All Years	All Months	15		126871
All Years	All Months	18		125846
All Years	All Months	13		117243
2020	All Months	All Hours		112916
All Years	All Months	12		111569
All Years	All Months	8		111213
2021	All Months	All Hours		110548
All Years	All Months	9		107621
All Years	All Months	11		104899
2022	All Months	All Hours		103869
All Years	All Months	19		102960
2012	All Months	All Hours		100545
All Years	All Months	10		100516
All Years	All Months	20		85977
All Years	All Months	21		72882
All Years	All Months	22		66456
2023	All Months	All Hours		66385

based on all the collision data collected from 2012 through 2023, it indicated that 4pm is still the most dangerous hour in the day.