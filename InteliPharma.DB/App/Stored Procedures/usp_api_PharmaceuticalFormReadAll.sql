
CREATE   PROCEDURE App.usp_api_PharmaceuticalFormReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT		PharmaceuticalFormId,
				PharmaceuticalFormDescription
	FROM App.PharmaceuticalForm;
END;