--1.  Calculate the number of orders for each product that has been ordered. Display the product name and number of orders in a column called “Number of Orders”. Display the results in
--descending order based on “Number of Orders”. Note: You are calculating the number of orders and not quantity ordered. For example, if Alice orders 3 pizzas today and 5 pizzas next 
--week then pizza orders equals 2 and the quantity of pizzas ordered equals 8. 109 rows returned.

SELECT p.productName, COUNT(o.orderNumber) AS "Number of Orders"     
FROM products p, orderdetails o 
WHERE p.productCode = o.productCode
GROUP BY p.productName
ORDER BY COUNT(o.orderNumber) DESC;
-- 2. Calculate the total number of each product that has been ordered. Display 
--the product name and quantity ordered in a column called “Quantity Ordered”. 
--Display the results in descending order based on Quantity Ordered. 109 rows returned.
SELECT p.productName, SUM(o.quantityOrdered) AS "Quantity Ordered"
FROM products p, orderdetails o
WHERE p.productCode = o.productCode
GROUP BY p.productName
ORDER BY SUM(o.quantityOrdered) DESC;
 
-- 3. Calculate the total dollar value of the top 25 products that has been 
--ordered in the database. Display the product name and the dollar value in a 
--column called “Total Value”.
SELECT p.productName, SUM(o.quantityOrdered * o.priceEach) AS "Total Value"
FROM products p, orderdetails o
WHERE p.productCode = o.productCode
GROUP BY p.productName
ORDER BY SUM(o.quantityOrdered);
--4. Calculate the number of orders each customer has placed and display the 
--top 25 in descending order based on orders placed. Display the customer name
-- and the orders placed in a columns called “Orders Placed”.
SELECT c.customerName, COUNT(o.orderNumber) AS "Orders Placed"
FROM customers c, orders o
WHERE c.customerNumber = o.customerNumber
GROUP BY c.customerName
ORDER BY COUNT(o.orderNumber) DESC 
LIMIT 25;


--5. Calculate the total payments made each year. Display the year and total 
--payments in a column called “Total Payments”. Note: you will have to use the 
--YEAR() function to get the year portion of the payment date.
SELECT SUM(p.amount) AS "Total Payments", YEAR(p.paymentDate) AS YEAR
FROM payments p
GROUP BY YEAR(p.paymentDate)
ORDER BY YEAR(p.paymentDate);

--6. Calculate the total payments made each month in 2004. Display the month 
--and total payments in a column called “Total Payments”. Order the results by 
--month in ascending order. Note: you will have to use the MONTH() and YEAR() functions.
SELECT SUM(amount) AS "Payment", MONTH(paymentDate) as "MONTH"
FROM payments
WHERE YEAR(paymentDate) = 2004
GROUP BY MONTH(paymentDate)
ORDER BY MONTH(paymentDate);

--7. Calculate the total payments made each day in December of 2004. Display the 
--day in a column named “Day” and total payments in a column called 
--“Total Payments”. Order the results by day in ascending order. Note: you will 
--have to use the MONTH(), DAY(), and YEAR() functions.
SELECT SUM(amount) AS "Payment", DAY(paymentDate)
FROM payments 
WHERE YEAR(paymentDate) = 2004 AND MONTH(paymentDate) = 12
GROUP BY DAY(paymentDate)
ORDER BY DAY(paymentDate);

--8.Calculate the total payments made by each customer in the database who has
--made a payment. Display the customer name and the total payments in a column
--named “Total Payments”. Order the results by total payments. 98 rows returned. 
--The results below show the first 5 and last 5 results.
SELECT c.customerName, SUM(p.amount) AS "Total Payments"
FROM customers c, payments p
WHERE c.customerNumber = p.customerNumber
GROUP BY c.customerName
ORDER BY SUM(p.amount) DESC;

--9. Calculate and display the number of customers in each state. Display the
--state name and and number of customers in each state in a column called 
--“Number of Customers in State”. Sort the results by the Number of Customers 
--in State.
SELECT c.state, COUNT(c.customerNumber) AS "Number of Customers in State"
FROM customers c
GROUP BY c.state
ORDER BY COUNT(c.customerNumber) DESC;

--10 Which employees manage the most people? Develop a query to calculate the 
--number of people each employees manages. Display the employee number and 
--number of employees employees they manage in a column called “Number of Reports”
--. Hint: we know an employee manages another employee if their employee number 
--appears in the reportsTo column in the employee table.

SELECT e.employeeNumber, COUNT(em.reportsTo) AS "Number of Reports"
FROM employees e, employees em
WHERE e.employeeNumber = em.reportsTo
GROUP BY e.employeeNumber;

SELECT e.employeeNumber, COUNT(e.reportsTo) AS "Number of Reports"
FROM employees e 
WHERE e.reportsTo = e.employeeNumber
GROUP BY e.employeeNumber;
--11. Write a query to calculate the number of product lines in the database. 
--Display the result in a column called “Number of Lines”.

SELECT COUNT(DISTINCT p.productLine) AS "Number of Lines"
FROM products p;

--12. Calculate the dollar value of each product in inventory. You can calculate 
--this by multiplying the quantity in stock by the buy price. Display the product 
--name, quantity in stock, buy price, and in its dollar value in a column called 
--“Dollar Value”. Sort the results in descending order based on dollar value. 
--110 rows returned. The results below show the first 5 and last 5 results.

SELECT p.productName, p.quantityInStock, p.buyPrice, (p.quantityInStock * p.buyPrice)
AS "Dollar Value"
FROM products p 
ORDER BY (p.quantityInStock * p.buyPrice) DESC;