
CREATE   PROCEDURE App.usp_api_ProfessionalTypeReadById
	@ProfessionalTypeId SMALLINT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	ProfessionalTypeId,
			ProfessionalTypeName
	FROM App.ProfessionalType
	WHERE ProfessionalTypeId = @ProfessionalTypeId;
END;