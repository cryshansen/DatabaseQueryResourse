USE [eRaceClub]
GO
/****** Object:  StoredProcedure [dbo].[UpdateRacer]    Script Date: 12/02/2007 01:26:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [dbo].[UpdateRacer](@raceID int, @carid int,@oldCarId int )
as
Begin
If @carid <>@oldCarId
Begin
	if exists(select carId from RaceDetail where raceId = @raceid and carid = @carid)
	--then update the racer 
	begin
		RaisError('Car already exists. Update denied.',16,1)
	end
	else
		begin
	--do the update
		Update RaceDetail
		set CarId = @carid
	    where CarId = @oldCarid and Raceid = @raceid
		end

if @@error<>0 or @@rowcount<>1
RaisError('Could not insert record',16,1)

end
Else
	
		begin
	--do the update
		Update RaceDetail
		set CarId = @carid
	    where CarId = @oldCarid and Raceid = @raceid
		end

if @@error<>0 or @@rowcount<>1
RaisError('Could not insert record',16,1)

end

