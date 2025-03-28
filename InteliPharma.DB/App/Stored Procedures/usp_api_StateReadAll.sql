﻿CREATE   PROCEDURE App.usp_api_StateReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT StateId,
	       StateName, 
	       Longitude,
		   Latitude,
		   StateAbbreviation
	FROM App.[State];
END;