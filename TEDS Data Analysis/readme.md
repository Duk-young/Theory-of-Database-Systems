Homework 4. In this homework, you will analyze the Treatment Episode Data Set (Admissions), a national data system of annual admissions to substance use treatment facilities.  TEDS-A keeps track of people aged 12 and older entering substance use treatment each year. It gives details about who they are (like age, gender, and job status) and their substance use habits (types of substances, when they started, how often, etc.). Note that the records represent admissions, not unique individuals, as someone might go through treatment more than once.

Dataset 
We will focus on the the datasets from 2000-2019. The dataset can be downloaded at TEDS-A-2000-2019-DS0001-bndl-data-csv_v1.zip (616MB, original csv file 5.37GB). The documentation on the dataset can be found in the cookbook. A sample of the data (sample.zip, 9MB) can be downloaded at Google drive. Missing values are usually represented as "-9".

Please use the sample dataset for developing purpose, and generate the final result with the original dataset. 

Pseudo-Distributed Hadoop And Spark
This is just to warm you up. In reality, Hadoop and Spark are usually deployed over actual distributed cluster nodes. However, for the purpose of this course and to get an idea of the environment, we're starting with a local single node Hadoop and Spark setup (following instructions on setting up a single node Hadoop/Spark.)


Analysis
We would like to understand the yearly (ADMYR - Year of admission) trends of people at different age groups who were admitted for substance use disorder treatment. The age groups (AGE) are defined on page 11 of the cookbook, with 12 distinct age groups: 12-14 (labeled as 1), 15-17 (2), ...., 65 and older (12).    i.e., we would like to have a "group by" like count of the admissions based on (age group, year).  

Task Requirements
[4 points] Your first task is to perform simple processing on the provided TED-A dataset.

Write Hadoop code to find the count of admissions for each age group and for each year in the dataset, sorted by Age and Year. 

Name your code/program AgeYearCount.java 

Program arguments

The HDFS path to your input dataset

The HDFS output path for your program (NOTE: You should remove the output path after every execution of your program. Hadoop cannot start a job if output directory is already created)

Output format

Age <TAB> Year <TAB> count



# Example ( with faked counts)

1	2000	30,000

1	2001	28,000

1   2002    27,700 

[3 points] Write Hadoop code to find unique Core Based Statistical Areas (column CBSA2010: cookbook page 2010) covered by the dataset. Core Based Statistical Area (CBSA) is a collective term for both metro and micro areas. For example, '35620" represents 'New York-Newark-Jersey City, NY-NJ-PA', '10580' represents 'Albany-Schenectady-Troy, NY'. 

(NOTE: Search for and look into the concepts of identity mapper and reducer in Hadoop)

Name your code/program UniqueCBSA.java

Program arguments

The HDFS path to your input dataset

The HDFS output path for your program (NOTE: You should remove the output path after every execution of your program. Hadoop cannot start a job if output directory is already created)

Output format

19820

-9

45820

...

[3] Write Spark code for 1, with a language of your preferred choice {java, py, scala}.

Name your code/program SparkAgeYearCount.{java, py, scala} based on your language of implementation


Examples
To execute Hadoop jobs using Java API (Terminal Commands)

hadoop jar hw4.jar AgeYearCount /cse532-f23/input /cse532-f23/output/

To view output (Terminal Commands)

(list contents of HDFS output directory)

hdfs dfs -ls /cse532-f23/output/

(print out the contents of output files to terminal)

hdfs dfs -cat /cse532-f23/output/part-*

To execute Spark jobs using Java API (Terminal Commands)

spark-submit --class SparkAgeYearCount hw4.jar /cse532-f23/input /cse532-s23/output

To execute Spark jobs using Python API (Terminal Commands)

spark-submit SparkAgeYearCount.py /cse532-f23/input /cse532-s23/output





[Extra Credit: 5 points] Google Cloud Platform Dataproc (GCP Dataproc)
In real world, distributed systems such as Hadoop and Spark come in handy when you have to process huge amounts of data. Processing such data on local machines is prohibitive unless you are working on Super Computers. The good news, however, is that the code written for pseudo distributed mode can safely be considered deployable (in most cases) on actual distributed cluster without much modifications.

Task Requirements  
In this task you will need to process this dataset on an actual distributed cluster. We'll be using Google Cloud Dataproc for this purpose where a lot of deployment and management details have been abstracted for you.

For this task you can write your code either for Hadoop OR Spark, whichever you feel comfortable with

Write code to find top 5 Core Based Statistical Areas (CBSA) in terms of total number of admissions  and identify the year for each of these CBSAs with lowest admissions.    

Name your code/program  SparkTopCountCBSA.{java, py, scala} based on your language of implementation.

Essentially, you can divide this into separate sub tasks

Identify all time top 5 CBSAs with highest number of total admissions

Count per year admissions for each of these CBSAs

Sort per year results and return the year with lowest number of admissions

Cloud Storage Output Location
Use a directory that doesn't exist on Cloud Storage bucket. Otherwise, your job will fail. If you would like to reuse the output directory, please delete the directory from Cloud Storage console.

It is highly recommended that you test your program locally before you run  it on the cloud.