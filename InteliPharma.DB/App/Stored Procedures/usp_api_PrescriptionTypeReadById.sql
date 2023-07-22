
CREATE PROCEDURE App.usp_api_PrescriptionTypeReadById
	@PrescriptionTypeId TINYINT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	PrescriptionTypeId,
			PrescriptionTypeName
	FROM App.PrescriptionTypeId
	WHERE PrescriptionTypeId = @PrescriptionTypeId;
END;
