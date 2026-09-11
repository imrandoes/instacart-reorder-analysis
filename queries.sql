-- Q1: Top reordered products (tests "staples drive reorders")
SELECT p.product_name, COUNT(*) AS times_reordered
FROM 'order_products__prior.csv' op
JOIN 'products.csv' p ON op.product_id = p.product_id
WHERE op.reordered = 1
GROUP BY p.product_name
ORDER BY times_reordered DESC
LIMIT 15;

-- Q2: Orders by day of week
SELECT order_dow, COUNT(*) AS num_orders
FROM 'orders.csv'
GROUP BY order_dow
ORDER BY num_orders DESC;

-- Q3: Orders by hour of day (shape of the day)
SELECT order_hour_of_day, COUNT(*) AS num_orders
FROM 'orders.csv'
GROUP BY order_hour_of_day
ORDER BY CAST(order_hour_of_day AS INTEGER);

-- Q4: Total reorders across whole prior file (the denominator)
SELECT COUNT(*) FROM 'order_products__prior.csv' WHERE reordered = 1;

-- Q5: Share of reorders owned by top 10 / top 100 products (concentration)
SELECT SUM(times_reordered) AS top_reorders
FROM (
    SELECT p.product_name, COUNT(*) AS times_reordered
    FROM 'order_products__prior.csv' op
    JOIN 'products.csv' p ON op.product_id = p.product_id
    WHERE op.reordered = 1
    GROUP BY p.product_name
    ORDER BY times_reordered DESC
    LIMIT 100
);
