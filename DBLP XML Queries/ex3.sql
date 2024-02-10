SELECT XMLCAST(XMLQUERY('/dblpperson/@name' PASSING XML_DOC) AS VARCHAR(100)) AS NAME, 
XMLQUERY('let $papers := for $paper in $XML//r order by count($paper//author) descending return $paper 
let $mostCoauthor := subsequence($papers, 1, 1) return count($mostCoauthor//author)' PASSING XML_DOC AS "XML") AS Most_Coauthor_Count,
XMLQUERY('let $papers := for $paper in $XML//r order by count($paper//author) descending return $paper 
let $mostCoauthor := subsequence($papers, 1, 1) return $mostCoauthor//title/text()' PASSING XML_DOC AS "XML") AS Most_Coauthor_Paper_Title,
XMLQUERY('let $papers := for $paper in $XML//r order by count($paper//author) descending return $paper 
let $mostCoauthor := subsequence($papers, 1, 1) return $mostCoauthor' PASSING XML_DOC AS "XML") AS Most_Coauthor_Paper
FROM PAPERS;
