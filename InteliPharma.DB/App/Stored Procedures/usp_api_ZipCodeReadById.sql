
CREATE   PROCEDURE App.usp_api_ZipCodeReadById
	@ZipCodeId INT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	ZipCodeId,
			ZipCodeCode,
			StreetId,
			ZipCodeFrom,
			ZipCodeTo
	FROM App.ZipCode
	WHERE ZipCodeId = @ZipCodeId;
END;