
CREATE   PROCEDURE App.usp_api_ProductUpdateById
	@ProductId      INT             NOT NULL,
    @ProductBarCode DATETIME        NULL,
    @Price          DECIMAL (10, 2) NULL,
    @Active         BIT             NULL
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_ProductUpdateById';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			UPDATE p
				SET ProductBarCode = @ProductBarCode,
					Price = @Price,
					Active = @Active
			FROM App.Product p
			WHERE ProductId = @ProductId

			PRINT CONCAT(@ProductId, ' ', 'updated successfully!');
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