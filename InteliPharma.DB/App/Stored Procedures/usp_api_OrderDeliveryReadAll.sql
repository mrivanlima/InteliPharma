
CREATE   PROCEDURE App.usp_api_OrderDeliveryReadAll
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
	FROM App.OrderDelivery;
END;