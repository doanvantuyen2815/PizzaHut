create proc DeleteNhanVien
@id varchar(128)
as
begin
	Delete from Users where ID=@id
end
go
exec dbo.DeleteNhanVien '10'
go