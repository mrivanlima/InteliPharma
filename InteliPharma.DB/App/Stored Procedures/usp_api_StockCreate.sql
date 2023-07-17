
CREATE	PROCEDURE App.usp_api_StockCreate
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

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_StockCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	
	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.Stock
			(
				StockId,
				ProductId,
				Lote,
				FabricationDate,
				ExpirationDate,
				Quantity
			)
			VALUES
			(
				@StockId,
				@ProductId,
				@Lote,
				@FabricationDate,
				@ExpirationDate,
				@Quantity
			)

			SET @StockId = SCOPE_IDENTITY();
			PRINT CONCAT(@StockId, ' ', 'added successfully!');
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