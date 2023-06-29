
CREATE   PROCEDURE App.usp_api_UserStoreReadAll
AS
BEGIN 
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT UserStoreId,
		   UserId,
		   StoreId,
		   IsDefault
	FROM App.UserStore;
END;
