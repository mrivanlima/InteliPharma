﻿
CREATE   PROCEDURE App.usp_api_ActivePrincipleReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	ActivePrincipleId,
			ActivePrincipleName
	FROM App.ActivePrinciple;
END;
