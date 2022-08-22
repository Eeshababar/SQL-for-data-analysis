The key takeaways here:

GROUP BY can be used to aggregate data within subsets of the data. For example, grouping for different accounts, different regions, or different sales representatives.


Any column in the SELECT statement that is not within an aggregator must be in the GROUP BY clause.


The GROUP BY always goes between WHERE and ORDER BY.


ORDER BY works like SORT in spreadsheet software.

GROUP BY - Expert Tip
Before we dive deeper into aggregations using GROUP BY statements, it is worth noting that SQL evaluates the aggregations before the LIMIT clause. If you don’t group by any columns, you’ll get a 1-row result—no problem there. If you group by a column with enough unique values that it exceeds the LIMIT number, the aggregates will be calculated, and then some rows will simply be omitted from the results.

This is actually a nice way to do things because you know you’re going to get the correct aggregates. If SQL cuts the table down to 100 rows, then performed the aggregations, your results would be substantially different. The above query’s results exceed 100 rows, so it’s a perfect example. In the next concept, use the SQL environment to try removing the LIMIT and running it again to see what changes.


SELECT accounts.name, orders.occurred_at
FROM accounts
JOIN orders
On accounts.id = orders.account_id
ORDER BY orders.occurred_at
LIMIT 1

Groupby example

SELECT accounts.name, SUM(orders.total_amt_usd)AS total
FROM accounts
JOIN orders
ON accounts.id = orders.account_id
GROUP BY accounts.name

SELECT accounts.name, web_events.channel, web_events.occurred_at
FROM accounts
JOIN web_events
ON web_events.account_id = accounts.id
ORDER BY web_events.occurred_at DESC
LIMIT 1

SELECT web_events.channel, COUNT(*)
FROM web_events
GROUP BY web_events.channel


SELECT web_events.occurred_at, accounts.primary_poc
FROM web_events
JOIN accounts
ON accounts.id = web_events.account_id
ORDER BY web_events.occurred_at
LIMIT 1  #Older the date is, biggest it is considered in ORDER BY


SELECT min(orders.total) AS Minimum, accounts.name
FROM orders
JOIN accounts
ON orders.account_id = accounts.id
GROUP BY accounts.name
ORDER BY Minimum

SELECT region.id, COUNT(sales_reps.id)
FROM region
JOIN sales_reps
ON sales_reps.region_id = region.id
GROUP BY region.id
ORDER BY COUNT(sales_reps.id)

Key takeaways:

You can GROUP BY multiple columns at once, as we showed here. This is often useful to aggregate across a number of different segments.

The order of columns listed in the ORDER BY clause does make a difference. You are ordering the columns from left to right.
GROUP BY - Expert Tips
The order of column names in your GROUP BY clause doesn’t matter—the results will be the same regardless. If we run the same query and reverse the order in the GROUP BY clause, you can see we get the same results.


As with ORDER BY, you can substitute numbers for column names in the GROUP BY clause. It’s generally recommended to do this only when you’re grouping many columns, or if something else is causing the text in the GROUP BY clause to be excessively long.


A reminder here that any column that is not within an aggregation must show up in your GROUP BY statement. If you forget, you will likely get an error. However, in the off chance that your query does work, you might not like the results!

SELECT accounts.name, AVG(orders.gloss_qty) Gloss, AVG(orders.poster_qty) Poster, AVG(orders.standard_qty) Standard
FROM accounts
JOIN orders
ON orders.account_id = accounts.id
GROUP BY accounts.name

SELECT accounts.name, AVG(orders.standard_amt_usd) stand, AVG(orders.gloss_amt_usd) gloss, AVG(poster_amt_usd) poster
FROM accounts
JOIN orders
ON accounts.id = orders.account_id
GROUP BY accounts.name

