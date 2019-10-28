create procedure Search_Combo
(
	@ten nvarchar(128)
)
as
begin
	select Combo.ID,Combo.DisplayName,Price
	from Combo
	where Combo.DisplayName is null or ((dbo.fuConvertToUnsign1(Combo.DisplayName) like '%'+@ten+'%' or Combo.DisplayName like '%'+@ten+'%'))
end
go
exec dbo.Search_Combo 't'
go
