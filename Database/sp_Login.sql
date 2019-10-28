CREATE PROCEDURE sp_Login
@userName nvarchar(128), @passWord nvarchar(128)
AS
BEGIN
	SELECT * FROM Users WHERE UserName = @userName AND Password = @passWord
END
GO