
CREATE   PROCEDURE App.usp_api_ZipCodeReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	ZipCodeId,
			ZipCodeCode,
			StreetId,
			ZipCodeFrom,
			ZipCodeTo
	FROM App.ZipCode;
END;