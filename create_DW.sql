---------------------SNOWFLAKE SCHEMA------------------
CREATE DATABASE DW_AdventureWorks2012
GO
USE [DW_AdventureWorks2012]
GO

---------Create year dimesion
CREATE TABLE [Dim_Year](
	[YearKey] [nvarchar](4) NOT NULL,
	[Year] [int] NOT NULL,
 CONSTRAINT [PK_Dim_Year] PRIMARY KEY CLUSTERED 
(
	[YearKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

---- Create month dimension
CREATE TABLE [Dim_Month](
	[MonthKey] [nvarchar](6) NOT NULL,
	[YearKey] [nvarchar](4) NOT NULL,
	[Month] [int] NOT NULL,
 CONSTRAINT [PK_Dim_Month] PRIMARY KEY CLUSTERED 
(
	[MonthKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [Dim_Month]  WITH CHECK ADD  CONSTRAINT [FK_Dim_Month_Dim_Year] FOREIGN KEY([YearKey])
REFERENCES [Dim_Year] ([YearKey])
GO
ALTER TABLE [Dim_Month] CHECK CONSTRAINT [FK_Dim_Month_Dim_Year]
GO

---- Create date dimension
CREATE TABLE [Dim_Date](
	[DateKey] [nvarchar](8) NOT NULL,
	[MonthKey] [nvarchar](6) NOT NULL,
	[Date] Date not null
 CONSTRAINT [PK_Dim_Date] PRIMARY KEY CLUSTERED 
(
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

alter TABLE [Dim_Date]
alter column [Date] datetime

go

ALTER TABLE [Dim_Date]  WITH CHECK ADD  CONSTRAINT [FK_Dim_Date_Dim_Month] FOREIGN KEY([MonthKey])
REFERENCES [Dim_Month] ([MonthKey])
GO

ALTER TABLE [Dim_Date] CHECK CONSTRAINT [FK_Dim_Date_Dim_Month]
GO

---

---------Create sales Person dimension
CREATE TABLE [Dim_SalesPerson](
	[SalesPersonKey] [int] IDENTITY(1,1) NOT NULL,
	[SalesPersonId] [int] NOT NULL,
	[FullName] [nvarchar](500) NULL,
	[NationalIDNumber] [nvarchar](15) NULL,
	[Gender] nchar(1) NULL,
	[HireDate] date NULL,

 CONSTRAINT [PK_Dim_SalesPerson] PRIMARY KEY CLUSTERED 
(
	[SalesPersonKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

---------Create territory dimension
CREATE TABLE [Dim_Territory](
	[TerritoryKey] [int] IDENTITY(1,1) NOT NULL,
	[TerritoryId] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[CountryRegionCode] [nvarchar](3) NOT NULL,

 CONSTRAINT [PK_Dim_Territory] PRIMARY KEY CLUSTERED 
(
	[TerritoryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

---------Create product category dimension
CREATE TABLE [Dim_ProductCategory](
	[ProductCategoryKey] [int] IDENTITY(1,1) NOT NULL,
	[ProductCategoryId] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,

 CONSTRAINT [PK_Dim_ProductCategory] PRIMARY KEY CLUSTERED 
(
	[ProductCategoryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

---- Create Product sub category dimension
CREATE TABLE [Dim_ProductSubCategory](
	[ProductSubCategoryKey] [int] IDENTITY(1,1) NOT NULL,
	[ProductSubCategoryId] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ProductCategoryKey] [int]  NOT NULL,
 CONSTRAINT [PK_Dim_ProductSubCategory] PRIMARY KEY CLUSTERED 
(
	[ProductSubCategoryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [Dim_ProductSubCategory]  WITH CHECK ADD  CONSTRAINT [FK_Dim_ProductSubCat_Dim_ProductCat] FOREIGN KEY([ProductCategoryKey])
REFERENCES [Dim_ProductCategory] ([ProductCategoryKey])
GO
ALTER TABLE [Dim_ProductSubCategory] CHECK CONSTRAINT [FK_Dim_ProductSubCat_Dim_ProductCat]
GO

---- Create Product dimension
CREATE TABLE [Dim_Product](
	[ProductKey] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ProductNumber] [nvarchar](25) NOT NULL,
	[StandardCost] money NOT NULL,
	[ListPrice] money NOT NULL,
	[Weight] decimal(8, 2) null,
	[ProductSubCategoryKey] [int]  NOT NULL,
 CONSTRAINT [PK_Dim_Product] PRIMARY KEY CLUSTERED 
(
	[ProductKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [Dim_Product]  WITH CHECK ADD  CONSTRAINT [FK_Dim_Product_Dim_ProductSubCat] FOREIGN KEY([ProductSubCategoryKey])
REFERENCES [Dim_ProductSubCategory] ([ProductSubCategoryKey])
GO
ALTER TABLE [Dim_Product] CHECK CONSTRAINT [FK_Dim_Product_Dim_ProductSubCat]
GO


-----Create Fact sales order

CREATE TABLE [Fact_SalesOrder](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateKey] [nvarchar](8) NOT NULL,
	[TerritoryKey] int NULL,
	[SalesPersonKey] int NULL,
	[Revenue] [money] NOT NULL,
	[NumberOrder] int NOT NULL
 CONSTRAINT [PK_Fact_SalesOrder] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [Fact_SalesOrder]  WITH CHECK ADD  CONSTRAINT [FK_Fact_SalesOrder_Dim_Date] FOREIGN KEY([DateKey])
REFERENCES [Dim_Date] ([DateKey])
GO

ALTER TABLE [Fact_SalesOrder] CHECK CONSTRAINT [FK_Fact_SalesOrder_Dim_Date]
GO

ALTER TABLE [Fact_SalesOrder]  WITH CHECK ADD  CONSTRAINT [FK_Fact_SalesOrder_Dim_SalesPerson] FOREIGN KEY([SalesPersonKey])
REFERENCES [Dim_SalesPerson] ([SalesPersonKey])
GO

ALTER TABLE [Fact_SalesOrder] CHECK CONSTRAINT [FK_Fact_SalesOrder_Dim_SalesPerson]
GO

ALTER TABLE [Fact_SalesOrder]  WITH CHECK ADD  CONSTRAINT [FK_Fact_SalesOrder_Dim_Territory] FOREIGN KEY([TerritoryKey])
REFERENCES [Dim_Territory] ([TerritoryKey])
GO

ALTER TABLE [Fact_SalesOrder] CHECK CONSTRAINT [FK_Fact_SalesOrder_Dim_Territory]
GO



-----Create Fact product

CREATE TABLE [Fact_Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateKey] [nvarchar](8) NOT NULL,
	[ProductKey] int NOT NULL,
	[TerritoryKey] int NULL,
	[Qty] bigint NOT NULL
 CONSTRAINT [PK_Fact_Product] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [Fact_Product]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Product_Dim_Date] FOREIGN KEY([DateKey])
REFERENCES [Dim_Date] ([DateKey])
GO

ALTER TABLE [Fact_Product] CHECK CONSTRAINT [FK_Fact_Product_Dim_Date]
GO

ALTER TABLE [Fact_Product]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Product_Dim_Product] FOREIGN KEY([ProductKey])
REFERENCES [Dim_Product] ([ProductKey])
GO

ALTER TABLE [Fact_Product] CHECK CONSTRAINT [FK_Fact_Product_Dim_Product]
GO


ALTER TABLE [Fact_Product]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Product_Dim_Territory] FOREIGN KEY([TerritoryKey])
REFERENCES [Dim_Territory] ([TerritoryKey])
GO

ALTER TABLE [Fact_Product] CHECK CONSTRAINT [FK_Fact_Product_Dim_Territory]
GO

create index idx_ProductCategory on Dim_ProductCategory(ProductCategoryKey);
create index idx_ProductCategory_ID on Dim_ProductCategory(ProductCategoryId);
create index idx_ProductSubCategory on Dim_ProductSubCategory(ProductSubCategoryKey);
create index idx_ProductSubCategory_ID on Dim_ProductSubCategory(ProductSubCategoryId);
create index idx_Dim_SalesPerson on Dim_SalesPerson(SalesPersonKey);
create index idx_Dim_SalesPerson_ID on Dim_SalesPerson(SalesPersonId);
create index idx_Dim_Territory on Dim_Territory(TerritoryKey);
create index idx_Dim_Territory_ID on Dim_Territory(TerritoryId);
create index idx_Fact_SalesOrder on Fact_SalesOrder(id);
create index idx_Fact_Product on Fact_Product(id);
create index idx_Dim_Product on Dim_Product(ProductKey);
create index idx_Dim_Product_ID on Dim_Product(ProductID);
create index idx_Dim_Year on Dim_Year(YearKey);
create index idx_Dim_Month on Dim_Month(MonthKey);
create index idx_Dim_Date on Dim_Date(Datekey);
create index idx_Dim_Date on Dim_Date(Date);