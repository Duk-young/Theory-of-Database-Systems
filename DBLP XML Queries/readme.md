DBLP is a computer science bibliography website that collects published papers, including journal papers, conference papers, etc. We will use two XML documents from dblp: John L. Hennessy  (XML) and David A. Patterson (XML). 

If the XML is not formed, you can manually change it by yourself. e.g., replace "&" with "&amp;". 

(Some example queries from course lectures can be found in XQueryExamples.zip.)

Hennessy and Patterson were recognized with the Turing Award in 2017 for “pioneering a systematic, quantitative approach to the design and evaluation of computer architectures with enduring impact on the microprocessor industry.” 

We will write following XML queries using Oxygen XML (instructions on using Oxygen XML).  We assume author names are unique.  (10 points)

(4 points) Write an XQuery to return for each year (sorted in ascending order) : 1) the count of papers and 2) the average number of co-authors per paper by David A. Patterson ("David A. Patterson 0001") . (q1.xquery.  

(6 points) Write an XQuery to return the title of the paper published by  John L. Hennessy ("John L. Hennessy") that has most co-authors (q2.xquery). 

Hint: We assume there are no ties. You may have multiple steps in your query. You can generate a result of counts sorted in descending order as a sequence. Then you can limit to return one result from the sequence using "[position() le 1]". Refer to  https://en.wikibooks.org/wiki/XQuery/Limiting_Result_Sets. 

Alternatively, you can use a subquery to return the max count of co-authors first. 

Extra credit ( 5 points):

Assume that we have the XML document for every author at dblp, and we will use the above two XML documents as example documents for queries. 

1. Please design a table in Db2 and load the two XML documents into the table (ex1.sql).

2. Please write an XQuery to return the author who published with both John L. Hennessy and  David Peterson across all papers in dblp. (ex2.sql).

3. Please write a XMLQuery  to return the paper with most co-authors for each author (based on root element "name" attribute).  (ex3.sql).