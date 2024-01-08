
-- Write a query to calculate the number of customers in each state. 
--Show the state and the number of customers

SELECT state AS "STATE", COUNT(state) AS "Number of Customers"
FROM customers
WHERE state IS NOT NULL
GROUP BY state
ORDER BY COUNT(state) DESC;

--write a query to calculate the number of customers in each state
--show the state and the number of customers only if the state has more than 3 customers

SELECT state AS "STATE", COUNT(state) AS "Number of Customers"
FROM customers
WHERE state IS NOT NULL 
GROUP BY state
HAVING count(*)
ORDER BY COUNT(state) DESC;

--write a query to calculate the number of customers in each state
--show the state and the number of customers only if the state has more customers than CT

SELECT state AS "STATE", COUNT(state) AS "Number of Customers"
FROM customers
WHERE state IS NOT NULL 
GROUP BY state
HAVING count(*) > (SELECT count(state) FROM customers WHERE state = "CT")
ORDER BY COUNT(state) DESC;

-- Display the customer name, number, and phone for customers with sales rep Gerard Hernandez
--Emp_no = 1370

SELECT customerName, customerNumber, phone, salesRepEmployeeNumber
FROM customers
WHERE salesRepEmployeeNumber = 1370;

--Write the equivelent nested query and add employee's first name and last name

SELECT c.customerNumber, c.customerName, c.phone, CONCAT(e.lastName, ", ", e.firstName) AS "Employee Name"
FROM customers c, employees e
WHERE customerNumber IN (SELECT customerNumber FROM customers WHERE salesRepEmployeeNumber = 1370) 
AND c.salesRepEmployeeNumber = e.employeeNumber;