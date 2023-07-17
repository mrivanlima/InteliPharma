
CREATE   PROCEDURE App.usp_api_ShippingAgreementReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	ShippingAgreementId,
			ShippingName
	FROM App.ShippingAgreement;
END;