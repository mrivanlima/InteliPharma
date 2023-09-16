
CREATE   PROCEDURE App.usp_api_MedicationPrescriptionTypeReadById
	@MedicationPrescriptionTypeId	BIGINT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	MedicationPrescriptionTypeId,
			MedicationId,
			PrescriptionId,
			PrescriptionTypeId,
			Quantity
	FROM App.MedicationPrescriptionType
	WHERE MedicationPrescriptionTypeId = @MedicationPrescriptionTypeId;
END;