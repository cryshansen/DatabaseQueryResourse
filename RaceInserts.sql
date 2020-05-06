use eRaceClub
go
delete racedetail
delete invoicerace
delete race
delete invoice where invoicenumber > 4
update idgenerator
set lastvalue = 4
where 'invoicenumber' = keyfield
go
--
--set up race data based on current date
--
declare @racedate datetime
set @racedate = convert(varchar(20),getdate() - 1, 107)
--
-- race data 3 yesterday, 7 today, 4 tommorrow
--
insert into race
values(1,convert(varchar(20),@racedate, 107) + ' 17:30',9,'Y',null)
insert into race
values(2,convert(varchar(20),@racedate, 107) + ' 18:30',5,'Y',null)
insert into race
values(3,convert(varchar(20),@racedate, 107) + ' 19:30',6,'Y',null)
insert into race
values(4,convert(varchar(20),@racedate + 1, 107) + ' 12:00',6,'Y',null)
insert into race
values(5,convert(varchar(20),@racedate + 1, 107) + ' 13:30',12,'Y',null)
insert into race
values(6,convert(varchar(20),@racedate + 1, 107) + ' 15:15',12,'N',null)
insert into race
values(7,convert(varchar(20),@racedate + 1, 107) + ' 17:00',12,'N',null)
insert into race
values(8,convert(varchar(20),@racedate + 1, 107) + ' 18:45',7,'N',null)
insert into race
values(9,convert(varchar(20),@racedate + 1, 107) + ' 20:00',10,'N',null)
insert into race
values(10,convert(varchar(20),@racedate + 1, 107) + ' 22:00',14,'N',null)
insert into race
values(11,convert(varchar(20),@racedate + 2, 107) + ' 13:00',0,'N',null)
insert into race
values(12,convert(varchar(20),@racedate + 2, 107) + ' 14:30',0,'N',null)
insert into race
values(13,convert(varchar(20),@racedate + 2, 107) + ' 16:00',0,'N',null)
insert into race
values(14,convert(varchar(20),@racedate + 2, 107) + ' 17:30',0,'N',null)
--
--race 1
--
insert into racedetail
values(1,26,7,'B',6,dateadd(ss,44*60+6,convert(varchar(20),@racedate, 107) + ' 17:30'),null,null)
insert into racedetail
values(1,28,49,'B',1,dateadd(ss,35*60+45,convert(varchar(20),@racedate, 107) + ' 17:30'),null,null)
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
values(1,31,147,'B',4,dateadd(ss,38*60+16,convert(varchar(20),@racedate, 107) + ' 17:30'),null,null)
insert into racedetail
values(1,39,154,'B',7,dateadd(ss,45*60-7,convert(varchar(20),@racedate, 107) + ' 17:30'),null,null)
--
--race 2
--
insert into racedetail
values(2,30,175,'A',5,dateadd(ss,44*60+6,convert(varchar(20),@racedate, 107) + ' 18:30'),null,null)
insert into racedetail
values(2,34,182,'B',4,dateadd(ss,40*60+45,convert(varchar(20),@racedate, 107) + ' 18:30'),null,null)
insert into racedetail
values(2,36,189,'A',3,dateadd(ss,40*60,convert(varchar(20),@racedate, 107) + ' 18:30'),null,null)
insert into racedetail
values(2,39,196,'B',1,dateadd(ss,32*60,convert(varchar(20),@racedate, 107) + ' 18:30'),null,null)
insert into racedetail
values(2,32,203,'C',2,dateadd(ss,36*60+1,convert(varchar(20),@racedate, 107) + ' 18:30'),null,null)
--
--race 3
--
insert into racedetail
values(3,1,126,'C',1,dateadd(ss,44*60+6,convert(varchar(20),@racedate, 107) + ' 19:30'),null,null)
insert into racedetail
values(3,2,217,'C',3,dateadd(ss,47*60+45,convert(varchar(20),@racedate, 107) + ' 19:30'),null,null)
insert into racedetail
values(3,3,280,'C',2,dateadd(ss,46*60,convert(varchar(20),@racedate, 107) + ' 19:30'),null,null)
insert into racedetail
values(3,4,322,'C',4,dateadd(ss,50*60,convert(varchar(20),@racedate, 107) + ' 19:30'),null,null)
insert into racedetail
values(3,5,329,'C',5,dateadd(ss,53*60+1,convert(varchar(20),@racedate, 107) + ' 19:30'),null,null)
insert into racedetail
values(3,9,343,'C',null,null,'Crash','Turn 5, spin out, wall to infield')
--
--race 4
--
insert into racedetail
values(4,41,3225,'D',1,dateadd(ss,44*60+6,convert(varchar(20),@racedate + 1, 107) + ' 12:00'),null,null)
insert into racedetail
values(4,42,3250,'D',6,dateadd(ss,55*60+45,convert(varchar(20),@racedate + 1, 107) + ' 12:00'),null,null)
insert into racedetail
values(4,43,3297,'D',2,dateadd(ss,46*60+5,convert(varchar(20),@racedate + 1, 107) + ' 12:00'),null,null)
insert into racedetail
values(4,44,3412,'D',5,dateadd(ss,53*60,convert(varchar(20),@racedate + 1, 107) + ' 12:00'),null,null)
insert into racedetail
values(4,45,3473,'D',4,dateadd(ss,52*60+17,convert(varchar(20),@racedate + 1, 107) + ' 12:00'),null,null)
insert into racedetail
values(4,40,3607,'D',3,dateadd(ss,49*60+1,convert(varchar(20),@racedate + 1, 107) + ' 12:00'),null,null)
--
-- race 5
--
insert into racedetail
values(5,48,3034,'c',10,dateadd(ss,55*60+6,convert(varchar(20),@racedate + 1, 107) + ' 13:00'),null,null)
insert into racedetail
values(5,49,3037,'c',4,dateadd(ss,45*60+45,convert(varchar(20),@racedate + 1, 107) + ' 13:00'),null,null)
insert into racedetail
values(5,50,3106,'c',7,dateadd(ss,50*60+5,convert(varchar(20),@racedate + 1, 107) + ' 13:00'),null,null)
insert into racedetail
values(5,51,3109,'c',9,dateadd(ss,55*60,convert(varchar(20),@racedate + 1, 107) + ' 13:00'),null,null)
insert into racedetail
values(5,52,3142,'c',1,dateadd(ss,44*60+17,convert(varchar(20),@racedate + 1, 107) + ' 13:00'),null,null)
insert into racedetail
values(5,53,3161,'c',2,dateadd(ss,45*60+1,convert(varchar(20),@racedate + 1, 107) + ' 13:00'),null,null)
insert into racedetail
values(5,54,3165,'c',3,dateadd(ss,45*60+6,convert(varchar(20),@racedate + 1, 107) + ' 13:00'),null,null)
insert into racedetail
values(5,55,3179,'c',12,dateadd(ss,56*60+45,convert(varchar(20),@racedate + 1, 107) + ' 13:00'),null,null)
insert into racedetail
values(5,56,3386,'c',11,dateadd(ss,56*60+5,convert(varchar(20),@racedate + 1, 107) + ' 13:00'),null,null)
insert into racedetail
values(5,57,3402,'c',8,dateadd(ss,53*60,convert(varchar(20),@racedate + 1, 107) + ' 13:00'),null,null)
insert into racedetail
values(5,58,3431,'c',5,dateadd(ss,47*60+17,convert(varchar(20),@racedate + 1, 107) + ' 13:00'),null,null)
insert into racedetail
values(5,59,3514,'c',6,dateadd(ss,49*60+1,convert(varchar(20),@racedate + 1, 107) + ' 13:00'),null,null)
--
--race 6
--
insert into racedetail
values(6,48,3551,'c',null,null,null,null)
insert into racedetail
values(6,49,3578,'c',null,null,null,null)
insert into racedetail
values(6,50,3630,'c',null,null,null,null)
insert into racedetail
values(6,51,3664,'c',null,null,null,null)
insert into racedetail
values(6,52,3720,'c',null,null,null,null)
insert into racedetail
values(6,53,3774,'c',null,null,null,null)
insert into racedetail
values(6,54,3788,'c',null,null,null,null)
insert into racedetail
values(6,55,3821,'c',null,null,null,null)
insert into racedetail
values(6,56,3879,'c',null,null,null,null)
insert into racedetail
values(6,57,3885,'c',null,null,null,null)
insert into racedetail
values(6,58,3891,'c',null,null,null,null)
insert into racedetail
values(6,59,3949,'c',null,null,null,null)
--
--race 7
--
insert into racedetail
values(7,49,3037,'c',null,null,null,null)
insert into racedetail
values(7,52,3142,'c',null,null,null,null)
insert into racedetail
values(7,53,3161,'c',null,null,null,null)
insert into racedetail
values(7,54,3165,'c',null,null,null,null)
insert into racedetail
values(7,58,3431,'c',null,null,null,null)
insert into racedetail
values(7,59,3514,'c',null,null,null,null)
--
--race 8
--
insert into racedetail
values(8,2,1104,'c',null,null,null,null)
insert into racedetail
values(8,22,1106,'c',null,null,null,null)
insert into racedetail
values(8,13,1107,'c',null,null,null,null)
insert into racedetail
values(8,4,1109,'c',null,null,null,null)
insert into racedetail
values(8,18,1112,'c',null,null,null,null)
insert into racedetail
values(8,19,1114,'c',null,null,null,null)
insert into racedetail
values(8,5,1118,'c',null,null,null,null)
--
--race 9
--
insert into racedetail
values(9,25,1171,'B',null,null,null,null)
insert into racedetail
values(9,26,1173,'B',null,null,null,null)
insert into racedetail
values(9,34,1176,'B',null,null,null,null)
insert into racedetail
values(9,35,1178,'B',null,null,null,null)
insert into racedetail
values(9,28,1181,'B',null,null,null,null)
insert into racedetail
values(9,39,2273,'B',null,null,null,null)
insert into racedetail
values(9,27,2279,'B',null,null,null,null)
insert into racedetail
values(9,32,2286,'B',null,null,null,null)
insert into racedetail
values(9,36,2297,'B',null,null,null,null)
insert into racedetail
values(9,30,2692,'B',null,null,null,null)
--
--race 10
--
insert into racedetail
values(10,25,1041,'A',null,null,'Scratched',null)
insert into racedetail
values(10,26,1060,'A',null,null,null,null)
insert into racedetail
values(10,34,1069,'A',null,null,null,null)
insert into racedetail
values(10,35,2418,'A',null,null,'Scratched',null)
insert into racedetail
values(10,28,2426,'A',null,null,null,null)
insert into racedetail
values(10,39,2534,'A',null,null,null,null)
insert into racedetail
values(10,27,2555,'A',null,null,null,null)
insert into racedetail
values(10,32,4091,'A',null,null,null,null)
insert into racedetail
values(10,36,4105,'A',null,null,null,null)
insert into racedetail
values(10,30,4126,'A',null,null,null,null)
insert into racedetail
values(10,25,2123,'A',null,null,null,null)
insert into racedetail
values(10,31,2130,'A',null,null,null,null)
insert into racedetail
values(10,29,2140,'A',null,null,null,null)
insert into racedetail
values(10,35,2131,'A',null,null,null,null)

