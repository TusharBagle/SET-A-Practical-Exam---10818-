Video Link :
https://drive.google.com/file/d/1Xi5muypmnOtTCE2K0Y71pmEwmbnD9cjK/view?usp=sharing


Delivery Delay Analysis — Set A

Student Name: Bagle Tushar 
Student ID: 10818 
Assigned Set: Set A 
Repository: data-analysis-set-d-10818 
Exam: Practical Data Analysis Exam — Excel • Power BI • SQL • Python


1. Business Objective

Primary business question: Which service type has the greatest delivery-delay burden, and which hub needs priority attention?

This project analyzes a synthetic delivery dataset across four tools (Excel, SQL, Python, Power BI) to identify:

Which service type (Express vs Standard) accumulates the most total delay days.
Which hub (Mumbai, Chennai, Delhi) needs priority operational attention based on cumulative delay.



2. Dataset & Data Dictionary
Source files
File	Rows	Description
data/raw/deliveries.csv	13 (incl. 1 duplicate)	Fact table — monthly route/hub delivery records
data/raw/routes.csv	4	Lookup table — route metadata and service type
Data dictionary — deliveries.csv
Column	Type	Description
record_id	Integer	Unique row identifier
month	Text (ordered category)	Jan → Feb → Mar
route_id	Text	Foreign key to routes.route_id
hub	Text	Delivery hub (Mumbai, Chennai, Delhi)
promised_days	Numeric	Promised delivery time (days)
actual_days	Numeric	Actual delivery time (days)
Data dictionary — routes.csv
Column	Type	Description
route_id	Text	Unique route identifier (primary key)
route	Text	Route name
service_type	Text	Express or Standard



4. Cleaning Steps & Metric Definitions
Duplicate removal: deliveries.csv contains 13 rows, including one exact duplicate (record_id = 12, Mar/R4/Mumbai). This row is removed in every module (Excel, SQL, Python, Power BI) so that 12 unique records remain.
Lookup join: service_type is attached to each delivery record via route_id (one routes row maps to many deliveries rows).
Derived field — delay_days:
  delay_days = MAX(actual_days − promised_days, 0)

Zero when a delivery is on time or early.

Delay incidence rate:
  Delay Incidence Rate = (records where actual_days > promised_days) ÷ (all records)

Displayed as a percentage; calculated from underlying counts, not by averaging subgroup percentages.

All numeric results are reported to two decimal places; all tied entities for highest/lowest are reported.
4. Tools & Versions Used
Tool	Version
Excel	[e.g., Microsoft 365 / Excel 2019]
Power BI Desktop	[version, Windows only]
Python	[version]
pandas	[version]
matplotlib	[version]
SQL engine	[e.g., MySQL 8.0 / SQL Server 2022] — state your engine and version here
Git	[version]
5. Project Folder Structure
data-analysis-set-d-[YOUR-STUDENT-ID]/
│
├── README.md
├── requirements.txt
├── .gitignore
│
├── data/
│   └── raw/
│       ├── deliveries.csv
│       └── routes.csv
│
├── excel/
│   └── analysis.xlsx          # Raw, Lookup, Clean, Summary sheets
│
├── sql/
│   ├── setup.sql              # CREATE TABLE + INSERT statements
│   └── queries.sql            # S2a, S2b, S2c labeled queries
│
├── python/
│   └── analysis.py            # or analysis.ipynb
│
├── powerbi/
│   └── dashboard.pbix
│
└── outputs/
    ├── clean_data.csv
    ├── python_summary.csv
    ├── python_chart.png
    ├── powerbi_dashboard.png
    └── sql/
        ├── s2a_delay_by_service_type.csv
        ├── s2b_significant_delay_routes.csv
        └── s2c_top2_hubs.csv
6. SQL — Setup & Execution Steps

Dialect / version: [e.g., MySQL 8.0] — also declared as a comment at the top of sql/setup.sql.

Run in this order from a fresh database:

bash
# 1. Create schema, tables, and load the 12 clean fact rows + 4 lookup rows
mysql -u <user> -p < sql/setup.sql

# 2. Run the three analytical queries + integrity check
mysql -u <user> -p < sql/queries.sql

Query outputs are saved to outputs/sql/:

s2a_delay_by_service_type.csv — total delay_days by service_type, descending
s2b_significant_delay_routes.csv — routes with summed delay_days > 8
s2c_top2_hubs.csv — top two hubs by summed delay_days (alphabetical tie-break)

A diagnostic LEFT JOIN query confirms zero unmatched route_id keys between deliveries and routes.

7. Python — Environment Setup & Run Instructions
bash
# 1. Install dependencies
pip install -r requirements.txt

# 2. Run from the repository root (all paths are relative)
python python/analysis.py

This script:

Loads data/raw/deliveries.csv and data/raw/routes.csv via relative paths.
Removes the exact duplicate row and merges on route_id (left join), asserting exactly 12 rows and zero unmatched service_type values.
Computes delay_days = (actual_days − promised_days).clip(lower=0).
Produces a service_type summary (total delay, delay incidence rate) and identifies the single highest-delay route and its share of total delay.
Plots monthly total delay_days (Jan → Feb → Mar) to outputs/python_chart.png.
Exports outputs/clean_data.csv and outputs/python_summary.csv.

(If using a notebook: Kernel → Restart & Run All was executed before committing; all outputs are visible in the saved .ipynb.)

8. Excel — Sheet Guide
Sheet	Purpose
Raw	Original, unedited 13-row deliveries.csv data
Lookup	Original 4-row routes.csv data
Clean	12 unique records (duplicate removed) + service_type via XLOOKUP + delay_days via MAX(actual_days−promised_days,0)
Summary	SUMIFS delay-by-hub table, PivotTable (service_type × month), and column chart

Before/after row counts (13 → 12) are shown directly in the Clean sheet.

9. Power BI — Data Source Refresh Instructions

powerbi/dashboard.pbix loads data/raw/deliveries.csv and data/raw/routes.csv as data sources.

To refresh the data source path after cloning:

Open dashboard.pbix in Power BI Desktop.
Go to Home → Transform Data → Data Source Settings.
Select each source and click Change Source.
Point both to the cloned repo's data/raw/ folder (e.g., <local-path>\data-analysis-set-d-[ID]\data\raw\deliveries.csv).
Click Apply Changes, then Refresh on the Home ribbon.

Model contains an active one-to-many relationship: routes[route_id] → deliveries[route_id] (single-direction filtering). DAX measures (Delivery Count, Total Delay Days, Delay Incidence Rate) live in a dedicated Measures table.

11. Cross-Tool Reconciliation

Chosen aggregate: Total delay_days for the Standard service type.

Tool	Value	Source
Excel	[value]	Summary sheet, PivotTable cell
SQL	[value]	outputs/sql/s2a_delay_by_service_type.csv
Python	[value]	outputs/python_summary.csv
Power BI	[value]	Bar chart / card filtered to Standard

Rounding notes: [Note any decimal-place or aggregation differences observed, if any.]

12. Video Explanation
Video URL: [[Paste unlisted YouTube or "Anyone with the link" Google Drive link here]](https://drive.google.com/file/d/1Xi5muypmnOtTCE2K0Y71pmEwmbnD9cjK/view?usp=sharing)
Duration: 12 Minutes
Content covered: Business problem, dataset/duplicate handling, Excel XLOOKUP & PivotTable demo, one live SQL query, Python merge assertion & chart, Power BI DAX measure & slicer demo, two numeric findings, one recommendation, one limitation.

(Playback tested in a signed-out/private browser window before submission.)


# Author
- Tushar Bagle
