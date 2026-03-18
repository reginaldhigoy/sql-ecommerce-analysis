# SQL Ecommerce Analysis  
### Website Conversion Performance Case Study

Dataset available here:
https://drive.google.com/file/d/1Z8Y-1Gu_FsaCStLI8vsk7-t0x85iQD-n/view?usp=sharing

## Project Overview

This project analyzes an ecommerce website's traffic and purchasing behavior using SQL.

The goal is to understand **how effectively website traffic converts into purchases** and identify opportunities to improve the conversion funnel.

The analysis explores marketing channels, device performance, website pages, and product revenue to generate actionable business insights.

---

## Business Question

**How effectively does website traffic convert into purchases, and where can the conversion process be improved?**

---

## Analysis Areas

This case study covers the following analyses:

1. Website traffic sources
2. Overall conversion rate
3. Conversion rate by marketing channel
4. Campaign performance
5. Device performance
6. Most visited pages
7. Purchase funnel analysis
8. Product revenue performance
9. Product profitability

---

## Dataset

The dataset simulates an ecommerce company's website analytics data.

Tables used in the analysis:

**website_sessions**  
Contains website visit information and marketing attribution.

**website_pageviews**  
Tracks the pages visited during each session.

**orders**  
Stores completed purchase transactions.

**order_items**  
Contains product-level order details including price and cost.

**products**  
Contains product information.

*Note: The dataset is not included due to file size limitations.*

---

## Tools Used

- SQL
- Relational database analysis
- Data analysis techniques

---

## Key Insights

### Website Traffic
Most website traffic originates from **Google search advertising**, making it the primary acquisition channel.

---

### Conversion Rate
The overall website conversion rate is approximately **7%**, meaning about 7 out of every 100 sessions result in a purchase.

---

### Marketing Channel Performance
Direct traffic shows the **highest conversion rate**, suggesting strong purchase intent from returning or brand-aware visitors.

Google search campaigns drive the **largest volume of traffic and orders**.

---

### Device Performance
Desktop users convert significantly better than mobile users.

Desktop conversion rate: **8.50%**  
Mobile conversion rate: **3.09%**

This suggests possible usability or checkout friction on mobile devices.

---

### Website Funnel Analysis

Funnel conversion rates:

Session → Product Page: **55%**  
Product Page → Cart: **36%**  
Cart → Shipping: **68%**  
Shipping → Billing: **75%**  
Billing → Order: **67%**

The largest drop-off occurs between the **product page and cart stage**, indicating potential product page friction.

---

### Product Performance

**The Original Mr. Fuzzy** is the company's top-performing product in both:

- Revenue
- Profit

This product generates over **$1.2M in revenue** and **$738K in profit**, indicating strong demand but also a dependency risk.

---

## Business Recommendations

Based on the analysis, potential improvements include:

- Improve product page design and call-to-action visibility
- Optimize the mobile checkout experience
- Improve product messaging and pricing communication
- Diversify product offerings to reduce reliance on a single flagship product

---
## SQL Queries

All SQL queries used for this analysis can be found in:

`ecommerce_analysis.sql`

The queries include:

- Traffic analysis
- Conversion rate calculations
- Marketing campaign performance
- Device performance analysis
- Page popularity analysis
- Funnel drop-off analysis
- Revenue and profitability analysis

---

## Project Structure
sql-ecommerce-analysis
│
├── conversion_analysis.sql
└── README.md

---

## Author

**Reginald Higoy**

SQL Portfolio Project  
Website Conversion Performance Analysis