--
--invoices from races run
--
--race 1
--
insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 5,7,dateadd(ss,53*60,convert(varchar(20),@racedate, 107) + ' 17:30'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 26)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 6,49,dateadd(ss,53*60,convert(varchar(20),@racedate, 107) + ' 17:30'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 28)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 7,56,dateadd(ss,53*60,convert(varchar(20),@racedate, 107) + ' 17:30'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 27)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 8,77,dateadd(ss,53*60,convert(varchar(20),@racedate, 107) + ' 17:30'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 30)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 9,105,dateadd(ss,53*60,convert(varchar(20),@racedate, 107) + ' 17:30'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 32)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 10,112,dateadd(ss,53*60,convert(varchar(20),@racedate, 107) + ' 17:30'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 34)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 11,119,dateadd(ss,53*60,convert(varchar(20),@racedate, 107) + ' 17:30'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 35)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 12,147,dateadd(ss,53*60,convert(varchar(20),@racedate, 107) + ' 17:30'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 31)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 13,154,dateadd(ss,53*60,convert(varchar(20),@racedate, 107) + ' 17:30'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 39)

--
--race 2
--
insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 14,175,dateadd(ss,49*60+6,convert(varchar(20),@racedate, 107) + ' 18:30'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 30)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 15,182,dateadd(ss,49*60+6,convert(varchar(20),@racedate, 107) + ' 18:30'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 34)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 16,189,dateadd(ss,49*60+6,convert(varchar(20),@racedate, 107) + ' 18:30'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 36)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 17,196,dateadd(ss,49*60+6,convert(varchar(20),@racedate, 107) + ' 18:30'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 39)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 18,203,dateadd(ss,49*60+6,convert(varchar(20),@racedate, 107) + ' 18:30'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 32)

