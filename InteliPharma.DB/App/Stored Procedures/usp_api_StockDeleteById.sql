
CREATE   PROCEDURE App.usp_api_StockDeleteById
	@StockId	BIGINT
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_StockDeleteById';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);


	IF NOT EXISTS (SELECT * FROM App.Stock WHERE StockId = @StockId)
	BEGIN
		SET @ErrorMessage = CONCAT(@StockId, ' ', 'not found!');
		THROW 50005, @ErrorMessage, 1;
	END
	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			DELETE s
			FROM App.Stock s 
			WHERE StockId = @StockId

			PRINT CONCAT(@StockId, ' ', 'Deleted successfully!');
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