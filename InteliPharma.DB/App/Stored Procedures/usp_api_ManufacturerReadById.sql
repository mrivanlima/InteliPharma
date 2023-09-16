
CREATE   PROCEDURE App.usp_api_ManufacturerReadById
	@ManufacturerId	SMALLINT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	ManufacturerId,
			ManufacturerName,
			ManufacturerPhoneNumber
	FROM App.Manufacturer
	WHERE ManufacturerId = @ManufacturerId;
END;
