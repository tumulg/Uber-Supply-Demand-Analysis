# Uber Supply-Demand Gap Analysis

**PostgreSQL | Python | Power BI**

## 📌 Project Overview

This comprehensive data analytics project analyzes Uber ride request data across 6,745 requests to identify critical supply-demand gaps and operational inefficiencies. The project demonstrates end-to-end data pipeline capabilities, from database management to executive-level business intelligence insights revealing systematic revenue opportunities.

## 📂 Project Background

**Uber Request Dataset**: Multi-dimensional ride-sharing data from July 2016, including pickup locations, driver assignments, trip statuses, and temporal patterns across airport and city operations representing real-world transportation challenges in urban markets.

## 📁 Project File Structure

**[SQL Pipeline](./SQL/)**: Data extraction, cleaning, and preprocessing scripts establishing the analytical foundation through database setup, timestamp standardization, derived field creation, and business logic validation for analysis-ready datasets.

**[Python Analytics](./Python/)**: Advanced exploratory data analysis and statistical modeling using comprehensive EDA to uncover supply-demand patterns, driver utilization insights, and temporal behavior analysis with custom visualizations revealing operational crisis zones.

**[Power BI Intelligence](./Power%20BI/)**: Executive-level dashboard creation transforming cleaned data into interactive business intelligence reports featuring hourly demand patterns, geographic analysis, supply-demand gap visualization, and strategic operational insights.

**[Dataset](./Dataset/)**: Processed ride request data with timestamp standardization and derived analytical fields optimized for multi-tool analysis pipeline and dashboard creation.

## 📈 Problem Statement & Business Context

This project explores critical operational challenges by analyzing Uber ride request data using SQL, Python, and Power BI to unlock revenue recovery opportunities in an increasingly competitive ride-sharing market.

* How do temporal demand patterns reveal systematic supply-demand mismatches during peak revenue periods?
* What geographic disparities in service reliability represent the highest-impact operational intervention opportunities?
* Which driver utilization patterns contribute to systematic cancellation behavior affecting customer experience?
* What correlation between location, time, and trip failure rates enables predictive modeling for capacity planning?
* How do supply shortage patterns create actionable business intelligence for immediate revenue recovery strategies?

## 🛠️ Tools & Technologies Used

* **PostgreSQL** – Used for data storage, cleaning, and transformation with mixed timestamp format resolution handling 6,745 records across temporal and geographic dimensions
* **pgAdmin4** – Served as the database interface to manage schema design, execute cleaning scripts, and validate business logic for failed trip handling
* **Python** – Used for comprehensive exploratory data analysis, supply-demand pattern discovery, driver utilization analysis, and creating statistical insights with correlation modeling
* **Power BI** – Designed interactive dashboard transforming analytical findings into executive-level business intelligence with 5 key visualizations and live PostgreSQL connectivity
* **VS Code** – For writing, organizing, and documenting the codebase across SQL scripts, Python analytics, and project documentation
* **Git & GitHub** – Facilitated version control and management of all scripts, datasets, and dashboards for professional portfolio presentation

## 🧮 [SQL Data Preparation & Analysis](./SQL/)

* **[Database Setup](./SQL/)**: Successfully created structured PostgreSQL database with uber_requests table handling 6,745 records with proper schema design for mixed timestamp formats and operational data integrity
* **[Timestamp Standardization](./SQL/4_cleaning.sql)**: Resolved critical mixed date formats (4,071 DD-MM-YYYY + 2,674 MM/DD/YYYY) into consistent datetime fields enabling accurate temporal analysis and derived field creation
* **[Derived Field Creation](./SQL/4_cleaning.sql)**: Generated request_hour (0-23) for hourly analysis and 7 logical time_slot categories (Night through Late Night) creating analysis-ready dimensions for business intelligence
* **[Business Logic Validation](./SQL/4_cleaning.sql)**: Confirmed drop_timestamp null values for failed trips (58% of requests) ensuring data integrity and proper handling of incomplete journey records
* **Integration Foundation**: Cleaned SQL outputs provide validated foundation for Python statistical analysis and Power BI dashboard creation with consistent data quality across analytical pipeline

