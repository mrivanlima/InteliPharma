
CREATE   PROCEDURE App.usp_api_PaymentMethodReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT		PaymentMethodId,
				PaymentMethodName
	FROM App.PaymentMethod;
END;