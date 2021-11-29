/*
Inner Jouins, Full/Left/Right Outer Joins
*/
SELECT *
FROM EmployeeDemographics;

SELECT *
FROM EmployeeSalary;

-- Inner Join
-- Everything that is the same from both tables
SELECT * 
FROM EmployeeDemographics
Inner Join EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;


-- Left Outer Join
--Everything from left (first) table and only what matches from right (second) table
SELECT * 
FROM EmployeeDemographics
Left Outer Join EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;

-- Right Outer Join
--Everything from right (second) table and only what matches from left (first) table
SELECT * 
FROM EmployeeDemographics
Right Outer Join EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;


-- Full Outer Join
--Everything from both tables
SELECT * 
FROM EmployeeDemographics
FUll Outer Join EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;

/*
Unions
*/
-- this is ok to do here because the tables are the same - matching columns
SELECT *
FROM EmployeeDemographics
UNION
SELECT *
FROM WareHouseEmployeeDemographics
ORDER BY EmployeeID;

-- This is not what not to do because the columns are not the same
SELECT EmployeeID, FirstName, Age
FROM EmployeeDemographics
UNION
SELECT EmployeeID, JobTitle, Salary
FROM EmployeeSalary
ORDER BY EmployeeID;

/*
Case Statements
*/
SELECT EmployeeID, FirstName, Age,
CASE
	WHEN AGE > 30 THEN 'Old'
	WHEN AGE BETWEEN 27 AND 30 THEN 'Young'
	ELSE 'Baby'
END
FROM EmployeeDemographics
WHERE Age is not null 
ORDER BY Age;

SELECT FirstName, LastName, JobTitle, Salary,
CASE 
	WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .10)
	WHEN JobTitle = 'Accountant' THEN Salary + (Salary * .05)
	WHEN JobTitle = 'HR' THEN Salary + (Salary * .0001)
	ELSE Salary + (Salary * 0.03)
END AS SalaryAfterRaise
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

/*
Having Clause
*/

SELECT JobTitle, COUNT(JobTitle)
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING COUNT(JobTitle) > 1

SELECT JobTitle,AVG(Salary)
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING AVG(Salary) > 45000
ORDER BY AVG(Salary);

/*
Updating and Deleting Data
*/

SELECT *
FROM EmployeeDemographics

UPDATE EmployeeDemographics
SET EmployeeID = 1012, Age = 31, Gender = 'Female'
WHERE FirstName = 'Holly' AND LastName = 'Flax';

/*
Aliasing
*/

SELECT FirstName + ' ' + LastName as FullName
FROM EmployeeDemographics

/*
Partition By
*/
-- divides results set into partitions 

SELECT FirstName, LastName, Gender, Salary,
COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender
FROM EmployeeDemographics dem
JOIN EmployeeSalary sal 
	ON dem.EmployeeID = sal.EmployeeID;

SELECT Gender,COUNT(Gender)
FROM EmployeeDemographics dem
JOIN EmployeeSalary sal 
	ON dem.EmployeeID = sal.EmployeeID
GROUP BY Gender

-- this query above returns the same as the one above it but the Partition by query returns the answer on each row 