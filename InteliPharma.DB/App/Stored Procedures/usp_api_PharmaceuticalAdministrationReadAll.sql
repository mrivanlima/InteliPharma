
CREATE   PROCEDURE App.usp_api_PharmaceuticalAdministrationReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	PharmaceuticalAdministrationId,
			PharmaceuticalAdministrationDescription
	FROM App.PharmaceuticalAdministration;
END;