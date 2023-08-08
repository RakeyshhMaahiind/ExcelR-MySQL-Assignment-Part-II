USE ASSIGNMENT;
-- 1. select all employees in department 10 whose salary is greater than 3000. [table: employee]
SELECT * FROM EMPLOYEE 
WHERE DEPTNO =10 AND SALARY>3000;

-- 2. The grading of students based on the marks they have obtained is done as follows:
	  40 to 50 -> THIRD Class
      50 to 60 -> SECOND Class
      60 to 80 -> First Class
      80 to 100 -> Distinctions
a. How many students have graduated with first class?
b. How many students have obtained distinction? [table: students]

ALTER TABLE STUDENTS
ADD COLUMN GRADE VARCHAR(20);

UPDATE STUDENTS
SET GRADE=
  CASE 
  WHEN MARKS BETWEEN 40 AND 49.99 THEN 'THIRD CLASS'
  WHEN MARKS BETWEEN 50 AND 59.99 THEN 'SECOND CLASS'
  WHEN MARKS BETWEEN 60 AND 79.99 THEN 'FIRST CLASS'
  WHEN MARKS BETWEEN 80 AND 100 THEN 'DISTINCTION'
  ELSE 'FAILED'
END;

SELECT * FROM STUDENTS;

SELECT COUNT(GRADE) AS 'STUDENTS PASS WITH FISRT CLASS'
FROM STUDENTS
WHERE GRADE REGEXP 'FIRST';

SELECT COUNT(GRADE) AS 'STUDENTS PASS WITH DISTINCTION'
FROM STUDENTS
WHERE GRADE REGEXP 'DIST';


-- 3. Get a list of city names from station with even ID numbers only. Exclude duplicates from your answer.[table: station]

SELECT DISTINCT(CITY) FROM STATION WHERE ID % 2 = 0;

-- 4. Find the difference between the total number of city entries in the table and the number of distinct city entries in the table. In other words, if N is the number of city entries in station, and N1 is the number of distinct city names in station, write a query to find the value of N-N1 from station.
[table: station]	

SELECT COUNT(CITY) AS 'COUNT OF CITIES' FROM STATION; 
SELECT COUNT(DISTINCT CITY) AS 'COUNT OF DISTINCT CITIES' FROM STATION;
SELECT COUNT(CITY)-COUNT(DISTINCT CITY) AS 'DIFFERENCE BETWEEN ALL CITIES AND DISTINCT CITIES' FROM STATION;

-- 5. Answer the following
-- a. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates. [Hint: Use RIGHT() / LEFT() methods ]

SELECT DISTINCT CITY
FROM STATION
WHERE CITY REGEXP '^A|,^E|,^I|,^O|,^U|'
GROUP BY CITY
ORDER BY CITY;
-- b. Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.

SELECT DISTINCT CITY 
FROM STATION
WHERE CITY REGEXP '^[AEIOU].*[AEIOU]$'
GROUP BY CITY
ORDER BY CITY;

-- c. Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.

SELECT DISTINCT CITY FROM STATION
WHERE CITY REGEXP '^[^AEIOU]'
ORDER BY CITY;

-- d. Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates. [table: station]

SELECT DISTINCT CITY
FROM STATION
WHERE CITY NOT REGEXP '^[AEIOU].*[AEIOU]$';

-- 6. Write a query that prints a list of employee names having a salary greater than $2000 per month who have been employed for less than 36 months. Sort your result by descending order of salary. [table: emp]

SELECT CONCAT(FIRST_NAME,'',LAST_NAME) AS EMPLOYEE,
       CONCAT (SALARY,'$') AS 'SALARY($)',
       HIRE_DATE,
       TIMESTAMPDIFF(MONTH,HIRE_DATE,CURDATE()) AS 'TOTAL_MONTHS_JOINED'
FROM EMP
WHERE SALARY > 2000
HAVING TOTAL_MONTHS_JOINED < 36
ORDER BY SALARY DESC;

-- 7. How much money does the company spend every month on salaries for each department? [table: employee]

Expected Result
----------------------
+--------+--------------+
| deptno | total_salary |
+--------+--------------+
|     10 |     20700.00 |
|     20 |     12300.00 |
|     30 |      1675.00 |
+--------+--------------+
3 rows in set (0.002 sec)

SELECT DEPTNO,
       SUM(SALARY) AS TOTAL_SALARY
FROM EMPLOYEE 
GROUP BY DEPTNO;

-- 8. How many cities in the CITY table have a Population larger than 100000. [table: city]

SELECT COUNT(NAME) FROM CITY WHERE POPULATION>100000;

-- 9. What is the total population of California? [table: city]

SELECT SUM(POPULATION) AS TOTAL_POPULATION FROM CITY WHERE DISTRICT='CALIFORNIA';

-- 10. What is the average population of the districts in each country? [table: city]

SELECT DISTRICT,AVG(POPULATION) FROM CITY
GROUP BY DISTRICT;

-- 11. Find the ordernumber, status, customernumber, customername and comments for all orders that are ‘Disputed=  [table: orders, customers]

SELECT O.ORDERNUMBER,
	   O.STATUS,
       O.CUSTOMERNUMBER,
       C.CUSTOMERNAME,
       O.COMMENTS
FROM CUSTOMERS C
JOIN ORDERS O
USING (CUSTOMERNUMBER)
WHERE O.STATUS='DISPUTED';

