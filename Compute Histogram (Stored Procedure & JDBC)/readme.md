In this homework, you will compute the histogram for employee's salaries from the employee table in DB2 sample database (employee table). If you want to create the table by yourself, you need to create a table employee with this schema and load the sample data into the database first.  You can find examples on stored procedures and JDBC.

A histogram is the probability distribution of a continuous variable, represented by frequencies of the variables falling into a bin. In this homework, your histogram program takes an initial value (inclusive), an end value (exclusive), and the number of bins, e.g., histogram(start, end, number), and it returns a set of bins with bin number, frequency, bin's start value, and bin's end value, i.e., (binnum, frequency, binstart, binend). For example:

binnum frequency binstart binend

1       2        35000 40000

2       3        40000 45000

Q1 (5 points). You will write a stored procedure in SQL/PL (gen_salary_histogram.sql) to implement it. Please consider performance in your implementation. For example, multiple queries on the same table will involve multiple scans, and could lead to slow performance. 

When the stored procedure is called, the histogram is returned and stored in a predefined table. Alternatively, you can return the result as an array. Refer to "Array support in SQL procedures".

To test your code, please use lower bound 30,000, upper bound 170,000, and interval 20,000 to generate a sample result.  

e.g., run the query "call gen_salary_histogram(30000, 170000, 7)"

Q2 (5 points). Implement the same function with a JDBC program SalaryHistogram (not a java stored procedure), with three parameters as arguments (binnum, frequency, binstart, binend), in addition to dbname, login, password. Again, you should consider only querying the table once to generate the result to maximize performance. No built-in aggregation function is allowed.  