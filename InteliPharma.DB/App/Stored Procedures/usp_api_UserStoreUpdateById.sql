
CREATE   PROCEDURE App.usp_api_UserStoreUpdateById
	@UserStoreId	BIGINT,
	@UserId			INT,
	@StoreId		INT,
	@IsDefault		BIT
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_UserStoreUpdateById';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	IF NOT EXISTS (SELECT * FROM App.UserStore WHERE UserStoreId = @UserStoreId)
	BEGIN 
		SET @ErrorMessage = CONCAT(@UserStoreId, ' ', 'not found!');
		THROW 50005, @ErrorMessage, 1;
	END

	BEGIN TRY 
		BEGIN TRANSACTION @StoredProcedureName

			UPDATE u
				SET UserId = @UserId,
					StoreId = @StoreId,
					IsDefault = @IsDefault
			FROM App.UserStore u
			WHERE UserStoreId = @UserStoreId

			PRINT CONCAT(@UserStoreId, ' ', 'updated sucessfully!');
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


		
		
