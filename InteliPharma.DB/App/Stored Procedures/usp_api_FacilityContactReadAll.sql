
CREATE   PROCEDURE App.usp_api_FacilityContactReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	FaciltiyContactId,
			FacilityId,
			ContactId
	FROM App.FaciltiyContact;
END;
