
CREATE   PROCEDURE App.usp_api_ShippingAgreementReadById
	@ShippingAgreementId SMALLINT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	ShippingAgreementId,
			ShippingName
	FROM App.ShippingAgreement
	WHERE ShippingAgreementId = @ShippingAgreementId;
END;