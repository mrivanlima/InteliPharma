
CREATE   PROCEDURE App.usp_api_UserAddressReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	UserAddressId,
			AddressId,
			UserId,
			AddressTypeId,
			Active
	FROM App.UserAddress;
END;