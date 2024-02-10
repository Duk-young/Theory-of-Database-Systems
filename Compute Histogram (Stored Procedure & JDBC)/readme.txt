CSE532 A2 - 111309287 Dukyoung Eom 

1. Open command prompt and navigate to directory that has SalaryHistogram.java

2. If you have db2 installed, locate the db2jcc4.jar (db2 jdbc Driver). It is typically located in the path below:
	---> C:\Program Files\IBM\SQLLIB\java\db2jcc4.jar"

3. Complie SalaryHistogram.java using the command below:
	javac -cp "[Your directory path to db2jcc4.jar]" SalaryHistogram.java
	
	for example, I used following command:
	javac -cp "C:\Program Files\IBM\SQLLIB\java\db2jcc4.jar" SalaryHistogram.java

4. Execute the program with the following command :
	java SalaryHistogram <dburl> <username> <password> <start_value> <end_value> <bin_numbers>

	for example, I used following command:
	java SalaryHistogram jdbc:db2://127.0.0.1:25000/CSE532 db2admin some_password 30000 170000 7

5. Check the output in the command line.

	Successfully connected to jdbc:db2://127.0.0.1:25000/CSE532
	BINNUM: 1, FREQUENCY: 22, BINSTART: 30000.0, BINEND: 50000.0
	BINNUM: 2, FREQUENCY: 11, BINSTART: 50000.0, BINEND: 70000.0
	BINNUM: 3, FREQUENCY: 5, BINSTART: 70000.0, BINEND: 90000.0
	BINNUM: 4, FREQUENCY: 3, BINSTART: 90000.0, BINEND: 110000.0
	BINNUM: 5, FREQUENCY: 0, BINSTART: 110000.0, BINEND: 130000.0
	BINNUM: 6, FREQUENCY: 0, BINSTART: 130000.0, BINEND: 150000.0
	BINNUM: 7, FREQUENCY: 1, BINSTART: 150000.0, BINEND: 170000.0