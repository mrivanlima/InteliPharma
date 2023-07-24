﻿
CREATE   PROCEDURE App.usp_api_OrderDeliveryCreate
	@OrderDeliveryId   BIGINT   NOT NULL,
    @DeliveryId        BIGINT   NULL,
    @OrderId           INT      NULL,
    @DriverId          INT      NULL,
    @AddressId         INT      NULL,
    @ProductCartUserId BIGINT   NULL,
    @DeliveryStartDate DATETIME NULL,
    @DeliveryEndDate   DATETIME NULL,
    @Completed         BIT      NULL
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_OrderDeliveryCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	
	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.OrderDelivery
			(
				OrderDeliveryId,   
				DeliveryId,        
				OrderId,           
				DriverId,          
				AddressId,        
				ProductCartUserId, 
				DeliveryStartDate, 
				DeliveryEndDate,   
				Completed         
			)
			VALUES
			(
				@OrderDeliveryId,   
				@DeliveryId,        
				@OrderId,           
				@DriverId,          
				@AddressId,        
				@ProductCartUserId, 
				@DeliveryStartDate, 
				@DeliveryEndDate,   
				@Completed
			)

			SET @OrderDeliveryId = SCOPE_IDENTITY();
			PRINT CONCAT(@OrderDeliveryId, ' ', 'added successfully!');
		COMMIT TRANSACTION @StoredProcedureName	
	END TRY

	BEGIN CATCH
		
		IF @@TRANCOUNT > 0
		BEGIN
			ROLLBACK TRANSACTION @StoredProcedureName;
		END;

		INSERT INTO [log].[ErrorLog] 
		(
			[ErrorNumber], 
			[ErrorSeverity], 
			[ErrorState], 
			[ErrorProcedure], 
			[ErrorLine], 
			[ErrorMessage], 
			[UserName],
			ErrorDate
		)
		VALUES
		( 
			 ERROR_NUMBER()
			,ERROR_SEVERITY()
			,ERROR_STATE()
			,ERROR_PROCEDURE()
			,ERROR_LINE()
			,ERROR_MESSAGE()
			,SUSER_NAME()
			,GETDATE()
		);
		PRINT @ErrorMessage;
	END CATCH
END;