
CREATE   PROCEDURE App.usp_api_OrderPaymentReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT		OrderPaymentId,
				OrderId,
				PaymentId
	FROM App.OrderPayment;
END;