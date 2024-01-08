--Calculate the average payment made by each customer
--Show the customer number and the average amount
SELECT customerNumber, AVG(amount) AS "Average Payment"
FROM payments
GROUP BY customerNumber;

--same as above, but return the customer name and number. And round avg to 2 decimal places
SELECT c.customerNumber, c.customerName, ROUND(AVG(p.amount), 2) AS "Average Payment"
FROM payments p, customers c
WHERE p.customerNumber = c.customerNumber
GROUP BY customerNumber;

--Calculate the number of payments made by customers who made payments
SELECT customerNumber, COUNT(customerNumber) AS "Number of Payments"
FROM payments
GROUP BY customerNumber;

--Calculate the total payments made by customers who made payments
SELECT customerNumber, SUM(amount) AS "Total Payments"
FROM payments
GROUP BY customerNumber;

--Calculate the number of customers an employees has
--Display the employee first name, last name, and number of customers
--Display results in Descending order

SELECT e.firstName, e.lastName, COUNT(c.salesRepEmployeeNumber) AS "Number of Customers"
FROM employees e, customers c
WHERE c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY c.salesRepEmployeeNumber
ORDER BY COUNT(c.salesRepEmployeeNumber) DESC;
