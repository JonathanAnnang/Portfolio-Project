/*


Data Cleaning: Deleting Redundant Columns


*/

---Selcting Table---


SELECT *
FROM PortfolioProject.dbo.HR_Employee_Attrition


---Deleting Unused columns--

ALTER TABLE PortfolioProject.dbo.HR_Employee_Attrition
DROP COLUMN Over18, RelationshipSatisfaction, StandardHours, StockOptionLevel, WorkLifeBalance


---Changing Data Type Of Age Column From Float To Integer---

SELECT CAST(Age as int)
FROM PortfolioProject.dbo.HR_Employee_Attrition

update HR_Employee_Attrition
set Age = CAST(Age as int)


---Creating A New Column: AgeGroup---


SELECT 
	(CASE
		WHEN Age >= 55 THEN 'Senior'
		WHEN Age <= 54 AND Age >= 40 THEN 'Adult'
		WHEN Age >= 25 AND Age <= 39 THEN 'Young Adult'
		WHEN Age < 25 THEN 'Youth'
	END)
FROM HR_Employee_Attrition


ALTER TABLE HR_Employee_Attrition
ADD AgeGroup Varchar(50)

UPDATE HR_Employee_Attrition
SET AgeGroup = (CASE
					WHEN Age >= 55 THEN 'Senior'
					WHEN Age <= 54 AND Age >= 40 THEN 'Adult'
					WHEN Age >= 25 AND Age <= 39 THEN 'Young Adult'
					WHEN Age < 25 THEN 'Youth'
				END)


--------------------------------------------------------------------------------------------------------------------

          ---EMPLOYEE DEMOGRAPHICS---

SELECT MIN(Age) Min_Age, MAX(Age) Max_Age, AVG(Age) Average_Age
FROM PortfolioProject.dbo.HR_Employee_Attrition


--Looking At The Count Of Gender, Count of Gender Per Department And Overall Percentage --

--Count vOf Gender
SELECT Gender, COUNT(Gender) Number
FROM PortfolioProject.dbo.HR_Employee_Attrition
GROUP BY Gender

--Count Of Gender Per Department
SELECT Department, Gender, 
COUNT(Gender) OVER (PARTITION BY Gender)
FROM HR_Employee_Attrition

--Overall Percentage
SELECT 
	  100 * SUM (CASE WHEN Gender = 'Male' THen 1 ELSE 0 END) / COUNT(Gender) Percentage_Of_Male,
	  100 * sum	(CASE WHEN Gender = 'Female' THEN 1 ELSE 0 END) / COUNT(Gender) Percentage_Of_Female
FROM PortfolioProject.dbo.HR_Employee_Attrition


--Marital Status And Percentage--


SELECT MaritalStatus, COUNT(MaritalStatus)
FROM PortfolioProject.dbo.HR_Employee_Attrition
GROUP BY MaritalStatus

SELECT
	  100 * SUM(CASE WHEN MaritalStatus = 'Single' THEN 1 ELSE 0 END) / COUNT(MaritalStatus) Single_Percentage,
	  100 * SUM(CASE WHEN MaritalStatus = 'Married' THEN 1 ELSE 0 END) / COUNT(MaritalStatus) Married_Percentage,
	  100 * SUM(CASE WHEN MaritalStatus = 'Divorced' THEN 1 ELSE 0 END) / COUNT(MaritalStatus) Divorce_Percentage
FROM PortfolioProject.dbo.HR_Employee_Attrition


---Relationship Between OverTime And AgeGroup---

SELECT COUNT(OverTime) Total_Overtime,
	100 * SUM(CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END) / COUNT(OverTime) Yes_Percentage,
	100 * SUM(CASE WHEN OverTime = 'No' THEN 1 ELSE 0 END) / COUNT(OverTime) NO_Percentage
FROM PortfolioProject.DBO.HR_Employee_Attrition

SELECT COUNT(OverTime) Youth_OverTime,
	100 * SUM(CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END) / COUNT(OverTime) Yes_Percentage,
	100 * SUM(CASE WHEN OverTime = 'No' THEN 1 ELSE 0 END) / COUNT(OverTime) NO_Percentage
FROM PortfolioProject.DBO.HR_Employee_Attrition
WHERE AgeGroup = 'Youth'

SELECT COUNT(OverTime) Young_Adult_OverTime,
	100 * SUM(CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END) / COUNT(OverTime) Yes_Percentage,
	100 * SUM(CASE WHEN OverTime = 'No' THEN 1 ELSE 0 END) / COUNT(OverTime) NO_Percentage
FROM PortfolioProject.DBO.HR_Employee_Attrition
WHERE AgeGroup = 'Young Adult'

SELECT COUNT(OverTime) Adult_OverTime,
	100 * SUM(CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END) / COUNT(OverTime) Yes_Percentage,
	100 * SUM(CASE WHEN OverTime = 'No' THEN 1 ELSE 0 END) / COUNT(OverTime) NO_Percentage
FROM PortfolioProject.DBO.HR_Employee_Attrition
WHERE AgeGroup = 'Adult'

SELECT COUNT(OverTime) Senior_OverTime,
	100 * SUM(CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END) / COUNT(OverTime) Yes_Percentage,
	100 * SUM(CASE WHEN OverTime = 'No' THEN 1 ELSE 0 END) / COUNT(OverTime) NO_Percentage
FROM PortfolioProject.DBO.HR_Employee_Attrition
WHERE AgeGroup = 'Senior'


---Attrition Rate---
SELECT ATTRITION, COUNT(Attrition) No_Employees
FROM HR_Employee_Attrition
GROUP BY Attrition


SELECT  COUNT(Attrition) No_Employees,
	100 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(Attrition) Yes_Percentage,
	100 * SUM(CASE WHEN Attrition = 'No' THEN 1 ELSE 0 END) / COUNT(Attrition) NO_Percentage
FROM PortfolioProject.dbo.HR_Employee_Attrition


---Attrition VS. Department---

SELECT Department, COUNT(Department) People
FROM PortfolioProject.dbo.HR_Employee_Attrition
GROUP BY Department

SELECT  COUNT(Attrition) No_Employees,
	100 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(Attrition) Yes_Percentage,
	100 * SUM(CASE WHEN Attrition = 'No' THEN 1 ELSE 0 END) / COUNT(Attrition) NO_Percentage
FROM PortfolioProject.dbo.HR_Employee_Attrition
WHERE Department = 'Sales'

SELECT  COUNT(Attrition) No_Employees,
	100 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(Attrition) Yes_Percentage,
	100 * SUM(CASE WHEN Attrition = 'No' THEN 1 ELSE 0 END) / COUNT(Attrition) NO_Percentage
FROM PortfolioProject.dbo.HR_Employee_Attrition
WHERE Department = 'Research & Development'

SELECT  COUNT(Attrition) No_Employees,
	100 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(Attrition) Yes_Percentage,
	100 * SUM(CASE WHEN Attrition = 'No' THEN 1 ELSE 0 END) / COUNT(Attrition) NO_Percentage
FROM PortfolioProject.dbo.HR_Employee_Attrition
WHERE Department = 'Human Resources'


SELECT  Gender, Attrition, COUNT(Attrition) 'Count', AVG(PerformanceRating) AVG_Performance
FROM HR_Employee_Attrition
GROUP BY Attrition, Gender