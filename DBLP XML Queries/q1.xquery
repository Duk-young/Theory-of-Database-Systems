let $xml :=  doc("DAPatterson.xml")//r
for $paper in $xml
group by $year := $paper//year
order by $year
return
<publication-informataion>
  <year>{$year}</year>
  <paper-count>{count($paper)}</paper-count>
  <average-coauthors>{
      avg(
        for $p in $paper
        return count($p//author)
      )
  }</average-coauthors>
</publication-informataion>