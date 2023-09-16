
CREATE   PROCEDURE App.usp_api_MedicationTypeReadById
	@MedicationTypeId	TINYINT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	MedicationTypeId,
			MedicationTypeName
	FROM App.MedicationType
	WHERE MedicationTypeId = @MedicationTypeId;
END;
