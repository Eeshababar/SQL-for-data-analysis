#Inner Join
SELECT orders.*, name
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

SELECT accounts.name, orders.occurred_at
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

SELECT *#Inner Join
SELECT orders.*, name
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

SELECT accounts.name, orders.occurred_at
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

SELECT *
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

SELECT orders.standard_qty, orders.gloss_qty, orders .poster_qty, accounts.website, accounts.primary_poc
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

Notice this result is the same as if you switched the tables in the FROM and JOIN. Additionally, which side of the = a column is listed doesn't matter.

SELECT id
FROM web_events

A foreign key is a column in one table that is a primary key in a different table. We can see in the Parch & Posey ERD that the foreign keys are:

region_id
account_id
sales_rep_id
Each of these is linked to the primary key of another table. An example is shown in the image below:

The crow's foot shows that the FK can actually appear in many rows in the sales_reps table.
While the single line is telling us that the PK shows that id appears only once per row in this table.


#3 Tables

SELECT *
FROM web_events
JOIN accounts
ON web_events.account_id = accounts.id
JOIN orders
ON accounts.id = orders.account_id


SELECT web_events.channel, accounts.name, orders.total
FROM web_events
JOIN accounts
ON web_events.account_id = accounts.id
JOIN orders
ON accounts.id = orders.account_id

Aliases:

FROM tablename AS t1
JOIN tablename2 AS t2

SELECT col1 + col2 AS total, col3

FROM tablename t1
JOIN tablename2 t2 #Without As

SELECT col1 + col2 total, col3

#Alias for column

Select t1.column1 aliasname, t2.column2 aliasname2
FROM tablename AS t1
JOIN tablename2 AS t2


SELECT web_events.channel,web_events.occurred_at, accounts.primary_poc, accounts.name
FROM web_events
JOIN accounts
ON web_events.account_id =  accounts.id
WHERE accounts.name = 'Walmart'

SELECT sales_reps.name AS name, region.name AS reg, accounts.name AS acc
FROM sales_reps
JOIN region
ON sales_reps.region_id =  region.id
JOIN accounts
ON sales_reps.id = sales_rep_id
ORDER BY accounts.name

SELECT region.name AS name, accounts.name AS reg, (orders.total_amt_usd/(orders.total+0.1)) AS unit_prices
FROM region
JOIN sales_reps
ON sales_reps.region_id =  region.id
JOIN accounts
ON sales_reps.id = accounts.sales_rep_id
JOIN orders
ON accounts.id = orders.account_id


Outer Join:
Notice each of these new JOIN statements pulls all the same rows as an INNER JOIN, which you saw by just using JOIN, but they also potentially pull some additional rows.

If there is not matching information in the JOINed table, then you will have columns with empty cells. These empty cells introduce a new data type called NULL. You will learn about NULLs in detail in the next lesson, but for now you have a quick introduction as you can consider any cell without data as NULL.

LEFT OUTER JOIN = LEFT JOIN
RIGHT OUTER JOIN = RIGHT JOIN

OUTER JOINS
The last type of join is a full outer join. This will return the inner join result set, as well as any unmatched rows from either of the two tables being joined.

Again this returns rows that do not match one another from the two tables. The use cases for a full outer join are very rare.

FULL OUTER JOIN = OUTER JOIN

SELECT c.countryid, c.countryName, s.stateName
FROM Country c
LEFT JOIN State s
ON c.countryid = s.countryid;


SELECT region.name reg, sales_reps.name sal, accounts.name acc
FROM region
JOIN sales_reps
ON sales_reps.region_id = region.id
JOIN accounts
ON sales_reps.id = accounts.sales_rep_id
WHERE region.name = 'Midwest'

SELECT region.name AS name, sales_reps.name AS sales , accounts.name AS accounts
FROM region
JOIN sales_reps
ON sales_reps.region_id = region.id
JOIN accounts
ON sales_reps.id = accounts.sales_rep_id
WHERE region.name = 'Midwest' AND sales_reps.name LIKE 'S%'
ORDER BY accounts.name
#First name starting with K

