
CREATE   PROCEDURE App.usp_api_PaymentMethodReadById
	@PaymentMethodId TINYINT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	PaymentMethodId,
			PaymentMethodName
	FROM App.PaymentMethod
	WHERE PaymentMethodId = @PaymentMethodId;
END;