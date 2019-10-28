/*CREATE PROCEDURE ThongKeTheoDonHang
AS
BEGIN
	DECLARE @ThongKeTheoDonHangTable TABLE
	(
		IDItem INT,
		Quantity INT
	)
	INSERT INTO @ThongKeTheoDonHangTable
	SELECT Items.ID,SUM(OrderDetailCombo.Quantity* ComboDetail.Quantity)
	FROM dbo.Items,dbo.ComboDetail,dbo.Combo,dbo.OrderDetailCombo
	WHERE Items.ID = ComboDetail.IDItems
		AND Combo.ID = IDCombo
		AND Combo.ID = ComboDetail.ID
	GROUP BY Items.ID

	INSERT INTO @ThongKeTheoDonHangTable
	SELECT Items.ID, SUM(Quantity) FROM dbo.Items , dbo.OrderDetail
	WHERE Items.ID = IDItems
	GROUP BY Items.ID

	SELECT IDItem AS ID, DisplayName AS Name , SUM(Quantity) AS Quantity FROM @ThongKeTheoDonHangTable,dbo.Items
	WHERE ID = IDItem
	GROUP BY IDItem, DisplayName
	ORDER BY Quantity DESC

END
GO*/
exec dbo.ThongKeTheoDonHang