SELECT CURRENT TIMESTAMP FROM SYSIBM.SYSDUMMY1;
WITH EMERDEPTZIP AS (
    SELECT DISTINCT SUBSTRING(ZIPCODE, 1, 5) AS ZIPCODE
    FROM CSE532.FACILITY AS FAC, CSE532.FACILITYCERTIFICATION AS FAC_CERT
    WHERE FAC_CERT.AttributeValue = 'Emergency Department'
    AND FAC.FACILITYID = FAC_CERT.FACILITYID
),
NYZIP AS (
    SELECT SUBSTRING(ZCTA5CE10, 1, 5) AS ZIPCODE, SHAPE AS BOUNDARY 
    FROM CSE532.USZIP 
    WHERE ZCTA5CE10 IN (SELECT SUBSTRING(ZIPCODE, 1, 5) FROM CSE532.FACILITY)
),
 EMERDEPTAREA AS (
    SELECT NYZIP.ZIPCODE AS ZIPCODE, BOUNDARY
    FROM NYZIP, EMERDEPTZIP
    WHERE NYZIP.ZIPCODE = EMERDEPTZIP.ZIPCODE
),
EMERDEPTEXIST AS (
    SELECT DISTINCT SUBSTRING(USZIP.ZCTA5CE10, 1, 5) AS ZIPCODE
    FROM EMERDEPTAREA EDA, CSE532.USZIP AS USZIP
    WHERE DB2GSE.ST_INTERSECTS(EDA.BOUNDARY, USZIP.SHAPE) = 1
)
SELECT DISTINCT SUBSTRING(ZIPCODE, 1, 5) AS ZIPCODE
FROM NYZIP
WHERE SUBSTRING(ZIPCODE, 1, 5) NOT IN(
    SELECT ZIPCODE
    FROM EMERDEPTEXIST
);
SELECT CURRENT TIMESTAMP FROM SYSIBM.SYSDUMMY1;

-- filter out zipcodes that have facility with emergency deparment -- 
-- Only consider zipcodes available in facility table --
-- get area boundary of zipcodes with emergency department --
-- mark all the neigboring or equal zipcodes with emergency department zipcodes--
-- get list of zipcodes that does not belong to EMERDEPTEXIST --