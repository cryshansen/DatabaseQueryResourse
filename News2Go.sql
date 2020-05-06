/*
	IST245
	Scott Hetherington
	Lab 3: News 2 Go!
	Stored Procedures
*/

--
-- Drop existing procedures
--

drop proc AddCarrier
drop proc UpdateDistributor
drop proc DeleteDropSite
drop proc LookUpDistributorCarrier
drop proc NoPapers
drop proc LookUpCustomer
drop proc TransferRegion


--
-- Procedure definitions
--

GO
--
-- #1: AddCarrier
--

create proc AddCarrier(@FirstName varchar(30) = null, 
			@LastName varchar(30) = null, 
			@Phone char(10) = null)
as
if @FirstName is null or @LastName is null or @Phone is null
begin
	RaisError('This procedure does not allow null parameters.', 16, 1)
end
else
begin
	if exists (select FirstName, LastName from Carrier where FirstName = @FirstName and LastName = @LastName)
	begin
		RaisError('Carrier already exists.', 16, 1)
	end
	else
	begin
		insert into Carrier(FirstName, LastName, Phone)
			values(@FirstName, @LastName, @Phone)
		select * from Carrier where CarrierID = @@identity
		if @@Error <> 0
		begin
			RaisError('Could not add new Carrier.', 16, 1)
		end
	end
end

return

GO
--
-- #2: UpdateDistributor
--

create proc UpdateDistributor(@DistributorID int = null, @FirstName varchar(40) = null, 
								@LastName varchar(40) = null, @Wage smallmoney = null, @PagerNumber char(10) = null)
as
if @DistributorID is null or @LastName is null or @FirstName is null or @Wage is null or @PagerNumber is null
begin
	RaisError('This procedure does not allow null parameters.', 16, 1)
end
else
begin
	if not exists (select * from Distributor where DistributorID = @DistributorID)
	begin
		RaisError('Record does not exist, update failed.', 16, 1)
	end
	else
	begin
		update Distributor
		set	LastName = @LastName, FirstName = @FirstName,
			Wage = @Wage, PagerNumber = @PagerNumber
			where DistributorID = @DistributorID
		if @@Error <> 0
		begin
			RaisError('Could not update Distributor.', 16, 1)
		end
	end
end

return

GO
--
-- #3: DeleteDropSite
--

create proc DeleteDropSite(@DropSiteID int = null)
as
if @DropSiteID is null
begin
	RaisError('Dropsite ID is a required parameter.', 16, 1)
end
else
begin
	if not exists (select * from DropSite where DropSiteID = @DropSiteID)
	begin
		RaisError('That Dropsite does not exist. Delete operation failed.', 16, 1)
	end
	else
	begin
		if exists (select * from Route where DropSiteID = @DropSiteID)
		begin
			RaisError('Dropsite in use by a route. Cannot delete.', 16, 1)
		end
		else
		begin
			delete from DropSite where DropSiteID = @DropSiteID
			if @@Error <> 0
			begin
				RaisError('Delete operation failed.', 16, 1)
			end
		end
	end
end

return

GO
--
-- #4: LookUpDistributorCarrier
--

create proc LookUpDistributorCarrier(@DistributorID int = null)
as
if @DistributorID is null
begin
	RaisError('Distributor ID is a required parameter.', 16, 1)
end
else
begin
	if not exists (select DistributorID from Distributor where DistributorID = @DistributorID)
	begin
		RaisError('That Distributor does not exist.', 16, 1)
	end
	else
	begin
		select Distributor.FirstName + ' ' + Distributor.LastName 'Distributor Name', 
				RegionName 'Region Name', 
				RouteName 'Route Name',
				Carrier.FirstName + ' ' + Carrier.LastName 'Carrier Name' from Carrier
			inner join Route on Carrier.CarrierID = Route.CarrierID
			inner join Region on Route.RegionID = Region.RegionID
			inner join Distributor on Region.DistributorID = Distributor.DistributorID
			where Distributor.DistributorID = @DistributorID
	end
end

return

GO
--
-- #5: NoPapers
--

create proc NoPapers
as
select FirstName + ' ' + LastName 'Customer Name', PostalCode 'Postal Code' from Customer
	left outer join CustomerPaper on CustomerPaper.CustomerID = Customer.CustomerID
	where CustomerPaper.CustomerID is null

return

GO
--
-- #6: LookUpCustomer
--

create proc LookUpCustomer(@PartialLastName varchar(30) = null)
as
if @PartialLastName is null
begin
	RaisError('Partial last name is a required parameter.', 16, 1)
end
else
begin
	if not exists (select LastName from Customer where LastName like '%' + @PartialLastName + '%')
	begin
		RaisError('No customers matching that criteria found.', 16, 1)
	end
	else
	begin
		select FirstName + ' ' + LastName 'Customer Name', Address, City, Province, PostalCode, PrePaidTip from Customer 
			where LastName like '%' + @PartialLastName + '%'
	end	
end

return

GO
--
-- #7: TransferRegion
--

create proc TransferRegion(@RegionID int = null, @DistributorID int = null)
as
if @RegionID is null or @DistributorID is null
begin
	RaisError('This procedure does not allow null parameters.', 16, 1)
end
else
begin
	begin transaction
		update Distributor
			set Wage = Wage - 1.00
			where DistributorID = (select DistributorID from Region where RegionID = @RegionID)
		if @@Error <> 0
		begin
			RaisError('The Distributor wage update failed.', 16, 1)
			Rollback transaction
		end
		else
		begin
			update Region
				set DistributorID = @DistributorID
				where RegionID = @RegionID
			if @@Error <> 0
			begin
				RaisError('The DistributorID update failed.', 16, 1)
				Rollback transaction
			end
			else
			begin
				update Distributor
					set Wage = Wage + 1.00
					where DistributorID = @DistributorID
				if @@Error <> 0
				begin
					RaisError('The second wage update failed.', 16, 1)
					Rollback transaction
				end
				else
				begin
					commit transaction
				end
			end
		end
	end
end

return

GO