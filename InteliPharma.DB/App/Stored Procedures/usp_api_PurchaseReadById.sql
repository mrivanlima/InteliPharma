
CREATE   PROCEDURE App.usp_api_PurchaseReadById
	@PurchaseId SMALLINT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT		PurchaseId,            
				DistributorId,            
				OperationNatureId,        
				TaxCalculationId,         
				TransporterId,            
				ShippingAgreementId,     
				PurchaseDate,             
				PurchaseFiscalNote,      
				DanfeBarCode,            
				AccessKey,                
				AuthorizationProtocol,    
				StateSubscription,        
				StateSubscriptionTribute, 
				CNPJ,                     
				EmissionDate,            
				OperationDate,           
				OperationTime
	FROM App.Purchase
	WHERE PurchaseId = @PurchaseId;
END;