
CREATE  PROCEDURE App.usp_api_UserMeasurementReadById
	@UserMeasurementId	INT
AS 
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	 UserMeasurementId,	
			 UserId,			
			 MeasurementId,	
			 UserMeasurementDate
	FROM App.UserMeasurement
	WHERE UserMeasurementId = @UserMeasurementId;
END;

