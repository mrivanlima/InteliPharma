
CREATE PROCEDURE App.usp_api_PrescriptionReadById
	@PrescriptionId BIGINT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT		PrescriptionId,
				ProfessionalId,
				PatientId,
				PrescriptionDate
	FROM App.Prescription
	WHERE PrescriptionId = @PrescriptionId;
END;
