XQUERY 
let $pattersonPapers := for $p in db2-fn:xmlcolumn("PAPERS.XML_DOC")//r
where some $author in $p//author satisfies ($author = 'David A. Patterson 0001')
return $p

let $hennessyPapers := for $p in db2-fn:xmlcolumn("PAPERS.XML_DOC")//r
where some $author in $p//author satisfies ($author = 'John L. Hennessy')
return $p

let $pattersonAuthors := distinct-values($pattersonPapers//author)
let $hennessyAuthors := distinct-values($hennessyPapers//author)

let $publishedWithBoth := for $author1 in $pattersonAuthors
where ($author1 != 'David A. Patterson 0001') and ($author1 != 'John L. Hennessy') and (some $author2 in $hennessyAuthors satisfies ($author1 = $author2))
return $author1

for $author in $publishedWithBoth
return <author>{$author}</author>;
