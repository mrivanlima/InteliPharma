
CREATE  PROCEDURE App.usp_api_UserDiseaseReadById
	@UserDiseaseId	INT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT  UserDiseaseId,
			UserId,
			DiseaseId 
	FROM App.UserDisease
	WHERE UserDiseaseId = @UserDiseaseId;
END;
