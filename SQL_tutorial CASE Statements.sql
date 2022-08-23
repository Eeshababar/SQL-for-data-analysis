SELECT ID, account_id, standard_amt_usd/standard_qty AS unit_price
FROM orders

SELECT ID, account_id, CASE WHEN standard_qty = 0 OR standard_qty IS NULL THEN 0 ELSE standard_amt_usd/standard_qty END AS unit_price
FROM orders


The CASE statement always goes in the SELECT clause.

CASE must include the following components: WHEN, THEN, and END. ELSE is an optional component to catch cases that didn’t meet any of the other previous CASE conditions.

You can make any conditional statement using any conditional operator (like WHERE) between WHEN and THEN. This includes stringing together multiple conditional statements using AND and OR.

You can include multiple WHEN statements, as well as an ELSE statement again, to deal with any unaddressed conditions.

In this video, we showed that getting the same information using a WHERE clause means only being able to get one set of data from the CASE at a time.

There are some advantages to separating data into separate columns like this depending on what you want to do, but often this level of separation might be easier to do in another programming language - rather than with SQL.

SELECT account_id, total_amt_usd,
CASE When total_amt_usd > 3000 THEN 'large'
ELSE 'SMALL' END AS total
FROM orders

SELECT account_id, total,
Case WHEN total >= 2000 THEN 'At Least 2000'
WHEN total >= 1000 and total < 2000 THEN 'Between 1000 and 2000'
ELSE 'Less than 1000' END AS t
FROM orders

SELECT account_id, total_amt_usd, CASE WHEN total_amt_usd > 200000 THEN 'Lifetime Value'
WHEN total_amt_usd >= 100000 AND total_amt_usd < 200000 THEN 'second level'
ELSE 'lowest level' END AS total
FROM orders
ORDER BY total

SELECT account_id, occurred_at, total_amt_usd, CASE WHEN total_amt_usd > 200000 THEN 'Lifetime Value'
WHEN total_amt_usd >= 100000 AND total_amt_usd < 200000 THEN 'second level'
ELSE 'lowest level' END AS total
FROM orders
WHERE occurred_at > '2015-12-31'
ORDER BY total

SELECT sales_reps.name, orders.total, CASE WHEN orders.total > 2000 THEN 'top'
ELSE 'not' END As T
FROM sales_reps
JOIN accounts
ON sales_reps.id = accounts.sales_rep_id
JOIN orders
ON accounts.id = orders.account_id

SELECT sales_reps.name, orders.total, orders.total_amt_usd, CASE WHEN orders.total > 200 AND orders.total_amt_usd > 750000
THEN 'top'
WHEN orders.total > 150 AND orders.total_amt_usd > 500000 THEN 'middle'
ELSE 'low' END As T
FROM sales_reps
JOIN accounts
ON sales_reps.id = accounts.sales_rep_id
JOIN orders
ON accounts.id = orders.account_id

Each of the sections has been labeled to assist if you need to revisit a particular topic. Intentionally, the solutions for a particular section are actually not in the labeled section, because my hope is this will force you to practice if you have a question about a particular topic we covered.

You have now gained a ton of useful skills associated with SQL. The combination of JOINs and Aggregations are one of the reasons SQL is such a powerful tool.
