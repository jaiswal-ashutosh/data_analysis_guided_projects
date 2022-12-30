/*

Cleaning Data in SQL Queries

*/
Select *
From PortfolioProject..NashvilleHousing
--Standardize Date Format

Select saledateconverted,convert(Date,SaleDate)
From PortfolioProject..NashvilleHousing

Update NashvilleHousing
Set SaleDate=Convert(Date,SaleDate)

Alter Table NashvilleHousing
Add SaleDateConverted date

Update NashvilleHousing
Set SaleDateConverted=Convert(Date,SaleDate)




--Populate Property Adderess date
Select *
From PortfolioProject..NashvilleHousing
--Where PropertyAddress is null
order by ParcelID


Select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From PortfolioProject..NashvilleHousing a
join PortfolioProject..NashvilleHousing b
   on a.ParcelID=b.ParcelID
   and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null


Update a
Set PropertyAddress=ISNULL(a.PropertyAddress,b.PropertyAddress)
From PortfolioProject..NashvilleHousing a
join PortfolioProject..NashvilleHousing b
   on a.ParcelID=b.ParcelID
   and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null








--Breaking out address into Individual Columns (Address, City, State)

Select PropertyAddress
From PortfolioProject..NashvilleHousing
--Where PropertyAddress is null
order by ParcelID


Select
SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) as Address
,SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress)) as Address
From PortfolioProject..NashvilleHousing


Alter Table NashvilleHousing
Add PropertySplitAddress nvarchar(255)

Update NashvilleHousing
Set PropertySplitAddress=SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)

Alter Table NashvilleHousing
Add PropertySplitCity nvarchar(255)


select *
from PortfolioProject..NashvilleHousing







select OwnerAddress
from PortfolioProject..NashvilleHousing

Select 
PARSENAME(REPLACE(OwnerAddress,',','.'),3)
,PARSENAME(REPLACE(OwnerAddress,',','.'),2)
,PARSENAME(REPLACE(OwnerAddress,',','.'),1)
from PortfolioProject..NashvilleHousing



Alter Table NashvilleHousing
Add OwnerSplitAddress nvarchar(255)

Update NashvilleHousing
Set OwnerSplitAddress=PARSENAME(REPLACE(OwnerAddress,',','.'),3)

Alter Table NashvilleHousing
Add OwnerSplitCity nvarchar(255)

Update NashvilleHousing
Set OwnerSplitAddress=PARSENAME(REPLACE(OwnerAddress,',','.'),2)

Alter Table NashvilleHousing
Add OwnerSplitState nvarchar(255)

Update NashvilleHousing
Set OwnerSplitState=PARSENAME(REPLACE(OwnerAddress,',','.'),1)





--Change Y and N to Yes and No in "Sold as Vacant" field

select Distinct(SoldAsVacant),Count(SoldAsVacant)
from PortfolioProject..NashvilleHousing
Group by SoldAsVacant
order by 2


select SoldAsVacant
,CASE when SoldAsVacant ='Y' then 'Yes'
      when SoldAsVacant ='N' then 'No'
	  Else SoldAsVacant
	  END
from PortfolioProject..NashvilleHousing

Update NashvilleHousing
Set SoldAsVacant=CASE when SoldAsVacant ='Y' then 'Yes'
      when SoldAsVacant ='N' then 'No'
	  Else SoldAsVacant
	  END








--Remove duplicates
with RowNumCTE As(
select *,
  ROW_NUMBER() over(
  Partition BY ParcelID,
               PropertyAddress,
			   SalePrice,
			   SaleDate,
			   LegalReference
			   Order by 
			     uniqueid
				 )row_num
from PortfolioProject..NashvilleHousing
--order by ParcelID
)

select *
From RowNumCTE
where row_num>1







--Delete Unused Columns


select *
From PortfolioProject..NashvilleHousing


Alter Table NashvilleHousing
DROP column OwnerAddress, TaxDistrict, PropertyAddress


Alter Table NashvilleHousing
DROP column SaleDate


--