USE [eRaceClub]
GO
/****** Object:  StoredProcedure [dbo].[GetRaceDetails]    Script Date: 11/27/2007 12:00:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Alter proc [dbo].[GetRaceDetails](@RaceID int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

Select Race.NumberOfCars,RaceDetail.RaceID,Race.Run,CarID,Member.MemberId 'MemberID',member.FirstName + ' '+ member.LastName 'Name',Member.CertificationLevel 'Cert', Place 'Finish',convert(varchar(17),Runtime-Race.RaceDate,108) as 'RunTime',Penalty,RaceDetail.Comment from RaceDetail
inner join Member on RaceDetail.memberId = Member.memberId 
inner join Race on RaceDetail.RaceId = Race.RaceId where RaceDetail.RaceId = @RaceID
End
