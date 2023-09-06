--Display agent name, customer name, order number, and order amount
SELECT a.AGENT_NAME, c.CUST_NAME, o.ORD_NUM, o.ORD_AMOUNT
FROM agents a, customer c, orders o
WHERE a.AGENT_CODE = o.AGENT_CODE AND o.CUST_CODE = c.CUST_CODE;

--Same but without aliases
SELECT agent.AGENT_NAME, customer.CUST_NAME, orders.ORD_NUM, orders.ORD_AMOUNT
FROM agents, orders, customer
WHERE agents.AGENT_CODE = orders.AGENT_CODE AND orders.CUST_CODE = customer.CUST_CODE

--Write a query to display the agent name, customer name, customer number, order number
--order amount, for customer C0020

SELECT a.AGENT_NAME, c.CUST_NAME, c.CUST_CODE, o.ORD_NUM, o.ORD_AMOUNT
FROM agents a, customer c, orders o
WHERE a.AGENT_CODE = o.AGENT_CODE AND o.CUST_CODE = c.CUST_CODE AND c.CUST_CODE = "C00020";

SELECT a.AGENT_NAME, c.CUST_NAME, c.CUST_CODE, o.ORD_NUM, o.ORD_AMOUNT
FROM agents a, customer c, orders o
WHERE a.AGENT_CODE = o.AGENT_CODE AND o.CUST_CODE = c.CUST_CODE AND c.CUST_NAME = "Albert";

--Display customer name and all of the agent's information
SELECT c.CUST_NAME, a.*
FROM customer c, agents a
WHERE c.AGENT_CODE = a.AGENT_CODE;

--Display customer name and all of the agent's infromation for agent A008
SELECT c.CUST_NAME, a.*
FROM customer c, agents a
WHERE c.AGENT_CODE = a.AGENT_CODE AND a.AGENT_CODE = "A008";
