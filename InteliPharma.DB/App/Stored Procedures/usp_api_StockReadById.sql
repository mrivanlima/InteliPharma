
CREATE   PROCEDURE App.usp_api_StockReadById
	@StockId BIGINT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	StockId,
			ProductId,
			Lote,
			FabricationDate,
			ExpirationDate,
			Quantity
	FROM App.Stock
	WHERE StockId = @StockId;
END;