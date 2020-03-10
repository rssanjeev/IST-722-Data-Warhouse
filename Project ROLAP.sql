/****** Object:  Database ist722_mafudge_cb3_dw    Script Date: 10/10/2019 7:47:57 PM ******/
/*
Kimball Group, The Microsoft Data Warehouse Toolkit
Generate a database from the datamodel worksheet, version: 4

You can use this Excel workbook as a data modeling tool during the logical design phase of your project.
As discussed in the book, it is in some ways preferable to a real data modeling tool during the inital design.
We expect you to move away from this spreadsheet and into a real modeling tool during the physical design phase.
The authors provide this macro so that the spreadsheet isn't a dead-end. You can 'import' into your
data modeling tool by generating a database using this script, then reverse-engineering that database into
your tool.

Uncomment the next lines if you want to drop and create the database
*/
/*
DROP DATABASE ist722_mafudge_cb3_dw
GO
CREATE DATABASE ist722_mafudge_cb3_dw
GO
ALTER DATABASE ist722_mafudge_cb3_dw
SET RECOVERY SIMPLE
GO
*/
USE ist722_mafudge_cb3_dw
;

/* Drop table dbo.RatingsFact */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.RatingsFact') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.RatingsFact 
;

/* Drop table dbo.PlanFact */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.PlanFact') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.PlanFact 
;


/* Drop table dbo.DimAccountTitle */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimAccountTitle') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimAccountTitle 
;

/* Drop table dbo.DimPlan */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimPlan') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimPlan 
;

/* Drop table dbo.DimItems */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimItems') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimItems 
;

/* Drop table dbo.DimTitle */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimTitle') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimTitle 
;

/* Drop table dbo.DimProduct */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimProduct') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimProduct 
;

/* Drop table dbo.DimCustomers */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimCustomers') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimCustomers 
;


/* Create table dbo.DimAccountTitle */
CREATE TABLE dbo.DimAccountTitle (
   [AccountTitleKey]  int IDENTITY  NOT NULL
,  [AccountTitleID]  int   NOT NULL
,  [TitleID]  varchar(20)   NOT NULL
,  [PlanID]  int   NOT NULL
,  [PlanName]  varchar(50)  NOT NULL
,  [PlanPrice]  money   NOT NULL
,  [PlanCurrent]  bit   NOT NULL
,  [ShippedDateKey]  int   NOT NULL
,  [ReturnDateKey]  int  NOT NULL
,  [AccountRating]  int   NULL
,  [RowIsCurrent]  nchar(1)   NOT NULL
,  [RowStartDate]  datetime    NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)    NULL
, CONSTRAINT [PK_dbo.DimAccountTitle] PRIMARY KEY CLUSTERED 
( [AccountTitleKey] )
) ON [PRIMARY]
;


SET IDENTITY_INSERT dbo.DimAccountTitle ON
;
INSERT INTO dbo.DimAccountTitle (AccountTitleKey, AccountTitleID, TitleID, PlanID, PlanName, PlanPrice, PlanCurrent, ShippedDateKey, ReturnDateKey, AccountRating, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, -1, 'Unk Attribute1', -1, 'Unknown', '', '', -1, -1, -1, 'Y', '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT dbo.DimAccountTitle OFF
;


/* Create table dbo.DimItems */
CREATE TABLE dbo.DimItems (
	[ItemKey] int IDENTITY NOT NULL
,	[ID] varchar(100) NOT NULL
,	[ItemName] varchar(200) NOT NULL
,	[ItemType] varchar(20) NULL
,  [RowIsCurrent]  nchar(1)   NOT NULL
,  [RowStartDate]  datetime   NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_dbo.DimItems] PRIMARY KEY CLUSTERED 
( [ItemKey] )
) ON [PRIMARY]
;

