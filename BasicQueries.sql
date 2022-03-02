################ CREATING DATABASE AND TABLES IN MYSQL



CREATE DATABASE ORG;
SHOW DATABASES;
USE ORG;

CREATE TABLE Worker (
	WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	FIRST_NAME CHAR(25),
	LAST_NAME CHAR(25),
	SALARY INT(15),
	JOINING_DATE DATETIME,
	DEPARTMENT CHAR(25)
);

INSERT INTO Worker 
	(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
		(001, 'Monika', 'Arora', 100000, '14-02-20 09.00.00', 'HR'),
		(002, 'Niharika', 'Verma', 80000, '14-06-11 09.00.00', 'Admin'),
		(003, 'Vishal', 'Singhal', 300000, '14-02-20 09.00.00', 'HR'),
		(004, 'Amitabh', 'Singh', 500000, '14-02-20 09.00.00', 'Admin'),
		(005, 'Vivek', 'Bhati', 500000, '14-06-11 09.00.00', 'Admin'),
		(006, 'Vipul', 'Diwan', 200000, '14-06-11 09.00.00', 'Account'),
		(007, 'Satish', 'Kumar', 75000, '14-01-20 09.00.00', 'Account'),
		(008, 'Geetika', 'Chauhan', 90000, '14-04-11 09.00.00', 'Admin');

CREATE TABLE Bonus (
	WORKER_REF_ID INT,
	BONUS_AMOUNT INT(10),
	BONUS_DATE DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Bonus 
	(WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
		(001, 5000, '16-02-20'),
		(002, 3000, '16-06-11'),
		(003, 4000, '16-02-20'),
		(001, 4500, '16-02-20'),
		(002, 3500, '16-06-11');
        
        
        CREATE TABLE Title (
	WORKER_REF_ID INT,
	WORKER_TITLE CHAR(25),
	AFFECTED_FROM DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Title 
	(WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
 (001, 'Manager', '2016-02-20 00:00:00'),
 (002, 'Executive', '2016-06-11 00:00:00'),
 (008, 'Executive', '2016-06-11 00:00:00'),
 (005, 'Manager', '2016-06-11 00:00:00'),
 (004, 'Asst. Manager', '2016-06-11 00:00:00'),
 (007, 'Executive', '2016-06-11 00:00:00'),
 (006, 'Lead', '2016-06-11 00:00:00'),
 (003, 'Lead', '2016-06-11 00:00:00');
 
 
 ##QUERYING
 
 SELECT * 
 FROM worker;
 
 
 SELECT FIRST_NAME 
 FROM worker;
 
 
SELECT UPPER(FIRST_NAME) 
FROM worker;


SELECT DISTINCT department 
FROM worker;


SELECT SUBSTRING(FIRST_NAME, 1, 3) 
FROM worker;


SELECT INSTR(FIRST_NAME, BINARY'a') 
FROM worker 
WHERE FIRST_NAME = 'Amitabh';


SELECT RTRIM(FIRST_NAME) 
FROM worker;


SELECT LTRIM(DEPARTMENT) 
FROM worker;


SELECT DISTINCT(LENGTH(department)) 
FROM worker;
 
 
 SELECT REPLACE(FIRST_NAME, 'a', 'A') 
 FROM worker;
 
 
 SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS COMPLETE_NAME 
 FROM worker;
 
 
 SELECT * 
 FROM worker 
 ORDER BY FIRST_NAME;
 
 
 SELECT * 
 FROM worker 
 ORDER BY FIRST_NAME ASC, DEPARTMENT DESC;
 
 
SELECT * 
FROM worker 
WHERE FIRST_NAME IN ('Vipul', 'Satish');


SELECT * 
FROM worker 
WHERE FIRST_NAME NOT IN ('Vipul', 'Satish');


SELECT * 
FROM worker 
WHERE department = 'Admin';


SELECT * 
FROM worker 
WHERE FIRST_NAME LIKE 'a%';


SELECT * 
FROM worker 
WHERE FIRST_NAME LIKE '_____h';


SELECT * 
FROM worker 
WHERE SALARY BETWEEN 100000 AND 500000;


SELECT * 
FROM worker 
WHERE year(JOINING_DATE) = 2014 AND MONTH(JOINING_DATE) = 2;


SELECT COUNT(*) 
FROM worker 
WHERE department = 'Admin';


SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS Worker_Name 
FROM worker 
WHERE SALARY BETWEEN 50000 AND 100000;


SELECT DEPARTMENT, COUNT(*) 
FROM worker 
GROUP BY DEPARTMENT 
ORDER BY DEPARTMENT DESC;


SELECT W.*, T.WORKER_TITLE 
FROM worker AS W 
JOIN title AS T 
ON W.WORKER_ID = T.WORKER_REF_ID 
WHERE T.WORKER_TITLE = 'Manager';


SELECT WORKER_TITLE, AFFECTED_FROM, COUNT(*) 
FROM title 
GROUP BY WORKER_TITLE, AFFECTED_FROM 
HAVING COUNT(*) > 1;


SELECT * 
FROM worker 
WHERE MOD(WORKER_ID, 2) <> 0;


SELEcT * 
FROM worker 
WHERE MOD(WORKER_ID, 2) = 0;


SELECT NOW();


SELECT * 
FROM worker 
ORDER BY SALARY DESC LIMIT 10;


##GETTING THE 5TH HIGHEST SALARY

SELECT * 
FROM worker AS w1 
WHERE 4 = (SELECT COUNT(DISTINCT(w2.Salary)) 
FROM worker AS w2 
WHERE w2.Salary >= w1.Salary);


#GETTING THE DETAILS OF WORKERS WITH THE SAME SALARY

SELECT W.* 
FROM worker W 
JOIN worker W2 
ON W.SALARY = W2.SALARY 
AND W.WORKER_ID <> W2.WORKER_ID;


##GETTING THE SECOND HIGHEST SALARY

SELECT MAX(SALARY)
FROM worker 
WHERE SALARY NOT IN (SELECT MAX(SALARY) FROM worker) 
LIMIT 1;


#WRITING QUERY TO SHOW ONE ROW TWICE

SELECT * 
FROM worker
UNION ALL
SELECT * 
FROM WORKER;


#GETTING 50% RECORDS OF THE TABLE

SELECT * 
FROM worker
WHERE WORKER_ID <= (SELECT COUNT(WORKER_ID)/2 FROM worker);


##Write an SQL query to fetch the departments that have less than five people in it.

SELECT department, COUNT(department) AS Number_Of_Workers
FROM worker 
GROUP BY department
HAVING COUNT(DISTINCT(department)) < 5;


#Write an SQL query to show all departments along with the number of people in there.

SELECT department, count(department) as Number_of_workers
FROM worker
GROUP BY department;


#Write an SQL query to show the last record from a table.

SELECT *
FROM worker
WHERE WORKER_ID = (SELECT MAX(WORKER_ID) FROM worker);


#Write an SQL query to fetch the first row of a table.


SELECT *
FROM worker
WHERE WORKER_ID = (SELECT MIN(WORKER_ID) FROM worker);



#Write an SQL query to print the name of employees having the highest salary in each department.

SELECT FIRST_NAME, department, MAX(SALARY)
FROM worker
GROUP BY department;


SELECT w.FIRST_NAME, w.department, Salary as MaxSalary
FROM (SELECT department, MAX(SALARY) as HighestSalary FROM worker
GROUP BY department) as w2
JOIN worker w 
ON w.salary = w2.HighestSalary;



#Write an SQL query to fetch three max salaries from a table.

SELECT DISTINCT(SALARY)
FROM worker
ORDER BY salary DESC
LIMIT 3;



#Write an SQL query to fetch three min salaries from a table.

SELECT DISTINCT(SALARY)
FROM worker
ORDER BY salary
LIMIT 3;



#Write an SQL query to fetch departments along with the total salaries paid for each of them.

SELECT department, SUM(salary) as Total_salary
FROM worker
GROUP BY department
ORDER BY total_salary DESC;



#Write an SQL query to fetch the names of workers who earn the highest salary.

SELECT FIRST_NAME, salary
FROM worker
WHERE SALARY = (SELECT MAX(salary) FROM worker)















 
 
 
 
 
 
 
 
 
 
 
 
 
 
 