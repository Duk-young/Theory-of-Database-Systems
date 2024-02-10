LOAD FROM "C:\Users\Dukyoung\Downloads\zipcodepopulation.csv" 
OF DEL METHOD P ( 1, 2, 3, 4) 
MESSAGES "c:\temp\loadmsg.txt" 
INSERT INTO ZIPCENSUS ( RANK, POPULATION_DENSITY, ZIP, POPULATION );