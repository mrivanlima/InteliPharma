
CREATE   PROCEDURE App.usp_api_ProfessionalSpecialtyReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT		ProfessionalSpecialtyId,
				SpecialtyId,
				ProfessionalId
	FROM App.ProfessionalSpecialty;
END;