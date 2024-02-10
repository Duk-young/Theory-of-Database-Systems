DROP TABLE CSE532.FacilityCertification;

CREATE TABLE CSE532.FacilityCertification (
FacilityID VARCHAR(16), 
FacilityName VARCHAR(150), 
Description VARCHAR(128), 
AttributeType VARCHAR(128), 
AttributeValue VARCHAR(128), 
MeasureValue DECIMAL(9, 2), 
County VARCHAR(16)
);