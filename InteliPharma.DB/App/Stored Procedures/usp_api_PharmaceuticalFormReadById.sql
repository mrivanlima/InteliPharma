
CREATE   PROCEDURE App.usp_api_PharmaceuticalFormReadById
	@PharmaceuticalFormId INT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT		PharmaceuticalFormId,
				PharmaceuticalFormDescription
	FROM App.PharmaceuticalForm
	WHERE PharmaceuticalFormId = @PharmaceuticalFormId;
END;