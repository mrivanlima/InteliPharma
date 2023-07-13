
CREATE   PROCEDURE App.usp_api_TaxCalculationCreate
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

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_TaxCalculationCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	
	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.TaxCalculation
			(
				TaxCalculationId,                        
				ICMSBaseCalculation,	
				ICMSValue,				
			    ICMSBaseStateCalculation,	
				ICMSValueState,				
				ValueImportation,			
				ICMSValueStateRemit,		
				ICPValue,					
				PISValue,					
				TotalProductValue,			
				ShipmentValue,				
				InsuranceValue,				
				Discount,					
			    OtherExpenses,				
				IPITotalValue,				
				ICMSValueStateDestination,	
				TotalTributationValue,		
				ConfinsValue,				
				TotalNoteValue				
			)
			VALUES
			(
				@TaxCalculationId,                        
				@ICMSBaseCalculation,	
				@ICMSValue,				
			    @ICMSBaseStateCalculation,	
				@ICMSValueState,				
				@ValueImportation,			
				@ICMSValueStateRemit,		
				@ICPValue,					
				@PISValue,					
				@TotalProductValue,			
				@ShipmentValue,				
				@InsuranceValue,				
				@Discount,					
			    @OtherExpenses,				
				@IPITotalValue,				
				@ICMSValueStateDestination,	
				@TotalTributationValue,		
				@ConfinsValue,				
				@TotalNoteValue	
			)

			SET @TaxCalculationId = SCOPE_IDENTITY();
			PRINT CONCAT(@TaxCalculationId, ' ', 'added successfully!');
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