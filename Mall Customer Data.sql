/*

Mall Customer Data Exploration

SKILLS USED: Aggregation Function, Conditional Function, SubQuery, Windows Function

*/


---Selecting Data To Be Working With---

SELECT *
FROM customer_shopping_data



--- Aggregating The Number of Trasactions By Each Shopping Mall ---
---Shows The Mall That Got The Most Traffic---

Select shopping_mall, Count(shopping_mall) As NumberOfTransaction
From customer_shopping_data
Group By shopping_mall
Order by 2 desc


--- Looking At The Market Share Of Each Mall ---

Select a. shopping_mall, Count(shopping_mall) As NumberOfTransaction, (Count(shopping_mall) * 100.00 / NumberOfTransaction) As 'MarketShare'
From (Select shopping_mall,Count(shopping_mall) Over () As NumberOfTransaction
From customer_shopping_data) a
Group by shopping_mall,NumberOfTransaction
Order By 'MarketShare' desc


--- Count Of Gender ---

Select gender, COUNT(Gender) CountOfGender
From customer_shopping_data
Group By  gender



--- Percentage Of Gender ---
--- Shows Percentage Of Gender Demography That Shopped Across The Malls---

Select 
	   100.00*SUM(Case When Gender = 'Male' Then 1 Else 0 End)/Count(gender) Male_Percentage,
	   100.00*SUM(Case When Gender = 'Female' Then 1 Else 0 End)/Count(gender) Female_Percentage
From customer_shopping_data


---Count Of Payment Method---
---Shows The Most Prefered Payment Method---

Select payment_method, COUNT(payment_method) As Count_PM
From customer_shopping_data
Group By payment_method 
Order By payment_method 


---Percentage Of Each Payment Method---

Select 
	  100.00*SUM(Case When payment_method = 'Cash' Then 1 Else 0 End)/COUNT(payment_method) As Cash_Percentage,
	  100.00*SUM(Case When payment_method = 'Credit Card' Then 1 Else 0 End)/Count(payment_method) As CC_Percentage,
	  100.00*SUM(Case When payment_method = 'Debit Card' Then 1 Else 0 End)/COUNT(payment_method) As DB_Percentage
From customer_shopping_data


---Calculating Descriptive Statistics Of Cutomer's Age---
---This Will Help Determine: The Youngest and Oldest Person That Shopped As Well As The Average Age Of Customers. Also We Will Get To See The Mode Of Customer's Age---

Select  MIN(Age) As Min_Age, MAX(Age) As Max_Age, Round(AVG(Age), 2) As Average_Age
From customer_shopping_data


---Grouping The Ages Of Shoppers---

SELECT AGE,
	(CASE
		WHEN age > 60 THEN '60 And Above'
		WHEN age >= 41 and age <= 60 THEN '41-60'
		WHEN age >= 21 and age <= 40 THEN '21-40'
		WHEN age <=20 THEN 'Below 20'
	END) AS 'Age_Group'
FROM customer_shopping_data
GROUP BY age
ORDER BY Age_Group


---Total Average Sale---

SELECT AVG(PRICE)
FROM customer_shopping_data


---Looking At The Average Sales of Each Mall---

SELECT shopping_mall, AVG(Price) Average_Price
FROM customer_shopping_data
GROUP BY shopping_mall
ORDER BY 2 DESC


---Looking At Total Sales And Total Sales of Each Mall---

SELECT SUM(Price) OverAllSales
FROM customer_shopping_data

SELECT shopping_mall, SUM(Price) Sales
FROM customer_shopping_data
GROUP BY shopping_mall
ORDER BY 2 DESC


---Percentage Of Sales By Mall As Against Over ALl Sales---

SELECT b. shopping_mall, SUM(price) AS Sales, (SUM(price) *100 / Sales) 'Percentage'
FROM (SELECT shopping_mall,price, SUM(price) OVER () AS Sales
FROM customer_shopping_data) b
group by shopping_mall, Sales
order by 'Percentage' DESC


---Looking At The Category That Generated The Most Revenue---

SELECT  category, SUM(price) AS Revenue
FROM customer_shopping_data
GROUP BY  category
ORDER BY Revenue DESC