--
--race 3
--
insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 19,126,dateadd(ss,58*60+1,convert(varchar(20),@racedate, 107) + ' 19:30'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 1)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 20,217,dateadd(ss,58*60+1,convert(varchar(20),@racedate, 107) + ' 19:30'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 2)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 21,280,dateadd(ss,58*60+1,convert(varchar(20),@racedate, 107) + ' 19:30'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 3)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 22,322,dateadd(ss,58*60+1,convert(varchar(20),@racedate, 107) + ' 19:30'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 4)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 23,329,dateadd(ss,58*60+1,convert(varchar(20),@racedate, 107) + ' 19:30'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 5)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 24,343,dateadd(ss,58*60+1,convert(varchar(20),@racedate, 107) + ' 19:30'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 9)

--
--race 4
--
insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 25,3225,dateadd(ss,60*60+45,convert(varchar(20),@racedate + 1, 107) + ' 12:00'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 41)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 26,3250,dateadd(ss,60*60+45,convert(varchar(20),@racedate, 107) + ' 12:00'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 42)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 27,3297,dateadd(ss,60*60+45,convert(varchar(20),@racedate, 107) + ' 12:00'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 43)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 28,3412,dateadd(ss,60*60+45,convert(varchar(20),@racedate, 107) + ' 12:00'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 44)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 29,3473,dateadd(ss,60*60+45,convert(varchar(20),@racedate, 107) + ' 12:00'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 45)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 30,3607,dateadd(ss,60*60+45,convert(varchar(20),@racedate, 107) + ' 12:00'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 40)

