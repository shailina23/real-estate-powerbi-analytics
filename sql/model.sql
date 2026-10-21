-- Snowflake-style target model for the synthetic Power BI portfolio project.
-- Documented grain: one dimension row per property_id and one fact row per
-- property_id/month. Snowflake does not enforce standard PK/FK constraints.

CREATE TABLE IF NOT EXISTS dim_property (
    property_id      VARCHAR(16)  NOT NULL,
    city             VARCHAR(40)  NOT NULL,
    property_type    VARCHAR(24)  NOT NULL,
    area_sqft        NUMBER(12,0) NOT NULL,
    occupancy_pct    NUMBER(5,3)  NOT NULL,
    monthly_rent     NUMBER(18,2) NOT NULL,
    CONSTRAINT pk_dim_property PRIMARY KEY (property_id)
);

CREATE TABLE IF NOT EXISTS fact_property_monthly (
    property_id      VARCHAR(16)  NOT NULL,
    month            DATE         NOT NULL,
    occupancy_pct    NUMBER(5,3)  NOT NULL,
    gross_rent       NUMBER(18,2) NOT NULL,
    collected_rent   NUMBER(18,2) NOT NULL,
    CONSTRAINT pk_fact_property_monthly PRIMARY KEY (property_id, month),
    CONSTRAINT fk_fact_property FOREIGN KEY (property_id)
        REFERENCES dim_property (property_id)
);