SET IDENTITY_INSERT dbo.DimItems ON
;
INSERT INTO dbo.DimItems(ItemKey, ID, ItemName, ItemType, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, 'Unknown', 'Unknown', 'Unknown', 'Y', '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT dbo.DimItems OFF
;


/* Create table dbo.DimCustomers */
CREATE TABLE dbo.DimCustomers (
   [CustomerKey]  int IDENTITY  NOT NULL
,  [FlixID]  int   NULL
,  [MartID]  int    NULL
,  [CustomerEmail]  varchar(200)    NULL
,  [CustomerFirstname]  varchar(50)    NULL
,  [CustomerLastname]  varchar(50)    NULL
,  [CustomerAddress]  varchar(1000)   NULL
,  [CustomerCity]  varchar(50)  NULL
,  [CustomerState]  varchar(2)    NULL
,  [CustomerZipcode]  varchar(20)    NULL
,  [CustomerPhone]  varchar(30)   NULL
,  [CustomerFax]  varchar(30)   NULL
,  [RowIsCurrent]  nchar(1)   NOT NULL
,  [RowStartDate]  datetime    NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999'  NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_dbo.DimCustomers] PRIMARY KEY CLUSTERED 
( [CustomerKey] )
) ON [PRIMARY]
;


SET IDENTITY_INSERT dbo.DimCustomers ON
;
INSERT INTO dbo.DimCustomers (CustomerKey, FlixID, MartID, CustomerEmail, CustomerFirstname, CustomerLastname, CustomerAddress, CustomerCity, CustomerState, CustomerZipcode, CustomerPhone, CustomerFax, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, -1, -1, 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'NA', '-1', '-1', '-1', 'Y', '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT dbo.DimCustomers OFF
;



/* Create table dbo.DimTitle */
CREATE TABLE dbo.DimTitle (
   [TitleKey]  int IDENTITY  NOT NULL
,  [TitleID]  varchar(20)    NOT NULL
,  [TitleName]  varchar(200)    NOT NULL
,  [TitleType]  varchar(20)    NOT NULL
-- ,  [TitleSynopsis]  varchar(max)    NOT NULL
,  [TitleAvgRating]  decimal(18,0)   NOT NULL
,  [TitleReleaseYear]  int    NOT NULL
,  [TitleRuntime]  int    NOT NULL
,  [TitleRating]  varchar(20)    NOT NULL
,  [TitleBlurayAvailable]  int   NULL
,  [TitleDvdAvailable]  int   NULL
,  [TitleInstantAvailable]  int NULL
,  [TitleDateModifiedKey]  int   NOT NULL
,  [RowIsCurrent]  nchar(1)   NOT NULL
,  [RowStartDate]  datetime    NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999'  NULL
,  [RowChangeReason]  nvarchar(200)    NULL
, CONSTRAINT [PK_dbo.DimTitle] PRIMARY KEY CLUSTERED 
( [TitleKey] )
) ON [PRIMARY]
;
/*

Delete from DimTitle where TitleKey = -1
*/

SET IDENTITY_INSERT dbo.DimTitle ON
;
INSERT INTO dbo.DimTitle (TitleKey, TitleID, TitleName, TitleType, TitleAvgRating, TitleReleaseYear, TitleRuntime, TitleRating, TitleBlurayAvailable, TitleDvdAvailable, TitleInstantAvailable, TitleDateModifiedKey, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, '-1' , 'Unk Attribute1', 'Unk Attribute2', -1, -1, -1, 'Unk',-1 , -1, -1, -1, 'Y', '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT dbo.DimTitle OFF
;


/* Drop table dbo.DimDate */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimDate') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimDate 
;

/* Create table dbo.DimDate */
CREATE TABLE dbo.DimDate (
   [DateKey]  int   NOT NULL
,  [Date]  datetime   NULL
,  [FullDateUSA]  nchar(11)   NOT NULL
,  [DayOfWeek]  tinyint   NOT NULL
,  [DayName]  nchar(10)   NOT NULL
,  [DayOfMonth]  tinyint   NOT NULL
,  [DayOfYear]  int   NULL
,  [WeekOfYear]  tinyint   NOT NULL
,  [MonthName]  nchar(10)   NOT NULL
,  [MonthOfYear]  tinyint   NULL
,  [Quarter]  tinyint   NOT NULL
,  [QuarterName]  nchar(10)   NOT NULL
,  [Year]  int   NOT NULL
,  [IsWeekday]  bit  DEFAULT 0 NOT NULL
, CONSTRAINT [PK_dbo.DimDate] PRIMARY KEY CLUSTERED 
( [DateKey] )
) ON [PRIMARY]
;

INSERT INTO dbo.DimDate (DateKey, Date, FullDateUSA, DayOfWeek, DayName, DayOfMonth, DayOfYear, WeekOfYear, MonthName, MonthOfYear, Quarter, QuarterName, Year, IsWeekday)
VALUES (-1, NULL, 'Unk date', 0, 'Unk date', 0, 0, 0, 'Unknown', 0, 0, 'Unk qtr', 0, 0)
;


/* Create table dbo.RatingsFact */
CREATE TABLE dbo.RatingsFact (
   [CustomerKey]  int   NOT NULL
,  [ItemKey] int NOT NULL
,  [ItemType] varchar(200) NOT NULL
,  [Rating]  int   NULL
, CONSTRAINT [PK_dbo.RatingsFact] PRIMARY KEY NONCLUSTERED 
( [CustomerKey], [ItemKey])
) ON [PRIMARY]
;

/* Create table dbo.PlanFact */
CREATE TABLE dbo.PlanFact (
   [TitleKey]  int NOT NULL
,  [AccountTitleKey]  int  NOT NULL
,  [ShippedDateKey]  int   NOT NULL
,  [ReturnedDateKey]  int   NOT NULL
,  [BlurayAvailability]  bit   NOT NULL
,  [DVDAvailability]  bit   NOT NULL
,  [InstantAvailability]  bit   NOT NULL
,  [DaysBetween]  int   NULL
,  [Total_Availability] int NULL
, CONSTRAINT [PK_dbo.PlanFact] PRIMARY KEY NONCLUSTERED 
( [TitleKey], [AccountTitleKey] )
) ON [PRIMARY]
;


ALTER TABLE dbo.RatingsFact ADD CONSTRAINT
   FK_dbo_RatingsFact_ItemKey FOREIGN KEY
   (
   ItemKey
   ) REFERENCES DimItems
   ( ItemKey)
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;

ALTER TABLE dbo.RatingsFact ADD CONSTRAINT
	FK_dbo_RatingsFact_CustomerKey FOREIGN KEY
	(
	CustomerKey
	) REFERENCES DimCustomers
	(CustomerKey)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION

 ALTER TABLE dbo.DimAccountTitle ADD CONSTRAINT
   FK_dbo_DimAccountTitle_ShippedDateKey FOREIGN KEY
   (
   ShippedDateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;


 ALTER TABLE dbo.DimAccountTitle ADD CONSTRAINT
   FK_dbo_DimAccountTitle_ReturnDateKey FOREIGN KEY
   (
   ReturnDateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;


 ALTER TABLE dbo.DimTitle ADD CONSTRAINT
   FK_dbo_DimTitle_TitleDateModifiedKey FOREIGN KEY
   (
   TitleDateModifiedKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;




ALTER TABLE dbo.PlanFact ADD CONSTRAINT
   FK_dbo_PlanFact_TitleKey FOREIGN KEY
   (
   TitleKey
   ) REFERENCES DimTitle
   ( TitleKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;


 
ALTER TABLE dbo.PlanFact ADD CONSTRAINT
   FK_dbo_PlanFact_ShippedDateKey FOREIGN KEY
   (
   ShippedDateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;

 
 ALTER TABLE dbo.PlanFact ADD CONSTRAINT
   FK_dbo_PlanFact_ReturnedDateKey FOREIGN KEY
   (
   ReturnedDateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
  

ALTER TABLE dbo.PlanFact ADD CONSTRAINT
   FK_dbo_PlanFact_AccountTitleKey FOREIGN KEY
   (
   AccountTitleKey
   ) REFERENCES DimAccountTitle
   ( AccountTitleKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;


/*
/* Create table dbo.DimPlan */
CREATE TABLE dbo.DimPlan (
   [Plan_Key]  int IDENTITY  NOT NULL
,  [Plan_ID]  int   NOT NULL
,  [Plan_Name]  nvarchar(50)   NOT NULL
,  [Plan_Price]  money   NOT NULL
,  [Plan_Current]  int   NOT NULL
,  [RowIsCurrent]  nchar(1)   NOT NULL
,  [RowStartDate]  datetime   NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NOT NULL
, CONSTRAINT [PK_dbo.DimPlan] PRIMARY KEY CLUSTERED 
( [Plan_Key] )
) ON [PRIMARY]
;

SET IDENTITY_INSERT dbo.DimPlan ON
;
INSERT INTO dbo.DimPlan (Plan_Key, Plan_ID, Plan_Name, Plan_Price, Plan_Current, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, -1, '', '', '', 'Y', '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT dbo.DimPlan OFF
;
*/

/*
/* Create table dbo.DimProduct */
CREATE TABLE dbo.DimProduct (
   [ProductKey]  int IDENTITY  NOT NULL
,  [ProductID]  nvarchar(15)   NOT NULL
,  [ProductDepartment]  nvarchar(100)   NOT NULL
,  [ProductName]  nvarchar(100)   NOT NULL
,  [ProductRetailPrice]  char(100)   NOT NULL
,  [ProductWholesalePrice]  char(100)   NULL
,  [ProductActive]  bit   NULL
,  [ProductAddDateKey]  int   NULL
,  [ProductVendorID]  int   NULL
,  [ProductDescription]  varchar(1000)   NOT NULL
,  [RowIsCurrent]  nchar(1)   NOT NULL
,  [RowStartDate]  datetime   NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NOT NULL
, CONSTRAINT [PK_dbo.DimProduct] PRIMARY KEY CLUSTERED 
( [ProductKey] )
) ON [PRIMARY]
;

ALTER TABLE DimProduct
ALTER COLUMN ProductID int NOT NULL



SET IDENTITY_INSERT dbo.DimProduct ON
;
INSERT INTO dbo.DimProduct (ProductKey, ProductID, ProductDepartment, ProductName, ProductRetailPrice, ProductWholesalePrice, ProductActive, ProductAddDateKey, ProductVendorID, ProductDescription, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, -1, 'Unknown', 'Unknown', -1, -1, -1, -1, -1, 'Unknown', 'Y', '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT dbo.DimProduct OFF
;

select * from DimProduct
*/

/*
/* Create table dbo.DimZipCode */
CREATE TABLE dbo.DimZipCode (
   [ZipCodeKey]  int IDENTITY  NOT NULL
,  [ZipCode]  char(5)   NOT NULL
,  [ZipCity]  varchar(50)   NOT NULL
,  [ZipState]  char(6)   NOT NULL
,  [RowIsCurrent]  nchar(1)   NOT NULL
,  [RowStartDate]  datetime   NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NOT NULL
, CONSTRAINT [PK_dbo.DimZipCode] PRIMARY KEY CLUSTERED 
( [ZipCodeKey] )
) ON [PRIMARY]
;


SET IDENTITY_INSERT dbo.DimZipCode ON
;
INSERT INTO dbo.DimZipCode (ZipCodeKey, ZipCode, ZipCity, ZipState, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, '-1', 'Unk City', 'Unk', 'Y', '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT dbo.DimZipCode OFF
;
*/


/*
 ALTER TABLE dbo.DimCustomers ADD CONSTRAINT
   FK_dbo_DimCustomer_ProductID FOREIGN KEY
   (
   ProductID
   ) REFERENCES DimProduct
   ( ProductKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;

ALTER TABLE dbo.RatingsFact ADD CONSTRAINT
   FK_dbo_RatingsFact_TitleKey FOREIGN KEY
   (
   TitleKey
   ) REFERENCES DimTitle
   ( TitleKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;

ALTER TABLE dbo.RatingsFact ADD CONSTRAINT
   FK_dbo_RatingsFact_AccountTitleKey FOREIGN KEY
   (
   AccountTitleKey
   ) REFERENCES DimAccountTitle
   ( AccountTitleKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;

ALTER TABLE dbo.RatingsFact ADD CONSTRAINT
   FK_dbo_RatingsFact_ZipCodeKey FOREIGN KEY
   (
   ZipCodeKey
   ) REFERENCES DimZipCode
   ( ZipCodeKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.PlanFact ADD CONSTRAINT
   FK_dbo_PlanFact_AccountKey FOREIGN KEY
   (
   AccountKey
   ) REFERENCES DimAccount
   ( AccountKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.PlanFact ADD CONSTRAINT
   FK_dbo_PlanFact_TitleKey FOREIGN KEY
   (
   TitleKey
   ) REFERENCES DimTitle
   ( TitleKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
 
ALTER TABLE dbo.PlanFact ADD CONSTRAINT
   FK_dbo_PlanFact_AccountTitleKey FOREIGN KEY
   (
   AccountTitleKey
   ) REFERENCES DimAccountTitle
   ( AccountTitleKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;

ALTER TABLE dbo.PlanFact ADD CONSTRAINT
   FK_dbo_PlanFact_PlanKey FOREIGN KEY
   (
   PlanKey
   ) REFERENCES DimPlan
   ( Plan_Key )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
 ALTER TABLE dbo.DimTitle ADD CONSTRAINT
   FK_dbo_DimTitle_TitleKey FOREIGN KEY
   (
   TitleDateModified
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
*/

/*
ALTER TABLE dbo.RatingsFact ADD CONSTRAINT
   FK_dbo_RatingsFact_DateKey FOREIGN KEY
   (
   DateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;


ALTER TABLE   dbo.RatingsFact
DROP CONSTRAINT FK_dbo_RatingsFact_DateKey

ALTER TABLE dbo.Ratings ADD CONSTRAINT
   FK_dbo_Ratings_CustomerKey FOREIGN KEY
   (
   CustomerKey
   ) REFERENCES DimCustomers
   ( CustomerKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 */

  /*
ALTER TABLE dbo.PlanFact ADD CONSTRAINT
   FK_dbo_PlanFact_ModifiedDateKey FOREIGN KEY
   (
   ModifiedDateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 */

 /*
 ALTER TABLE dbo.DimTitle ADD CONSTRAINT
   FK_dbo_DimTitle_AccountTitleKey FOREIGN KEY
   (
   AccountTitleKey
   ) REFERENCES DimAccountTitle
   ( AccountTitleKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
*/

/*
 ALTER TABLE dbo.DimProduct ADD CONSTRAINT
   FK_dbo_DimTitle_ProductAddDateKey FOREIGN KEY
   (
   ProductAddDateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;

ALTER TABLE   dbo.DimProduct
DROP CONSTRAINT FK_dbo_DimTitle_ProductAddDateKey
*/