-- Star-schema model for Power BI
CREATE TABLE dim_property (
    property_id VARCHAR,
    city VARCHAR,
    property_type VARCHAR,
    area_sqft NUMBER,
    occupancy_pct NUMBER(5,3),
    monthly_rent NUMBER(18,2)
);

CREATE TABLE fact_property_monthly (
    property_id VARCHAR,
    month DATE,
    occupancy_pct NUMBER(5,3),
    gross_rent NUMBER(18,2),
    collected_rent NUMBER(18,2)
);

-- Relationship: dim_property[property_id] 1 -> * fact_property_monthly[property_id]
