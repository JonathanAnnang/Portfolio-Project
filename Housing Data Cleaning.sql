/*

Cleaning Data In SQL

*/


---Standardize Date Format---

SELECT SaleDateConverted, CONVERT(DATE, Saledate)
FROM PortfolioProject.dbo.[NashvilleHousing]

UPDATE [NashvilleHousing]
SET SaleDate = CONVERT(DATE, Saledate)

ALTER TABLE [NashvilleHousing]
add SaleDateConverted Date;

UPDATE [NashvilleHousing]
SET SaleDateConverted = CONVERT(DATE, Saledate)


--------------------------------------------------------------------------------

---Populate Property Address---

 SELECT *
FROM PortfolioProject.dbo.NashvilleHousing
ORDER BY ParcelID


 SELECT A.ParcelID, A.PropertyAddress, B.ParcelID, B.PropertyAddress, ISNULL(A.PropertyAddress, B.PropertyAddress)
FROM PortfolioProject.dbo.NashvilleHousing A
JOIN PortfolioProject.dbo.NashvilleHousing B
ON A.ParcelID = B.ParcelID
AND A.[UniqueID ] <> B.[UniqueID ]
WHERE A.PropertyAddress IS NULL

UPDATE A
SET PropertyAddress = ISNULL(A.PropertyAddress, B.PropertyAddress)
FROM PortfolioProject.dbo.NashvilleHousing A
JOIN PortfolioProject.dbo.NashvilleHousing B
ON A.ParcelID = B.ParcelID
AND A.[UniqueID ] <> B.[UniqueID ]
WHERE A.PropertyAddress IS NULL


---------------------------------------------------------------------------------------------------------------------------------------


---Breaking Down Property Address Into Individual Columns (Address, City, State)---

 SELECT PropertyAddress
FROM PortfolioProject.dbo.NashvilleHousing
--ORDER BY ParcelID

 SELECT 
 SUBSTRING (PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) AS Address,
  SUBSTRING (PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress)) AS Address
FROM PortfolioProject.dbo.NashvilleHousing



ALTER TABLE [NashvilleHousing]
ADD PropertySplitAddress NVARCHAR(255);

UPDATE [NashvilleHousing]
SET PropertySplitAddress = SUBSTRING (PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)

ALTER TABLE [NashvilleHousing]
ADD PropertyCity NVARCHAR(255);

UPDATE [NashvilleHousing]
SET PropertyCity = SUBSTRING (PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress))



-----------------------------------------------------------------------------------------------------------------------------------------

---Breaking Down Owner's Address Into Individual Columns (Address, City, State)---

SELECT OwnerAddress
FROM PortfolioProject.DBO.NashvilleHousing


SELECT 
PARSENAME(REPLACE(OwnerAddress, ',','.'), 3),
PARSENAME(REPLACE(OwnerAddress, ',','.'), 2),
PARSENAME(REPLACE(OwnerAddress, ',','.'), 1)
FROM PortfolioProject.DBO.NashvilleHousing



ALTER TABLE [NashvilleHousing]
ADD OwnerSplitAddress NVARCHAR(255);

UPDATE [NashvilleHousing]
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',','.'), 3)

ALTER TABLE [NashvilleHousing]
ADD OwnerCity NVARCHAR(255);

UPDATE [NashvilleHousing]
SET OwnerCity = PARSENAME(REPLACE(OwnerAddress, ',','.'), 2)

ALTER TABLE [NashvilleHousing]
ADD OwnerState NVARCHAR(255);

UPDATE [NashvilleHousing]
SET OwnerState = PARSENAME(REPLACE(OwnerAddress, ',','.'), 1)



----------------------------------------------------------------------------------------------------------------------------------------

---Change Y and N in Sold As Vacant To Yes and No---

SELECT SoldAsVacant, COUNT(SoldAsVacant)
FROM PortfolioProject.dbo.NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY 2

SELECT SoldAsVacant,
	CASE
		WHEN SoldAsVacant = 'Y' THEN 'YES'
		WHEN SoldAsVacant = 'N' THEN 'NO'
		ELSE SoldAsVacant
	END
FROM PortfolioProject.dbo.NashvilleHousing

UPDATE NashvilleHousing
SET SoldAsVacant = CASE
				   WHEN SoldAsVacant = 'Y' THEN 'YES'
				   WHEN SoldAsVacant = 'N' THEN 'NO'
				   ELSE SoldAsVacant
				   END


-----------------------------------------------------------------------------------------------------------------------------------------

---Remove Duplicate---

WITH RowNumCTE AS (
SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
	ORDER BY UniqueID
	)  Row_num
FROM PortfolioProject.dbo.NashvilleHousing
)
DELETE 
FROM RowNumCTE
WHERE Row_num > 1



-----------------------------------------------------------------------------------------------------------------------------------------

---Delete Unused Columns---

SELECT *
FROM PortfolioProject.dbo.NashvilleHousing

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN PropertyAddress,SaleDate,OwnerAddress,TaxDistrict