SELECT sales_reps.id, web_events.channel, COUNT(*)
FROM web_events
JOIN accounts
ON web_events.account_id = accounts.id
JOIN sales_reps
ON sales_reps.id = accounts.sales_rep_id
GROUP BY sales_reps.id, web_events.channel
ORDER BY COUNT(*)

SELECT r.name, w.channel, COUNT(*) num_events
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name, w.channel
ORDER BY num_events DESC;

Distinct

DISTINCT is always used in SELECT statements, and it provides the unique rows for all columns written in the SELECT statement. Therefore, you only use DISTINCT once in any particular SELECT statement.

You could write:

SELECT DISTINCT column1, column2, column3
FROM table1;
which would return the unique (or DISTINCT) rows across all three columns.

You would not write:

SELECT DISTINCT column1, DISTINCT column2, DISTINCT column3
FROM table1;
You can think of DISTINCT the same way you might think of the statement "unique".

DISTINCT - Expert Tip
It’s worth noting that using DISTINCT, particularly in aggregations, can slow your queries down quite a bit.


SELECT COUNT(accounts.name)  AS nam, COUNT(accounts.id) AS i, COUNT(region.name) AS regio, COUNT(region.id) AS regid
 FROM accounts
 JOIN sales_reps
 ON sales_rep_id = sales_reps.id
 JOIN region
 ON region.id  = sales_reps.region_id

SELECT DISTINCT COUNT(id) AS I, COUNT(name) AS N
FROM accounts;

SELECT COUNT(accounts.name) AS name, COUNT(region.name) AS region
FROM accounts
JOIN sales_reps
ON accounts.sales_rep_id = sales_reps.id
JOIN region
ON sales_reps.region_id = region.id

SELECT DISTINCT COUNT(accounts.name) AS name, COUNT(region.name) reg
FROM accounts
JOIN sales_reps
ON accounts.sales_rep_id = sales_reps.id
JOIN region
ON sales_reps.region_id = region.id

SELECT DISTINCT COUNT(sales_reps.name) AS naam, COUNT(accounts.name) AS acc
FROM accounts
JOIN sales_reps
ON sales_reps.id = accounts.sales_rep_id

HAVING
HAVING is the “clean” way to filter a query that has been aggregated, but this is also commonly done using a subquery.
Essentially, any time you want to perform a WHERE on an element of your query that was created by an aggregate, you need to use HAVING instead.

SELECT sales_reps.id, sales_reps.name, COUNT(accounts.id)
FROM sales_reps
JOIN accounts
ON accounts.sales_rep_id = sales_reps.id
GROUP BY sales_reps.id, sales_reps.name
HAVING  COUNT(accounts.id)  > 5
ORDER BY COUNT(accounts.id)

SELECT accounts.id, accounts.name, COUNT(orders.id)
FROM accounts
JOIN orders
ON accounts.id = orders.account_id
GROUP BY accounts.id, accounts.name
ORDER BY COUNT(orders.id) DESC
LIMIT 1

SELECT accounts.id, accounts.name, SUM(total_amt_usd)
FROM accounts
JOIN orders
ON accounts.id = orders.account_id
GROUP BY accounts.id, accounts.name
HAVING SUM(total_amt_usd) > 30000

SELECT accounts.id, accounts.name, SUM(total_amt_usd)
FROM accounts
JOIN orders
ON accounts.id = orders.account_id
GROUP BY accounts.id, accounts.name
HAVING SUM(total_amt_usd) < 1000

SELECT accounts.name, web_events.channel, COUNT(web_events.channel)
FROM accounts
JOIN web_events
ON accounts.id = web_events.account_id
GROUP BY accounts.name, web_events.channel
HAVING COUNT(web_events.channel) > 6 AND web_events.channel = 'facebook'

SELECT accounts.name, web_events.channel, COUNT(web_events.channel)
FROM accounts
JOIN web_events
ON accounts.id = web_events.account_id
GROUP BY accounts.name, web_events.channel
ORDER BY COUNT(web_events.channel) DESC
