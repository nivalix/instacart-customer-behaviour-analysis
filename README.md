# Instacart Customer Behaviour Analysis
This project analyses over 32 million Instacart grocery transactions to understand how customer behaviour data can be used to increase reorder revenue. The analysis combines Python-based machine learning and SQL-based business intelligence to deliver actionable customer segmentation insights.

## Main Question
**How can Instacart use customer behaviour data to increase reorder revenue?**

## Analytical Pipeline

| Layer | Method | Tool | Status |
|-------|--------|------|--------|
| Exploratory Data Analysis | Distribution analysis, data quality validation | Python | Done |
| Customer Segmentation | RFM-inspired K-Means Clustering | Python | Done |
| Business Intelligence | Peak ordering, reorder rate, RFM segmentation | SQL (PostgreSQL) | Done |
| Reorder Prediction | Logistic Regression | Python | Planned |
| Product Classification | Multinomial Naive Bayes | Python | Planned |
| Association Rules | Apriori / FP-Growth | Python | Planned |

## Key Findings

### Python Analysis
- Peak shopping happens between 10AM - 4PM, with Sunday and Monday 
  being the highest order volume days
- K-Means clustering (k=3) identified three distinct customer segments:
  - **The Loyalist**: high frequency, high reorder rate → retention priority
  - **The Newcomer**: low frequency, low reorder rate → onboarding priority  
  - **The Potential Churn**: previously active, declining engagement → re-engagement priority
 
### SQL Analysis
- **Dairy and beverages dominate reorder behaviour**: top reordered products 
  are staple necessities (milk, purified water), indicating reorder revenue is driven by habitual purchasing.
- **Baby and alcohol departments show the highest reorder rates**: needs-based categories create the strongest customer retention.
- **Customer segmentation by frequency** reveals Heavy Buyers place significantly more orders with shorter intervals between purchases, representing the highestlong-term-revenue potential.

## Project Structure
```
instacart-customer-behaviour-analysis/
├── data/                              # Raw CSVs (gitignored, download from Kaggle)
├── sql/
│   ├── 01_setup.sql                   # Schema creation and data loading
│   └── 02_analysis.sql                # Business intelligence queries
├── sql_outputs/                       # SQL query result screenshots
├── notebook_outputs/                  # Python analysis output charts
├── customer_behaviour_analysis.ipynb
├── requirements.txt
└── .gitignore
```

## SQL Queries Overview
Located in `/sql/02_analysis.sql`:
1. **Peak Ordering Behaviour**: order volume by day and hour.
2. **Top Reordered Products**: product-level reorder rate ranking.
3. **Department Reorder Rate**: category-level retention analysis.
4. **Customer Frequency Segments**: light/medium/heavy buyer segmentation using window functions.
5. **RFM Feature Engineering**: recency, frequency, monetary proxy per customer using chained CTEs.

## Dataset
Instacart Online Grocery Shopping Dataset 2017  
[Download from Kaggle](https://www.kaggle.com/datasets/psparks/instacart-market-basket-analysis)

Place the CSV files inside a `/data` folder:
- `aisles.csv`
- `departments.csv`
- `orders.csv`
- `products.csv`
- `order_products__train.csv`
- `order_products__prior.csv`

## Setup

### Python (Notebook)
1. Clone the repository
```bash
git clone https://github.com/nivalix/instacart-customer-behaviour-analysis.git
cd instacart-customer-behaviour-analysis
```
2. Create and activate virtual environment
```bash
python -m venv .venv
# Windows
.venv\Scripts\activate
# Mac/Linux
source .venv/bin/activate
```
3. Install dependencies
```bash
pip install -r requirements.txt
```
4. Open the notebook
```bash
jupyter notebook customer_behaviour_analysis.ipynb
```

### SQL
1. Install PostgreSQL 16 and create a database named `instacart`
2. Run `sql/01_setup.sql` to create tables and load data.
3. Run `sql/02_analysis.sql` to execute the business intelligence queries.
