
CREATE   PROCEDURE App.usp_api_IndicationReadById
	@IndicationId INT						NOT NULL
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	IndicationId,
			IndicationDescription
	FROM App.Indication
	WHERE IndicationId = @IndicationId;
END;
