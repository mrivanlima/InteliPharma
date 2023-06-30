
CREATE  PROCEDURE App.usp_api_UserMeasurementReadAll
AS 
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	UserMeasurementId,	
			UserId,			
			MeasurementId,		
			UserMeasurementDate
	FROM App.UserMeasurement;
END;
