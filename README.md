# 🎧 Music Industry Intelligence Using SQL

### Turning Streaming Data into Strategic Market Insights

---

## 📌 Project Overview

This project goes beyond basic SQL analysis and treats a Spotify-style music dataset as a **digital content marketplace**.

Instead of asking *“Which song is most popular?”*This analysis answers:

* Is popularity concentrated among a few artists?
* Are some genres oversupplied yet underperforming?
* Do collaborations statistically improve performance?
* Does explicit content influence engagement?
* Is there an optimal duration for hits?
* What structural traits define the top 10% tracks?

The goal was not just querying — but **modelling the music ecosystem like a portfolio**.

---

## 🧠 Analytical Framework

The dataset contained:

* Track-level metadata
* 11 separate artist columns (denormalised schema)
* Popularity scores
* Duration
* Explicit flag
* Genre & album information

To ensure analytical accuracy:

* Artist columns were normalised using `UNION ALL` to remove schema bias
* Pareto (80/20) concentration analysis was performed
* Top 10% tracks were identified using `NTILE()` (MySQL-compatible percentile logic)
* Pearson correlation was implemented manually (since MySQL lacks `PERCENTILE_CONT`)
* Variance was used to measure consistency vs volatility
* Multi-factor scoring was built to model a “Hit Profile”

This ensured results were statistically meaningful, not surface-level.

---

## 📊 Strategic Insights Uncovered

* Popularity is highly concentrated — a small fraction of artists drive a disproportionate share of hits.
* Duration shows almost no linear correlation with popularity.
* Certain genres exhibit high production volume but low per-track efficiency.
* Collaboration influence becomes visible only after proper normalisation.
* Top 10% tracks follow identifiable structural patterns.

These findings shift the analysis from descriptive reporting to decision intelligence.

---

## 🎯 Business Applications

If applied in a real-world scenario:

**Streaming Platforms**

* Identify mid-tier artists with strong consistency
* Detect undervalued genres with scalable potential

**Record Labels**

* Optimise release strategies (volume vs quality trade-offs)
* Leverage collaboration patterns strategically

**Data Teams**

* Understand how schema design impacts analytical truth
* Move from aggregate reporting to structural modelling

---

## 🛠 Technical Skills Demonstrated

* Advanced CTE structuring
* Window functions (`NTILE`, cumulative sums)
* Manual Pearson correlation implementation
* Percentile modelling without built-in functions
* Variance & volatility analysis
* Pareto distribution logic
* Multi-factor scoring design

---

## 🚀 Why This Project Stands Out

Most music data projects stop at ranking top tracks.

This project:

* Questions schema bias
* Validates statistical correctness
* Applies portfolio logic
* Extracts decision-grade insights

It demonstrates the ability to think like:

* An Analyst
* A Strategist
* And a Data Professional

Not just a SQL user.

## Author:
Abhishek Singh
Data Analyst| Business Analyst| Business Strategist
