/*ALTER PROCEDURE InsertOrderDetail
(
	@IDCustomer int,
	@Address NVARCHAR(128)
)
AS
BEGIN
	
	DECLARE @Total_Amount MONEY
	SET @Total_Amount = (SELECT SUM(Quantity * Price) FROM dbo.OrderDetailTemp , dbo.Items WHERE ID = IDItem )
		+ (SELECT SUM(Quantity * Price) FROM dbo.OrderDetailComboTemp, dbo.Combo WHERE ID = IDCombo)
	DECLARE @IDPromotions INT
	SET @IDPromotions = (SELECT TOP 1 ID FROM dbo.Promotions WHERE StartTime < GETDATE() AND EndTime > GETDATE() ORDER BY Discount DESC)
	IF (@IDPromotions IS NOT NULL)
		SET @Total_Amount = @Total_Amount *( 100 - (SELECT Discount FROM dbo.Promotions WHERE ID = @IDPromotions) ) / 100
	INSERT INTO dbo.Orders
	(
	    CreateDate,
	    Total_Amount,
	    IDCustomer,
	    Address,
	    IDPromotions
	)
	VALUES
	(   GETDATE(),
	    @Total_Amount,
	    @IDCustomer,
	    @Address,
	    @IDPromotions
		)

	DECLARE @IDOrder INT
	SET @IDOrder = (SELECT TOP 1 ID FROM dbo.Orders ORDER BY ID DESC)

	INSERT INTO dbo.OrderDetail
	SELECT @IDOrder,IDItem,Quantity FROM dbo.OrderDetailTemp

	INSERT INTO dbo.OrderDetailCombo
	SELECT @IDOrder, IDCombo,Quantity FROM dbo.OrderDetailComboTemp

	TRUNCATE TABLE dbo.OrderDetailTemp
	TRUNCATE TABLE dbo.OrderDetailComboTemp
END
GO*/
exec dbo.InsertOrderDetail 1,N'Dĩ An, Bình Dương'