﻿
CREATE   PROCEDURE App.usp_api_IndicationReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	IndicationId,
			IndicationDescription
	FROM App.Indication;
END;
