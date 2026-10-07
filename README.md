# What grocery customers reorder — and when

**Short answer:** reordering is concentrated but not *owned* — the top 100 products out of ~50,000 drive only 28% of all reorders, so there's a long tail of items people quietly buy again and again.

**Dashboard:** https://public.tableau.com/app/profile/imran.ahmed5104/viz/InstacartReorderAnalysis_17891275663150/Dashboard1?publish=yes

## Why I did this

Every week as an Asda delivery driver, I load my van with what feels like the exact same items shift after shift — usually bananas, milk, and leafy greens. This routine made me wonder if a tiny handful of everyday staples really dominates grocery reorders, or if demand is more diverse than it looks from the driver's seat.

To test my real-world instinct without touching my employer's private data, I brought the domain knowledge from the job — not the company's data — and analysed the public Instacart Market Basket dataset: ~3.4 million orders and 32.4 million order lines, queried with SQL in DuckDB.

## What I expected vs. what the data showed

Going in, I expected a tiny, elite group of around 10 staple products to dominate repeat business and own the lion's share of all grocery reorders. Driving a delivery van trains your brain to notice patterns, and that's the pattern I thought I was seeing.

The data disagreed:

- The top 10 most-reordered products account for a mere **9.6%** of all reorders.
- Widen the net to the top 100 products and they still only cover **28%**.

Ten times as many products, but only three times the share — so each product added pulls less weight than the last. That's the signature of a **long tail**: a few big items at the head, then demand thinning out across a huge catalogue. My driver's eye was only catching the loudest, heaviest items in the crates — but no small set of products owns repeat buying.

## The other findings — when people order

- **The weekend carries the week.** Ordering peaks hard on **Saturday and Sunday**. This matches what I see on the road: those shifts where the van is packed to the roof because everyone is stocking up for the week.
- **A daytime shop, not a late-night one.** Hourly volume climbs sharply from around 7 AM, peaks at **10–11 AM**, holds a broad plateau through mid-afternoon, then tails off in the evening. Customers lock their shopping in during the day, not late at night.

## Caveats (the real analyst tell)

- **Decoding the days.** The dataset labels days of the week `0`–`6` with no key. I inferred `0` and `1` as Saturday and Sunday from the large order spike on those two days — weekends are when people are home doing the big shop, which fits both the data and what I see on shift. It's a reasoned judgment, not a documented fact, so I'm flagging it.
- **The banana split.** "Banana" and "Bag of Organic Bananas" are treated as two separate SKUs. To read the single biggest staple honestly, you have to acknowledge the data splits them, even though they occupy the same mental space for the shopper.

## The data

- **Orders & products:** public Instacart Market Basket dataset ([Kaggle](https://www.kaggle.com/c/instacart-market-basket-analysis)) — ~3.4 million orders, 32.4 million prior order lines. No proprietary or employer data was used.

## Tools & how to reproduce

SQL in DuckDB (joins, aggregation, a hand-built share-of-total check), Tableau Public for the dashboard.

All five queries are in [`queries.sql`](queries.sql). DuckDB reads the CSVs directly, so there's no database import step — point it at the files and run.