## 🐍 [Python Data Analysis](./Python/)

* **[Data Pipeline](./Python/eda.ipynb)**: Connected directly to PostgreSQL using SQLAlchemy with pandas integration for seamless data extraction ensuring analysis on most current cleaned datasets
* **[Statistical Validation](./Python/eda.ipynb)**: Comprehensive data quality verification confirming 100% completeness for operational fields with business logic validation for systematic pattern analysis
* **[Critical Pattern Discovery](./Python/eda.ipynb)**: Identified Airport 53% supply shortage vs City 30% cancellation rates, revealing location-specific operational challenges requiring differentiated intervention strategies
* **[Driver Utilization Analysis](./Python/eda.ipynb)**: Discovered 300 active drivers handling 4,095 requests while 2,650 requests receive no assignment, with 31% cancellation rate among assigned rides indicating systematic behavior issues
* **[Temporal Insights](./Python/eda.ipynb)**: Quantified 6 PM peak demand (510 requests) coinciding with 75.8% Airport failure rates and Early Morning 70.7% City cancellation patterns enabling predictive capacity planning
* **Business Intelligence**: Evening and Early Morning periods account for 45% of total demand but show highest failure rates, creating clear targeting for surge pricing and driver incentive interventions

## 📊 [Power BI Dashboard](./Power%20BI/)

* **Data Pipeline**: Connected Power BI directly to PostgreSQL using native connector with live refresh capability ensuring real-time analytical updates and enterprise-grade data architecture

**[Dashboard Visualizations](./Power%20BI/Uber%20Supply%20Demand%20Dashboard.png)**:
 - **[Hourly Demand Pattern](./Power%20BI/Charts/UberViz1%20-%20Hourly%20Demand%20Pattern.png)**: 24-hour demand analysis revealing 6 PM peak (510 requests) and bimodal distribution patterns for capacity planning and resource allocation optimization
 - **[Time Slot Distribution](./Power%20BI/Charts/UberViz2%20-%20Demand%20by%20Time%20Slot.png)**: Evening and Early Morning dominance (45% of total demand) identifying critical periods requiring priority operational focus and driver incentive programs
 - **[Geographic Balance](./Power%20BI/Charts/UberViz3%20-%20Requests%20by%20Pickup%20Point.png)**: City vs Airport comparison (52% vs 48%) confirming balanced market coverage requiring equal operational attention across both service areas
 - **[Supply-Demand Gap Treemap](./Power%20BI/Charts/UberViz5%20-%20Supply%20Demand%20Gaps%20by%20Location%20and%20Time.png)**: Visual crisis zone identification showing City morning cancellations and Airport evening supply shortages with location-time intervention targeting
 - **[Status Breakdown Analysis](./Power%20BI/Charts/UberViz4%20-%20Trip%20Status%20by%20Time%20Period.png)**: Temporal failure rate patterns revealing different failure types (supply vs cancellation) requiring time-specific operational solutions
* **Business Takeaways**: 58% overall failure rate representing massive revenue recovery opportunity, 81.3% Airport evening failure rate, and 70.7% City morning cancellation crisis requiring immediate intervention

## 📄 [Documentation](Uber%20Analysis%20Report.pdf)

Comprehensive project documentation including **[Project Report](Uber%20Analysis%20Report.pdf)** available for detailed methodology review, containing technical implementation details, business impact quantification, and strategic recommendations for operational improvements.

## 🔚 Conclusion

* **Key Insights**: Analysis reveals systematic 58% failure rate with two primary crisis zones - Airport evening supply shortage (81.3% failure) and City morning cancellation patterns (70.7% failure) representing immediate revenue recovery opportunities worth significant operational investment
* **Final Thoughts**: This multi-tool analysis successfully transforms raw operational data into actionable business intelligence, demonstrating enterprise-level data architecture while delivering quantified revenue opportunities and targeted intervention strategies essential for ride-sharing operational excellence and market competitiveness