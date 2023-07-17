
CREATE   PROCEDURE App.usp_api_SpecialtyReadById
	@SpecialtyId SMALLINT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	SpecialtyId,
			SpecialtyName
	FROM App.Specialty
	WHERE SpecialtyId = @SpecialtyId;
END;