
CREATE   PROCEDURE App.usp_api_ProductReadById
	@ProductId INT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT		ProductId,
				ProductBarCode,
				Price,
				Active
	FROM App.Product
	WHERE ProductId = @ProductId;
END;