
CREATE   PROCEDURE App.usp_api_ProductReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT		ProductId,
				ProductBarCode,
				Price,
				Active
	FROM App.Product;
END;