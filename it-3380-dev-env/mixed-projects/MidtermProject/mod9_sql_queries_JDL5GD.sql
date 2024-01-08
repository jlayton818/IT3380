--1. What are the top 15 books ordered in 2022. Show the book title and number 
--ordered in a column called "Number of Books Ordered" in descending order.
--????

SELECT b.title, COUNT(ol.order_id) AS "Number of Books Ordered"
FROM book b, order_line ol, cust_order co
WHERE b.book_id = ol.book_id AND co.order_id = ol.order_id AND DATE_FORMAT(co.order_date, '%Y') = 2022
GROUP BY b.title
ORDER BY COUNT(ol.order_id) DESC
LIMIT 15;

--2. How many books are there in each languages in the database? Display the language and the number of books in a column called "Number of Books" in descending order.


SELECT bl.language_name, COUNT(b.book_id)
FROM book_language bl, book b
WHERE b.language_id = bl.language_id
GROUP BY bl.language_name
ORDER BY COUNT(b.book_id) DESC;

--3. List the top 20 top customers who ordered the highest dollar amount of books. Show the customer first, last name and order amount in a column called "Total orders" in descending order.

SELECT c.first_name, c.last_name, SUM(ol.price) AS "Total Orders"
FROM customer c, cust_order co, order_line ol
WHERE c.customer_id = co.customer_id AND co.order_id = ol.order_id
GROUP BY c.first_name, c.last_name
ORDER BY SUM(ol.price) DESC
LIMIT 20;

--4. Calculate the dollar amount in orders by country. Display the country name and the order amount in a column called "Total Orders" in descending order. 107 results
--????
SELECT ctry.country_name, SUM(ol.price) AS "Total orders"
FROM country ctry, order_line ol, cust_order co, address ad, customer_address ca, customer c
WHERE ol.order_id = co.order_id AND co.customer_id = c.customer_id AND c.customer_id = ca.customer_id AND ad.country_id = ctry.country_id AND ad.address_id = ca.address_id
GROUP BY ctry.country_name
ORDER BY SUM(ol.price) DESC;

--5 Calculate the total order amount, including the shipping cost for each month of each year in the database. The total will include book price and shipping cost. Display the 
--results in columns called "Year", "Month" and "Total Orders w/Shipping". Display in ascending order by year and month. Hint: you will need to group by multiple columns

SELECT DATE_FORMAT(co.order_date,'%Y') AS "YEAR", DATE_FORMAT(co.order_date,'%m') AS "MONTH", SUM(sm.cost + ol.price) AS "Total Orders w/Shipping"
FROM order_line ol, cust_order co, shipping_method sm 
WHERE co.order_id = ol.order_id AND co.shipping_method_id = sm.method_id 
GROUP BY DATE_FORMAT(co.order_date,'%Y'), DATE_FORMAT(co.order_date,'%m')
ORDER BY DATE_FORMAT(co.order_date,'%Y'), DATE_FORMAT(co.order_date,'%m') ASC;

--6 How many customers are there from each country in the database? Display the results in a column for country and "Total Customers". Display results in 
--descending order by Total Customers. 107 results.

SELECT ctry.country_name, COUNT(ca.customer_id) AS "Total Customers"
FROM customer_address ca, address a, country ctry
WHERE ca.address_id = a.address_id AND a.country_id = ctry.country_id
GROUP BY ctry.country_name
ORDER BY COUNT(ca.customer_id) DESC;

--7. How many authors have published with each publisher? Show the top 20. List the publisher name and the number of authors in a column called "Number of Authors".

SELECT p.publisher_name, COUNT(ba.author_id)
FROM publisher p, book b, book_author ba 
WHERE p.publisher_id = b.publisher_id AND b.book_id = ba.book_id
GROUP BY p.publisher_name
ORDER BY COUNT(ba.author_id) DESC
LIMIT 20;

--8. Whats the average order per country in 2022? Display the Country name and average order in a column called "Average Order" rounded to 2 decimal places. 
--Display results in descending order by average order. 94 results
--???

SELECT ctry.country_name, ROUND(AVG(ol.price), 2) AS 'Average Order'
FROM order_line ol, country ctry, address ad, cust_order co, customer c, customer_address ca
WHERE ol.order_id = co.order_id AND co.customer_id = c.customer_id AND c.customer_id = ca.customer_id AND ca.address_id = ad.address_id AND ad.country_id = ctry.country_id AND DATE_FORMAT(co.order_date, '%Y') = 2022
GROUP BY ctry.country_name
ORDER BY ROUND(AVG(ol.price), 2) DESC;