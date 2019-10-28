create procedure Add_Customer
(
	@name nvarchar(128),
	@address nvarchar(128),
	@phone nvarchar(128),
	@birthday datetime
)
as
begin
	insert into DBCustomer(Name,Address,Phone,Birthday)values(@name,@address,@phone,@birthday)
end
go
exec dbo.Add_Customer N'Chống Đức Anh','Dĩ An, Bình Dương','0123456789','19980101'
go