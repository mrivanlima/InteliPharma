
CREATE   PROCEDURE App.usp_api_MedicationPrescriptionTypeReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	MedicationId,
			PrescriptionId,
			PrescriptionTypeId,
			Quantity,
			MedicationPrescriptionTypeId
	FROM App.MedicationPrescriptionType;
END;
