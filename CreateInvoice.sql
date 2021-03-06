USE [eRaceClub]
GO
/****** Object:  StoredProcedure [dbo].[CreateInvoice]    Script Date: 12/02/2007 01:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER Proc [dbo].[CreateInvoice] (@carid int , @memberid int)
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
