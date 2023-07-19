
CREATE   PROCEDURE App.usp_api_ProfessionalReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT		ProfessionalId,
				ProfessionalName,
				ProfessionalAssociationNumber
	FROM App.Professional;
END;