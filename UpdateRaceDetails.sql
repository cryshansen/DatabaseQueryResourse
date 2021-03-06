USE [eRaceClub]
GO
/****** Object:  StoredProcedure [dbo].[UpdateRaceDetails]    Script Date: 12/02/2007 18:54:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER Proc [dbo].[UpdateRaceDetails](@raceid int,@CarID int, 
									@MemberID int,
									@Place int, 
									@RunTime varchar(17), 
									@Penalty varchar(15) = null,
									@Comment varchar(1048) )
As
Begin
--@RunTime

declare @runtime1 VARCHAR(17)
set @runtime1 = (Select convert(varchar(10),RaceDate,1)from Race where RaceId = @raceid)
--select @runtime1
set @runtime1 = @runtime1 + ' '+ @RunTime  
Select @runtime1
declare @runtime2 DateTime
set @runtime2 =convert(datetime,@runtime1)
Select @runtime2
If @Place = null
	begin
	set @Place = 999

		UPDATE RaceDetail
		SET Place=@Place, 
			RunTime=@runtime2,
			Penalty = @Penalty,
			Comment=@Comment, 
			MemberID =@MemberID
			WHERE CarID = @CarID AND
			RaceID =  @RaceID
	end
	
	If @@error<>0 AND @@rowcount=0
	begin
			Raiserror('Error: Update not completed.', 16, 1)
	end
Else
	begin
		UPDATE RaceDetail
		SET Place=@Place, 
			RunTime=@runtime2,
			Penalty = @Penalty,
			Comment=@Comment, 
			MemberID =@MemberID
			WHERE CarID = @CarID AND
			RaceID =  @RaceID
	end
	
	If @@error<>0 AND @@rowcount=0
	begin
			Raiserror('Error: Update not completed.', 16, 1)
	end
End

