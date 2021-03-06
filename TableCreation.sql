use model
go
drop database eRaceClub
go
create database eRaceClub
go 
use eRaceClub
go
drop table orderdetail
drop table InvoiceDetail
drop table InvoiceRace
drop table Invoice
drop table RaceDetail
drop table Race
drop table Car
drop table MemberTransaction
drop table Product
drop table orders
drop table CarClass
drop table Member
drop table Employee
drop table Job
drop table PaymentType
drop table IDGenerator
GO

create table IDGenerator(
KeyField	varchar(50)	not null
	Constraint PK_IDGenerator_KeyField primary key clustered,
LastValue	int		not null
	Constraint DF_IDGenerator_LastValue default 0
	Constraint CHK_IDGenerator_LastValue check (LastValue >= 0),
IncrementValue	int
	Constraint DF_IDGenerator_IncrementValue default 1
	Constraint CHK_IDGenerator_IncrementValue check (IncrementValue >= 0),
)
go
insert into IDGenerator(KeyField)
values ('RaceID')
insert into IDGenerator(KeyField)
values ('TransactionID')
insert into IDGenerator(Keyfield)
values ('OrderNumber')
insert into IDGenerator(KeyField)
values ('InvoiceNumber')
go

create table PaymentType(
PaymentTypeID int identity(1,1) not null
	constraint PK_PaymentType_PaymentTypeID primary key,
Description varchar(20) not null
)
go 
insert into PaymentType
values('Cash')
insert into paymenttype
values('Account')
insert into PaymentType
values('Debit')
insert into PaymentType
values('Credit Card')
go

create table Job(
JobCode int	identity(1,1) not null
	Constraint PK_Job_JobCode primary key clustered,
Description varchar(50) not null
	Constraint UNQ_Job_Description Unique(Description),
Wage	decimal(5,2) not null
	Constraint CHK_Job_Wage check (Wage >= 0)
)
go

create table Employee(
EmployeeID  int  identity(1,1) not null
	constraint PK_Employee_EmployeeID Primary Key clustered,
LastName	varchar (30) not null,
FirstName	varchar	(30) not null,
Address		varchar (30) not null,
City		varchar (30) not null,
PostalCode  varchar (7) not null,
Phone		varchar (30) not null,
JobCode		int			not null
	constraint FK_EmployeeJob_JobCode foreign key references Job(JobCode),
LoginId		varchar(50) null,
Birthdate	datetime not null,
SocialInsuranceNumber char(9) not null
)
go
CREATE TABLE Member (
MemberId 	Int  identity(1,1)	NOT NULL 
	Constraint PK_Member_MemberID Primary Key clustered,
LastName 	varchar (30)  	NOT NULL ,
FirstName 	varchar (30)  	NOT NULL ,
Phone 		varchar (15)  	NULL ,
Address 	varchar (30)  	Not NULL ,
City		varchar	(30)	not null,
PostalCode  varchar(7)		not null,
EmailAddress 	varchar (30)  	NULL,
BirthDate	datetime		not null,
CreditCardNumber varchar(16) null,
ExpiryDate	varchar(5)		null,
CreditLimit 	money 		NOT NULL 
	Constraint DF_Members_CreditLimit default 0
	Constraint CHK_Member_CreditLimit check (CreditLimit >=0),
AccountBalance 	money 		NOT NULL 
	Constraint DF_Member_AccountBalance default 0,
CertificationLevel		char(1)		not null
	Constraint CHK_Member_CertificationLevel check(CertificationLevel in ('A','B','C','D')),
LoginId		varchar(50)	null,
Gender		char(1) not null
) 
GO

CREATE TABLE CarClass (
CarClassID 		int IDENTITY (1, 1)	NOT NULL 
	Constraint PK_CarClass_CarTypeID primary key clustered,
CarClassName 		varchar (30)  		NOT NULL ,
MaxEngineSize			decimal(4,1)		not null
	Constraint	CHK_CarClass_MaxEngineSize check(MaxEngineSize > 0.0),
CertificationLevel		char(1)		not null
	Constraint CHK_CarClass_CertificationLevel check(CertificationLevel in ('A','B','C','D')),
RaceRentalFee 		money 			NOT NULL 
	Constraint DF_CarClass_RaceRentalFee default 0
	Constraint CHK_CarClass_RaceRentalFee check (RaceRentalFee >= 0),
Description		varchar(255) not null
) 
GO

