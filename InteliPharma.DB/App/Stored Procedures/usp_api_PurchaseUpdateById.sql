
CREATE   PROCEDURE App.usp_api_PurchaseUpdateById
	@PurchaseId               INT           NOT NULL,
    @DistributorId            INT           NULL,
    @OperationNatureId        SMALLINT      NULL,
    @TaxCalculationId         SMALLINT      NULL,
    @TransporterId            SMALLINT      NULL,
    @ShippingAgreementId      TINYINT       NULL,
    @PurchaseDate             DATETIME      NULL,
    @PurchaseFiscalNote       VARCHAR (20)  NULL,
    @DanfeBarCode             VARCHAR (40)  NULL,
    @AccessKey                VARCHAR (200) NULL,
    @AuthorizationProtocol    VARCHAR (400) NULL,
    @StateSubscription        VARCHAR (50)  NULL,
    @StateSubscriptionTribute VARCHAR (50)  NULL,
    @CNPJ                     VARCHAR (200) NULL,
    @EmissionDate             DATE          NULL,
    @OperationDate            DATE          NULL,
    @OperationTime            TIME (7)      NULL
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_PurchaseUpdateById';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			UPDATE p
				SET             
					DistributorId = @DistributorId,            
					OperationNatureId = @OperationNatureId,        
					TaxCalculationId = @TaxCalculationId,         
					TransporterId = @TransporterId,            
					ShippingAgreementId = @ShippingAgreementId,     
					PurchaseDate = @PurchaseDate,             
					PurchaseFiscalNote = @PurchaseFiscalNote,      
					DanfeBarCode = @DanfeBarCode,            
					AccessKey = @AccessKey,                
					AuthorizationProtocol = @AuthorizationProtocol,    
					StateSubscription = @StateSubscription,        
					StateSubscriptionTribute = @StateSubscriptionTribute, 
					CNPJ = @CNPJ,                     
					EmissionDate = @EmissionDate,            
					OperationDate = @OperationDate,           
					OperationTime = @OperationTime
			FROM App.Purchase p
			WHERE PurchaseId = @PurchaseId

			PRINT CONCAT(@PurchaseId, ' ', 'updated successfully!');
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