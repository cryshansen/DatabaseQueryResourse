USE [eRaceClub]
GO
/****** Object:  StoredProcedure [dbo].[AddTrackCar]    Script Date: 11/20/2007 10:52:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Crystal>
-- Create date: <Sept 28,,>
-- Description:	<This updates a Car from the Car Table,,>
-- =============================================
Create proc [dbo].[AddTrackCar](@SerialNumber varchar(15),@CarClassID int,@State varchar(10),@Description Varchar(255))

as
Begin
	Insert into car(SerialNumber , Ownership ,CarClassID,State,Description ,MemberID )
	Values(@SerialNumber , 'Rental',@CarClassID,@State ,@Description,Null)
if @@error<>0
RaisError('Could not insert record',16,1)
else
Select @@Identity as CarID
end

USE [eRace]
GO
/****** Object:  StoredProcedure [dbo].[AddProduct]    Script Date: 11/20/2007 10:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Crystal>
-- Create date: <Sept 28,,>
-- Description:	<This adds a product to the Product Table,,>
-- =============================================
Create proc [dbo].[AddProduct]( @itemname varchar(40),@itemprice money,@unitcost money,@unitType varchar(6),@unitsize int,@qoh int,@reOrder int,@restock money,@category varchar(20))


as
Begin
	Insert into product(itemname,itemprice,orderunitcost,orderunitType,orderunitsize,quantityonhand ,reorderlevel ,restockcharge,category)

	Values(@itemname,@itemprice,@unitcost,@unitType,@unitsize,@qoh,@reOrder,@restock,@category)

if @@error<>0
RaisError('Could not insert record',16,1)
else
Select @@Identity as ProductID
end


USE [eRace]
GO
/****** Object:  StoredProcedure [dbo].[CreateInvoice]    Script Date: 11/20/2007 10:54:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Don Welch>
-- Create date: <July 2007>
-- Description:	<Create Invoice >
-- =============================================
Create PROCEDURE [dbo].[CreateInvoice]
	(@memberid varchar(10),
	 @paymenttype int,
	 @ccard varchar(16),
	 @subtotal money,
	 @gst money)
AS
BEGIN
	declare @errflag int
	set @errflag = 0
	set @memberid = ltrim(rtrim(@memberid))
	set @ccard = ltrim(rtrim(@ccard))
	if @memberid = '' 
		set @memberid = null
	if @ccard = '' 
		set @ccard = null
	if @paymenttype = 2 and @memberid is null
	begin
		set @errflag =1
		RaisError('Payment on account requires a memberid',16,1)
	end
	if @errflag = 0
		if @paymenttype = 4 and @ccard is null
		begin
			set @errflag =1
			RaisError('Payment on credit requires a credit card number',16,1)
		end
	if @errflag = 0
	begin
		begin transaction
		Declare @NextKey Integer

		Update IDGenerator With (Rowlock, RepeatableRead)
		Set @NextKey = LastValue = LastValue+1
		Where KeyField = 'InvoiceNumber'
		if @@error <> 0
		begin
			RaisError('Unable to generate new invoice number.',16,1)
			Rollback Transaction
		end
		else
		begin
			insert into invoice
			values(@nextkey, @memberid, getdate(), @paymenttype, @ccard, @subtotal, @gst)
			if @@error <> 0
			begin
				RaisError('Unable to generate new invoice.',16,1)
				Rollback Transaction
			end
			else
			begin
				Commit Transaction
				Select @Nextkey 'InvoiceNumber'
			end
		end
	end
	
END
USE [eRace]
GO
/****** Object:  StoredProcedure [dbo].[ChargeMemberBalance]    Script Date: 11/20/2007 10:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Don Welch>
-- Create date: <July 2007>
-- Description:	<Add a charge to a members balance>
-- =============================================
Create PROCEDURE [dbo].[ChargeMemberBalance]
	(@memberid int,
	 @charge money)
AS
BEGIN
	if exists(select memberid from member where memberid = @memberid)
	begin
		if (select creditlimit - accountbalance
			from member
			where memberid = @memberid) >= @charge
		begin
			update member
			set accountbalance = accountbalance + @charge
			where memberid = @memberid
		end
		else
		begin
			RaisError('Member does not have sufficient account balance to cover charge',16,1)
		end
	end
	else
	begin	
		RaisError('Member id does not exist on file.',16,1)
	end
END
USE [eRace]
GO
/****** Object:  StoredProcedure [dbo].[CreateInvoiceDetail]    Script Date: 11/20/2007 10:55:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Don Welch>
-- Create date: <July 2007>
-- Description:	<Create Invoice Detail>
-- =============================================
Create PROCEDURE [dbo].[CreateInvoiceDetail]
	(@invoicenumber int,
	 @productid int,
	 @quantity int,
	 @Price money)
AS
BEGIN
	if exists(select productid
			  from product
			  where productid = @productid
			    and quantityonhand >= @quantity)
	begin
		begin transaction
		insert into invoicedetail
		values (@invoicenumber, @productid, @quantity, @price)
		if @@error <> 0
		begin
			RaisError('Unable to generate invoice detail.',16,1)
			rollback transaction
		end
		else
		begin
			update product
			set quantityonhand = quantityonhand - @quantity
			where productid = @productid
			if @@error <> 0
			begin
				RaisError('Unable to update product quantity on hand.',16,1)
				rollback transaction
			end
			else
			begin
				commit transaction
			end
		end
	end
	else
	begin
		RaisError('Product does not exist or has insufficient quantity to cover sale.',16,1)
	end
END
USE [eRace]
GO
/****** Object:  StoredProcedure [dbo].[getAllCarClassID]    Script Date: 11/20/2007 10:56:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Crystal>
-- Create date: <Sept 07,,>
-- Description:	<Gets the states of the vehicles,,>
-- =============================================
Create PROCEDURE [dbo].[getAllCarClassID]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT CarClassID,CarClassName from CarClass group by CarClassID, CarClassName
END

USE [eRace]
GO
/****** Object:  StoredProcedure [dbo].[getAllStates]    Script Date: 11/20/2007 10:56:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Crystal>
-- Create date: <Sept 07,,>
-- Description:	<Gets the states of the vehicles,,>
-- =============================================
Create PROCEDURE [dbo].[getAllStates]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT count(*)'id',State 'State' from car group by state
END

USE [eRace]
GO
/****** Object:  StoredProcedure [dbo].[getAllUnitTypes]    Script Date: 11/20/2007 10:56:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Crystal>
-- Create date: <Sept 07,,>
-- Description:	<Gets the order unit types of the products,,>
-- =============================================
Create PROCEDURE [dbo].[getAllUnitTypes]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT count(*)'id',OrderUnitType 'UnitType' from Product group by OrderUnitType
END

USE [eRace]
GO
/****** Object:  StoredProcedure [dbo].[GetProductCategories]    Script Date: 11/20/2007 10:56:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Crystal>
-- Create date: <Sept 07,,>
-- Description:	<This gets the categories from the Products table,,>
-- =============================================
Create PROCEDURE [dbo].[GetProductCategories]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT category from product group by category
END

USE [eRace]
GO
/****** Object:  StoredProcedure [dbo].[GetProductsforCategory]    Script Date: 11/20/2007 10:57:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Don Welch>
-- Create date: <June 2007>
-- Description:	<Get Category Products>
-- =============================================
Create PROCEDURE [dbo].[GetProductsforCategory] (@Category varchar(20))
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT p.ProductID, ItemName, QuantityonHand, isnull(QuantityonOrder,0) 'QuantityonOrder', orderunitcost / orderunitsize 'Cost', itemprice
	from product p left join ProductsOnOrder o on p.productid = o.productid
where p.system = @category
END
USE [eRace]
GO
/****** Object:  StoredProcedure [dbo].[LookupCarByCarID]    Script Date: 11/20/2007 10:57:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Crystal Hansen>
-- Create date: <Sept 29 2007>
-- Description:	<Look up product by product id>
-- =============================================
Create PROCEDURE [dbo].[LookupCarByCarID](@carid integer)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	If Exists (Select MemberId from member where memberId in(Select MemberId from Car where CarID = @carid))
		Select CarID, SerialNumber, ownership,CarClassID,State, Description,FirstName + ' ' + LastName 'RegisteredOwner',Member.MemberId from Car inner join Member on Car.MemberId = Member.MemberId
	else
	 SELECT CarID, SerialNumber, ownership,CarClassID,State, Description,''  from Car where CarID = @carid

END
USE [eRace]
GO
/****** Object:  StoredProcedure [dbo].[LookupMemberbyMemberid]    Script Date: 11/20/2007 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Don Welch>
-- Create date: <July 2007>
-- Description:	<Lookup Member by memberid>
-- =============================================
Create PROCEDURE [dbo].[LookupMemberbyMemberid]
	(@memberid int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT memberid, Lastname, firstName, Phone, Address, City,
		postalcode, emailaddress, birthdate, creditcardnumber,
		expirydate, accountbalance,  Gender
	from member
	where memberid = @memberid
END

USE [eRace]
GO
/****** Object:  StoredProcedure [dbo].[LookupProductbyCategory]    Script Date: 11/20/2007 10:58:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Crystal>
-- Create date: <Sept 2007>
-- Description:	<Look up product by category>
-- =============================================
Create PROCEDURE [dbo].[LookupProductbyCategory](@category varchar(20))
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Productid, itemname, quantityonhand
	from product
	where Category = @category
END

USE [eRace]
GO
/****** Object:  StoredProcedure [dbo].[LookupProductbyCategoryD]    Script Date: 11/20/2007 10:58:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Crystal>
-- Create date: <Sept 2007>
-- Description:	<Look up product by category>
-- =============================================
Create PROCEDURE [dbo].[LookupProductbyCategoryD](@category varchar(20))
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Productid, itemname, itemprice, orderunitcost, orderunittype,
			orderunitsize,quantityonhand, reorderlevel,
			RestockCharge, category
	from product
	where Category = @category
END
USE [eRace]
GO
/****** Object:  StoredProcedure [dbo].[LookupProductbyProductID]    Script Date: 11/20/2007 10:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Don Welch>
-- Create date: <July 2007>
-- Description:	<Look up product by product id>
-- =============================================
Create PROCEDURE [dbo].[LookupProductbyProductID](@productid integer)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Productid, itemname, itemprice, orderunitcost, orderunittype,
			orderunitsize,quantityonhand, reorderlevel,
			RestockCharge, category
	from product
	where ProductID = @productid
END
USE [eRace]
GO
/****** Object:  StoredProcedure [dbo].[LookupProductPrice]    Script Date: 11/20/2007 10:59:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Don Welch>
-- Create date: <July 2007>
-- Description:	<lookup product price>
-- =============================================
Create PROCEDURE [dbo].[LookupProductPrice] (@productid int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT itemprice
	from product
	where productid = @productid
END
USE [eRace]
GO
/****** Object:  StoredProcedure [dbo].[UpdateProduct]    Script Date: 11/20/2007 10:59:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Crystal>
-- Create date: <Sept 28,,>
-- Description:	<This updates a Product from the Product Table,,>
-- =============================================
Create proc [dbo].[UpdateProduct](@productId int, @itemname varchar(40),@itemprice money,@unitcost money,@unitType varchar(6),@unitsize int,@qoh int,@reOrder int,@restock money,@category varchar(20))


as
Begin
Update Product
 Set itemname =@itemname,itemprice=@itemprice,orderunitcost=@unitcost,orderunitType=@unitType,orderunitsize=@unitsize,quantityonhand=@qoh ,reorderlevel=@reOrder, restockcharge=@restock,category=@category
Where productId = @productId
if @@error<>0
RaisError('Could not insert record',16,1)

end


USE [eRace]
GO
/****** Object:  StoredProcedure [dbo].[UpdateRaceCar]    Script Date: 11/20/2007 11:00:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Crystal>
-- Create date: <Sept 28,,>
-- Description:	<This adds a product to the Product Table,,>
-- =============================================

Create proc [dbo].[UpdateRaceCar](@CarId int, @SerialNumber varchar(15), @Ownership Varchar(6),@CarClassID int,@State varChar(10),@Description Varchar(255),@MemberID Varchar(8))




as
		set @MemberId =Ltrim(Rtrim (@MemberId))
		if @MemberId =''
			update car
			set SerialNumber =@SerialNumber,
				Ownership = @Ownership,
				CarClassID =@CarClassID,
				State = @State,
				Description = @Description, 
				MemberID = null
				where CarID = @CarID
	   		else if isNumeric (@MemberId)= 1
				update car
				set SerialNumber =@SerialNumber,
				Ownership = @Ownership,
				CarClassID =@CarClassID,
				State = @State,
				Description = @Description, 
				MemberID = @MemberId
				where CarID = @CarID
		else
		begin
			
			RaisError('Unable to Update Car',16,1)

		end
	
return @@error

USE [eRaceClub]
Go

Create proc [dbo].[GetRaceByDate] (@date datetime)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
Select RaceId, convert(varchar(10),RaceDate,108)'RaceDate' from Race where convert(varchar(10),RaceDate,109) = convert(varchar(10),@date,109)
End
Go
Create proc [dbo].[GetRaceDetails](@RaceID int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

Select Race.NumberOfCars,RaceDetail.RaceID,CarID,Member.MemberId 'MemberID',member.FirstName + ' '+ member.LastName 'Name',Member.CertificationLevel 'Cert', Place 'Finish',convert(varchar(17),Runtime-Race.RaceDate,108) as 'RunTime',Penalty,RaceDetail.Comment from RaceDetail
inner join Member on RaceDetail.memberId = Member.memberId 
inner join Race on RaceDetail.RaceId = Race.RaceId where RaceDetail.RaceId = @RaceID
End

Go

Alter proc [dbo].[AddRacer](@raceID int, @carid int,@memberid int )
as
Begin
if not exists(select memberId from member where memberId = @memberid)
	begin
		RaisError('Member is not active. Add denied.',16,1)
	end
else
	if not exists(select carId from car where carId = @carid)
		begin
			RaisError('Car is not active. Add denied.',16,1)
		end
	else
		begin
			declare @M_certificate char(1) 
			Select @M_certificate = CertificationLevel from Member where memberId = @memberid
			if not exists(select carid from car where carId = @carid and State = 'Certified')
				begin
				RaisError('Car must be certified. Add denied.',16,1)
				end
			Else
			begin
				Insert into RaceDetail(RaceId,CarID,MemberID,Certification)
				Values(@RaceID,@carid,@memberid,@M_certificate)

				Select Race.NumberOfCars,RaceDetail.RaceID,Race.Run,RaceDetail.CarID,RaceDetail.MemberId 'MemberID',member.FirstName + ' '+ member.LastName 'Name',Member.CertificationLevel 'Cert', Place 'Finish',convert(varchar(17),Runtime-Race.RaceDate,108) as 'RunTime',Penalty,RaceDetail.Comment from RaceDetail
				inner join Member on RaceDetail.memberId = Member.memberId 
inner join Race on RaceDetail.RaceId = Race.RaceId 

where RaceDetail.RaceId = @RaceID and RaceDetail.CarID = @carid and RaceDetail.memberid = @memberid
end
if @@error<>0 or @@rowcount<>1
RaisError('Could not insert record',16,1)
end
end

Create proc [dbo].[UpdateRacer](@raceID int, @carid int,@oldCarId int )
as
Begin
if exists(select carId from RaceDetail where raceId = @raceid and carid = @carid)
	--then update the racer 
	begin
		RaisError('Car already exists. Update denied.',16,1)
	end
else
--do the update
		Update RaceDetail
		set CarId = @carid
		where CarId = @oldCarid and Raceid = @raceid

if @@error<>0 or @@rowcount<>1
RaisError('Could not insert record',16,1)

end

Create proc [dbo].[FinalRace](@RaceID int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

Select Race.NumberOfCars,RaceDetail.RaceID,CarID,Member.MemberId 'MemberID',member.FirstName + ' '+ member.LastName 'Name',Member.CertificationLevel 'Cert', Place 'Finish',convert(varchar(17),Runtime-Race.RaceDate,108) as 'RunTime',Penalty,RaceDetail.Comment from RaceDetail
inner join Member on RaceDetail.memberId = Member.memberId 
inner join Race on RaceDetail.RaceId = Race.RaceId where RaceDetail.RaceId = @RaceID
End

USE [MuffinData]
GO
/****** Object:  StoredProcedure [dbo].[AddSaleItem]    Script Date: 11/29/2007 17:18:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
ALTER Procedure [dbo].[AddSaleItem] ( @SaleId int, @StockID int, @QuantitySold int,
        @UnitPrice money)
As
   Declare @ErrFlag as int, @WholeSaleCost money
   select @wholesalecost=wholesalecost from Stocks where StockId=@StockId 
   If @WholeSaleCost is null
      Raiserror( 'AddSaleItem - Stock does not exist StockID=%d',16,1,@StockId)
   Else
     If  not exists ( select * from Sales where SaleId=@SaleId)
         Raiserror( 'AddSaleItem - Sale Id does not exist SaleID=%d',16,1,@Saleid)
     Else
   Begin
     Begin Tran
   
     Set @ErrFlag=0
     Insert SaleItems Values ( @saleId, @StockId, @QuantitySold, @WholeSaleCost, @UnitPrice )
     If  @@error  < >  0
       Begin
          Raiserror( 'AddSaleItem - insert into Sale Items table failed',16,1)
          Set @ErrFlag=1
       End

     If @ErrFlag=0
     Begin
         Update Stocks  
            Set QuantityOnhand=QuantityOnhand - @QuantitySold
         Where StockId =@StockId 
       If  @@error  < >  0
       Begin
          Raiserror( 'AddSaleItem - Update Stock table failed',16,1)
          Set @ErrFlag=1
       End
     End
   -- last Block
   If @errflag=0
      Commit Tran
   else
      RollBack tran
   end
 Return
