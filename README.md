# Real Estate Portfolio Analytics — Power BI

A portfolio demonstration using synthetic property and monthly performance data. This repository currently publishes the project overview and source data files.

> **Data notice:** All records are synthetic and created for demonstration. They do not describe real properties, clients, or financial performance.

## Scenario

A property portfolio team wants to compare occupancy, gross rent, rent collected, and collection performance across cities, property types, and months.

## Data files

- [Property dimension](data/dim_property.csv): 80 properties, one row per property.
- [Monthly property facts](data/fact_property_monthly.csv): 960 records, one row per property per month for January–December 2025.

### Property dimension fields

| Field | Meaning |
| --- | --- |
| `property_id` | Synthetic unique property key |
| `city` | Portfolio city |
| `property_type` | Residential, Office, or Retail |
| `area_sqft` | Property area in square feet |
| `occupancy_pct` | Property-level occupancy ratio from 0 to 1 |
| `monthly_rent` | Synthetic monthly rent amount; no currency is specified |

### Monthly fact fields

| Field | Meaning |
| --- | --- |
| `property_id` | Property key that joins to the dimension |
| `month` | Month start date (`YYYY-MM-DD`) |
| `occupancy_pct` | Monthly occupancy ratio from 0 to 1 |
| `gross_rent` | Synthetic gross rent amount for the property and month |
| `collected_rent` | Synthetic rent collected for the property and month |

## Suggested Power BI model

Load both CSVs and create a one-to-many relationship:

```text
dim_property[property_id]  1 ─── *  fact_property_monthly[property_id]
```

Treat the two occupancy fields as ratios/percentages. Do not sum them; choose and document an averaging method appropriate to the question. Rent amounts can be summed across the selected properties and months. A portfolio collection rate can be calculated as total collected rent divided by total gross rent, with a zero-denominator check.

## Analysis ideas

- Compare occupancy by city, property type, and month.
- Trend gross and collected rent over time.
- Identify where collection rate or occupancy changes most.
- Compare property-level and portfolio-level measures.

## Scope

This initial release contains only this README and the two CSV data files. The data is synthetic and intended for practicing analytics and dashboard design.
