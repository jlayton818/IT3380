--SELECT(Read Queries)
--1. Write a query to calculate the dollar amount of payments each sales agent 
--is responsible for. Display the agent name and the total payments.

SELECT a.agent_name AS "Agent Name", SUM(c.payment_amt) AS "Total Payments"
FROM customer c, agents a 
WHERE a.agent_code = c.agent_code
GROUP BY a.agent_name;

--2. Write a query to calculate payments for each sales agent country. 
--Display the agent country and total payments.

SELECT a.WORKING_AREA, SUM(c.payment_amt) AS "Total Payments"
FROM customer c, agents a
WHERE a.agent_code = c.agent_code
GROUP BY a.WORKING_AREA;

--3. Calculate the commission for each order. Display order id, customer name, 
--agent name, and commission amount.

SELECT o.ord_num, c.cust_name, a.agent_name, SUM(a.commission * o.ord_amount)
FROM orders o, customer c, agents a
WHERE a.agent_code = c.agent_code AND o.cust_code = c.cust_code
GROUP BY o.ord_num;

--UPDATE Queries
--1. In the customers table, for customers from New York update the CUST_CITY value to change it from “New York” to “NY”.
-- A. Now write an query to select all customers from New York City.

UPDATE customer 
SET CUST_CITY = "NY"
WHERE CUST_CITY = "New York";

SELECT * 
FROM customer
WHERE CUST_CITY = "NY";

--2. Increase the commission for sales agents from London by 20%.
-- B. Calculate the commission for each order where the agent is from London. 
--Display order id, customer name, agent name, and commission amount.

UPDATE agents 
SET COMMISSION = COMMISSION * 1.2
WHERE WORKING_AREA = "London";

SELECT o.ord_num, c.cust_name, a.agent_name, SUM(a.commission * o.ord_amount)
FROM orders o, customer c, agents a
WHERE a.agent_code = c.agent_code AND o.cust_code = c.cust_code AND a.WORKING_AREA = "London"
GROUP BY o.ord_num;

--Update customers with grade 2 to grade 3.
--C. Select all customers names and customer codes with grade 3.

UPDATE customer
SET GRADE = 3
WHERE GRADE = 2;

SELECT cust_name, cust_code
FROM customer
WHERE grade = 3;

--DELETE Queries
--1. Delete sales agents from Bangalore.
--E. Write a query to select all columns for all sales agents

DELETE 
FROM agents
WHERE WORKING_AREA = "Bangalore";

SELECT * 
FROM agents;
--2. Delete customers whose name begins with the letter “S”.
--F. Select all columns for all customers.

DELETE 
FROM customer
WHERE cust_name LIKE 's%';

SELECT * 
FROM customer;
