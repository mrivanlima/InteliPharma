
CREATE   PROCEDURE usp_api_StateUpdate
	@StateName	VARCHAR(20),
	@Longitude	DECIMAL(12,9) = NULL,
	@Latitude	DECIMAL(12,9) = NULL,
	@StateId	TINYINT
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_StateUpdate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @StateName = TRIM(@StateName);

	IF NOT EXISTS (SELECT * FROM App.[State] WHERE StateId = @StateId)
	BEGIN
		SET @ErrorMessage = CONCAT(@StateId, ' ', 'not found!');
		THROW 50005, @ErrorMessage, 1;
	END
	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			UPDATE s
				SET StateName = @StateName,
				    Longitude = @Longitude,
					Latitude = @Latitude
			FROM App.[State] s 
			WHERE StateId = @StateId

			PRINT CONCAT(@StateName, ' ', 'updated successfully!');
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