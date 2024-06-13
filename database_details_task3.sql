
-- Q 3.2

use employee_dataset_ibm;

-- Query 1

# Query with GROUP BY Clause (To analyze the average Monthly Income by Gender)

SELECT Gender, AVG(MonthlyIncome) as AverageIncome
FROM employee_dataset_ibm
GROUP BY Gender;

-- Query 2

# Query with Window Function (To rank Employees by Salary within each Department)

SELECT Department, EmployeeNumber, MonthlyIncome,
  RANK() OVER (PARTITION BY Department ORDER BY MonthlyIncome DESC) as SalaryRank
FROM employee_dataset_ibm;

-- Query 3

# Query using Views (To create a view for Employee Work Details and then select from it)

CREATE VIEW vw_EmployeeWorkDetails AS
SELECT EmployeeNumber, JobRole, YearsAtCompany, TotalWorkingYears
FROM employee_dataset_ibm;

SELECT *
FROM vw_EmployeeWorkDetails
WHERE YearsAtCompany > 5;

-- Query 4

# (To find Employees who may be considered for promotion):

SELECT EmployeeNumber, YearsInCurrentRole, YearsSinceLastPromotion, JobLevel
FROM employee_dataset_ibm
WHERE YearsSinceLastPromotion > 2 AND YearsInCurrentRole > 3 AND JobLevel < 5;
