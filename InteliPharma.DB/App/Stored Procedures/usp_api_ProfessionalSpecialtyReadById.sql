
CREATE   PROCEDURE App.usp_api_ProfessionalSpecialtyReadById
	@ProfessionalSpecialtyId INT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT		ProfessionalSpecialtyId,
				SpecialtyId,
				ProfessionalId
	FROM App.ProfessionalSpecialty
	WHERE ProfessionalSpecialtyId = @ProfessionalSpecialtyId;
END;