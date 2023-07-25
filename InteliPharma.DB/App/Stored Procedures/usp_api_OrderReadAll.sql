﻿
CREATE   PROCEDURE App.usp_api_OrderReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT		OrderId,
				CartId,
				TotalPrice
	FROM App.[Order];
END;