
CREATE   PROCEDURE App.usp_api_StateCreate
	@StateName	VARCHAR(20),
	@Longitude	DECIMAL(12,9) = NULL,
	@Latitude	DECIMAL(12,9) = NULL,
	@StateId	TINYINT = NULL OUTPUT
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_CreateState';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @StateName = TRIM(@StateName);

	IF EXISTS (SELECT * FROM App.[State] WHERE StateName = @StateName)
	BEGIN
		SET @WarningMessage = CONCAT(@StateName, ' ', 'already exists!');
		PRINT @WarningMessage;
		SET @StateId = (
							SELECT TOP (1) StateId 
							FROM App.[State] 
							WHERE StateName = @StateName
						);
		RETURN;
	END
	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.[State]
			(
				StateName,
				Longitude,
				Latitude
			)
			VALUES
			(
				@StateName,
				@Longitude,
				@Latitude	
			)

		SET @StateId = SCOPE_IDENTITY();
		PRINT CONCAT(@StateName, ' ', 'added successfully!');
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