--
--race 5
--
insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 31,3034,dateadd(ss,61*60+45,convert(varchar(20),@racedate + 1, 107) + ' 13:00'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 48)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 32,3037,dateadd(ss,61*60+45,convert(varchar(20),@racedate + 1, 107) + ' 13:00'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 49)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 33,3106,dateadd(ss,61*60+45,convert(varchar(20),@racedate + 1, 107) + ' 13:00'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 50)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 34,3109,dateadd(ss,61*60+45,convert(varchar(20),@racedate + 1, 107) + ' 13:00'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 51)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 35,3142,dateadd(ss,61*60+45,convert(varchar(20),@racedate + 1, 107) + ' 13:00'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 52)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 36,3161,dateadd(ss,61*60+45,convert(varchar(20),@racedate + 1, 107) + ' 13:00'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 53)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 37,3168,dateadd(ss,61*60+45,convert(varchar(20),@racedate + 1, 107) + ' 13:00'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 54)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 38,3179,dateadd(ss,61*60+45,convert(varchar(20),@racedate + 1, 107) + ' 13:00'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 55)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 39,3386,dateadd(ss,61*60+45,convert(varchar(20),@racedate + 1, 107) + ' 13:00'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 56)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 40,3402,dateadd(ss,61*60+45,convert(varchar(20),@racedate + 1, 107) + ' 13:00'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 57)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 41,3431,dateadd(ss,61*60+45,convert(varchar(20),@racedate + 1, 107) + ' 13:00'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 58)

insert into invoice(InvoiceNumber,memberid,Invoicedate,Paymenttypeid,subtotal,Gst)
select 42,3514,dateadd(ss,61*60+45,convert(varchar(20),@racedate + 1, 107) + ' 13:00'),2,
		raceRentalFee, racerentalfee *.06
from carclass where carclassid = (select carclassid from car where carid = 59)


