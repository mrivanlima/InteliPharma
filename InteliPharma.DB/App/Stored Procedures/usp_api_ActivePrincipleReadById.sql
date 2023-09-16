
CREATE   PROCEDURE App.usp_api_ActivePrincipleReadById
	@ActivePrincipleId INT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	ActivePrincipleId,
			ActivePrincipleName,
			ActivePrincipleNameASCII
	FROM App.ActivePrinciple
	WHERE ActivePrincipleId = @ActivePrincipleId;
END;
