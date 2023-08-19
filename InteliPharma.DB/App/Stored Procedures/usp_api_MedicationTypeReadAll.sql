
CREATE   PROCEDURE App.usp_api_MedicationTypeReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	MedicationTypeId,
			MedicationTypeName
	FROM App.MedicationType;
END;
