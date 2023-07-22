
CREATE   PROCEDURE App.usp_api_PrescriptionReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT		PrescriptionId,
				ProfessionalId,
				PatientId,
				PrescriptionDate
	FROM App.Prescription;
END;