CREATE TABLE Car (
CarID 		int identity(1,1)  	NOT NULL 
	Constraint PK_Car_CarID primary key clustered,
SerialNumber 		varchar (5)  	NOT NULL ,
Ownership	varchar(6)		not null
	Constraint CHK_Car_Ownership check(Ownership in ('Owner','Rental')),
CarClassID 	int 		 
	Constraint FK_CarCarClass_CarClassID foreign key
		references CarClass(CarClassID),
State 		varchar (10)  	NOT NULL
	Constraint CHK_Car_State check (State in ('Certified','InShop','Wrecked','Unknown')),
Description	varchar(255) not null,
Memberid	int null
	Constraint FK_CarMember_MemberID foreign key
		references Member(MemberID)
) 
GO

CREATE TABLE Product (
ProductID 	int IDENTITY (1, 1) 	NOT NULL 
	Constraint PK_Roduct_ProductID primary key clustered,
ItemName 	varchar (40)  		NOT NULL ,
ItemPrice 		money 			NOT NULL 
	Constraint DF_Product_ItemPrice default 0
	Constraint CHK_Product_ItemPrice check (ItemPrice >= 0),
OrderUnitCost 		money 			NOT NULL 
	Constraint DF_Product_OrderUnitCost default 0
	Constraint CHK_Product_OrderUnitCost check (OrderUnitCost >= 0),
OrderUnitType	varchar(6)			not null
	Constraint CHK_Product_OrderUnitType check (OrderUnitType in ('Unit','Case','Litre')),
OrderUnitSize	int				not null
	Constraint	DF_Product_OrderUnitSize default 1
	Constraint CHK_Product_OrderUnitSize check (OrderUnitSize >= 1),
QuantityOnHand 	int 			NOT NULL
	Constraint DF_Products_QuantityOnHand default 0
	Constraint CHK_Product_QuantityOnHand check (QuantityOnHand >= 0),
ReOrderLevel	int			not Null 
	Constraint DF_Products_ReOrderLevel default 0
	Constraint CHK_Product_ReOrderLevel check (ReOrderLevel >= 0),
ReStockCharge	money		not null
	Constraint DF_Product_ReStockCharge default 0
	Constraint CHK_Product_ReStockCharge check (ReStockCharge >= 0),
Category	varchar(20) not null
) 
GO

CREATE TABLE MemberTransaction (
TransactionID 		int  NOT NULL 
	Constraint PK_MemberTransaction_TransactionID primary key clustered,
MemberID 			int  NOT NULL 
	Constraint FK_MemberTransactionMember Foreign key 
		references Member(MemberID),
TransactionDate 	datetime NOT NULL 
	Constraint DF_MemberTransaction_TransactionDate default getdate(),
TransactionAmount 	money NOT NULL 
	Constraint CHK_MemberTransaction_TransactionAmount check (TransactionAmount >= 0),
TransactionType 	varchar (8)  NOT NULL 
	Constraint CHK_MemberTransaction_TransactionType check (TransactionType in ('Deposit','Payment','Refund')),
Comments			varchar(1048) null
) 
GO



CREATE TABLE Race (
RaceID 		int IDENTITY (1, 1) 	NOT NULL 
	Constraint PK_Race_RaceID primary key clustered,
RaceDate 	datetime 		NOT NULL ,
NumberOfCars 	int 			NOT NULL 
	Constraint DF_Race_NumberOfCars default 0
	Constraint CHK_Race_NumberOfCars check(NumberOfCars >=0),
Run 		char (1)  		NOT NULL
	Constraint DF_Race_Run default 'N'
	Constraint CHK_Race_Run check (Run in ('Y','N')),
Comment		varchar(1048) null 
) 
GO

CREATE TABLE RaceDetail (
RaceID 		int NOT NULL 
	Constraint FK_RaceDetail_RaceID foreign key
		references Race(RaceID),
CarID 		int  NOT NULL 
	Constraint FK_RaceDetail_CarID foreign key
		references Car(CarID),
MemberID 	int  NOT NULL
	Constraint FK_RaceDetailMember foreign key
		references Member(MemberID), 
Certification	char(1) not null
	Constraint CHK_RaceDetail_Certification check(Certification in ('A','B','C','D')),
Place 		int NULL
	Constraint CHK_RaceDetail_Place check (Place >=1),
RunTime		datetime Null,
Penalty		varchar(15) null
	Constraint CHK_RaceDetail_Penalty check (Penalty in ('Scratched', 'Disqualified', 'Crash', 'Mechanical')),
Comment		varchar(1048) null
Constraint PK_RaceDetail_RaceIDCarID primary key clustered (RaceID, CarID)
) 
GO

