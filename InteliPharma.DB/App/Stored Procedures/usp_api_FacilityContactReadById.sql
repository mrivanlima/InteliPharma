
CREATE   PROCEDURE App.usp_api_FacilityContactReadById
	@FacilityContactId	BIGINT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	FaciltiyContactId,
			FacilityId,
			ContactId
	FROM App.FaciltiyContact
	WHERE FaciltiyContactId = @FacilityContactId;
END;
