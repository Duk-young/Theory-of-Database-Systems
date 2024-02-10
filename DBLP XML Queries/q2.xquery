let $xml :=  doc("JohnLHennessy.xml")//r
let $coauthorOrderedPaper := (
for $paper in $xml
order by count($paper//author) descending
return 
  $paper
)
let $mostCoauthorPaper := subsequence($coauthorOrderedPaper, 1, 1)
return
    if ($mostCoauthorPaper) then
    <paper>
        {$mostCoauthorPaper//title}
        <coauthor-count>{count($mostCoauthorPaper//author)}</coauthor-count>
      </paper>
    else ()