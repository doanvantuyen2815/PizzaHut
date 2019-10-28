CREATE PROCEDURE ThongKeTheoKhachHang
AS
BEGIN
	SELECT DBCustomer.ID AS ID, Name ,SUM(Total_Amount) AS Total_Amount FROM dbo.Orders ,dbo.DBCustomer
	WHERE IDCustomer = DBCustomer.ID
	GROUP BY DBCustomer.ID , Name
	ORDER BY Total_Amount DESC
END
GO
exec dbo.ThongKeTheoKhachHang
go