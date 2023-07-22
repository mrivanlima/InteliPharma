
CREATE   PROCEDURE App.usp_api_PrescriptionTypeReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	PrescriptionTypeId,
			PrescriptionTypeName
	FROM App.PrescriptionType;
END;
