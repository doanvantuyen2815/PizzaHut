create procedure Search_NhanVien
(
	@ten nvarchar(128)
)
as
begin
	select ID,DisplayName,Phone,Birthday
	from Users
	where Users.DisplayName is null or dbo.fuConvertToUnsign1(Users.DisplayName) like '%'+@ten+'%' or Users.DisplayName like '%'+@ten+'%'
end
go
exec dbo.Search_NhanVien 'a'
go