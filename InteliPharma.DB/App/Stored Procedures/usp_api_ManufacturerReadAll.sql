
CREATE   PROCEDURE App.usp_api_ManufacturerReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	ManufacturerId,
			ManufacturerName,
			ManufacturerPhoneNumber
	FROM App.Manufacturer;
END;
