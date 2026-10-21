# Real Estate Portfolio Analytics — Power BI

A portfolio project showing how synthetic property and monthly performance data can be shaped into a small reporting model for occupancy, rent, and collections.

> **Data notice:** Every record in this project is synthetic. It does not represent real properties, clients, or financial performance.

## Business scenario

A property portfolio team wants to compare occupancy, gross rent, rent collected, and collection performance across cities, property types, and months. This repository documents a simple star schema, Power BI measures, data quality checks, and a proposed three-page dashboard.

## Current status

The repository contains source data, Snowflake-style DDL, SQL validation queries, DAX measures, and a dashboard build specification. It does not contain a `.pbix` report file; the dashboard specification is the implementation guide for building it in Power BI Desktop.

## Repository contents

| Path | Purpose |
| --- | --- |
| `data/dim_property.csv` | 80 synthetic properties, one row per property |
| `data/fact_property_monthly.csv` | 960 property-month records for January–December 2025 |
| `sql/model.sql` | Target dimension and fact table definitions |
| `sql/data_quality_checks.sql` | Suggested load validation and reconciliation queries |
| `powerbi/measures.dax` | Core rent, occupancy, and portfolio measures |
| `docs/dashboard-spec.md` | Page layouts, business questions, and build guidance |

## Data model

- `dim_property`: one row per `property_id`; contains city, property type, area, baseline occupancy, and monthly rent reference value.
- `fact_property_monthly`: one row per `property_id` and `month`; contains that month's occupancy, gross rent, and collected rent.
- Join `dim_property[property_id]` to `fact_property_monthly[property_id]` as a one-to-many relationship with single-direction filtering from the dimension.

The numeric rent values are deliberately not assigned a currency. Add a currency definition before using them in a real business context.

## Build in Power BI Desktop

1. Import the two CSV files from `data/`.
2. Confirm `property_id` is text, `month` is a date, `area_sqft` is a whole number, rent fields are decimal numbers, and occupancy values are decimal ratios from 0 to 1.
3. Create the relationship described above. Keep the dimension on the one side.
4. Add the measures in `powerbi/measures.dax`. Format occupancy and collection rate as percentages.
5. Follow `docs/dashboard-spec.md` to build the report pages and validate totals against the source CSVs.
6. If using the SQL scripts, create the target tables with `sql/model.sql`, load the CSVs, then run the relevant checks in `sql/data_quality_checks.sql`.

## Metric interpretation

- Rent totals sum over the selected property-month rows.
- Occupancy is a ratio. The supplied average is an unweighted average across property-month records; use a weighted calculation if the business definition requires weighting by area or rentable units.
- Rent collection rate is total collected rent divided by total gross rent, rather than an average of property-level rates.
- Gross rent per square foot uses the sum of property-month area in the denominator so multi-month selections remain interpretable as a period average.
- The annualized gross rent run rate multiplies average monthly gross rent in the current month filter context by 12. It is a run-rate estimate, not a forecast.

## Limitations

This is a synthetic portfolio demonstration. The values are for practicing data modeling and reporting and should not be presented as real market or investment analysis. The SQL DDL is Snowflake-style and may need adjustment for another database.
