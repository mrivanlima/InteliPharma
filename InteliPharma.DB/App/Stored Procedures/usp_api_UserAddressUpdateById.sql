
CREATE   PROCEDURE App.usp_api_UserAddressUpdateById
	@UserAddressId		INT,
	@AddressId			INT,
	@UserId				INT,
	@AddressTypeId		SMALLINT,
	@Active				BIT,
	@Default			BIT
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'sp_api_UserAddressUpdateById';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	

	IF NOT EXISTS (SELECT * FROM App.UserAddress WHERE UserAddressId = @UserAddressId)
	BEGIN
		SET @ErrorMessage = CONCAT(@UserAddressId, ' ', 'not found!');
		THROW 50005, @ErrorMessage, 1;
	END
	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			UPDATE u
				SET u.AddressId = @AddressId,
					u.UserId = @UserId,
				    u.AddressTypeId = @AddressTypeId,
					u.Active = @Active
					
			FROM App.UserAddress u
			WHERE UserAddressId = @UserAddressId

			PRINT CONCAT(@UserAddressId, ' ', 'updated successfully!');
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
			 ERROR_NUMBER()
			,ERROR_SEVERITY()
			,ERROR_STATE()
			,ERROR_PROCEDURE()
			,ERROR_LINE()
			,ERROR_MESSAGE()
			,SUSER_NAME()
			,GETDATE()
		);
		PRINT @ErrorMessage;
	END CATCH
END;