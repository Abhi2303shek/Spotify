# 🎧 Music Industry Intelligence Using SQL

### Turning Streaming Data into Strategic Market Insights

---

## 📌 Project Overview

This project analyses a Spotify-style dataset by treating it as a **digital content marketplace**, not just a collection of songs.

Instead of asking *“Which song is most popular?”*The analysis explores deeper structural questions:

* Is popularity concentrated among a small group of artists?
* Are certain genres oversupplied yet underperforming?
* Do collaborations statistically improve performance?
* Does explicit content influence engagement?
* Is there an optimal duration range for higher popularity?
* What defines the structural profile of the top 10% tracks?

The objective was to move beyond basic aggregation and model the music ecosystem like a performance portfolio.

---

## 🧠 Analytical Framework

The dataset includes:

* Track-level metadata
* 11 separate artist columns (denormalised schema)
* Popularity scores
* Duration
* Explicit flag
* Genre and album information

To ensure analytical rigour:

* Artist columns were normalised using `UNION ALL` to eliminate schema bias
* Pareto (80/20) concentration analysis was performed to measure artist dominance
* Top 10% tracks were identified using `NTILE()` (MySQL-compatible percentile logic)
* Pearson correlation was implemented manually using the mathematical formula
* Variance was used to measure consistency vs volatility
* A multi-factor scoring model was built to define a structured “Hit Profile”

This ensured the results were statistically sound and strategically meaningful.

---

## 📊 Strategic Insights

* Popularity is highly concentrated — a small fraction of artists drive a disproportionate share of high-performing tracks.
* Song duration shows negligible linear correlation with popularity.
* Some genres demonstrate high production volume but lower per-track efficiency.
* Collaboration impact becomes visible only after proper normalisation.
* Top 10% tracks follow identifiable structural patterns.

These insights shift the analysis from descriptive reporting to performance intelligence.

---

## 🎯 Business Applications

If applied in a real-world setting:

**Streaming Platforms**

* Identify high-consistency artists beyond viral spikes
* Detect scalable genre opportunities

**Record Labels**

* Optimise release strategies (quality vs quantity trade-offs)
* Evaluate collaboration effectiveness

**Data & Analytics Teams**

* Understand how schema design affects analytical accuracy
* Move from aggregate dashboards to structural insight

---

## 🛠 Technical Skills Demonstrated

* Advanced CTE structuring
* Window functions (`NTILE`, cumulative sums)
* Manual Pearson correlation implementation
* Percentile modelling without `PERCENTILE_CONT`
* Variance and volatility analysis
* Pareto concentration logic
* Multi-factor scoring design

---

## Author

**Abhishek Singh**
Data Analyst | Business Analyst | Business Strategist
