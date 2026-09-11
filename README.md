What Grocery Customers Reorder and When
An analysis of 32 million rows of grocery order data, from someone who delivers it for a living.
Why I did this
Every week as an Asda delivery driver, I load my van with what feels like the exact same items shift after shift. Its usually bananas, milk, and leafy greens. This routine made me wonder if a tiny handful of everyday staples truly dominates grocery reorders, or if customer demand is more diverse than it looks from the driver's seat.
To test my real-world instinct without touching my employer's private data, I brought the domain knowledge from the job, not the company's data, and analysed the public Instacart Market Basket dataset: ~3.4 million orders and 32.4 million order lines, queried with SQL in DuckDB
What I expected vs. what the data showed
What I expected: Driving a delivery van trains your brain to notice patterns. Based on my shifts, I expected a tiny, elite group of around 10 staple products to dominate repeat business and own the lion's share of all grocery reorders.
What the data actually showed: The data disagreed with my real-world bias. The top 10 most-reordered products account for a mere 9.6% of all reorders. Expand the list to the top 100 products, and they still only cover 28%.
The honest conclusion: Grocery reordering is concentrated, but it isn't owned by a few famous items. Widening the net from the top 10 to the top 100 (ten times as many products) only moves the share from 9.6% to 28%, so each product added pulls less weight than the last. That is the signature of a long tail: a few big items at the head, then demand thinning out across a huge catalogue. My driver's eye was only catching the loudest, heaviest items in the crates, but no small set of products owns repeat buying.
The other findings — when people order
	•	The weekend carries the week. Ordering peaks hard on Saturday and Sunday due to weekly shoppings. This matches what I see on the road: those dreadful shifts where the van is packed to the roof because everyone is stocking up for the week.
	•	A daytime shop, not a late-night one. Hourly volume climbs sharply from around 7 AM, peaks at 10–11 AM, holds a broad plateau through mid-afternoon, then tails off in the evening. Customers lock their shopping in during the day, not late at night.
Caveats (the real analyst tell)
	•	Decoding the days. The dataset labels days of the week 0–6 with no key. I inferred 0 and 1 as Saturday and Sunday based on the large order spike on those two days. Weekends are when people are home doing the big shop, which fits both the data and what I see on shift. It's a reasoned judgment, not a documented fact, so I'm flagging it.
	•	The banana split. "Banana" and "Bag of Organic Bananas" are treated as two separate SKUs. To read the single biggest staple honestly, you have to acknowledge the data splits them, even though they occupy the same mental space for the shopper.
Tools & how to reproduce
	•	SQL / DuckDB — all five queries are in queries.sql. DuckDB reads the CSVs directly, so no database import is needed.
	•	Tableau Public — interactive dashboard: https://public.tableau.com/app/profile/imran.ahmed5104/viz/InstacartReorderAnalysis_17891275663150/Dashboard1?publish=yes
	•	Data — public Instacart Market Basket dataset (Kaggle). No proprietary or employer data was used.
