--1.  Write a query to create a view named “EmployeesPerCountry” that shows the country_name and the number of employees from that country in a column called “Number of Employees”. 
--Display your results in descending order of number of employees.

CREATE VIEW EmployeesPerCountry AS
SELECT COUNT(e.employee_id), c.country_name
FROM employees e, countries c, departments d, locations l
WHERE e.department_id = d.department_id AND d.location_id = l.location_id AND l.country_id = c.country_id
GROUP BY c.country_name
ORDER BY COUNT(e.employee_id) DESC;

--Query the EmployeesPerCountry to show the number of employees from the United Kingdom .

SELECT * FROM EmployeesPerCountry
WHERE country_name = "United Kingdom";

--2. Write a query to create a view named “managers” to display all the managers. Include the manager’s name (first, last), phone number, email, job title, and department name. 

CREATE VIEW managers AS
SELECT CONCAT(e.first_name, " ", e.last_name) AS "Name", e.phone_number, e.email, j.job_title, d.department_name
FROM employees e
JOIN jobs j ON j.job_id = e.job_id
JOIN departments d ON d.department_id = e.department_id
WHERE e.employee_id IN(SELECT manager_id FROM employees);

SELECT department_name, COUNT(Name) AS "Number of Managers" 
FROM managers 
GROUP BY d.department_name 
ORDER BY COUNT(Name) DESC;


--3. Write a query to create a view named DependentsByJobTitle to get a count of how many dependents there are for each job title. Show job titles even if they do not have dependents. 
--Place the number of dependents in a column called "Number of Dependents". HINT: Remember directional Joins (LEFT & RIGHT), you will have to use one of those.

CREATE VIEW DependentsByJobTitle AS
SELECT j.job_title, COUNT(d.dependent_id) AS "Number of Dependents"
FROM jobs j
LEFT JOIN employees e ON j.job_id = e.job_id
LEFT JOIN dependents d ON e.employee_id = d.employee_id
GROUP BY j.job_title;

SELECT * 
FROM DependentsByJobTitle
WHERE `Number of Dependents` = (SELECT MAX(`Number of Dependents`) FROM DependentsByJobTitle);



--4. Write a query to create a view named DepartmentHiresByYear that calculates the number of employees hired each year in each department, Order results by department name. 
--HINT: Remember the SQL $year function, and you will have to group by two columns (year and department name). You separate the column names by a comma in the GROUP BY clause.

CREATE VIEW DepartmentHiresByYear AS
SELECT year(e.hire_date) AS YEAR , d.department_name, COUNT(e.employee_id) AS "Employees Hired"
FROM employees e, departments d 
WHERE e.department_id = d.department_id
GROUP BY YEAR(e.hire_date), d.department_name
ORDER BY d.department_name, YEAR ASC;

SELECT * FROM DepartmentHiresByYear WHERE YEAR = 1998;

--5. Write a query to create a view named “AvgSalaryByJobTitle” to calculate the average salary for each job title. Display the job title, average salary in a column named 
--"Average salary", and number of employees with that title in a column called "Number of Employees". Display results in descending order by average salary. 
--HINT: You can use both the AVG() and COUNT() functions in the Select clause of your query.

CREATE VIEW AvgSalaryByJobTitle AS 
SELECT j.job_title, AVG(e.salary) AS "Average salary", COUNT(e.employee_id) As "Number of Employees"
FROM employees e, jobs j
WHERE e.job_id = j.job_id
GROUP BY j.job_title
ORDER BY AVG(e.salary) DESC;

SELECT * FROM AvgSalaryByJobTitle WHERE job_title = "Programmer";

--6. Write a query to create a view named “AvgSalaryByDepartment” to calculate average salaries for each department. Display the department name, 
--average salary in a column named "Average salary", and number of employees with that title in a column called "Number of Employees"

CREATE VIEW AvgSalaryByDepartment AS 
SELECT d.department_name, avg(e.salary) AS "Average Salary", COUNT(e.employee_id) AS "Number of Employees"
FROM employees e, jobs j, departments d
WHERE e.job_id = j.job_id AND e.department_id = d.department_id
GROUP BY d.department_name;

SELECT * FROM AvgSalaryByDepartment WHERE department_name = "Purchasing";

--7. Write a query to create a view named “EmployeeDependents” that calculates the number of dependents each employees has. 
--This query should show employees even if they have 0 dependents. Display the employee name (first, last), email, phone number, and number of dependents. 
--Hint: You will have to use left or right join.

CREATE VIEW EmployeeDependents AS 
SELECT CONCAT(e.first_name, " ", e.last_name) AS "Name", e.phone_number, e.email, COUNT(d.dependent_id) AS num_dependents
FROM employees e
LEFT JOIN dependents d ON e.employee_id = d.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name, e.phone_number, e.email;

SELECT * FROM EmployeeDependents
WHERE `Name` =  "William Gietz"

--8. Write a query to create a view named “CountryLocation” that calculates the number of locations in each region. This query should show regions even if they have 0 locations. 
--Display the region name and number of locations in descending order by number of locations. HINT: Remember directional Joins (LEFT & RIGHT), you will have to use one of those.

CREATE VIEW CountryLocation AS
SELECT COUNT(l.location_id) AS "Number of Locations", r.region_name
FROM regions r 
LEFT JOIN countries c ON c.region_id = r.region_id
LEFT JOIN locations l ON l.country_id = c.country_id
GROUP BY r.region_name
ORDER BY COUNT(l.location_id) DESC;

SELECT * FROM CountryLocation
WHERE `Number of Locations` = 0;

