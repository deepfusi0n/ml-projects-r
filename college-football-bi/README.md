# College Football BI (R) — What Drives Wins & Losses?

**Goal.** Use public college football statistics to understand which factors drive wins and losses, and build simple predictive models.  
**Type.** Business Intelligence + Statistical Modeling (R)  
**Stack** R, tidyverse (dplyr/ggplot2), readr, caret (or tidymodels)

---

## TL;DR
- Cleaned and explored a season-level dataset of college football team metrics.
- Built visualizations (bar charts, distributions) to surface patterns.
- Fit multiple regression models to explain **wins** and **losses** from key features.
- Findings (example highlights):
  - Passing efficiency and explosive plays correlate strongly with **wins**.
  - Penalties/turnovers are strong contributors to **losses**.
- Emphasis: **Data cleaning and feature engineering** were the most important steps—garbage in, garbage out.

---

## Data
- **Source.** Public college football stats (Kaggle-style season/ team metrics).
- **Scope.** ~36 variables across offense, defense, and discipline (e.g., yards/play, third-down %, turnovers, penalties).
- **Granularity.** Team-season.
- **Target variables.** `wins`, `losses` (numeric).

> Note: raw CSVs may be omitted for licensing/size. The pipeline runs with any compatibly-structured CSV in `data/`.

---

## Cleaning & Prep
1. Removed a redundant all-zeros column (pre-R step done quickly in Excel).
2. Normalized column names and data types in R (`readr::type_convert`).
3. Checked missing values; removed/filled as needed.
4. Created features (examples):
   - Efficiency: `yards_per_play`, `third_down_pct`
   - Ball security: `turnovers`, `int`, `fumbles_lost`
   - Explosiveness proxy: big-play counts/ratios (if present)
5. Split into train/test sets (where applicable).

---

## Exploratory Visualizations (R)
- **Highest net passing yards** by team (bar chart).
- **Turnover distribution** across teams (histogram + summary stats).
- Correlations and simple pairwise plots for candidate predictors.

---

## Modeling
- **Wins model:** multiple linear regression using offensive/efficiency metrics.
- **Losses model:** multiple linear regression using “negative” stats (penalties, turnovers, etc.).
- Reported model quality (e.g., RMSE/MAE on test split) and **most significant factors**.
- Example interpretation:
  - Each additional passing TD is associated with a meaningful increase in expected wins (holding other factors constant).
  - Additional penalties increase expected losses.

> These simple models are intentionally explainable for BI storytelling; tree-based models can be added as a robustness check.

---

## Results (Examples)
- **Passing-game efficiency** and **explosive plays** were top drivers of wins.
- **Penalties** and **turnovers** explained a substantial portion of losses.
- Models generalized reasonably on test splits and matched real-team outcomes in spot checks.
<img width="1121" height="633" alt="Screenshot 2025-09-28 at 8 42 43 PM" src="https://github.com/user-attachments/assets/96c33ffc-713a-443a-8f6a-e884f9264b1f" />
<img width="1116" height="629" alt="Screenshot 2025-09-28 at 8 43 09 PM" src="https://github.com/user-attachments/assets/c131ff73-5261-4080-a654-ca9de23a6b7e" />
<img width="1119" height="631" alt="Screenshot 2025-09-28 at 8 44 13 PM" src="https://github.com/user-attachments/assets/bb3fc740-de9f-4cb9-b756-4b466880127c" />

