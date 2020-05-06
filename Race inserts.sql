use eRaceClub
go
delete racedetail
delete race
delete invoicerace
delete invoice where invoicenumber > 4
go
update idgenerator
set lastvalue = 4
where keyfield = 'invoicenumber'
go
declare @racedate datetime
set @racedate = 'Nov 18, 2007'
insert into race
values(1,convert(varchar(20),@racedate, 107) + ' 17:30',9,'Y',null)
insert into race
values(2,convert(varchar(20),@racedate, 107) + ' 18:30',5,'Y',null)
insert into race
values(3,convert(varchar(20),@racedate, 107) + ' 19:30',6,'Y',null)
insert into race
values(4,convert(varchar(20),@racedate + 1, 107) + ' 12:00',5,'Y',null)
insert into race
values(5,convert(varchar(20),@racedate + 1, 107) + ' 13:30',12,'Y',null)
insert into race
values(6,convert(varchar(20),@racedate + 1, 107) + ' 14:15',12,'Y',null)
insert into race
values(7,convert(varchar(20),@racedate + 1, 107) + ' 15:00',8,'Y',null)
insert into race
values(8,convert(varchar(20),@racedate + 1, 107) + ' 17:30',7,'Y',null)
insert into race
values(9,convert(varchar(20),@racedate + 1, 107) + ' 18:30',10,'Y',null)
insert into race
values(10,convert(varchar(20),@racedate + 1, 107) + ' 19:30',14,'Y',null)
insert into race
values(11,convert(varchar(20),@racedate + 2, 107) + ' 13:00',8,'Y',null)
insert into race
values(12,convert(varchar(20),@racedate + 2, 107) + ' 14:30',8,'Y',null)
insert into race
values(13,convert(varchar(20),@racedate + 2, 107) + ' 16:00',8,'Y',null)
insert into race
values(14,convert(varchar(20),@racedate + 2, 107) + ' 17:30',8,'Y',null)
go
declare @racedate datetime
set @racedate = 'Nov 18, 2007'
insert into racedetail
values(1,26,7,'B',6,dateadd(ss,44*60+6,convert(varchar(20),@racedate, 107) + ' 17:30'),null,null)
insert into racedetail
values(1,28,49,'B',1,dateadd(ss,35+60+45,convert(varchar(20),@racedate, 107) + ' 17:30'),null,null)
insert into racedetail
values(1,27,56,'B',null,null,'Disqualified','Pit row infaction')
insert into racedetail
values(1,30,77,'B',8,dateadd(ss,48*60,convert(varchar(20),@racedate, 107) + ' 17:30'),null,null)
insert into racedetail
values(1,32,105,'B',3,dateadd(ss,38*60+1,convert(varchar(20),@racedate, 107) + ' 17:30'),null,null)
insert into racedetail
values(1,34,112,'B',2,dateadd(ss,36*60+5,convert(varchar(20),@racedate, 107) + ' 17:30'),null,null)
insert into racedetail
values(1,35,119,'B',5,dateadd(ss,41*60+18,convert(varchar(20),@racedate, 107) + ' 17:30'),null,null)
insert into racedetail
values(1,31,147,'B',4,dateadd(ss,38*30+16,convert(varchar(20),@racedate, 107) + ' 17:30'),null,null)
insert into racedetail
values(1,39,154,'B',7,dateadd(ss,45*60-7,convert(varchar(20),@racedate, 107) + ' 17:30'),null,null)
--insert into racedetail
--values(1,carid,memberid,cerification,place,dateadd(mm,nn,'Nov 6,2007 17:30'),penalty,comment)