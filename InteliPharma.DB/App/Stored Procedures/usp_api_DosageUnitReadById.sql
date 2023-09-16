
CREATE   PROCEDURE App.usp_api_DosageUnitReadById
	@DosageUnitId	SMALLINT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	DosageUnitId,
			UnitName,
			UnitAbbrev
	FROM App.DosageUnit
	WHERE DosageUnitId = @DosageUnitId;
END;
