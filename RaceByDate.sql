USE [eRaceClub]
GO
/****** Object:  StoredProcedure [dbo].[GetRaceByDate]    Script Date: 11/27/2007 12:37:29 ******/
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
