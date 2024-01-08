--Wildcards
--Select all products hwose name contains Ford. Return product name and product code

SELECT productName, productCode
FROM products
WHERE productName LIKE '%Ford%';

--SELECT all product names who begin with the letter 'T'

SELECT productName, productCode
FROM products
WHERE productName LIKE 'T%';

-- JOINS

--Display customer name and number along with the employee name(first, last) and number
--Include only employees that have customers

SELECT c.customerName, c.customerNumber, e.employeeNumber, CONCAT(e.firstName, " ",  e.lastName) AS "Employee Name"
FROM customers c, employees e 
WHERE c.salesRepEmployeeNumber = e.employeeNumber;

SELECT c.customerName, c.customerNumber, e.employeeNumber, CONCAT(e.firstName, " ",  e.lastName) AS "Employee Name"
FROM customers c 
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber;

--Include employees who don't have customers

SELECT c.customerName, c.customerNumber, e.employeeNumber, CONCAT(e.firstName, " ",  e.lastName) AS "Employee Name"
FROM customers c 
RIGHT JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber;

SELECT c.customerName, c.customerNumber, e.employeeNumber, CONCAT(e.firstName, " ",  e.lastName) AS "Employee Name"
FROM employees e
LEFT JOIN customers c ON c.salesRepEmployeeNumber = e.employeeNumber;

--Include customers who do not have employees

SELECT c.customerName, c.customerNumber, e.employeeNumber, CONCAT(e.firstName, " ",  e.lastName) AS "Employee Name"
FROM customers c 
LEFT JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber;

SELECT c.customerName, c.customerNumber, e.employeeNumber, CONCAT(e.firstName, " ",  e.lastName) AS "Employee Name"
FROM employees e
RIGHT JOIN customers c ON c.salesRepEmployeeNumber = e.employeeNumber;

--Display the order number, customer name, employee first and last name for 
--customers who have placed orders

SELECT o.orderNumber, c.customerName, CONCAT(e.firstName, " ",  e.lastName) AS "Employee Name"
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN employees e ON e.employeeNumber = c.salesRepEmployeeNumber;

--Include "customers" who have not placed orders

SELECT o.orderNumber, c.customerName, CONCAT(e.firstName, " ",  e.lastName) AS "Employee Name"
FROM customers c
LEFT JOIN orders o ON c.customerNumber = o.customerNumber
JOIN employees e ON e.employeeNumber = c.salesRepEmployeeNumber;

--Only view customers who did not place orders

SELECT o.orderNumber, c.customerName, CONCAT(e.firstName, " ",  e.lastName) AS "Employee Name"
FROM customers c
LEFT JOIN orders o ON c.customerNumber = o.customerNumber
JOIN employees e ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE o.orderNumber IS NULL;

--Show customer names and amount for customers who have not made payments

SELECT c.customerName, p.amount
FROM customers c
LEFT JOIN payments p ON p.customerNumber = c.customerNumber
WHERE p.amount IS NULL;

-- Write an equivalent query to the one above 

SELECT customerName 
FROM customers 
WHERE customerNumber NOT IN (SELECT customerNumber FROM payments);