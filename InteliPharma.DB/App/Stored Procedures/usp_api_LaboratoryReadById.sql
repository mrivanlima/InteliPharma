
CREATE   PROCEDURE App.usp_api_LaboratoryReadById
	@LaboratoryId INT					NOT NULL
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	LaboratoryId,
			LaboratoryNameASCII,
			AddressId,
			CNPJ,
			StateSubscription
	FROM App.Laboratory
	WHERE LaboratoryId = @LaboratoryId;
END;
