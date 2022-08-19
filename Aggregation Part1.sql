NULLs are a datatype that specifies where no data exists in SQL. They are often ignored in our aggregation functions, which you will get a first look at in the next concept using COUNT.


Notice that NULLs are different than a zero - they are cells where data does not exist.

When identifying NULLs in a WHERE clause, we write IS NULL or IS NOT NULL. We don't use =, because NULL isn't considered a value in SQL. Rather, it is a property of the data.

NULLs - Expert Tip
There are two common ways in which you are likely to encounter NULLs:

NULLs frequently occur when performing a LEFT or RIGHT JOIN. You saw in the last lesson - when some rows in the left table of a left join are not matched with rows in the right table, those rows will contain some NULL values in the result set.


NULLs can also occur from simply missing data in our database.


SELECT Count(*)
FROM accounts;

SELECT Count(accounts.id)
FROM accounts;

SELECT Count(accounts.id)
FROM accounts
WHERE accounts.id IS NULL

Notice that COUNT does not consider rows that have NULL values. Therefore, this can be useful for quickly identifying which rows have missing data. You will learn GROUP BY in an upcoming concept, and then each of these aggregators will become much more useful.


Unlike COUNT, you can only use SUM on numeric columns. However, SUM will ignore NULL values, as do the other aggregation functions you will see in the upcoming lessons.

Aggregation Reminder
An important thing to remember: aggregators only aggregate vertically - the values of a column. If you want to perform a calculation across rows, you would do this with simple arithmetic.

SELECT SUM(poster_qty)
FROM orders

SELECT SUM(total_amt_usd)
FROM orders

SELECT standard_amt_usd+gloss_amt_usd AS Total
FROM orders

SELECT SUM(standard_amt_usd)/SUM (standard_qty) AS Total
FROM orders

Notice that here we were simultaneously obtaining the MIN and MAX number of orders of each paper type. However, you could run each individually.

Notice that MIN and MAX are aggregators that again ignore NULL values. Check the expert tip below for a cool trick with MAX & MIN.

Expert Tip
Functionally, MIN and MAX are similar to COUNT in that they can be used on non-numerical columns. Depending on the column type, MIN will return the lowest number, earliest date, or non-numerical value as early in the alphabet as possible. As you might suspect, MAX does the opposite—it returns the highest number, the latest date, or the non-numerical value closest alphabetically to “Z.”


Similar to other software AVG returns the mean of the data - that is the sum of all of the values in the column divided by the number of values in a column. This aggregate function again ignores the NULL values in both the numerator and the denominator.

If you want to count NULLs as zero, you will need to use SUM and COUNT. However, this is probably not a good idea if the NULL values truly just represent unknown values for a cell.

MEDIAN - Expert Tip
One quick note that a median might be a more appropriate measure of center for this data, but finding the median happens to be a pretty difficult thing to get using SQL alone — so difficult that finding a median is occasionally asked as an interview question.


SELECT MIN(orders.occurred_at)
FROM orders #earliest order


SELECT orders.occurred_at
FROM orders
ORDER BY occurred_at  #Without aggregate function

SELECT MAX(web_events.occurred_at)
FROM web_events

SELECT web_events.occurred_at
FROM web_events
Order By occurred_at DESC #Without aggregate

SELECT AVG(standard_qty) mean_standard, AVG(gloss_qty) mean_gloss,
           AVG(poster_qty) mean_poster, AVG(standard_amt_usd) mean_standard_usd,
           AVG(gloss_amt_usd) mean_gloss_usd, AVG(poster_amt_usd) mean_poster_usd
FROM orders;


SELECT *
FROM (SELECT total_amt_usd
      FROM orders
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2; #Median
 
