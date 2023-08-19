CREATE PROCEDURE App.usp_api_MedicationPrescriptionTypeCreate
	@MedicationId INT,
	@PrescriptionId BIGINT,
	@PrescriptionTypeId TINYINT = NULL,
	@Quantity TINYINT = NULL,
	@MedicationPrescriptionTypeId BIGINT = NULL OUTPUT
AS
BEGIN

	SET NOCOUNT ON;

END
