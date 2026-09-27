# **Video Link :** https://drive.google.com/file/d/18EyK-_b69F0A3uYmalKjuAWM3t_Iv1HK/view?usp=sharing



# 🚚 Delivery Delay Analysis — Set A

### Practical Exam — Data Analysis

**Student Name:** Tushar Bagle
**Student ID:** 10818
**Assigned Set:** Set A
**Project:** Delivery Delay Analysis
**Duration:** 3 Hours / 180 Minutes

---

## 📌 Project Overview

This project is a practical data analysis solution for **Delivery Delay Analysis** using four analytical tools:

* 📗 Microsoft Excel
* 🗄️ SQL
* 🐍 Python
* 📊 Microsoft Power BI

The objective is to clean, transform, analyze, visualize, and interpret delivery performance data across different routes, hubs, months, and service types.

### 🎯 Business Question

> **Which service type has the greatest delivery-delay burden, and which hub needs priority attention?**

The analysis uses delivery records and route information to calculate:

* Total delivery delay
* Delay by service type
* Delay by hub
* Monthly delay trends
* Delay incidence rate
* Routes with significant delays
* Top hubs by cumulative delay

---

# 📂 Repository Structure

```text
SET-A-Practical-Exam---10818-/
│
├── data/
│       ├── deliveries.csv
│       └── routes.csv
│
├── excel/
│   └── analysis.xlsx
│
├── sql/
│   ├── setup.sql
│   └── queries.sql
│
├── python/
│   └── analysis.ipynb
│
├── powerbi/
│   └── dashboard.pbix
│
├── outputs/
│   ├── clean_data.csv
│   ├── python_summary.csv
│   ├── python_chart.png
│   ├── powerbi_dashboard.png
│   │
│   └── sql/
│       ├── s2a_delay_by_service_type.csv
│       ├── s2b_significant_routes.csv
│       └── s2c_top_two_hubs.csv
│
├── README.md
├── requirements.txt
```

---

# 📊 Dataset Description

The project uses two CSV files.

## 1. `deliveries.csv`

This is the main fact table containing delivery performance information.

The original file contains **13 rows**, including **one intentional exact duplicate**.

After cleaning:

**13 rows → 12 unique records**

### Columns

| Column          | Type    | Description                          |
| --------------- | ------- | ------------------------------------ |
| `record_id`     | Integer | Unique delivery record identifier    |
| `month`         | Text    | Delivery month — Jan, Feb, or Mar    |
| `route_id`      | Text    | Route identifier                     |
| `hub`           | Text    | Delivery hub                         |
| `promised_days` | Numeric | Number of days promised for delivery |
| `actual_days`   | Numeric | Actual delivery duration             |

---

## 2. `routes.csv`

This is the route lookup table.

| Column         | Type | Description             |
| -------------- | ---- | ----------------------- |
| `route_id`     | Text | Unique route identifier |
| `route`        | Text | Route name              |
| `service_type` | Text | Service category        |

### Service Types

* **Express**
* **Standard**

---

# 🧹 Data Cleaning

The same core cleaning rules are applied across Excel, SQL, Python, and Power BI.

### Duplicate Handling

The `deliveries.csv` file contains one exact duplicate record.

```text
Original records: 13
Duplicate records: 1
Clean records: 12
```

The duplicate is removed before analysis.

### Route Lookup

`route_id` is used as the key between:

```text
routes
   │
   │ route_id
   ▼
deliveries
```

Each route can have multiple delivery records.

---

# 🧮 Metric Definitions

## Delay Days

Delay is calculated as:

```text
delay_days = MAX(actual_days - promised_days, 0)
```

Therefore:

* On-time delivery → `0`
* Early delivery → `0`
* Delayed delivery → actual days − promised days

---

## Delay Incidence Rate

The delay incidence rate is calculated as:

```text
Delayed Records / Total Records × 100
```

A delivery is considered delayed when:

```text
actual_days > promised_days
```

Percentages are calculated from the underlying record counts rather than by averaging subgroup percentages.

---

# 📗 Excel Analysis

File:

```text
excel/analysis.xlsx
```

The workbook contains four required sheets:

```text
Raw
Lookup
Clean
Summary
```

### Raw

Contains the original 13-row delivery data.

### Lookup

Contains the route lookup data from `routes.csv`.

### Clean

Contains the cleaned 12-row delivery dataset.

The `service_type` column is populated using `XLOOKUP` based on `route_id`.

The `delay_days` column is calculated using:

```excel
=MAX(actual_days-promised_days,0)
```

### Summary

Contains:

