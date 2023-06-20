CREATE DATABASE STAGING_AdventureWorks2012
GO

USE STAGING_AdventureWorks2012
GO

CREATE TABLE [Employee](
	[BusinessEntityID] [int] NULL,
	[Gender] [nvarchar](1) NULL,
	[HireDate] [date] NULL,
	[NationalIDNumber] [nvarchar](15) NULL
) ON [PRIMARY]
GO

CREATE TABLE [OrderDetail](
	[SalesOrderID] [int] NULL,
	[SalesOrderDetailID] [int] NULL,
	[OrderQty] [smallint] NULL,
	[ProductID] [int] NULL
) ON [PRIMARY]
GO

CREATE TABLE [OrderHeader](
	[SalesOrderID] [int] NULL,
	[OrderDate] [datetime] NULL,
	[TerritoryID] [int] NULL,
	[TotalDue] [money] NULL,
	[Status] [tinyint] NULL,
	[SalesPersonID] [int] NULL
) ON [PRIMARY]
GO

CREATE TABLE [Person](
	[BusinessEntityID] [int] NULL,
	[Title] [nvarchar](8) NULL,
	[FirstName] [nvarchar](50) NULL,
	[MiddleName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL
) ON [PRIMARY]
GO


CREATE TABLE [Product](
	[ProductID] [int] NULL,
	[Name] [nvarchar](50) NULL,
	[ProductNumber] [nvarchar](25) NULL,
	[StandardCost] [money] NULL,
	[ListPrice] [money] NULL,
	[Weight] [numeric](8, 2) NULL,
	[ProductSubcategoryID] [int] NULL
) ON [PRIMARY]
GO



CREATE TABLE [ProductCategory](
	[ProductCategoryID] [int] NULL,
	[Name] [nvarchar](50) NULL
) ON [PRIMARY]

GO

CREATE TABLE [ProductSubCategory](
	[ProductCategoryID] [int] NULL,
	[Name] [nvarchar](50) NULL,
	[ProductSubcategoryID] [int] NULL
) ON [PRIMARY]

GO

CREATE TABLE [Territory](
	[TerritoryID] [int] NULL,
	[Name] [nvarchar](50) NULL,
	[CountryRegionCode] [nvarchar](3) NULL
) ON [PRIMARY]
GO

CREATE TABLE [Dim_Date](
	[OrderDate] [date] NULL,
	[Month] [int] NULL,
	[Year] [int] NULL
) ON [PRIMARY]
GO

CREATE TABLE [Dim_SalesPerson](
	[SalesPersonID] [int] NULL,
	[HireDate] [date] NULL,
	[Gender] [nvarchar](1) NULL,
	[NationalIDNumber] [nvarchar](15) NULL,
	[FullName] [nvarchar](308) NULL
) ON [PRIMARY]
GO

CREATE TABLE [Dim_Territory](
	[TerritoryID] [int] NULL,
	[Name] [nvarchar](50) NULL,
	[CountryRegionCode] [nvarchar](3) NULL
) ON [PRIMARY]
GO

CREATE TABLE [Fact_SalesOrder](
	[OrderDate] [date] NULL,
	[SalesPersonID] [int] NULL,
	[TerritoryID] [int] NULL,
	[Revenue] [money] NULL,
	[NumberOrder] [int] NULL
) ON [PRIMARY]
GO

CREATE TABLE [Fact_Product](
	[OrderDate] [date] NULL,
	[TerritoryID] [int] NULL,
	[ProductID] [int] NULL,
	[Qty] [bigint] NULL
) ON [PRIMARY]
GO

CREATE TABLE [Dim_Product](
	[ProductCategoryID] [int] NULL,
	[ProductID] [int] NULL,
	[Name] [nvarchar](50) NULL,
	[ProductNumber] [nvarchar](25) NULL,
	[StandardCost] [money] NULL,
	[ListPrice] [money] NULL,
	[Weight] [numeric](8, 2) NULL,
	[ProductSubcategoryID] [int] NULL,
	[ProductSubcategoryName] [nvarchar](50) NULL,
	[ProductCategoryName] [nvarchar](50) NULL
) ON [PRIMARY]

GO
create index idx_Employee on Employee(BusinessEntityID);
create index idx_OrderDetail on OrderDetail(SalesOrderDetailID);
create index idx_OrderHeader on OrderHeader(SalesOrderID);
create index idx_Person on Person(BusinessEntityID);
create index idx_Product on Product(ProductID);
create index idx_ProductCategory on ProductCategory(ProductCategoryID);
create index idx_ProductSubCategory on ProductSubCategory(ProductSubCategoryID);
create index idx_Territory on Territory(TerritoryID);
create index idx_Dim_Date on Dim_Date(OrderDate);
create index idx_Dim_SalesPerson on Dim_SalesPerson(SalesPersonID);
create index idx_Dim_Territory on Dim_Territory(TerritoryID);
create index idx_Fact_SalesOrder on Fact_SalesOrder(OrderDate);
create index idx_Fact_Product on Fact_Product(OrderDate);
create index Dim_Product on Dim_Product(ProductID);