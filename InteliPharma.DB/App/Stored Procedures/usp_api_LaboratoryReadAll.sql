
CREATE   PROCEDURE App.usp_api_LaboratoryReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	LaboratoryName,
			LaboratoryNameASCII,
			AddressId,
			CNPJ,
			StateSubscription
	FROM App.Laboratory;
END;
