drop table papers;

create table papers (
    id INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    xml_doc XML,
    PRIMARY KEY (id)
);

LOAD FROM "C:\Users\Dukyoung\Desktop\CSE532A5\DAPatterson.del" OF DEL XML FROM "C:\Users\Dukyoung\Downloads\DAPatterson.xml" INSERT INTO papers(xml_doc);
LOAD FROM "C:\Users\Dukyoung\Desktop\CSE532A5\JohnLHennessy.del" OF DEL XML FROM "C:\Users\Dukyoung\Downloads\JohnLHennessy.xml" INSERT INTO papers(xml_doc);
