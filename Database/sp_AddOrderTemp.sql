/*CREATE TABLE OrderDetailTemp
(
	STT INT  IDENTITY(1,1) PRIMARY KEY,
	IDItem NVARCHAR(128),
	DisplayName nvarchar(128),
	Quantity INT,
	TotalPrice money
)
GO*/
/*create procedure Add_OrderTemp
(
	@id int,
	@displayname nvarchar(128),
	@price money,
	@quantity int
)
as
begin
	insert into OrderDetailTemp(IDItem,DisplayName,Quantity,TotalPrice)values(@id,@displayname,@quantity,@quantity*@price)
end
go*/
exec dbo.Add_OrderTemp '1',N'Pizza thập cẩm',200000,2
go