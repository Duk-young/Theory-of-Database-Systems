drop index cse532.facilityidx;
drop index cse532.fac_cert_facilityididx;
drop index cse532.fac_zipcodeidx;
drop index cse532.fac_cert_attributevalueidx;
drop index cse532.zipidx;
drop index cse532.uszip_zipcodeidx;

create index cse532.facilityidx on cse532.facility(geolocation) extend using db2gse.spatial_index(0.85, 2, 5);

create index cse532.fac_cert_facilityididx on CSE532.FacilityCertification (FacilityID);

CREATE INDEX cse532.fac_zipcodeidx ON CSE532.FACILITY (SUBSTRING(ZIPCODE, 1, 5));

create index cse532.fac_cert_attributevalueidx on CSE532.FacilityCertification (AttributeValue);

create index cse532.zipidx on cse532.uszip(shape) extend using db2gse.spatial_index(0.85, 2, 5);

create index cse532.uszip_zipcodeidx on CSE532.USZIP (ZCTA5CE10);

runstats on table cse532.facility and indexes all;

runstats on table cse532.facilitycertification and indexes all;

runstats on table cse532.uszip and indexes all;

