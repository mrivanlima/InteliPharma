
CREATE	 PROCEDURE App.usp_api_UserStoreReadById
	@UserStoreId BIGINT
AS 
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	UserStoreId,
			UserId,
			StoreId,
			IsDefault
	FROM App.UserStore
	WHERE UserStoreId = @UserStoreId;
END;

