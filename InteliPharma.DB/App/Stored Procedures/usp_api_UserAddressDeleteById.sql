﻿

CREATE  PROCEDURE App.UserAddressDeleteById
	@UserAddressId INT
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_UserAddressDeleteById'
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName)
	DECLARE @WarningMessage			VARCHAR(100);


	IF NOT EXISTS (SELECT * FROM App.UserAddress WHERE UserAddressId = @UserAddressId)
	BEGIN
		SET @ErrorMessage = CONCAT(@UserAddressId, ' ', 'not found!');
		THROW 50005, @ErrorMessage, 1;
	END

	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			DELETE u
			FROM App.UserAddress u
			WHERE UserAddressId = @UserAddressId

			PRINT CONCAT(@UserAddressId, ' ', 'Deleted successfully!');
		COMMIT TRANSACTION @StoredProcedureName 
	END TRY

	BEGIN CATCH 

		IF @@TRANCOUNT > 0
		BEGIN
			ROLLBACK TRANSACTION @StoredProcedureName;
		END;

		INSERT INTO [log].[ErrorLog]
		(
			[ErrorNumber], 
			[ErrorSeverity], 
			[ErrorState], 
			[ErrorProcedure], 
			[ErrorLine], 
			[ErrorMessage], 
			[UserName],
			ErrorDate
		)
		VALUES
		(
			ERROR_NUMBER(),
			ERROR_SEVERITY(),
			ERROR_STATE(),
			ERROR_PROCEDURE(),
			ERROR_LINE(),
			ERROR_MESSAGE(),
			SUSER_NAME(),
			GETDATE()
		);
		PRINT @ErrorMessage;
	END CATCH 
END;
