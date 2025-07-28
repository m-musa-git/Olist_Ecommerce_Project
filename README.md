# Olist Ecommerce Analysis

## Project Background
Founded in 2015, Olist is a Brazilian e-commerce platform that operates as a marketplace integrator. Unlike standalone marketplaces such as Amazon, Olist connects small and medium-sized businesses with major online sales channels like Amazon Brazil and Mercado Livre.

The platform provides a publicly available dataset of around 100,000 anonymized e-commerce orders placed between 2016 and 2018. The dataset contains critical e-commerce data regarding customer and seller details, order records, customer reviews and geolocations. This project analyzes this data in order to uncover actionable insights and recommendations to improve performance across marketing, sales, product and finance teams. Regarding the previously mentioned categories, the analysis is focused on the following key metrics:

- **Customer Acquisition & Retention:** *"How do payment methods influence repeat purchase behavior, and which should we incentivize?"* 

- **Geographic Targeting:** *"Which regions have untapped demand for high-margin categories like Health/Beauty?"*  

- **Financial Risk Management:** *"Which payment methods correlate with cancellations/fraud, and how can we mitigate them?"* 

- **Delivery Performance & Customer Satisfaction:** *"Is there a relationship between delivery performance and review scores?"*

- **Quarterly Sales Trends:** *"How do revenue and AOV fluctuate seasonally, and how can we optimize campaigns or inventory around those peaks?"*

## Data Structure

<img width="1706" height="732" alt="Screenshot 2025-07-24 151953" src="https://github.com/user-attachments/assets/bed557b7-c7cb-4aeb-90ee-06928af5aed0" />

## Executive Summary
Analysis of 100K orders reveals three high-impact opportunities to grow revenue and reduce risk:

- **Voucher Loyalty Potential:** Voucher users show 3x higher repeat rates (86% vs. 21.7-49.1% for other payment methods) and dominate bed/bath purchases (11% category share). However, their 81% cancellation rate for non-delivered orders requires mitigation.

- **Regional Inventory Alignment:** Health/Beauty is a top-3 category in 10/12 states and pairs strongly with Sports/Leisure (10 states) and Bed/Bath (9 states). Watches/Gifts show hyper-local demand (69.2% sales from just Pernambuco/Ceará).

- **Delivery Quality Crisis:** Late deliveries (4+ days) crater ratings (mean 1.7-2.2 vs. 4.3 for early deliveries), with 6/10 worst offenders having ≥10% late delivery rates.

## Insights Deep-Dive
### Customer Acquisition & Retention:
- Customers who used vouchers had an 86% repeat purchase rate (3x higher than other payment methods)
- Credit cards as a payment method accounted for 76% of the total revenue and the highest average order value (R$125.69) but only 1.2 orders per customer 
- The top category for both credit card and voucher (Payment options with the highest repeat purchase rates) users was bed/bath accounting for 10% and 11% respectively 
- Debit cards accounted for the lowest repeat purchase rate (21.7%) and the lowest order frequency (1.14 orders/customer)
