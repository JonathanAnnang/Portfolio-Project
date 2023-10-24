




SELECT *
FROM Exercise.DBO.DETAILS
JOIN Exercise.dbo.ORDERS
ON DETAILS.Order_ID = ORDERS.Order_ID
----------------------------------------------------------------------------------

--TOTAL SALES AND AVERAGE SALES--

SELECT SUM(Amount * Quantity) AS Total_Sales, AVG(Amount * Quantity) AS AVG_Sales
FROM DETAILS

SELECT State, SUM(Amount * Quantity) Total_Sales
FROM Exercise.DBO.DETAILS
JOIN Exercise.dbo.ORDERS
ON DETAILS.Order_ID = ORDERS.Order_ID
GROUP BY State
ORDER BY Total_Sales DESC




--SELECT Order_Date, State, Category, Amount, COUNT(Quantity)
--	OVER (PARTITION BY state) SSS
--FROM Exercise..DETAILS
--JOIN Exercise..ORDERS
--ON DETAILS.Order_ID = ORDERS.Order_ID
--where Sub_Category = 'stole'

---looking At The Quantity, Price, Sale and Profit of Individual Product

SELECT Sub_Category, COUNT(QUANTITY) QTY, SUM(Amount) Price, SUM(quantity * amount) Amount, SUM(Profit) Profit
FROM DETAILS
JOIN ORDERS
ON DETAILS.Order_ID = ORDERS.Order_ID
GROUP BY Sub_Category
ORDER BY Profit DESC

SELECT Category, SUM(PROFIT) Profit
FROM DETAILS
GROUP BY Category

---Looking At The Quantity Of Products Sold  In Each Sate--

SELECT  Sub_Category, State, Amount, COUNT(Sub_Category)
	OVER (PARTITION BY  Sub_Category) QTY
FROM Exercise..DETAILS
JOIN Exercise..ORDERS
ON DETAILS.Order_ID = ORDERS.Order_ID
order by QTY desc


---Looking At THe Most Prefered Payment Mode

SELECT PaymentMode, COUNT(PaymentMode) Usage
FROM DETAILS
GROUP BY PaymentMode
ORDER BY 2 DESC


---Sales Trend By Category

SELECT Order_Date, Category, SUM(amount * quantity)
FROM DETAILS
JOIN ORDERS
ON DETAILS.Order_ID = ORDERS.Order_ID
GROUP BY Order_Date, Category
ORDER BY Order_Date

