
CREATE   PROCEDURE App.usp_api_TaxCalculationReadById
	@TaxCalculationId INT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT		TaxCalculationId,                        
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
	FROM App.TaxCalculation
	WHERE TaxCalculationId = @TaxCalculationId;
END;