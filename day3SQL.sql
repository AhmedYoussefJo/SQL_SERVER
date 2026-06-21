/* =====================================================
SQL LAB QUESTIONS
Solve each question by writing the SQL query below it
Database: Employee – Departments – Project – Works_for
===================================================== */


/* 1) Show all distinct department numbers from the Employee table. */
SELECT DISTINCT Dno FROM Employee 

/* 2) Show the first 5 employees. */
SELECT TOP(5) * FROM EMPLOYEE

/* 3) Show the top 3 employees ordered by salary descending. */
SELECT TOP(3) * 
FROM EMPLOYEE 
ORDER BY SALARY DESC

/* 4) Show 3 random employees. */
SELECT TOP(3) * 
FROM Employee 
ORDER BY NEWID();

/* 5) Show 2 random projects. */
SELECT TOP(2) * 
FROM PROJECT 
ORDER BY NEWID();

/* 6) Show the top 3 employees ordered by salary with ties. */
SELECT TOP(3) WITH ties *
FROM Employee 
ORDER BY Salary DESC;

/* 7) Show employee first name, last name and salary,
      and create a column called Salary_Level using CASE:
      - "High" if salary >= 5000
      - "Low" otherwise. */

SELECT 
    Fname AS [First Name],
    Lname AS [Last Name],
    Salary,
    CASE 
        WHEN Salary >= 5000 THEN 'High'
        ELSE 'Low'
    END AS Salary_Level
FROM 
    dbo.Employee;

-- or 
Select fname , lname, salary ,
iif(Salary >= 5000, 'High', 'Low') 
from Employee as Salary_Level

/* 8) Show employee first name and birth date,
      and add a column showing the current date. */
      SELECT FNAME, LNAME, Bdate, GETDATE() as [Current Date] FROM Employee

/* 9) Show employee first name and the year of birth. */
SELECT FNAME, YEAR(BDATE) AS BYEAR FROM Employee

/* 10) Show the last day of the current month. */
SELECT EOMONTH(GETDATE());

/* 11) Create a new table called Employee_Copy
       from the Employee table. */
       SELECT * INTO Employee_Copy FROM Employee

/* 12) Create a table called HighSalaryEmployees
       containing employees whose salary > 5000. */
       SELECT * 
       INTO HighSalaryEmployees 
       FROM Employee 
       WHERE Salary > 5000
       

/* 13) Show the number of employees in each department. */
SELECT D.DNAME, COUNT(E.DNO) AS Employee_Count
FROM DEPARTMENTS D
LEFT JOIN EMPLOYEE E ON D.DNUM = E.DNO
GROUP BY D.DNAME;

/* 14) Show departments that have more than 3 employees. */
SELECT D.DNAME, COUNT(E.DNO) AS Employee_Count
FROM DEPARTMENTS D
LEFT JOIN EMPLOYEE E ON D.DNUM = E.DNO
GROUP BY D.DNAME
HAVING COUNT(E.DNO) > 3;

/* 15) Show departments where the average salary is greater than 4000. */
SELECT D.DNAME, AVG(E.SALARY)
FROM DEPARTMENTS D
LEFT JOIN EMPLOYEE E
ON D.DNUM = E.DNO
GROUP BY D.DNAME

/* =====================================================
Advanced Questions
===================================================== */


/* 16) Show employee first name, last name, department name and salary.
       Create a column called Salary_Level using CASE:
       - "High Salary" if salary >= 6000
       - "Medium Salary" if salary between 3000 and 6000
       - "Low Salary" if salary < 3000.
       (Use JOIN between Employee and Departments) */
       SELECT E.FNAME, E.LNAME, D.DNAME, E.SALARY, 
       CASE
            WHEN E.SALARY >= 6000 THEN 'High Salary'
            WHEN E.SALARY <= 6000 AND E.SALARY >= 3000 THEN 'Medium Salary'
            ELSE 'Low Salary'
       END AS  Salary_Level
       FROM EMPLOYEE E
       LEFT JOIN DEPARTMENTS D
       ON D.DNUM = E.DNO


/* 17) Show department name and number of employees in each department.
       Display only departments that have more than 3 employees.
       (Use JOIN + GROUP BY + HAVING) */
       SELECT D.DNAME, COUNT(E.DNO)
       FROM DEPARTMENTS D
       INNER JOIN EMPLOYEE E
       ON D.DNUM = E.DNO
       GROUP BY D.DNAME
       HAVING COUNT(E.DNO) > 3


/* 18) Show employee name, project name and working hours
       for employees who work more than 20 hours on a project.
       (Use JOIN between Employee, Works_for and Project) */
       SELECT E.FNAME + ' ' + E.LNAME AS FULL_NAME, P.PNAME, W.Hours
       FROM EMPLOYEE E
       INNER JOIN WORKS_FOR W
       ON E.SSN = W.ESSN
       INNER JOIN PROJECT P
       ON W.Pno = P.Pnumber
       WHERE W.Hours > 20

/* 19) Show the top 3 projects with the highest total working hours,
       including ties.
       (Use JOIN + GROUP BY + SUM + TOP WITH TIES) */
       SELECT TOP(3) WITH TIES
       P.PNAME AS [PROJECT NAME],
       SUM(W.HOURS) AS [TOTAL HOURS]
       FROM PROJECT P
       INNER JOIN WORKS_FOR W
       ON P.Pnumber = W.Pno
       GROUP BY P.PNAME 
       ORDER BY [TOTAL HOURS] DESC;

/* 20) Show 2 random employees with their department names.
       (Use JOIN + NEWID) */
       SELECT TOP(3)
       E.FNAME, 
       E.LNAME,
       D.DNAME AS DEP_NAME
       FROM EMPLOYEE E
       INNER JOIN DEPARTMENTS D
       ON D.Dnum = E.Dno
       ORDER BY NEWID()