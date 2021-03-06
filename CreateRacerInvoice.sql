USE [eRaceClub]
GO
/****** Object:  StoredProcedure [dbo].[CreateRacerInvoice]    Script Date: 12/02/2007 01:36:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER Proc [dbo].[CreateRacerInvoice] (@raceid int,@carid int,  @memberid int,@transactionno int,@employeeid int)
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