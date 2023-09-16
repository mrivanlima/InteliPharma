
CREATE   PROCEDURE App.usp_api_MedicationReadById
	@MedicationId	INT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	MedicationId,
			DrugId,
			ClassificationId,
			ManufacturerId,
			MedicationTypeId,
			AgeUsageId,
			PharmaceuticalAdministrationId,
			PharmaceuticalFormId,
			ActivePrincipleId,
			IndicationId,
			AgeUsageDescription,
			Threshold
	FROM App.Medication
	WHERE MedicationId = @MedicationId;
END;
