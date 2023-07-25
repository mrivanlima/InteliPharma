
CREATE   PROCEDURE App.usp_api_OperationNatureReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT		OperationNatureId,
				OperationNatureName
	FROM App.OperationNature;
END;