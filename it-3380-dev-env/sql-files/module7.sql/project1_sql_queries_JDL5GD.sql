--1. How many universities in each country? Display the country name and number of 
--universities in a column named "Number of Universities". Display results in 
--descending order based on the number of universities. (74 rows returned). 
--The results show the first 10 rows and last 10 rows of the results.
SELECT c.country_name, COUNT(u.university_name) AS "Number of Universities"
FROM country c, university u
WHERE c.id = u.country_id
GROUP BY c.country_name
ORDER BY COUNT(u.university_name) DESC;

--2.List all of the current universities in the database. 
--List the university name and country (1247 rows returned)
SELECT c.country_name, u.university_name
FROM country c, university u
WHERE c.id = u.country_id;

--3. Show the average university student enrollment for each country in the 
--database In 2015. Display the country and average enrollment in a column named 
--"Average enrollment". Round to 0 decimal places and order by the average number 
--of students.
SELECT c.country_name, ROUND(AVG(uy.num_students),0) AS "Average Enrollment"
FROM country c, university u, university_year uy 
WHERE c.id = u.country_id AND u.id = uy.university_id AND uy.year = 2015
GROUP BY c.country_name
ORDER BY ROUND(AVG(uy.num_students),0) DESC;

--4. How many ranking criteria does each ranking system have? Display the ranking 
--system name and number of criteria in a column named "Total Criteria". Display 
--in descending order by total criteria.
SELECT rs.system_name, COUNT(rc.criteria_name) AS "Total Criteria"
FROM ranking_system rs, ranking_criteria rc 
WHERE rs.id = rc.ranking_system_id
GROUP BY rs.system_name
ORDER BY COUNT(rc.criteria_name) DESC;

--5. Show the average score for each ranking criteria in the year 2014. Display
--the system name, criteria name and average score in a column named average score. 
--Round the average scores to 2 decimal places. Display results in descending order 
--by ranking system name. Hint: you will have to group by two columns. Hint Hint 
--group by the columns you ant displayed.
SELECT rs.system_name, rc.criteria_name, ROUND(AVG(ury.score),2)AS "Average Score"
FROM ranking_system rs, ranking_criteria rc, university_ranking_year ury
WHERE rs.id = rc.ranking_system_id AND rc.id = ury.ranking_criteria_id AND ury.year = 2014
GROUP BY rs.system_name, rc.criteria_name, rs.id
ORDER BY rs.id DESC;

--6. Show the top 25 universities with the highest alumni employment rank in 
--2015. Display in Descending order

SELECT u.university_name, rc.criteria_name, ury.score
FROM university u, ranking_criteria rc, university_ranking_year ury 
WHERE u.id = ury.university_id AND ury.ranking_criteria_id = rc.id AND ury.year = 2015 AND rc.criteria_name = "Alumni Employment Rank"
ORDER BY  ury.score DESC;
LIMIT 25;

--7. Show the number of international students at each United States universities
--in 2013. Show the University name and the number of students in a column called 
--"Total Internalional Students". Display in descending order by total students. 
--You can calculate the number of international students by 
--(pct_international_students * 0.01) * num students.

SELECT u.university_name, ROUND(((uy.pct_international_students * 0.01) * uy.num_students),0)  AS "Total International Students"
FROM university_year uy, university u
WHERE uy.university_id = u.id AND uy.year = 2013 AND u.country_id = 73
ORDER BY ROUND(((uy.pct_international_students * 0.01) * uy.num_students),0) DESC;

--8. Show the number of students in each country in 2016. Display the contry name and number
--of students in a column called "Total Students" ordered by the number of students in 
--descending order.
SELECT c.country_name, SUM(uy.num_students)
FROM country c, university_year uy, university u
WHERE uy.university_id = u.id AND u.country_id = c.id AND uy.year = 2016
GROUP BY c.country_name
ORDER BY SUM(uy.num_students) DESC;
