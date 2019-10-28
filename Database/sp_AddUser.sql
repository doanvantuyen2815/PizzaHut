create procedure AddUser
(
	@name nvarchar(128),
	@phone nchar(128),
	@birthday datetime,
	@username nvarchar(128),
	@password nvarchar(128),
	@role bit
)
as
begin
	insert into Users(DisplayName,Phone,Birthday,UserName,Password,Managers)values(@name,@phone,@birthday,@username,@password,@role)
end
go
exec dbo.AddUser N'nhân viên 2','0123456789','19980101','staff2','1',0
go