* Total delay by hub
* PivotTable
* Service type analysis
* Monthly breakdown
* Column chart

The monthly order is maintained as:

```text
Jan → Feb → Mar
```

---

# 🗄️ SQL Analysis

SQL files:

```text
sql/setup.sql
sql/queries.sql
```

### SQL Engine

**MySQL**

### Execution Order

Run the files in this order:

```text
1. setup.sql
2. queries.sql
```

`setup.sql` creates and loads the required tables.

`queries.sql` contains three analytical queries.

---

## S2a — Total Delay Days by Service Type

The deliveries table is joined with the routes table using:

```sql
route_id
```

The query calculates total delay days for each service type.

Expected analysis:

| Service Type | Total Delay Days |
| ------------ | ---------------: |
| Express      |               12 |
| Standard     |               22 |

---

## S2b — Routes with Significant Delay

Routes whose cumulative delay exceeds:

```text
8 days
```

are identified using `GROUP BY` and `HAVING`.

Expected routes include:

| Route        | Total Delay Days |
| ------------ | ---------------: |
| Rural Feeder |               14 |
| Metro Link   |                9 |

---

## S2c — Top Two Hubs by Delay

The hubs are ranked using their total cumulative delay.

Expected top hubs:

| Hub    | Total Delay Days |
| ------ | ---------------: |
| Mumbai |               15 |
| Delhi  |               14 |

Alphabetical ordering is used as the tie-breaker when required.

---

# 🐍 Python Analysis

Notebook:

```text
python/analysis.ipynb
```

Python is used for:

* Loading CSV files
* Data type validation
* Duplicate removal
* Data merging
* Delay calculation
* Service-type analysis
* Delay incidence calculation
* Route analysis
* Monthly visualization
* CSV exports

### Libraries

```text
pandas
matplotlib
```

Install dependencies using:

```bash
pip install -r requirements.txt
```

Run the notebook from the repository root.

---

## Python Data Processing

The delivery and route datasets are merged using:

```text
route_id
```

The final merged dataset contains:

```text
12 records
```

The analysis also validates that every delivery `route_id` has a matching route record.

---

## Python Delay Calculation

```python
df["delay_days"] = (
    df["actual_days"] - df["promised_days"]
).clip(lower=0)
```

---

# 📊 Key Analytical Results

After removing the duplicate record, the clean dataset contains:

```text
12 delivery records
34 total delay days
```

## Delay by Service Type

| Service Type | Total Delay Days |
| ------------ | ---------------: |
| Express      |        **12.00** |
| Standard     |        **22.00** |

## Delay by Hub

| Hub     | Total Delay Days |
| ------- | ---------------: |
| Mumbai  |        **15.00** |
| Delhi   |        **14.00** |
| Chennai |         **5.00** |

## Monthly Delay

| Month | Total Delay Days |
| ----- | ---------------: |
| Jan   |         **8.00** |
| Feb   |         **9.00** |
| Mar   |        **17.00** |

## Delay Incidence Rate

| Service Type | Delay Incidence Rate |
| ------------ | -------------------: |
| Express      |           **66.67%** |
| Standard     |           **83.33%** |

## Route with Greatest Delay

The route with the greatest cumulative delay is:

**R4 — Rural Feeder**

```text
Total Delay = 14 days
```

Overall delay:

```text
34 days
```

Share of overall delay:

```text
14 / 34 × 100 = 41.18%
```

---

# 📊 Power BI Dashboard

File:

```text
powerbi/dashboard.pbix
```

The Power BI report is designed to provide an interactive view of delivery performance.

## Data Model

The model uses:

```text
Routes
   │
   │ 1 : *
   ▼
Deliveries
```

Relationship:

```text
routes[route_id]
        ↓
deliveries[route_id]
```

Filtering direction:

```text
Routes → Deliveries
```

---

# 📐 DAX Measures

## Delivery Count

```DAX
Delivery Count =
COUNTROWS(deliveries)
```

## Total Delay Days

```DAX
Total Delay Days =
SUMX(
    deliveries,
    MAX(
        deliveries[actual_days] - deliveries[promised_days],
        0
    )
)
```

## Delay Incidence Rate

```DAX
Delay Incidence Rate =
DIVIDE(
    COUNTROWS(
        FILTER(
            deliveries,
            deliveries[actual_days] > deliveries[promised_days]
        )
    ),
    COUNTROWS(deliveries),
    0
)
```

The incidence-rate measure is formatted as a percentage.

---

# 📈 Power BI Report Components

The report page contains:

### KPI Cards

* Delivery Count
* Total Delay Days
* Delay Incidence Rate

