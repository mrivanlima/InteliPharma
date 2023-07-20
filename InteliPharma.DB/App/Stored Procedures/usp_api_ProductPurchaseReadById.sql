
CREATE   PROCEDURE App.usp_api_ProductPurchaseReadById
	@ProductPurchaseId SMALLINT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT		ProductPurchaseId,
				ProductId,
				PurchaseId,
			    Quantity,
				Price,
				PurchaseDate,
				Serial,
				ProductBarCode,
				ProductCode,
				NCMSH,
				CMCST,
				CFOP,
				UN,
				UnitValue,
				TotalValue,
				ICMSBaseCalculation,
				ICMSValue,
				IPIValue,
				ICMSPercent,
				IPIPercent
	FROM App.ProductPurchase
	WHERE ProductPurchaseId = @ProductPurchaseId;
END;