alter procedure Search_Customer
(
	@ten nvarchar(128)
)
as
begin
	select *from DBCustomer
	where DBCustomer.Name is null or dbo.fuConvertToUnsign1(DBCustomer.Name) like '%'+@ten+'%' or DBCustomer.Name like '%'+@ten+'%'
end
go
exec dbo.Search_Customer 'a'
go