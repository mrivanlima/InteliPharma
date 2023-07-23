
CREATE   PROCEDURE App.usp_api_PharmaceuticalAdministrationReadById
	@PharmaceuticalAdministrationId SMALLINT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT		PharmaceuticalAdministrationId,
				PharmaceuticalAdministrationDescription
	FROM App.PharmaceuticalAdministration
	WHERE PharmaceuticalAdministrationId = @PharmaceuticalAdministrationId;
END;