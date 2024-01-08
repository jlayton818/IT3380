--2A 
--1. Display the customer name, customer number, along with their sales 
--rep’s number, first name, and last name.

SELECT c.customerName, c.customerNumber, c.salesRepEmployeeNumber, e.firstName, e.lastName
FROM employees e 
JOIN customers c ON c.salesRepEmployeeNumber = e.employeeNumber;
--100 Rows

SELECT c.customerName, c.customerNumber, c.salesRepEmployeeNumber, e.firstName, e.lastName
FROM employees e 
INNER JOIN customers c ON c.salesRepEmployeeNumber = e.employeeNumber;

SELECT c.customerName, c.customerNumber, c.salesRepEmployeeNumber, e.firstName, e.lastName
FROM employees e 
LEFT JOIN customers c ON c.salesRepEmployeeNumber = e.employeeNumber;
--108 Rows NULL Customer Number, customer name

SELECT c.customerName, c.customerNumber, c.salesRepEmployeeNumber, e.firstName, e.lastName
FROM employees e 
RIGHT JOIN customers c ON c.salesRepEmployeeNumber = e.employeeNumber;
--122 Rows. NULL salesRepEmployeeNumber, firstName, lastName

--2. Display each employee’s first and last name and their office code, city, and phone.

SELECT e.firstName, e.lastName, e.officeCode, o.city, o.phone
FROM employees e
LEFT JOIN offices o ON e.officeCode = o.officeCode;
--23 Results, no NULLS
SELECT e.firstName, e.lastName, e.officeCode, o.city, o.phone
FROM employees e
RIGHT JOIN offices o ON e.officeCode = o.officeCode;
--23 Results, no NULLS
SELECT e.firstName, e.lastName, e.officeCode, o.city, o.phone
FROM employees e
JOIN offices o ON e.officeCode = o.officeCode;
--23 Results no NULLS

--3. Display the customer’s name, and number along with the order number order date,
-- product name, quantity, and price for each of the customer’s orders.

SELECT c.customerName, c.phone, o.orderNumber, o.orderDate, p.productName, od.quantityOrdered, od.priceEach
FROM customers c 
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode;
--2996 Results

SELECT c.customerName, c.phone, o.orderNumber, o.orderDate, p.productName, od.quantityOrdered, od.priceEach
FROM customers c 
LEFT JOIN orders o ON c.customerNumber = o.customerNumber
LEFT JOIN orderdetails od ON o.orderNumber = od.orderNumber
LEFT JOIN products p ON od.productCode = p.productCode;
--3020 Results, NULLS ordernumber, orderDate, productName, quantity ordered and price each

SELECT c.customerName, c.phone, o.orderNumber, o.orderDate, p.productName, od.quantityOrdered, od.priceEach
FROM customers c 
RIGHT JOIN orders o ON c.customerNumber = o.customerNumber
RIGHT JOIN orderdetails od ON o.orderNumber = od.orderNumber
RIGHT JOIN products p ON od.productCode = p.productCode;
--2997 Results, 1 row of null for everything except the 1985 Toytoa Supra.

--4. Display the customer name and customer number along with the payment date, 
--check number, and amount for each payment

SELECT c.customerName, c.customerNumber, p.paymentDate, p.checkNumber, p.amount
FROM customers c 
JOIN payments p ON p.customerNumber = c.customerNumber;
--273 Rows No NULLS

SELECT c.customerName, c.customerNumber, p.paymentDate, p.checkNumber, p.amount
FROM customers c 
LEFT JOIN payments p ON p.customerNumber = c.customerNumber;
--297 Results NULL payment data

SELECT c.customerName, c.customerNumber, p.paymentDate, p.checkNumber, p.amount
FROM customers c 
RIGHT JOIN payments p ON p.customerNumber = c.customerNumber;
--273 Rows

--5.Display the product line, description, and product name for all products

SELECT pl.productLine, pl.textDescription, p.productName
FROM productlines pl 
JOIN products p ON pl.productLine = p.productLine;
--110 Results

SELECT pl.productLine, pl.textDescription, p.productName
FROM productlines pl 
LEFT JOIN products p ON pl.productLine = p.productLine;
--110 Rows

SELECT pl.productLine, pl.textDescription, p.productName
FROM productlines pl 
RIGHT JOIN products p ON pl.productLine = p.productLine;
--110 Rows


--2B
--1 .Show the customer name, order number and order date only for customers 
--who have placed orders.

SELECT c.customerName, o.orderNumber, o.orderDate
FROM customers c
RIGHT JOIN orders o ON c.customerNumber = o.customerNumber;

--2. Show the order number, and order total for all orders. 
--Include orders with no order details.
--Order total is price each * quantity ordered
SELECT o.orderNumber, SUM(od.priceEach * od.quantityOrdered)
FROM orders o 
LEFT JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY o.orderNumber;

--3. Show the employee name (first, last) and office address 
--(address line 1, state and country) for all employees.

SELECT e.firstName, e.lastName, o.addressLine1, o.state, o.country
FROM employees e
JOIN offices o ON e.officeCode = o.officeCode;

--4. Show the customer, number, payment date, check number, and amount for 
--each payment. Include customers who have not made any payments.

SELECT c.customerName, c.phone, p.paymentDate, p.amount
FROM customers c
LEFT JOIN payments p ON c.customerNumber = p.customerNumber;

--5. Show the employee name, customer name and the total sales for that customer. 
--The results should include employees even if they have do not have customers.

SELECT e.firstName, e.lastName, c.customerName, SUM(od.priceEach * od.quantityOrdered)
FROM customers c
LEFT JOIN orders o ON o.customerNumber = c.customerNumber
RIGHT JOIN employees e ON e.employeeNumber = salesRepEmployeeNumber
LEFT JOIN orderdetails od ON od.orderNumber = o.orderNumber
GROUP BY e.firstName, e.lastName, c.customerName;