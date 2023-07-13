
CREATE   PROCEDURE App.usp_api_TaxCalculationUpdateById
	@TaxCalculationId           INT,             
    @ICMSBaseCalculation		DECIMAL (10, 2) = NULL,
    @ICMSValue					DECIMAL (10, 2) = NULL,
    @ICMSBaseStateCalculation	DECIMAL (10, 2) = NULL,
    @ICMSValueState				DECIMAL (10, 2) = NULL,
    @ValueImportation			DECIMAL (10, 2) = NULL,
    @ICMSValueStateRemit		DECIMAL (10, 2) = NULL,
    @ICPValue					DECIMAL (10, 2) = NULL,
    @PISValue					DECIMAL (10, 2) = NULL,
    @TotalProductValue			DECIMAL (10, 2) = NULL,
    @ShipmentValue				DECIMAL (10, 2) = NULL,
    @InsuranceValue				DECIMAL (10, 2) = NULL,
    @Discount					DECIMAL (10, 2) = NULL,
    @OtherExpenses				DECIMAL (10, 2) = NULL,
    @IPITotalValue				DECIMAL (10, 2) = NULL,
    @ICMSValueStateDestination	DECIMAL (10, 2) = NULL,
    @TotalTributationValue		DECIMAL (10, 2) = NULL,
    @ConfinsValue				DECIMAL (10, 2) = NULL,
    @TotalNoteValue				DECIMAL (10, 2) = NULL
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_TaxCalculationUpdateById';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	

	IF NOT EXISTS (SELECT * FROM App.TaxCalculation WHERE TaxCalculationId = @TaxCalculationId)
	BEGIN
		SET @ErrorMessage = CONCAT(@TaxCalculationId, ' ', 'not found!');
		THROW 50005, @ErrorMessage, 1;
	END
	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			UPDATE t
				SET                    
					ICMSBaseCalculation = @ICMSBaseCalculation,
					ICMSValue = @ICMSValue,
					ICMSBaseStateCalculation = @ICMSBaseStateCalculation,	
					ICMSValueState = @ICMSValueState,
					ValueImportation = @ValueImportation,
					ICMSValueStateRemit = @ICMSValueStateRemit,
					ICPValue = @ICPValue,
					PISValue = @PISValue,		
					TotalProductValue = @TotalProductValue,		
					ShipmentValue = @ShipmentValue,
					InsuranceValue = @InsuranceValue,
					Discount = @Discount,
					OtherExpenses = @OtherExpenses,		
					IPITotalValue = @IPITotalValue,
					ICMSValueStateDestination = @ICMSValueStateDestination,
					TotalTributationValue = @TotalTributationValue,
					ConfinsValue = @ConfinsValue,
					TotalNoteValue = @TotalNoteValue
			FROM App.TaxCalculation t
			WHERE TaxCalculationId = @TaxCalculationId

			PRINT CONCAT(@TaxCalculationId, ' ', 'updated successfully!');
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