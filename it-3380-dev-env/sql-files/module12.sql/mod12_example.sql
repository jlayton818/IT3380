-- Change working area to "London City" for customers from CUST_CITY = London

UPDATE customer 
SET WORKING_AREA = "London City"
WHERE CUST_CITY = "London";

UPDATE customer 
SET WORKING_AREA = "London"
WHERE CUST_CITY = "London";