﻿
CREATE   PROCEDURE App.usp_api_MeasurementReadById
	@MeasurementId	INT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	MeasurementId,
			MeasurementName
	FROM App.Measurement
	WHERE MeasurementId = @MeasurementId;
END;
