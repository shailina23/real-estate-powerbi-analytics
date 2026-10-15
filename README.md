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

## Suggested Power BI model

Load both CSVs and create a one-to-many relationship:

```text
dim_property[property_id]  1 ─── *  fact_property_monthly[property_id]
```

Treat occupancy fields as ratios/percentages. Do not sum them; choose and document an averaging method appropriate to the question. Rent amounts can be summed across selected properties and months. A portfolio collection rate can be calculated as total collected rent divided by total gross rent, with a zero-denominator check.

## Analysis ideas

- Compare occupancy by city, property type, and month.
- Trend gross and collected rent over time.
- Identify where collection rate or occupancy changes most.
- Compare property-level and portfolio-level measures.

## Current repository contents

This staged project currently includes the README, synthetic CSV datasets, and SQL model draft. DAX measures, dashboard documentation, and a Power BI report are not included in this release.