CREATE TABLE Invoice (
InvoiceNumber 	int 	NOT NULL 
	Constraint PK_Invoice_InvoiceID primary key clustered,
MemberID 	int  		 NULL 
	Constraint FK_InvoiceMember Foreign key 
		references Member(MemberID),
InvoiceDate 	datetime 		NOT NULL 
	Constraint DF_Invoice_InvoiceDate default getdate(),
PaymentTypeID	int			not null
	Constraint FK_InvoicePaymentType_PaymentTypeID foreign key
		references PaymentType(PaymentTypeID),
CreditCard		varchar(16) null,
SubTotal 	money 			NOT NULL ,
GST 		money 			NOT NULL ,
Total 		AS (SubTotal + GST) 
) 
go

CREATE TABLE InvoiceDetail (
InvoiceNumber 	int NOT NULL 
	Constraint FK_InvoiceDetailInvoice_InvoiceNumber foreign key
		references Invoice(InvoiceNumber) ,
ProductID 	int NOT NULL 
	Constraint FK_InvoiceDetailProduct foreign key
		references Product(ProductID),
Quantity 	int NOT NULL ,
Price 		money NULL ,
Constraint PK_InvoiceDetails_InvoiceIDProductID primary key clustered (InvoiceNumber, ProductID) 
)
GO

CREATE TABLE InvoiceRace (
InvoiceNumber 	int 		NOT NULL 
	Constraint FK_InvoiceRaceInvoice_InvoiceNumber foreign key
		references Invoice(InvoiceNumber),
CarID 		int 	NOT NULL 
	Constraint FK_InvoiceRaceCar foreign key
		references Car(CarID) ,
Price 		money 	NOT NULL,
EmployeeId 	int	not null
Constraint FK_InvoiceRaceEmployee_EmployeeId foreign key
		references Employee(EmployeeId)
Constraint PK_InvoiceRace_InvoiceIDCarID primary key clustered (InvoiceNumber, CarID),
) 
GO
CREATE TABLE Orders(
OrderNumber int NOT NULL 
	CONSTRAINT PK_Orders_OrderNumber PRIMARY KEY CLUSTERED,
OrderDate datetime NOT NULL default getdate(),
ReceiveDate datetime NULL ,
EmployeeID int NOT NULL 
	Constraint Fk_OrderEmployee_EmployeeID Foreign Key references Employee(EmployeeID),
TaxGST smallmoney NOT NULL default (0),
OrderCost money NOT NULL default (0)
) 
GO

CREATE TABLE OrderDetail (
OrderNumber int NOT NULL 
	Constraint FK_OrderDetailOrder_OrderNumber Foreign Key references Orders(OrderNUmber),
LineNumber int NOT NULL ,
ProductID int NOT NULL 
	Constraint FK_OrderDetailProduct Foreign Key references Product(ProductID),
Quantity int NOT NULL Default (1)
	Constraint Chk_OrderDetail_Quantity Check(Quantity > 0),
OrderUnitSize int not null
	Constraint CHk_OrderDetail_OrderUnitSize check (orderunitsize >= 1),
OrderUnitCost smallmoney NOT NULL Default (0)
	Constraint Chk_OrderDetail_Unitcost check(OrderUnitCost >= 0),
	CONSTRAINT PK_OrderDetail_orderNumberLineNumber PRIMARY KEY CLUSTERED (OrderNumber,LineNumber) 
) 
GO
create nonclustered index IDX_InvoiceRace_InvoiceNumber on InvoiceRace(InvoiceNumber) 
go
create nonclustered index IDX_InvoiceRace_CarID on InvoiceRace(CarID) 
go
create nonclustered index IDX_InvoiceDetail_InvoiceNumber on InvoiceDetail(InvoiceNumber) 
go
create nonclustered index IDX_InvoiceDetail_ProductID on InvoiceDetail(ProductID) 
go
create nonclustered index IDX_Invoice_PaymentTypeID on Invoice(PaymentTypeID) 
go
create nonclustered index IDX_Invoice_MemberID on Invoice(MemberID) 
go
create nonclustered index IDX_RaceDetail_MemberID on RaceDetail(MemberID) 
go
create nonclustered index IDX_RaceDetail_RaceID on RaceDetail(RaceID) 
go
create nonclustered index IDX_RaceDetail_CarID on RaceDetail(CarID) 
go
create nonclustered index IDX_Car_CarClassID on Car(CarclassID) 
go
create nonclustered index IDX_MemberTransaction_MemberID on MemberTransaction(MemberID) 
go
create nonclustered index IDX_OrderDetail_OrderNumber on OrderDetail(OrderNumber)
go
create nonclustered index IDX_OrderDetail_ProductID on OrderDetail(ProductID) 
go
create nonclustered index IDX_Order_EmployeeId on Orders(EmployeeID)
go
create nonclustered index IDX_Employee_JobCode on Employee(JobCode)
go
create nonclustered index IDX_InvoiceRace_EmployeeId on INvoiceRace(EmployeeId)
go




