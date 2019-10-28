create procedure Search_Item
(
	@ten nvarchar(128)
)
as
begin
	select Items.ID,Items.DisplayName,DBUnit.DisplayName as DonVi,Price
	from Items,DBUnit
	where Items.DisplayName is null or ((dbo.fuConvertToUnsign1(Items.DisplayName) like '%'+@ten+'%' or Items.DisplayName like '%'+@ten+'%')and Items.IDUnit=DBUnit.ID)
end
go
exec dbo.Search_Item 'o'
go
