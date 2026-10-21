-- Suggested checks after loading the synthetic CSVs into the target tables.
-- Each query should return no rows for the listed integrity checks.

-- Expected volume for this portfolio dataset: 80 properties and 960
-- property-month rows (80 properties x 12 months).
SELECT 'dim_property' AS table_name, COUNT(*) AS row_count
FROM dim_property
UNION ALL
SELECT 'fact_property_monthly', COUNT(*)
FROM fact_property_monthly;

-- Dimension key must be unique.
SELECT property_id, COUNT(*) AS row_count
FROM dim_property
GROUP BY property_id
HAVING COUNT(*) <> 1;

-- Fact grain must be unique at property and month.
SELECT property_id, month, COUNT(*) AS row_count
FROM fact_property_monthly
GROUP BY property_id, month
HAVING COUNT(*) <> 1;

-- Fact records must resolve to a property dimension row.
SELECT f.property_id, f.month
FROM fact_property_monthly AS f
LEFT JOIN dim_property AS d
    ON d.property_id = f.property_id
WHERE d.property_id IS NULL;

-- Ratios must be within the expected 0-to-1 range.
SELECT property_id, occupancy_pct
FROM dim_property
WHERE occupancy_pct < 0 OR occupancy_pct > 1;

SELECT property_id, month, occupancy_pct
FROM fact_property_monthly
WHERE occupancy_pct < 0 OR occupancy_pct > 1;

-- Basic financial sanity checks. Investigate returned rows before reporting.
SELECT property_id, month, gross_rent, collected_rent
FROM fact_property_monthly
WHERE gross_rent < 0
   OR collected_rent < 0
   OR collected_rent > gross_rent;

-- Compare these totals with the imported source files during the first load.
SELECT
    COUNT(*) AS fact_rows,
    SUM(gross_rent) AS gross_rent_total,
    SUM(collected_rent) AS collected_rent_total,
    MIN(month) AS first_month,
    MAX(month) AS last_month
FROM fact_property_monthly;
