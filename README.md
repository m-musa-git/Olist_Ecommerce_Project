
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
### Customer Acquisition & Retention
- Customers who used vouchers had an 86% repeat purchase rate (3x higher than other payment methods).
- Credit cards as a payment method accounted for 76% of the total revenue and the highest average order value (R$125.69) but only 1.2 orders per customer.
- The top category for both credit card and voucher (Payment options with the highest repeat purchase rates) users was bed/bath accounting for 10% and 11% respectively.
- Debit cards accounted for the lowest repeat purchase rate (21.7%) and the lowest order frequency (1.14 orders/customer).
<img width="1511" height="431" alt="image" src="https://github.com/user-attachments/assets/a5f11249-b0c5-40d3-ba2d-4300026d25f1" />

<img width="1115" height="145" alt="image" src="https://github.com/user-attachments/assets/c64ee026-7f30-47fd-98df-716f11dac944" />

### Geographic Targeting
- Health/Beauty was among the top 3 best selling categories for 10 out of the 12 states in the dataset.
- The most common pairs of categories were: (Health/Beauty, Sports/Leisure) which appeared in 10 states (BA, DF, ES, GO, PE, PR, RJ, RS, SC, SP), (Health/Beauty, Bed/Bath/Table) which appeared in 9 states (DF, ES, GO, MG, PR, RJ, RS, SC, SP) and (Bed/Bath/Table, Sports/Leisure) which appeared in 8 states (DF, ES, GO, PR, RJ, RS, SC, SP). 
- All of the products sold in Ceará were from the categories Health/Beauty and Watches/Gifts.
- 69.2% of all sales for the category Watches/Gifts came from 2 states: Pernambuco and Ceará.
<img width="1282" height="330" alt="image" src="https://github.com/user-attachments/assets/2c3151f5-735d-4544-8273-c801ae0ea6a7" />

### Financial Risk Management
- Despite representing 9.1% of the payment methods chosen by customers(Only definitive failures), vouchers accounted for 14.7% of all cancellations.
- 81% of non-delivered voucher orders end in cancellation, a much higher rate compared to its counterparts  49.1% for credit cards, 46.7% for debit cards and 40.9% for boleto).
- Boleto had a higher percentage of orders in the processing stage (30%) compared to its counterparts.
- Debit Cards had a higher percentage of orders in the invoiced stage (40%) compared to its counterparts.
<img width="1150" height="433" alt="image" src="https://github.com/user-attachments/assets/829d229e-7175-4ed4-ba1b-3a1fe0a36d8c" />

### Delivery Performance & Customer Satisfaction
- There is a strong correlation between late deliveries and the percentage of low reviews, with said percentage nearly tripling between ideal delivery performance (1-3 days) and late delivery performance (4-7).
- Orders arriving >3 days early have 4.3 avg rating (9.1% low ratings).  
- Late (4-7) and Very late (8+d) orders each had a median score of 1.0 and a mean score of 2.2 and 1.7 respectively.
- 6 of the top 10 sellers by late delivery impact had a late delivery percentage >= 10%.
- Nearly all late sellers had deliveries late by more than 10 days.
<img width="1620" height="458" alt="image" src="https://github.com/user-attachments/assets/d296bbd8-feb0-4eba-8c7d-2201b4acf0a9" />

### Quarterly Sales Trends
#### Caveat: These categories were specifically chosen since they are the 3 most profitable categories: Bed/Bath Table (R$1710261.96), Health/Beauty (R$1651310.96) and Computer Accessories (R$1582933.75)
- Computer accessories had the sharpest decline in AOV (average order value) out of the 3 categories: Going from R$288.98 in Q4-2017 to R$158.17 in Q3-2018.
- Health/Beauty had a marginal increase in AOV from Q1 to Q2 in 2017 and 2018 (Going from R$175.99 to R$192.71 in 2017 and from R$179.7 to R$191.15 in 2018).
- Bed/Bath table and Health/Beauty had the same trends in terms of quarterly revenue.
- Computer Accessories had the sharpest decline in revenue: Going from R$497936.57 in Q1 2018 to R$122268.15 in Q3 2018 which is lower than any quarterly revenue it had except for Q1 2017
- Q3 2018 was the only quarter where revenue for all 3 categories declined.
<img width="1546" height="367" alt="image" src="https://github.com/user-attachments/assets/c7d12476-b163-440b-97ca-d7347bb986f7" />

## Recommendations
#### Payment-Led Growth Strategies: Optimizing Methods by Category Potential
- **Capitalize on Voucher Loyalty:** Expand voucher rewards for high-retention categories like bed/bath, leveraging their 86% repeat purchase rate.
- **Boost Credit Card Utilization:** Target credit card promotions toward high-AOV categories, given their R$125+ average order value.
- **Strengthen Credit & Voucher Partnerships in Bed/Bath category:** Bed/Bath represents 10–11% of sales for both credit cards (high AOV) and vouchers (high retention). Consider exclusive perks for repeat Bed/Bath purchases falling under these payment types.

#### Regional Growth Levers: Bundling, Pricing & Niche Expansion
- **Bundling Opportunities:** Create cross-category bundles pairing Health/Beauty with Sports/Leisure (10 states) and Bed/Bath/Table (9 states), leveraging their frequent co-purchase patterns.
- **Dynamic Pricing:** Offer discounts on Bed/Bath/Table when purchased with Health/Beauty in states like DF and GO, where their pairing is strongest.
- **Watches/Gifts as Niche Focus:** Expand this category’s inventory exclusively in Ceará and Pernambuco, where it already shows organic traction. Consider testing localized promotions.

#### Payment Risk Mitigation Strategies
- **Implement Voucher Limits:** Cap voucher use at a low percentage of total cart value to discourage high-risk cancellations. Increase the percentage gradually for repeat customers to reward loyalty while curbing fraud.
- **Pre-Authorize Funds:** Partner with banks to hold debit card amounts during "invoiced" status, reducing cancellations.
- **Boleto Processing Optimization:** To reduce the number of boleto orders with "processed" status, add a countdown timer when checking out.

#### Decline Reversal & Growth Acceleration
- **Address the decline in Computer Accessories sales:** Sharp AOV decline (R$288 → R$158) and revenue collapse (R$497K → R$122K) suggest severe margin pressure. Look into what factors could have caused this sort of decline from Q4-2017 to Q3-2018.
- **High-Impact Product Pairings":** Bed/Bath/Table sales parallel declines with Computer Accessories (R$269K → R$198K) which may indicate a shared issue. Compare customer demographics/order timings of both categories to identify potential overlaps.
- **Health/Beauty Growth Acceleration:** Consistent AOV growth (R$175 → R$192) indicates premiumization potential. Consider expanding the stock of items falling under the Health/Beauty category.














