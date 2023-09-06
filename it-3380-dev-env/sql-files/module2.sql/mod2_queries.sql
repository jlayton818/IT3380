-- Display all of the customer data
SELECT * 
FROM customer;

--Display all of the agent data
SELECT * 
FROM agents;

--Display customer names and grades
SELECT CUST_NAME, GRADE
FROM customer;

--Display agent code, name, and working area
SELECT AGENT_CODE, AGENT_NAME, WORKING_AREA 
FROM agents;

--Display order number, order amount, and order date
SELECT ORD_NUM, ORD_AMOUNT, ORD_DATE 
FROM orders;

--Show all customer code, name, country, and phone number, for all customers from the United States
SELECT CUST_CODE, CUST_NAME, CUST_COUNTRY, PHONE_NO 
FROM customer 
WHERE CUST_COUNTRY = 'USA';

--Show agent names and phone numbers for agents from Bangalore
SELECT AGENT_NAME, PHONE_NO 
FROM agents
WHERE COUNTRY = 'Bangalore';

--Show orders with advance amounts of $100
SELECT ADVANCE_AMOUNT 
FROM orders
WHERE ADVANCE_AMOUNT > 100;

--Show the names of grade 2 customers
SELECT CUST_NAME 
FROM customer
WHERE GRADE = 2;

--Show all customer information for customers from New York
SELECT *
FROM customer
WHERE WORKING_AREA = 'New York';

--Show all agent information for agents who work in London with commission rates greater than 0.12
SELECT *
FROM agents
WHERE WORKING_AREA = 'London'
AND COMMISSION > 0.12;

--Show order number, agent code, and customer code for orders with advance amount less than or equal to $500, and order amount greater than or equal to $1500.
SELECT ORD_NUM, AGENT_CODE, CUST_CODE 
FROM orders 
WHERE ADVANCE_AMOUNT <= 500 
AND ORD_AMOUNT >= 1500;

--Show customer code, customer name, agent code, and outstanding amount for customers with outstanding amounts greater than $6000 and pay amount less tha or equal to $3000
SELECT CUST_CODE, CUST_NAME, AGENT_CODE, OUTSTANDING_AMT, PAYMENT_AMT
FROM customer
WHERE OUTSTANDING_AMT > 6000 
AND PAYMENT_AMT <= 3000;

--Show order numbers for order amounts less than $1000
SELECT ORD_NUM
FROM orders
WHERE ORD_AMOUNT < 1000;

--Show customer names from India with outstanding amounts less than $10,000
SELECT CUST_NAME
FROM customer
WHERE CUST_COUNTRY = 'India'
AND OUTSTANDING_AMT < 10000;
