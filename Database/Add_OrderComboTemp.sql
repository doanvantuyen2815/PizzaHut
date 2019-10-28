/*CREATE TABLE OrderDetailComboTemp
(
	STT INT  IDENTITY(1,1) PRIMARY KEY,
	IDCombo NVARCHAR(128),
	DisplayName nvarchar(128),
	Quantity INT
)
GO
*/
create procedure Add_OrderComboTemp
(
	@id int,
	@displayname nvarchar(128),
	@price money,
	@quantity int
)
as
begin
	insert into OrderDetailComboTemp(IDCombo,DisplayName,Quantity,TotalPrice)values(@id,@displayname,@quantity,@quantity*@price)
end
go
exec dbo.Add_OrderComboTemp '1',N'Combo tưng bừng',600000,1
go