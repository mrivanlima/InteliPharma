﻿
CREATE   PROCEDURE App.usp_api_DosageReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	DosageId,
			DosageValue
	FROM App.Dosage;
END;
