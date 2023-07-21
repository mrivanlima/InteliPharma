
CREATE   PROCEDURE App.usp_api_ProfessionalReadById
	@ProfessionalId INT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	ProfessionalId,
			ProfessionalName,
			ProfessionalAssociationNumber
	FROM App.Professional
	WHERE ProfessionalId = @ProfessionalId;
END;