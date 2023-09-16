
CREATE   PROCEDURE App.usp_api_FacilityReadById
	@FacilityId	INT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	FacilityId,
			FacilityName,
			AddressId
	FROM App.Facility
	WHERE FacilityId = @FacilityId;
END;