--
-- InvoiceRace data
--
-- race 1
--
insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 5,26,1,raceRentalFee, 5
from carclass where carclassid = (select carclassid from car where carid = 26)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 6,28,1,raceRentalFee, 5
from carclass where carclassid = (select carclassid from car where carid = 28)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 7,27,1,raceRentalFee, 5
from carclass where carclassid = (select carclassid from car where carid = 27)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 8,30,1,raceRentalFee, 5
from carclass where carclassid = (select carclassid from car where carid = 30)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 9,32,1,raceRentalFee, 5
from carclass where carclassid = (select carclassid from car where carid = 32)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 10,34,1,raceRentalFee, 5
from carclass where carclassid = (select carclassid from car where carid = 34)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 11,35,1,raceRentalFee, 5
from carclass where carclassid = (select carclassid from car where carid = 35)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 12,31,1,raceRentalFee, 5
from carclass where carclassid = (select carclassid from car where carid = 31)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 13,39,1,raceRentalFee, 5
from carclass where carclassid = (select carclassid from car where carid = 39)
--
-- race 2
--
insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 14,30,2,raceRentalFee, 5
from carclass where carclassid = (select carclassid from car where carid = 30)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 15,34,2,raceRentalFee, 5
from carclass where carclassid = (select carclassid from car where carid = 34)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 16,36,2,raceRentalFee, 5
from carclass where carclassid = (select carclassid from car where carid = 36)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 17,39,2,raceRentalFee, 5
from carclass where carclassid = (select carclassid from car where carid = 39)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 18,32,2,raceRentalFee, 5
from carclass where carclassid = (select carclassid from car where carid = 32)
--
-- race 3
--
insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 19,1,3,raceRentalFee, 5
from carclass where carclassid = (select carclassid from car where carid = 1)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 20,2,3,raceRentalFee, 5
from carclass where carclassid = (select carclassid from car where carid = 2)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 21,3,3,raceRentalFee, 5
from carclass where carclassid = (select carclassid from car where carid = 3)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 22,4,3,raceRentalFee, 5
from carclass where carclassid = (select carclassid from car where carid = 4)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 23,5,3,raceRentalFee, 5
from carclass where carclassid = (select carclassid from car where carid = 5)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 24,9,3,raceRentalFee, 5
from carclass where carclassid = (select carclassid from car where carid = 9)
--
-- race 4
--
insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 25,41,4,raceRentalFee, 17
from carclass where carclassid = (select carclassid from car where carid = 41)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 26,42,4,raceRentalFee, 17
from carclass where carclassid = (select carclassid from car where carid = 42)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 27,43,4,raceRentalFee, 17
from carclass where carclassid = (select carclassid from car where carid = 43)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 28,44,4,raceRentalFee, 17
from carclass where carclassid = (select carclassid from car where carid = 44)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 29,45,4,raceRentalFee, 17
from carclass where carclassid = (select carclassid from car where carid = 45)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 30,40,4,raceRentalFee, 17
from carclass where carclassid = (select carclassid from car where carid = 40)
--
-- race 5
--
insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 31,48,5,raceRentalFee, 17
from carclass where carclassid = (select carclassid from car where carid = 48)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 32,49,5,raceRentalFee, 17
from carclass where carclassid = (select carclassid from car where carid = 49)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 33,50,5,raceRentalFee, 17
from carclass where carclassid = (select carclassid from car where carid = 50)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 34,51,5,raceRentalFee, 17
from carclass where carclassid = (select carclassid from car where carid = 51)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 35,52,5,raceRentalFee, 17
from carclass where carclassid = (select carclassid from car where carid = 52)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 36,53,5,raceRentalFee, 17
from carclass where carclassid = (select carclassid from car where carid = 53)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 37,54,5,raceRentalFee, 17
from carclass where carclassid = (select carclassid from car where carid = 54)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 38,55,5,raceRentalFee, 17
from carclass where carclassid = (select carclassid from car where carid = 55)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 39,56,5,raceRentalFee, 17
from carclass where carclassid = (select carclassid from car where carid = 56)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 40,57,5,raceRentalFee, 17
from carclass where carclassid = (select carclassid from car where carid = 57)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 41,58,5,raceRentalFee, 17
from carclass where carclassid = (select carclassid from car where carid = 58)

insert into invoicerace(InvoiceNumber,carid,raceid,price,employeeid)
select 42,59,5,raceRentalFee, 17
from carclass where carclassid = (select carclassid from car where carid = 59)

--
-- update the IDGenerator table for the invoice number
--
update IDGenerator
set lastvalue = 42
where keyfield='InvoiceNumber'