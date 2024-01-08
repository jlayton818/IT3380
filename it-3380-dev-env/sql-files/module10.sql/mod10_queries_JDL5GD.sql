--1. Write a query to show the customer number, name, payment date, and payment amount for payments greater than the average payment.

SELECT c.customerNumber, c.customerName, p.paymentDate, p.amount
FROM customers c, payments p 
WHERE p.amount > (SELECT AVG(amount) FROM payments) AND c.customerNumber = p.customerNumber;

SELECT AVG(amount)
FROM payments 

--2. Create a query to generate a list of managers. Show their employee number, first name, and last name.

SELECT e.employeeNumber, e.firstName, e.lastName
FROM employees e 
WHERE (SELECT COUNT(reportsTo) FROM employees WHERE reportsTo = e.employeeNumber) > 0

SELECT COUNT(reportsTo) 
FROM employees 
WHERE reportsTo = e.employeeNumber

--3. Which offices have the same number of employees as the London office? 
-- Show the city, office code and number of employees.

SELECT o.city, o.officeCode, COUNT(e.employeeNumber)
FROM offices o, employees e 
WHERE o.officeCode IS NOT NULL AND e.officeCode = o.officeCode
GROUP BY e.officeCode
HAVING COUNT(*) = (SELECT COUNT(e.employeeNumber) FROM employees e, offices o WHERE e.officeCode = o.officeCode AND o.city = 'London');


SELECT COUNT(e.employeeNumber)
FROM employees e, offices o
WHERE e.officeCode = o.officeCode
AND o.city = 'London';

--4. Which product(s) have a higher quantity ordered than “1940s Ford truck”? 
--Show the product names and quantity ordered.

SELECT p.productName, SUM(od.quantityOrdered)
FROM products p, orderdetails od 
WHERE p.productCode = od.productCode
GROUP BY p.productName
HAVING SUM(od.quantityOrdered) > (SELECT SUM(quantityOrdered)
FROM orderdetails
WHERE productCode = 'S18_4600');

SELECT SUM(quantityOrdered)
FROM orderdetails
WHERE productCode = 'S18_4600'; 

--5. Show the products that have a lower dollar value in orders than the 
--“1957 Corvette Convertible”. Show the product name and total value.

SELECT p.productName, SUM(o.quantityOrdered * o.priceEach) AS "Total Value"
FROM products p, orderdetails o 
WHERE p.productCode = od.productCode
GROUP BY p.productName
HAVING SUM(o.quantityOrdered * o.priceEach) < 
(SELECT SUM(o.quantityOrdered * o.priceEach)
FROM orderdetails o, products p
WHERE p.productName = '1957 Corvette Convertible');

SELECT SUM(quantityOrdered * priceEach)
FROM orderdetails
WHERE productCode = 'S18_4721';

--6. Show the order number, customer number, and order total for orders 
--with a larger order total than order number 10222.
-- Order total = buy price * quantity ordered
SELECT o.orderNumber, o.customerNumber, SUM(od.priceEach * od.quantityOrdered)
FROM orders o, orderdetails od
WHERE od.orderNumber = o.orderNumber
GROUP BY o.orderNumber
HAVING SUM(od.priceEach * od.quantityOrdered) >
(SELECT SUM(od.priceEach * quantityOrdered)
FROM orderdetails od
WHERE od.orderNumber = 10222);

SELECT SUM(od.priceEach * quantityOrdered)
FROM orderdetails od
WHERE od.orderNumber = 10222;


--Wildcard Queries
--1. Show the customer name and total payments for companies whose name ends in “Ltd”.

SELECT c.customerName, COUNT(p.amount) AS "Total Payments"
FROM customers c, payments p
WHERE c.customerName LIKE '%Ltd' AND c.customerNumber = p.customerNumber
GROUP BY c.customerName;

--2. How many employees have a three digit extension? A three digit extension looks like xXXX.

SELECT count(employeeNumber)
FROM employees
WHERE extension LIKE 'x___';

--3. Show the product code, name, vendor, and buy price for products from the 
--1950s (1950 - 1959). The year appears is in the name.

SELECT p.productCode, p.productName, p.productVendor, p.buyPrice
FROM products p 
WHERE productName LIKe '%195_%'

--4. show all office information for offices in the 212 area code. 
--Hint. Look at the phone number.

SELECT *
FROM offices
WHERE phone like '%212%'

--5. Show first name, last name, employee number and email for the sales managers.

SELECT lastName, firstName, employeeNumber, email, jobTitle
FROM employees
WHERE jobTitle LIKE '%Sale%Manager%';

--6. Show the name, product code, quantity in stock, and buy price for products
-- with “Chevy” in the name.

SELECT productName, productCode, quantityInStock, buyPrice
FROM products 
WHERE productName LIKE '%Chevy%'


Select c.customerName, od.orderNumber
From customers c
RIGHT JOIN orders od On c.customerNumber = od.customerNumber;
