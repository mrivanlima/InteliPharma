
CREATE   PROCEDURE App.usp_api_PurchaseReadAll
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
	FROM App.Purchase;
END;