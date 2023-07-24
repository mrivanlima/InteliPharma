
CREATE   PROCEDURE App.usp_api_OrderPaymentReadById
	@OrderPaymentId SMALLINT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT		OrderPaymentId,
				OrderId,
				PaymentId
	FROM App.OrderPayment
	WHERE OrderPaymentId = @OrderPaymentId;
END;