﻿
CREATE   PROCEDURE App.usp_api_DiseaseReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	DiseaseId,
			DieseaseName
	FROM App.Disease;
END;
