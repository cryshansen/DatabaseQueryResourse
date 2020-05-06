USE [eRaceClub]
GO

Drop Proc UpdateRacer
Drop Proc UpdateRaceDetails
Drop Proc GetRaceDetails
/****** Object:  StoredProcedure [dbo].[UpdateRacer]    Script Date: 12/02/2007 21:59:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[UpdateRacer](@raceID int, @carid int,@oldCarId int )
as
Begin

Begin
Declare @memberid int
set @memberid = (Select memberId from RaceDetail where raceId = @raceID and carId = @oldcarID )
--check if new car id exists where memberid doesnt exist@raceid
	if exists(select carId from RaceDetail where raceId =@raceid and carid = @carid and memberid<> @memberid)
	--then update the racer 
	begin
		RaisError('Car already exists. Update denied.',16,1)
	end
	else
		begin
	--do the update
		Update RaceDetail
		set CarId = @carid
	    where CarId = @oldCarid and Raceid = @raceID
		end

if @@error<>0 or @@rowcount<>1
RaisError('Could not insert record',16,1)

end
end


USE [eRaceClub]
GO
/****** Object:  StoredProcedure [dbo].[UpdateRaceDetails]    Script Date: 12/02/2007 22:01:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Alter Proc [dbo].[UpdateRaceDetails](@raceid int,@CarID int, 
									@MemberID int,
									@Place int, 
									@RunTime varchar(17), 
									@Penalty varchar(15) = null,
									@Comment varchar(1048))
As
Begin
--@RunTime

--declare @runtime1 VARCHAR(17)
--set @runtime1 = (Select convert(varchar(10),RaceDate,1)from Race where RaceId = 1 @raceid)
----select @runtime1
--set @runtime1 = @runtime1 + ' '+ @RunTime  
--Select @runtime1
--declare @runtime2 DateTime
--set @runtime2 =convert(datetime,@runtime1)
--Select @runtime2
--declare @Runtime Varchar(17) Set @Runtime = '17:53:05'
declare @runtime1 DateTime
select @runtime1 = RaceDate from Race where RaceId = 1 --@raceid
--select @runtime1
declare @Hour VarChar(2)
declare @Min VarChar(2)
declare @Sec VarChar(2)
set @Hour = SubString(@RunTime,1,2)
set @Min = SubString(@Runtime,4,2)
set @Sec = SubString(@RunTime,7,2)
--Select @Hour,@Min, @Sec

Set @runtime1 = DateAdd(Hour,convert(int,@Hour),@runtime1 )
Set @runtime1 = DateAdd(Minute,convert(int,@Min),@runtime1 )
Set @runtime1 = DateAdd(Second,convert(int,@Sec),@runtime1 )
--Select @runtime1

If @Place = null
	begin
	set @Place = 999

		UPDATE RaceDetail
		SET Place=@Place, 
			RunTime=@runtime1,
			Penalty = @Penalty,
			Comment=@Comment, 
			MemberID =@MemberID
			WHERE CarID = @CarID AND
			RaceID =  @RaceID
	end
	
	If @@error<>0 AND @@rowcount=0
	begin
			Raiserror('Error: Update not completed.You must pass a time in Hour:Min:Sec.', 16, 1)
	end
Else
	begin
		UPDATE RaceDetail
		SET Place=@Place, 
			RunTime=@runtime1,
			Penalty = @Penalty,
			Comment=@Comment, 
			MemberID =@MemberID
			WHERE CarID = @CarID AND
			RaceID =  @RaceID
	end
	
	If @@error<>0 AND @@rowcount=0
	begin
			Raiserror('Error: Update not completed. You must pass a time in Hour:Min:Sec.', 16, 1)
	end
End

USE [eRaceClub]
GO
/****** Object:  StoredProcedure [dbo].[GetRaceDetails]    Script Date: 12/02/2007 22:01:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[GetRaceDetails](@RaceID int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

Select Race.NumberOfCars 'NoC',RaceDetail.RaceID,Race.Run 'R',CarID,Member.MemberId 'MemberID',member.FirstName + ' '+ member.LastName 'Name',Member.CertificationLevel 'Cert', Place 'Finish',convert(varchar(17),Runtime-Race.RaceDate,108) as 'RunTime',Penalty,RaceDetail.Comment from RaceDetail
inner join Member on RaceDetail.memberId = Member.memberId 
inner join Race on RaceDetail.RaceId = Race.RaceId where RaceDetail.RaceId = @RaceID
End

USE [eRaceClub]
GO
/****** Object:  StoredProcedure [dbo].[GetRaceByDate]    Script Date: 12/02/2007 22:02:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[GetRaceByDate] (@date datetime)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
Select RaceId, convert(varchar(10),RaceDate,108)'RaceDate' from Race where convert(varchar(10),RaceDate,109) = convert(varchar(10),@date,109)
End
USE [eRaceClub]
GO
/****** Object:  StoredProcedure [dbo].[CreateRacerInvoice]    Script Date: 12/02/2007 22:02:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[CreateRacerInvoice] (@raceid int,@carid int,  @memberid int,@transactionno int,@employeeid int)
As

Declare @sub money 
set @sub = (Select RaceRentalFee from CarClass inner join car on carClass.carclassId = car.carclassId  where carid = @carid)



		Begin

			insert into InvoiceRace	
			(InvoiceNumber, CarId, RaceID, Price, EmployeeId)
			values
			(@transactionno, @carid,@raceid, @sub, @employeeid)
			
			If @@Error<>0 or @@Rowcount<>1
				Begin
					RaisError('Failed to Create Invoice', 16,1)
					
				End
						
		End

USE [eRaceClub]
GO
/****** Object:  StoredProcedure [dbo].[CreateInvoice]    Script Date: 12/02/2007 22:03:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[CreateInvoice] (@carid int , @memberid int)
As
Declare @NextKey Integer
Declare @sub money 
set @sub = (Select RaceRentalFee from CarClass inner join car on carClass.carclassId = car.carclassId  where carid = @carid)
Declare @gst money
set @gst = @sub * 0.06
Begin Transaction
Update
    IDGenerator With (Rowlock, RepeatableRead)
    Set @NextKey = LastValue = LastValue+IncrementValue
    Where KeyField = 'InvoiceNumber'

If @@Rowcount<>1 or @@Error<>0 
		Begin
			RaisError('Failed to get Invoice number.'  ,16, 1)
			Rollback tran
		end
	else
Begin
			insert into Invoice	
			(InvoiceNumber, MemberId, InvoiceDate, PaymentTypeID, SubTotal,GST)
			values
			(@NextKey, @memberid,getDate(), 2, @sub,@gst)
			
			If @@Error<>0 or @@Rowcount<>1
				Begin
					RaisError('Failed to Create Invoice', 16,1)
					Rollback tran
				End
			Else 
				Begin
					select @NextKey
					Commit tran
				End
			
		End

Return
USE [eRaceClub]
GO
/****** Object:  StoredProcedure [dbo].[AddRacer]    Script Date: 12/02/2007 22:03:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[AddRacer](@raceID int, @carid int,@memberid int )


as
Begin
declare @M_certificate char(1) 
set @M_certificate = (Select CertificationLevel from Member where memberId = @memberid)

	Insert into RaceDetail(RaceId,CarID,MemberID,Certification)

	Values(@RaceID,@carid,@memberid,@M_certificate)

if @@error<>0 or @@rowcount<>1
RaisError('Could not insert record',16,1)
else
Select Race.NumberOfCars,RaceDetail.RaceID,Race.Run,RaceDetail.CarID,Member.MemberId 'MemberID',member.FirstName + ' '+ member.LastName 'Name',Member.CertificationLevel 'Cert',RaceDetail.Comment   from RaceDetail
inner join Member on RaceDetail.memberId = Member.memberId 
inner join Race on RaceDetail.RaceId = Race.RaceId 
inner join Car on RaceDetail.Carid = Car.CarID
where RaceDetail.RaceId = @RaceID and Car.CarID = @carid and Member.memberid = @memberid

end