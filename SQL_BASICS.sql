#Example1
SELECT occurred_at, account_id, channel
FROM web_events
LIMIT 15;

#SELECT, FROM, LIMIT can be upper case or lower case
#The comma after 15 is optional
#SQL does not care about spaces
#Its a good practice to have instruction uppercase and comma after 15

#Example2
SELECT id, occurred_at, total_amt_usd
FROM orders
Limit 10

#Example3
SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at
LIMIT 10;

#Example4
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC  #Largest to lowest
LIMIT 5;

#Example5
SELECT id, account_id, total_amt_usd #Default is ascending
FROM orders
ORDER BY total_amt_usd
LIMIT 20;

#Example6
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY account_id ASC, total_amt_usd DESC

#Example7
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC, account_id ASC

#In query #1, all of the orders for each account ID are grouped together,
#and then within each of those groupings, the orders appear from the
#greatest order amount to the least. In query #2, since you sorted
#by the total dollar amount first, the orders appear from greatest to least
#regardless of which account ID they were from. Then they are sorted by account
#ID next. (The secondary sorting by account ID is difficult to see here,
#since only if there were two orders with equal total dollar amounts would there
#need to be any sorting by account ID.)

#Example8
SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5

#Example9
SELECT *
FROM orders
WHERE total_amt_usd < 500
Limit 10
#when using these WHERE statements, we do not need to ORDER BY
#unless we want to actually order our data. Our condition will
# work without having to do any sorting of the data.

#Example10
SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil'

#If you received an error message when executing your query,
#remember that SQL requires single-quotes, not double-quotes
#around text values like 'Exxon Mobil.'

#Example10
SELECT standard_amt_usd/standard_qty AS unit_price, id,
account_id
FROM orders
Limit 10;

#Example11
SELECT id, account_id,
  poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS post_per
FROM orders
LIMIT 10;
#because of this lower and uppercase letters are not the same within the string.
#Searching for 'T' is not the same as searching for 't'. In other SQL environments
#(outside the classroom), you can use either single or double quotes.

#Example12
SELECT name
FROM accounts
Where name Like 'C%'

#Begin with C

SELECT name
From accounts
Where name LIKE '%one%'


SELECT name
From accounts
Where name LIKE '%S' End with S


SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom')

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords')

#The NOT operator is an extremely useful operator for working with the
#previous two operators we introduced: IN and LIKE. By specifying
#NOT LIKE or NOT IN, we can grab all of the rows that do not meet a particular criteria.


SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom')

SELECT channel
FROM web_events
WHERE channel NOT IN ('organic', 'adwords')

SELECT name
FROM accounts
WHERE name NOT LIKE 'C%' #BEGIN

SELECT name
FROM accounts
WHERE name NOT LIKE '%one%'

SELECT name
FROM accounts
WHERE name NOT LIKE '%s' END

SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0.


SELECT *
FROM orders
WHERE gloss_qty BETWEEN 24 AND 29
ORDER BY gloss_qty   #includes 24 and 29


SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY occurred_at DESC;

SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000;

SELECT *
FROM orders
WHERE standard_qty = 0 AND (gloss_qty > 1000 OR
                            poster_qty > 1000)

SELECT *
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%')
           AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%')
           AND primary_poc NOT LIKE '%eana%');


#Statement	How to Use It	Other Details
#SELECT	SELECT Col1, Col2, ...	Provide the columns you want
#FROM	FROM Table	Provide the table where the columns exist
#LIMIT	LIMIT 10	Limits based number of rows returned
#ORDER BY	ORDER BY Col	Orders table based on the column. Used with DESC.
#WHERE	WHERE Col > 5	A conditional statement to filter your results
#LIKE	WHERE Col LIKE '%me%'	Only pulls rows where column has 'me' within the text
#IN	WHERE Col IN ('Y', 'N')	A filter for only rows with column of 'Y' or 'N'
#NOT	WHERE Col NOT IN ('Y', 'N')	NOT is frequently used with LIKE and IN
#AND	WHERE Col1 > 5 AND Col2 < 3	Filter rows where two or more conditions must be true
#OR	WHERE Col1 > 5 OR Col2 < 3	Filter rows where at least one condition must be true
#BETWEEN	WHERE Col BETWEEN 3 AND 5	Often easier syntax than using an AND

#Though SQL is not case sensitive (it doesn't care if you write your statements
#as all uppercase or lowercase), we discussed some best practices.
#The order of the key words does matter! Using what you know so far,
#you will want to write your statements as:

SELECT col1, col2
FROM table1
WHERE col3  > 5 AND col4 LIKE '%os%'
ORDER BY col5
LIMIT 10;
Notice, you can retrieve different columns than those being used in the ORDER BY and WHERE statements.
#Assuming all of these column names existed in this way (col1, col2, col3, col4, col5)
#within a table called table1, this query would run just fine.
