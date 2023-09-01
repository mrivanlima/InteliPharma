﻿
CREATE   PROCEDURE App.usp_api_MeasurementReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	MeasurementId,
			MeasurementName
	FROM App.Measurement;
END;
