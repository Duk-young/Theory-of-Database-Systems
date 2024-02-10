SELECT CURRENT TIMESTAMP FROM SYSIBM.SYSDUMMY1;
WITH FAC AS(
    SELECT FacilityID, FacilityName, Address1, Address2, City, ZipCode, CountyCode, County,
db2gse.st_astext(Geolocation) as Geolocation 
,db2gse.st_distance(Geolocation, db2gse.st_point(-73.016479, 40.891720, 1), 'STATUTE MILE') as distance
FROM CSE532.FACILITY
WHERE db2gse.st_contains(db2gse.st_buffer(db2gse.st_point(-73.016479, 40.891720, 1), 10, 'STATUTE MILE'), Geolocation) = 1
)
SELECT FAC.FacilityID, FAC.FacilityName, FAC.Address1, FAC.Address2, FAC.City, 
       FAC.ZipCode, FAC.CountyCode, FAC.County, FAC.Geolocation, FAC.Distance, FAC_CERT.AttributeType, FAC_CERT.AttributeValue
FROM FAC
JOIN CSE532.FacilityCertification as FAC_CERT ON FAC.FACILITYID = FAC_CERT.FACILITYID
WHERE FAC_CERT.AttributeValue = 'Intensive Care'
ORDER BY Distance
FETCH FIRST 1 ROWS ONLY;
SELECT CURRENT TIMESTAMP FROM SYSIBM.SYSDUMMY1;