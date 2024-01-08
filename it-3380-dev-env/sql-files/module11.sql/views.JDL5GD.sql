--1a. Write a query to create a view named "SFEmployees" for those salespeople who work in the San Francisco office. Include the employee name (first, last), number, email, and job title.
CREATE VIEW SFEmployees AS 
SELECT e.firstName, e.lastName, e.extension, e.email, e.jobtitle
FROM employees e, offices o 
WHERE o.officeCode = e.officeCode AND o.city = "San Francisco";

--1b. Query the SFEmployees view to count the number of employees in the San Francisco office.
--??
SELECT count(*)
FROM SFEmployees;
--2a. Write a query to create a view named "managers" to display all the managers. Include the manager’s name (first, last), number, email,  job title, and office city.
CREATE VIEW managers AS 
SELECT e.firstName, e.lastName, e.extension, e.email, e.jobTitle, o.city
FROM employees e, offices o 
WHERE e.officeCode = o.officeCode AND employeeNumber IN (SELECT reportsTo FROM employees);

--2b. Query the managers view to show the number of managers in each city.
SELECT city, count(*)
FROM managers
GROUP BY city;

--3a. Write a query to create a view named "custByCity" to get a count of how many customers there are in each city.
CREATE VIEW custByCity AS 
SELECT city, COUNT(customerNumber)
FROM customers
GROUP BY city
ORDER BY count(customerNumber) DESC;

--3b. Query the custByCity view to show the number of customers in Singapore.
SELECT *
FROM custByCity
WHERE city = "Singapore"

--4a. Write a query to create a view named "paymentsByMonth" that calculates payments per month. You will have to group by multiple columns for this query: 
--month and year because payments from January 2004 and January 2005 should not be grouped together. Remember the SQL month() and year() functions.
CREATE VIEW paymentsByMonth AS
SELECT sum(amount), MONTH(paymentDate) AS MONTH, YEAR(paymentDate) AS YEAR
FROM payments
GROUP BY MONTH(paymentDate), YEAR(paymentDate)
ORDER BY YEAR(paymentDate) ASC, MONTH(paymentDate) ASC;

--4b. Query the paymentsByMonth view to show payments in November 2004
SELECT * 
FROM paymentsByMonth
WHERE MONTH = 11 AND YEAR = 2004
--5a. Write a query to create a view named "orderTotalsByMonth" to calculate order totals (in dollars) per month.
CREATE VIEW orderTotalsByMonth AS 
SELECT SUM(od.quantityOrdered * od.priceEach), MONTH(o.orderDate) AS MONTH, YEAR (o.orderDate) AS YEAR 
FROM orders o, orderdetails od 
WHERE o.orderNumber = od.orderNumber
GROUP BY MONTH(o.orderDate), YEAR(o.orderDate);

--5b. Query the orderTotalsByMonth view to show the order total in August 2004.
SELECT * 
FROM orderTotalsByMonth
WHERE MONTH = 8 AND YEAR = 2004;

--6a. Write a query to create a view named "salesPerLine" that calculates sales per product line.
CREATE VIEW salesPerLine AS 
SELECT p.productLine, SUM(od.quantityOrdered * od.priceEach)
FROM products p, orderdetails od 
WHERE p.productCode = od.productCode
GROUP BY p.productLine;

--6b. Query the salesPerLine view to show the total sales for the "Classic Cars" line.
SELECT *
FROM salesPerLine
WHERE productLine = "Classic Cars";

--7a. Write a query to create a view named "productSalesYear" that calculates sales per product per year. Include the product name, sales total, and year.
CREATE VIEW productSalesYear AS 
SELECT p.productName, SUM(od.quantityOrdered * od.priceEach), YEAR(o.orderDate) AS "YEAR"
FROM products p, orderdetails od, orders o 
WHERE p.productCode = od.productCode AND o.orderNumber = od.orderNumber
GROUP BY YEAR(o.orderDate), p.productName;

--7b. Query the productSalesYear view to show the sales per year for the "2001 Ferrari Enzo" in 2004.
SELECT * 
FROM productSalesYear
WHERE productName = "2001 Ferrari Enzo" AND YEAR = 2004;
--8a. Write a query to create a view named "orderTotals" that displays the order total for each order. Include order number, customer name, and total.
CREATE VIEW orderTotals AS 
SELECT od.orderNumber, c.customerName, SUM(od.quantityOrdered * od.priceEach) AS "OrderTotal"
FROM customers c, orders o, orderdetails od
WHERE c.customerNumber = o.customerNumber AND o.orderNumber = od.orderNumber
GROUP BY od.orderNumber;

--8b. Query the orderTotals view to select the top 15 orders.
SELECT *
FROM orderTotals
ORDER BY OrderTotal DESC
LIMIT 15;
--9. Write a query to create a view named "salesPerRep" that calculates total sales for each sales rep.
CREATE VIEW salesPerRep AS 
SELECT CONCAT( e.firstName, " ", e.lastName), SUM(od.quantityOrdered * od.priceEach) AS "TotalSales"
FROM employees e, customers c, orders o, orderdetails od 
WHERE e.employeeNumber = c.salesRepEmployeeNumber AND c.customerNumber = o.customerNumber AND od.orderNumber = o.orderNumber
GROUP BY CONCAT( e.firstName, " ", e.lastName)

--10. Write a query to create a view named "salesPerOffice" that displays sales per office.

CREATE VIEW salesPerOffice AS 
SELECT ofc.officeCode, SUM(od.quantityOrdered * od.priceEach) AS "TotalSales"
FROM  offices ofc, employees e, customers c, orders o, orderdetails od 
WHERE ofc.officeCode = e.officeCode AND e.employeeNumber = c.salesRepEmployeeNumber AND c.customerNumber = o.customerNumber AND od.orderNumber = o.orderNumber
GROUP BY ofc.officeCode
