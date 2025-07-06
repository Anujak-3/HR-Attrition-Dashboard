USE [HR Database];

-- All Data
SELECT * FROM HR_Employee_Attrition;

-- Basic Attrition Count
SELECT Attrition, COUNT(Attrition) AS "No of Employees left/retent"
FROM HR_Employee_Attrition
GROUP BY Attrition;

-- Percentage of Employees Leaving
SELECT 
  Attrition,
  COUNT(*) AS TotalEmployees,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM HR_Employee_Attrition), 2) AS Percentage
FROM HR_Employee_Attrition 
GROUP BY Attrition;

-- Age Affecting Attrition
SELECT Attrition, COUNT(*) FROM HR_Employee_Attrition WHERE Age > 36 GROUP BY Attrition;
SELECT Attrition, COUNT(*) FROM HR_Employee_Attrition WHERE Age < 36 GROUP BY Attrition;
SELECT AVG(Age) FROM HR_Employee_Attrition;

SELECT TOP 1 
  (SELECT COUNT(*) FROM HR_Employee_Attrition WHERE Age > 36 AND Attrition = 'Yes') * 100.0 / 
  (SELECT COUNT(*) FROM HR_Employee_Attrition WHERE Age > 36) AS "Percentage of Old Employees Leaving"
FROM HR_Employee_Attrition;

SELECT TOP 1 
  (SELECT COUNT(*) FROM HR_Employee_Attrition WHERE Age < 36 AND Attrition = 'Yes') * 100.0 / 
  (SELECT COUNT(*) FROM HR_Employee_Attrition WHERE Age < 36) AS "Percentage of Young Employees Leaving"
FROM HR_Employee_Attrition;

SELECT 
  CASE WHEN Age < 36 THEN 'Young (<36)' ELSE 'Older (36+)' END AS Age_Group,
  COUNT(*) AS Total_Employees,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left,
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Attrition_Percentage
FROM HR_Employee_Attrition
GROUP BY CASE WHEN Age < 36 THEN 'Young (<36)' ELSE 'Older (36+)' END;

-- Business Travel affecting Attrition
SELECT BusinessTravel, Attrition, COUNT(*) AS "No. of Employees left/ not left"
FROM HR_Employee_Attrition
GROUP BY BusinessTravel, Attrition;

SELECT 
  BusinessTravel, 
  COUNT(*) AS "Total Employees",
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS "Employee left", 
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS "Attrition Rate %"
FROM HR_Employee_Attrition
WHERE OverTime = 1
GROUP BY BusinessTravel
ORDER BY [Attrition Rate %] DESC;

-- Department-wise Attrition
SELECT 
  Department, 
  COUNT(*) AS "Total Employees",
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS "Employee left", 
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS "Attrition Rate %"
FROM HR_Employee_Attrition
GROUP BY Department;

-- Education Field vs Attrition
SELECT 
  EducationField,
  COUNT(*) AS "Total Employees", 
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS "Employees Left",
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS "Attrition Rate" 
FROM HR_Employee_Attrition
GROUP BY EducationField
ORDER BY [Attrition Rate] DESC;

-- Education Level vs Attrition
SELECT 
  Education, 
  COUNT(*) AS "Total Employees",
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS "Employees Left",
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS "Attrition Rate" 
FROM HR_Employee_Attrition
GROUP BY Education
ORDER BY Education ASC;

-- Environment Satisfaction vs Attrition
SELECT 
  EnvironmentSatisfaction,  
  COUNT(*) AS "Total Employees",
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS "Employees Left",
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS "Attrition Rate" 
FROM HR_Employee_Attrition
GROUP BY EnvironmentSatisfaction
ORDER BY EnvironmentSatisfaction ASC;

-- Gender and Overtime Impact
SELECT 
  Gender, OverTime, 
  COUNT(*) AS "Total Employees",
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS "Employees Left",
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS "Attrition Rate" 
FROM HR_Employee_Attrition
GROUP BY Gender, OverTime
ORDER BY [Attrition Rate] DESC;

-- Gender with Job & Environment Satisfaction
SELECT 
  Gender, JobSatisfaction, EnvironmentSatisfaction,
  COUNT(*) AS "Total Employees",
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS "Employees Left",
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS "Attrition Rate" 
FROM HR_Employee_Attrition
GROUP BY Gender, JobSatisfaction, EnvironmentSatisfaction
ORDER BY [Attrition Rate] DESC;

-- Age Group + Gender + Overtime
SELECT 
  CASE WHEN Age < 36 THEN 'Young (<36)' ELSE 'Older (36+)' END AS Age_Group,
  Gender,
  COUNT(*) AS "Total Employees",
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS "Employees Left",
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS "Attrition Rate" 
FROM HR_Employee_Attrition
WHERE OverTime = 1
GROUP BY Gender, CASE WHEN Age < 36 THEN 'Young (<36)' ELSE 'Older (36+)' END
ORDER BY [Attrition Rate] DESC;

