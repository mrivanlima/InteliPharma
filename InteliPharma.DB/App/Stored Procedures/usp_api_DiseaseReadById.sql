﻿
CREATE   PROCEDURE App.usp_api_DiseaseReadById
	@DiseaseId	INT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	DiseaseId,
			DiseaseName
	FROM App.Disease
	WHERE DiseaseId = @DiseaseId;
END;
