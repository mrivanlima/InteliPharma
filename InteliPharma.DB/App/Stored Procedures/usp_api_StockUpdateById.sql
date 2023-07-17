
CREATE   PROCEDURE App.usp_api_StockUpdateById
	@StockId         BIGINT       NOT NULL,
    @ProductId       INT          NULL,
    @Lote            VARCHAR (20) NULL,
    @FabricationDate DATE         NULL,
    @ExpirationDate  DATE         NULL,
    @Quantity        INT          NULL
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_StockUpdateById';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	
	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			UPDATE s
				SET StockId = @StockId,
					ProductId = @ProductId,
					Lote = @Lote,
					FabricationDate = @FabricationDate,
					ExpirationDate = @ExpirationDate,
					Quantity = @Quantity
			FROM App.Stock s
			WHERE StockId = @StockId

			PRINT CONCAT(@StockId, ' ', 'updated successfully!');
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