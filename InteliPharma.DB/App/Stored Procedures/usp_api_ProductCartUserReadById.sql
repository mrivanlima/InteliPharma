
CREATE   PROCEDURE App.usp_api_ProductCartUserReadById
	@ProductCartUserId SMALLINT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT		ProductCartUserId,
				ProductId,
				CartId,
				UserId,
				AddedOn,
				Active
	FROM App.ProductCartUser
	WHERE ProductCartUserId = @ProductCartUserId;
END;