
CREATE   PROCEDURE App.usp_api_OrderDeliveryReadById
	@OrderDeliveryId BIGINT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT		OrderDeliveryId,   
				DeliveryId,        
				OrderId,           
				DriverId,          
				AddressId,        
				ProductCartUserId, 
				DeliveryStartDate, 
				DeliveryEndDate,   
				Completed
	FROM App.OrderDelivery
	WHERE OrderDeliveryId = @OrderDeliveryId;
END;