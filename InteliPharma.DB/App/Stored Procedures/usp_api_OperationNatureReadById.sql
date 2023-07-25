
CREATE   PROCEDURE App.usp_api_OperationNatureReadById
	@OperationNatureId SMALLINT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT		OperationNatureId,
				OperationNatureName
	FROM App.OperationNature
	WHERE OperationNatureId = @OperationNatureId;
END;