### Visuals

* Total Delay Days by Service Type
* Monthly Delay Trend
* Hub Slicer

The hub slicer is designed to filter the cards and charts simultaneously.

---

# 🔄 Cross-Tool Reconciliation

The same business metric is checked across all four tools.

### Total Delay Days

```text
Excel       → 34
SQL         → 34
Python      → 34
Power BI    → 34
```

### Standard Service Type

```text
Excel       → 22
SQL         → 22
Python      → 22
Power BI    → 22
```

The values are expected to reconcile, with only possible differences caused by display formatting or rounding.

---

# 💡 Business Findings

### Finding 1 — Service Type

Standard service has:

```text
22 total delay days
```

compared with:

```text
12 total delay days
```

for Express service.

The Standard service also has a delay incidence rate of:

```text
83.33%
```

compared with:

```text
66.67%
```

for Express.

### Finding 2 — Hub

Mumbai has the highest cumulative delay:

```text
15 days
```

followed by:

```text
Delhi — 14 days
Chennai — 5 days
```

### Recommendation

Based on the analyzed records, operational attention should be directed toward the areas showing the highest cumulative delay, particularly the **Standard service category and Mumbai hub**.

### Limitation

The dataset contains only **12 unique delivery records** covering three months. Therefore, the results describe the supplied sample and should not automatically be treated as representative of longer-term delivery performance.

---

# 📤 Output Files

The `outputs/` folder contains the generated analysis results.

### Python

```text
outputs/clean_data.csv
outputs/python_summary.csv
outputs/python_chart.png
```

### Power BI

```text
outputs/powerbi_dashboard.png
```

### SQL

```text
outputs/sql/s2a_delay_by_service_type.csv
outputs/sql/s2b_significant_routes.csv
outputs/sql/s2c_top_two_hubs.csv
```

---

# ⚙️ Setup & Reproducibility

## 1. Clone the Repository

```bash
git clone https://github.com/TusharBagle/SET-A-Practical-Exam---10818-.git
```

Move into the project directory:

```bash
cd SET-A-Practical-Exam---10818-
```

---

## 2. Python Environment

Install the required packages:

```bash
pip install -r requirements.txt
```

Required packages:

```text
pandas
matplotlib
```

Open:

```text
python/analysis.ipynb
```

and run the notebook from the repository root.

---

## 3. SQL

Open your MySQL environment.

Run:

```text
sql/setup.sql
```

first.

Then run:

```text
sql/queries.sql
```

The SQL queries reproduce the analytical results.

---

## 4. Excel

Open:

```text
excel/analysis.xlsx
```

The workbook contains editable formulas, PivotTable analysis, and charts.

---

## 5. Power BI

Open:

```text
powerbi/dashboard.pbix
```

The report uses the CSV files located in:

```text
data/raw/
```

If the repository is cloned to another computer, update the CSV source paths in Power Query if required and refresh the dataset.

---

# 🎥 Project Explanation Video

**Video:** [Add your working video link here]

**Duration:** [Add duration here]

The video demonstrates:

* Project introduction
* Dataset structure
* Duplicate removal
* Excel XLOOKUP and delay calculation
* Excel PivotTable
* SQL analysis
* Python data processing
* Python validation and chart
* Power BI DAX measures
* Power BI hub slicer
* Key findings and recommendation

---

# 🛠️ Tools & Technologies

| Tool            | Purpose                                                      |
| --------------- | ------------------------------------------------------------ |
| Microsoft Excel | Data cleaning, XLOOKUP, SUMIFS, PivotTable and visualization |
| MySQL           | Database creation and analytical SQL queries                 |
| Python          | Data cleaning, transformation, analysis and visualization    |
| Pandas          | Data manipulation                                            |
| Matplotlib      | Data visualization                                           |
| Power BI        | Interactive dashboard and DAX analysis                       |
| Git & GitHub    | Version control and project submission                       |

---

# 👤 Author

**Tushar Bagle**

Data Analyst | Power BI | SQL | Python

GitHub:
https://github.com/TusharBagle

---

# 📜 Authorship Declaration

> All work in this repository is my own except where cited.

---

## 📌 Project Summary

This project demonstrates an end-to-end data analysis workflow:

```text
Raw Data
   ↓
Data Cleaning
   ↓
Excel / SQL / Python / Power BI
   ↓
Data Transformation
   ↓
Delay Analysis
   ↓
Visualization
   ↓
Business Findings
   ↓
Recommendation
```

**Delivery Delay Analysis — Set A**
**Student ID: 10818**
**Tushar Bagle**