SELECT region.name AS name, sales_reps.name AS sales , accounts.name AS accounts
FROM region
JOIN sales_reps
ON sales_reps.region_id = region.id
JOIN accounts
ON sales_reps.id = accounts.sales_rep_id
WHERE region.name = 'Midwest' AND sales_reps.name LIKE '%K%'
ORDER BY accounts.name #Last name starting with K

SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100;

SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price;

SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price DESC;

SELECT DISTINCT a.name, w.channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE a.id = '1001';

SELECT o.occurred_at, a.name, o.total, o.total_amt_usd
FROM accounts a
JOIN orders o
ON o.account_id = a.id
WHERE o.occurred_at BETWEEN '01-01-2015' AND '01-01-2016'
ORDER BY o.occurred_at DESC;

Primary and Foreign Keys
You learned a key element for JOINing tables in a database has to do with primary and foreign keys:

primary keys - are unique for every row in a table. These are generally the first column in our database (like you saw with the id column for every table in the Parch & Posey database).

foreign keys - are the primary key appearing in another table, which allows the rows to be non-unique.

Choosing the set up of data in our database is very important, but not usually the job of a data analyst. This process is known as Database Normalization.

JOINs
In this lesson, you learned how to combine data from multiple tables using JOINs. The three JOIN statements you are most likely to use are:

JOIN - an INNER JOIN that only pulls data that exists in both tables.
LEFT JOIN - pulls all the data that exists in both tables, as well as all of the rows from the table in the FROM even if they do not exist in the JOIN statement.
RIGHT JOIN - pulls all the data that exists in both tables, as well as all of the rows from the table in the JOIN even if they do not exist in the FROM statement.
There are a few more advanced JOINs that we did not cover here, and they are used in very specific use cases. UNION and UNION ALL, CROSS JOIN, and the tricky SELF JOIN. These are more advanced than this course will cover, but it is useful to be aware that they exist, as they are useful in special cases.

Alias
You learned that you can alias tables and columns using AS or not using it. This allows you to be more efficient in the number of characters you need to write, while at the same time you can assure that your column headings are informative of the data in your table.



FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

SELECT orders.standard_qty, orders.gloss_qty, orders .poster_qty, accounts.website, accounts.primary_poc
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

Notice this result is the same as if you switched the tables in the FROM and JOIN. Additionally, which side of the = a column is listed doesn't matter.

SELECT id
FROM web_events

A foreign key is a column in one table that is a primary key in a different table. We can see in the Parch & Posey ERD that the foreign keys are:

region_id
account_id
sales_rep_id
Each of these is linked to the primary key of another table. An example is shown in the image below:

The crow's foot shows that the FK can actually appear in many rows in the sales_reps table.
While the single line is telling us that the PK shows that id appears only once per row in this table.


#3 Tables

SELECT *
FROM web_events
JOIN accounts
ON web_events.account_id = accounts.id
JOIN orders
ON accounts.id = orders.account_id


SELECT web_events.channel, accounts.name, orders.total
FROM web_events
JOIN accounts
ON web_events.account_id = accounts.id
JOIN orders
ON accounts.id = orders.account_id

Aliases:

FROM tablename AS t1
JOIN tablename2 AS t2

SELECT col1 + col2 AS total, col3

FROM tablename t1
JOIN tablename2 t2 #Without As

SELECT col1 + col2 total, col3

#Alias for column

Select t1.column1 aliasname, t2.column2 aliasname2
FROM tablename AS t1
JOIN tablename2 AS t2


SELECT web_events.channel,web_events.occurred_at, accounts.primary_poc, accounts.name
FROM web_events
JOIN accounts
ON web_events.account_id =  accounts.id
WHERE accounts.name = 'Walmart'

SELECT sales_reps.name AS name, region.name AS reg, accounts.name AS acc
FROM sales_reps
JOIN region
ON sales_reps.region_id =  region.id
JOIN accounts
ON sales_reps.id = sales_rep_id
ORDER BY accounts.name

