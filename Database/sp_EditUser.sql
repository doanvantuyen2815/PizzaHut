create procedure EditUser
(
	@id int,
	@name nvarchar(128),
	@phone nchar(128),
	@birthday datetime
)
as
begin
	update Users set DisplayName=@name, Phone=@phone, Birthday=@birthday where ID=@id
end
go
exec dbo.EditUser '4',N'Văn Tuyến','01234567891','19980101'
