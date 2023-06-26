
CREATE   PROCEDURE usp_api_CityUpdateById
	@StateId	TINYINT,
	@CityName	VARCHAR(20),
	@Longitude	DECIMAL(12,9) = NULL,
	@Latitude	DECIMAL(12,9) = NULL,
	@CityId		SMALLINT
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_CityUpdateById';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @CityName = TRIM(@CityName);

	IF NOT EXISTS (SELECT * FROM App.City WHERE CityId = @CityId)
	BEGIN
		SET @ErrorMessage = CONCAT(@CityId, ' ', 'not found!');
		THROW 50005, @ErrorMessage, 1;
	END
	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			UPDATE c
				SET CityName = @CityName,
					StateId = @StateId,
				    Longitude = @Longitude,
					Latitude = @Latitude
			FROM App.City c 
			WHERE CityId = @CityId

			PRINT CONCAT(@CityName, ' ', 'updated successfully!');
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