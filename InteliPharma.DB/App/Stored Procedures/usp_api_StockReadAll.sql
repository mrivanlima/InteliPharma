
CREATE   PROCEDURE App.usp_api_StockReadAll
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
	FROM App.Stock;
END;