-- Salary Hike
SELECT 
  CASE WHEN PercentSalaryHike > 15 THEN 'Salary Hike 15+' ELSE 'Salary Hike 15<' END AS "Salary Interval",
  COUNT(*) AS "Total Employees",
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS "Employees Left",
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS "Attrition Rate"
FROM HR_Employee_Attrition
GROUP BY CASE WHEN PercentSalaryHike > 15 THEN 'Salary Hike 15+' ELSE 'Salary Hike 15<' END;

-- Salary Hike with Overtime
SELECT 
  CASE WHEN PercentSalaryHike > 15 THEN 'Salary Hike 15+' ELSE 'Salary Hike 15<' END AS "Salary Interval",
  COUNT(*) AS "Total Employees",
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS "Employees Left",
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS "Attrition Rate"
FROM HR_Employee_Attrition
WHERE OverTime = 1
GROUP BY CASE WHEN PercentSalaryHike > 15 THEN 'Salary Hike 15+' ELSE 'Salary Hike 15<' END;

-- Job Role + Business Travel + Salary
SELECT 
  JobRole, BusinessTravel,
  CASE WHEN PercentSalaryHike > 15 THEN 'Salary Hike 15+' ELSE 'Salary Hike 15<' END AS "Salary Interval",
  COUNT(*) AS "Total Employees",
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS "Employees Left",
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS "Attrition Rate"
FROM HR_Employee_Attrition
WHERE OverTime = 1
GROUP BY JobRole, BusinessTravel, CASE WHEN PercentSalaryHike > 15 THEN 'Salary Hike 15+' ELSE 'Salary Hike 15<' END
ORDER BY [Attrition Rate] DESC;

-- Job Level
SELECT 
  JobLevel,
  COUNT(*) AS "Total Employees",
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS "Employees Left",
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS "Attrition Rate"
FROM HR_Employee_Attrition
GROUP BY JobLevel
ORDER BY [Attrition Rate] DESC;

-- Department + JobRole + JobLevel
SELECT 
  Department, JobRole, JobLevel,
  COUNT(*) AS "Total Employees",
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS "Employees Left",
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS "Attrition Rate"
FROM HR_Employee_Attrition
GROUP BY Department, JobRole, JobLevel
ORDER BY [Attrition Rate] DESC;

-- WorkLifeBalance and Job Role (Overtime)
SELECT 
  WorkLifeBalance, JobRole,
  COUNT(*) AS "Total Employees",
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS "Employees Left",
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS "Attrition Rate"
FROM HR_Employee_Attrition
WHERE OverTime = 1
GROUP BY WorkLifeBalance, JobRole
ORDER BY [Attrition Rate] DESC;

-- WorkLifeBalance + BusinessTravel + JobRole (No Overtime)
SELECT 
  WorkLifeBalance, BusinessTravel, JobRole,
  COUNT(*) AS [Total],
  SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS [Left],
  ROUND(100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS [Attrition Rate]
FROM HR_Employee_Attrition
WHERE WorkLifeBalance = 4 AND OverTime = 0
GROUP BY WorkLifeBalance, BusinessTravel, JobRole
ORDER BY [Attrition Rate] DESC;

-- Years Since Last Promotion (Overtime only)
SELECT 
  YearsSinceLastPromotion,
  COUNT(*) AS [Total],
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS [Left],
  ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS [Attrition Rate]
FROM HR_Employee_Attrition
WHERE OverTime = 1
GROUP BY YearsSinceLastPromotion
ORDER BY [Attrition Rate] DESC;

-- Monthly Income vs Attrition by Job Role
SELECT 
  JobRole, Attrition,
  COUNT(*) AS "Total Employees",
  ROUND(AVG(MonthlyIncome), 2) AS "Avg Income",
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS "Employees Left",
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS "Attrition Rate"
FROM HR_Employee_Attrition
GROUP BY JobRole, Attrition
ORDER BY [Avg Income] DESC;

-- Average Income for Attrition Yes/No
SELECT 
  JobRole,
  ROUND(AVG(CASE WHEN Attrition = 'Yes' THEN MonthlyIncome END), 2) AS AvgIncome_Left,
  ROUND(AVG(CASE WHEN Attrition = 'No' THEN MonthlyIncome END), 2) AS AvgIncome_Stayed,
  COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS Left_Count,
  COUNT(CASE WHEN Attrition = 'No' THEN 1 END) AS Stayed_Count
FROM HR_Employee_Attrition
WHERE OverTime = 1
GROUP BY JobRole
ORDER BY AvgIncome_Left DESC;

-- Avg Income for Attrition='Yes' only
SELECT 
  JobRole, AVG(MonthlyIncome) AS Avg_income
FROM HR_Employee_Attrition
WHERE Attrition = 'Yes'
GROUP BY JobRole
ORDER BY Avg_income DESC;

