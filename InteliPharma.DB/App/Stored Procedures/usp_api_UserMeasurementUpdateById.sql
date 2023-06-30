
CREATE  PROCEDURE App.usp_api_UserMeasurementUpdateById
	@UserMeasurementId		INT,
	@UserId					INT,
	@MeasurementId			INT,
	@UserMeasurementDate	DATE
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_UserMeasurementUpdateById'
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	IF NOT EXISTS (SELECT * FROM App.UserMeasurement WHERE UserMeasurementId = @UserMeasurementId)
	BEGIN
		SET @ErrorMessage = CONCAT(@UserMeasurementId, ' ', 'not found!');
		THROW 50005, @ErrorMessage, 1;
	END

	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			UPDATE u
				SET UserId = @UserId,
					MeasurementId = @MeasurementId,
					UserMeasurementDate = @UserMeasurementDate
			FROM App.UserMeasurement u
			WHERE UserMeasurementId = @UserMeasurementId

			PRINT CONCAT(@UserMeasurementId, ' ', 'updated sucessfully!');
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

