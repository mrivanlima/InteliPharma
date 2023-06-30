
CREATE   PROCEDURE App.usp_api_UserMeasurementCreate
	@UserMeasurementId		INT,
	@UserId					INT,
	@MeasurememntId			INT,
	@UserMeasurementDate	DATE
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_UserMeasurementCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	BEGIN TRY 
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.UserMeasurement
			(
				UserId,
				MeasurementId,
				UserMeasurementDate
			)
			VALUES
			(
				@UserId,
				@MeasurememntId,
				@UserMeasurementDate
			)

			SET @UserMeasurementId = SCOPE_IDENTITY();
			PRINT CONCAT(@UserMeasurementId, ' ', 'added sucessfully!');
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

