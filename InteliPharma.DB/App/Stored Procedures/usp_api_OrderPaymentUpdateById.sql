
CREATE   PROCEDURE App.usp_api_OrderPaymentUpdateById
	@OrderPaymentId BIGINT  NOT NULL,
    @OrderId        BIGINT  NOT NULL,
    @PaymentId      TINYINT NOT NULL
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_OrderPaymentUpdateById';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	
	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			UPDATE o
				SET OrderPaymentId = @OrderPaymentId,
					OrderId = @OrderId,
					PaymentId = @PaymentId
			FROM App.OrderPayment o 
			WHERE OrderPaymentId = @OrderPaymentId

			PRINT CONCAT(@OrderPaymentId, ' ', 'updated successfully!');
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