
CREATE   PROCEDURE App.usp_api_ProductPurchaseCreate
	@ProductPurchaseId   INT,
    @ProductId           INT = NULL,
    @PurchaseId          INT = NULL,
    @Quantity            INT = NULL,
    @Price               DECIMAL (10, 2) = NULL,
    @PurchaseDate        DATETIME = NULL,
    @Serial              VARCHAR (10) = NULL,
    @ProductBarCode      VARCHAR (40) = NULL,
    @ProductCode         VARCHAR (20) = NULL,
    @NCMSH               VARCHAR (10) = NULL,
    @CMCST               VARCHAR (20) = NULL,
    @CFOP                VARCHAR (20) = NULL,
    @UN                  SMALLINT = NULL,
    @UnitValue           DECIMAL (10, 2) = NULL,
    @TotalValue          DECIMAL (10, 2) = NULL,
    @ICMSBaseCalculation DECIMAL (10, 2) = NULL,
    @ICMSValue           DECIMAL (10, 2) = NULL,
    @IPIValue            DECIMAL (10, 2) = NULL,
    @ICMSPercent         DECIMAL (10, 2) = NULL,
    @IPIPercent          DECIMAL (10, 2) = NULL
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_ProductPurchaseCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	
	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.ProductPurchase
			(
				ProductPurchaseId,
				ProductId,
				PurchaseId,
			    Quantity,
				Price,
				PurchaseDate,
				Serial,
				ProductBarCode,
				ProductCode,
				NCMSH,
				CMCST,
				CFOP,
				UN,
				UnitValue,
				TotalValue,
				ICMSBaseCalculation,
				ICMSValue,
				IPIValue,
				ICMSPercent,
				IPIPercent
			)
			VALUES
			(
				@ProductPurchaseId,
				@ProductId,
				@PurchaseId,
			    @Quantity,
				@Price,
				@PurchaseDate,
				@Serial,
				@ProductBarCode,
				@ProductCode,
				@NCMSH,
				@CMCST,
				@CFOP,
				@UN,
				@UnitValue,
				@TotalValue,
				@ICMSBaseCalculation,
				@ICMSValue,
				@IPIValue,
				@ICMSPercent,
				@IPIPercent	
			)

			SET @ProductPurchaseId = SCOPE_IDENTITY();
			PRINT CONCAT(@ProductPurchaseId, ' ', 'added successfully!');
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