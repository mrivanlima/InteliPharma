
CREATE   PROCEDURE App.usp_api_ManufacturerReadById
	@ManufacturerId SMALLINT					NOT NULL
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	ManufacturerName,
			ManufacturerPhoneNumber
	FROM App.Manufacturer
	WHERE ManufacturerId = @ManufacturerId;
END;
