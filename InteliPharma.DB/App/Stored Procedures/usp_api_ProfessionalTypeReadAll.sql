
CREATE   PROCEDURE App.usp_api_ProfessionalTypeReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	ProfessionalTypeId,
			ProfessionalTypeName
	FROM App.ProfessionalType;
END;