# Real Estate Portfolio Analytics — Power BI

A portfolio demonstration using synthetic property and monthly performance data.

> **Data notice:** All records are synthetic and created for demonstration. They do not describe real properties, clients, or financial performance.

## Scenario

A property portfolio team wants to compare occupancy, gross rent, rent collected, and collection performance across cities, property types, and months.

## Data files

- [Property dimension](data/dim_property.csv): 80 properties, one row per property.
- [Monthly property facts](data/fact_property_monthly.csv): 960 records, one row per property per month for January–December 2025.

## SQL model

The [SQL DDL draft](sql/model.sql) defines the property dimension and monthly fact table. It uses a Snowflake-style `NUMBER` type for numeric fields; adjust data types and add warehouse-specific constraints as needed for your target platform.

The intended grain and relationship are:

- `dim_property`: one row per `property_id`.
- `fact_property_monthly`: one row per `property_id` and `month`.
- Join `dim_property[property_id]` to `fact_property_monthly[property_id]` as a one-to-many relationship.

## Power BI measures

The [DAX measures](powerbi/measures.dax) include gross and collected rent, collection rate, average monthly occupancy, property count, gross rent per square foot, and an annualized gross rent run rate. The annualized measure uses average monthly gross rent across the months in the current filter context, multiplied by 12.

Occupancy is stored as a ratio from 0 to 1. Format the occupancy and collection rate measures as percentages, and do not sum occupancy values.

## Suggested Power BI model

Load both CSVs and create a one-to-many relationship:

```text
dim_property[property_id]  1 ─── *  fact_property_monthly[property_id]
```

## Analysis ideas

- Compare occupancy by city, property type, and month.
- Trend gross and collected rent over time.
- Identify where collection rate or occupancy changes most.
- Compare property-level and portfolio-level measures.

## Current repository contents

This staged project currently includes the README, synthetic CSV datasets, a SQL model draft, and DAX measures. Dashboard documentation and a Power BI report are not included in this release.