SELECT region.name AS name, accounts.name AS reg, (orders.total_amt_usd/(orders.total+0.1)) AS unit_prices
FROM region
JOIN sales_reps
ON sales_reps.region_id =  region.id
JOIN accounts
ON sales_reps.id = accounts.sales_rep_id
JOIN orders
ON accounts.id = orders.account_id


Outer Join:
Notice each of these new JOIN statements pulls all the same rows as an INNER JOIN, which you saw by just using JOIN, but they also potentially pull some additional rows.

If there is not matching information in the JOINed table, then you will have columns with empty cells. These empty cells introduce a new data type called NULL. You will learn about NULLs in detail in the next lesson, but for now you have a quick introduction as you can consider any cell without data as NULL.

LEFT OUTER JOIN = LEFT JOIN
RIGHT OUTER JOIN = RIGHT JOIN

OUTER JOINS
The last type of join is a full outer join. This will return the inner join result set, as well as any unmatched rows from either of the two tables being joined.

Again this returns rows that do not match one another from the two tables. The use cases for a full outer join are very rare.

FULL OUTER JOIN = OUTER JOIN

SELECT c.countryid, c.countryName, s.stateName
FROM Country c
LEFT JOIN State s
ON c.countryid = s.countryid;


SELECT region.name reg, sales_reps.name sal, accounts.name acc
FROM region
JOIN sales_reps
ON sales_reps.region_id = region.id
JOIN accounts
ON sales_reps.id = accounts.sales_rep_id
WHERE region.name = 'Midwest'

SELECT region.name AS name, sales_reps.name AS sales , accounts.name AS accounts
FROM region
JOIN sales_reps
ON sales_reps.region_id = region.id
JOIN accounts
ON sales_reps.id = accounts.sales_rep_id
WHERE region.name = 'Midwest' AND sales_reps.name LIKE 'S%'
ORDER BY accounts.name
#First name starting with K

SELECT region.name AS name, sales_reps.name AS sales , accounts.name AS accounts
FROM region
JOIN sales_reps
ON sales_reps.region_id = region.id
JOIN accounts
ON sales_reps.id = accounts.sales_rep_id
WHERE region.name = 'Midwest' AND sales_reps.name LIKE '%K%'
ORDER BY accounts.name #Last name starting with K

SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100;

SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price;

SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price DESC;

SELECT DISTINCT a.name, w.channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE a.id = '1001';

SELECT o.occurred_at, a.name, o.total, o.total_amt_usd
FROM accounts a
JOIN orders o
ON o.account_id = a.id
WHERE o.occurred_at BETWEEN '01-01-2015' AND '01-01-2016'
ORDER BY o.occurred_at DESC;

Primary and Foreign Keys
You learned a key element for JOINing tables in a database has to do with primary and foreign keys:

primary keys - are unique for every row in a table. These are generally the first column in our database (like you saw with the id column for every table in the Parch & Posey database).

foreign keys - are the primary key appearing in another table, which allows the rows to be non-unique.

Choosing the set up of data in our database is very important, but not usually the job of a data analyst. This process is known as Database Normalization.

JOINs
In this lesson, you learned how to combine data from multiple tables using JOINs. The three JOIN statements you are most likely to use are:

JOIN - an INNER JOIN that only pulls data that exists in both tables.
LEFT JOIN - pulls all the data that exists in both tables, as well as all of the rows from the table in the FROM even if they do not exist in the JOIN statement.
RIGHT JOIN - pulls all the data that exists in both tables, as well as all of the rows from the table in the JOIN even if they do not exist in the FROM statement.
There are a few more advanced JOINs that we did not cover here, and they are used in very specific use cases. UNION and UNION ALL, CROSS JOIN, and the tricky SELF JOIN. These are more advanced than this course will cover, but it is useful to be aware that they exist, as they are useful in special cases.

Alias
You learned that you can alias tables and columns using AS or not using it. This allows you to be more efficient in the number of characters you need to write, while at the same time you can assure that your column headings are informative of the data in your table.
