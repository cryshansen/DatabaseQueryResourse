USE [eRaceClub]
GO
/****** Object:  StoredProcedure [dbo].[AddRacer]    Script Date: 12/02/2007 01:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [dbo].[AddRacer](@raceID int, @carid int,@memberid int )
as
Begin
declare @RaceDate datetime
set @RaceDate = (Select RaceDate from Race where raceid = 1--@raceID)
if getDate() < @RaceDate
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
Else
Begin
RaisError('Can not add racer when race has begun',16,1)
End
end