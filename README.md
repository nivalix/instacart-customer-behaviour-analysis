# Instacart Customer Behaviour Analysis
This project performs a set of analysis on over 32 million Instacart grocery transactions to understand purchasing patterns. The goal is to identify actionable insights on how customer behaviour data can be used to increase reorder revenue.

## Main Question
How can Instacart use customer behaviour data to increase reorder revenue?

## Analytical Pipeline:
1. EDA                 : Understand distribution and validate data quality
2. K-Means             : Segment/group customers by purchasing behaviour
3. Logistic Regression : Predict item-level reorder probability (Future Work)
4. Naive Bayes         : Auto-classify products into departments (Future Work)
5. Apriori / FP Growth : Discover product association rules for bundling (Future Work)

## Dataset
Instacart Online Grocery Shopping Dataset 2017
(https://www.kaggle.com/datasets/psparks/instacart-market-basket-analysis)

Download the dataset from Kaggle and place the CSV files inside a `/data` folder:
- `aisles.csv`
- `departments.csv`
- `orders.csv`
- `products.csv`
- `order_products__train.csv`
- `order_products__prior.csv`

## Setup
1. Clone the repository
````bash
    git clone https://github.com/nivalix/instacart-customer-behaviour-analysis.git
    cd instacart-customer-behaviour-analysis
````

2. Create and activate virtual environment
````bash
    python -m venv .venv

    # Windows
    .venv\Scripts\activate

    # Mac/Linux
    source .venv/bin/activate
````
   
3. Install dependencies
````bash
    pip install -r requirements.txt
````
4. Open the notebook
````bash
    jupyter notebook customer_behaviour_analysis.ipynb
````

## Key Findings
*Will be updated upon project completion.*

