## E-commerce Purchase Intelligence

This project analyzes online shopper behavior using Python, SQL,
machine learning, and business-oriented purchase-intent segmentation.

The goal is to understand which behavioral signals are associated
with purchase sessions and translate those insights into actionable
customer-engagement strategies.

### Project Workflow

Raw Dataset
→ Data Cleaning & EDA
→ SQL Business Analysis
→ Advanced SQL
→ Query Optimization
→ Machine Learning
→ Purchase Probability
→ Intent Segmentation
→ Analytical Dashboard

### SQL Analysis

The project includes:

- Conversion-rate analysis
- Visitor-type analysis
- Monthly performance analysis
- Bounce-rate analysis
- Product engagement analysis
- Weekend vs weekday analysis
- CTEs
- Window functions
- JOIN-based analysis
- Data-quality checks
- Query-performance analysis

A composite index was created on:

`(visitor_type, revenue)`

to optimize purchase-related filtering.

### Machine Learning

Four classification models were evaluated:

| Model | Accuracy | Precision | Recall | F1 Score | ROC-AUC |
|---|---:|---:|---:|---:|---:|
| Decision Tree | 89.97% | 71.22% | 60.17% | 65.23% | **92.30%** |
| Logistic Regression | 88.93% | 77.25% | 41.30% | 53.83% | 89.64% |
| SVM | 89.02% | 76.30% | 43.19% | 55.15% | 87.84% |
| KNN | 87.35% | 66.43% | 38.57% | 48.81% | 77.93% |

The Decision Tree was selected based on its strongest overall
classification performance and highest ROC-AUC.

### Purchase Intent Segmentation

The selected model was used to estimate purchase probability
and divide sessions into three intent groups.

| Intent Segment | Sessions | Purchases | Conversion Rate |
|---|---:|---:|---:|
| Low Intent | 2,542 | 137 | 5.39% |
| Medium Intent | 234 | 129 | 55.13% |
| High Intent | 276 | 211 | 76.45% |

This demonstrates how behavioral predictions can be translated
into actionable engagement segments.

### Key Behavioral Drivers

The Decision Tree identified the following major predictive signals:

- PageValues — 77.21%
- BounceRates — 7.76%
- Month_Nov — 4.52%
- ProductRelated_Duration — 3.98%

PageValues was the dominant predictive feature in the model.

### Business Insights

- High-intent sessions showed substantially higher observed conversion
  than low-intent sessions.
- Product engagement and browsing behavior provide useful signals
  for purchase prediction.
- Bounce-rate behavior can be used as an indicator for identifying
  sessions requiring different engagement strategies.
- Predictive intent segmentation can help prioritize engagement
  efforts toward sessions with stronger purchase signals.

### Important Dataset Limitation

The dataset represents online shopping sessions rather than a
full customer-level transaction history.

Therefore, this project does not claim customer lifetime value,
customer-level retention, or causal relationships.

A production system could extend the approach by combining
session behavior with customer IDs, purchase history, campaign
interactions and downstream conversion outcomes.