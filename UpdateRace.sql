USE [eRaceClub]
GO
/****** Object:  StoredProcedure [dbo].[UpdateRace]    Script Date: 12/02/2007 01:37:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[UpdateRace](@raceId int, @raceComment  varChar(1048))
As
IF EXISTS(SELECT RaceID FROM Race 
		WHERE RaceID=@RaceID)
	Begin	
If ltrim(@raceComment) = ''
	begin
		set @raceComment = null
	end

	Update Race
	SET	Comment=@raceComment, Run='Y'
	WHERE RaceID=@RaceID
	End
Else
	Raiserror ('This race does not exist; Update is not possible.', 16,1)
	
Return