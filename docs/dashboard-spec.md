# Power BI dashboard specification

## Audience and purpose

The audience is a portfolio manager comparing property operations across city, property type, and month. The report should make revenue, occupancy, and collection patterns easy to compare, while clearly identifying the synthetic nature of the data.

## Model setup

- Import `data/dim_property.csv` and `data/fact_property_monthly.csv`.
- Create a one-to-many relationship from `dim_property[property_id]` to `fact_property_monthly[property_id]`.
- Use single-direction filtering from the dimension to the fact table.
- Treat occupancy values as ratios from 0 to 1 and format as percentages.
- Use `month` as a date field. For a production report, add a dedicated calendar table and relate it to the fact table.
- Add measures from `powerbi/measures.dax`.

## Page 1 — Portfolio overview

**Purpose:** Give leadership a quick view of the size and direction of portfolio performance.

**KPI cards:** Property Count, Gross Rent, Collected Rent, Average Monthly Occupancy %, and Rent Collection Rate.

**Visuals:**

- Line chart: Gross Rent and Collected Rent by month.
- Bar chart: Gross Rent by city, sorted descending.
- Column chart: Average Monthly Occupancy % by property type.

**Slicers:** Month, city, and property type. Keep slicers consistent across pages.

## Page 2 — Property performance

**Purpose:** Let an analyst compare individual properties and investigate differences within a city or property type.

**Visuals:**

- Matrix: City → Property Type → Property, with Gross Rent, Collected Rent, Rent Collection Rate, and Average Monthly Occupancy %.
- Line chart: monthly occupancy for the selected property or group.
- Clustered bar chart: Gross Rent vs Collected Rent by property.
- Bar chart: Gross Rent per Sq Ft by property, with a Top N filter for readability.

**Slicers:** City, property type, and property.

## Page 3 — Exceptions and follow-up

**Purpose:** Surface records that may merit operational review. These thresholds are illustrative and should be agreed with business stakeholders for any real deployment.

**Suggested exception views:**

- Properties with monthly occupancy below 75%.
- Property-months with collection rate below 90%. For this visual, use a property-level ratio of collected rent to gross rent in the current property/month context; avoid averaging those ratios for the portfolio KPI.
- Month-over-month gross rent declines, using the month field and a dedicated calendar table if you add time-intelligence calculations.

Include property, city, property type, month, occupancy, gross rent, collected rent, and collection rate in a detail table so a user can investigate the flagged row.

## Business questions

1. Which cities and property types contribute the most gross rent?
2. How do occupancy and rent collections change over time?
3. Which properties have consistently low occupancy or collection rates?
4. Which properties or locations should the team investigate first?

## Design and validation notes

- Label currency only after selecting a real or explicitly stated currency. The source data has no currency metadata.
- Do not sum occupancy percentages. The supplied average is unweighted across property-month rows.
- Check that report totals reconcile to the imported CSVs under the same filters.
- Add a visible subtitle or note: “Synthetic portfolio data for demonstration.”
- Use descriptive titles and meaningful axis units; avoid presenting the thresholds as universal business rules.
