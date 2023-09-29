
CREATE   PROCEDURE App.usp_api_MeasurementCreate
	@MeasurementId	INT					= NULL OUTPUT,
	@MeasurementName	VARCHAR(50)		= NULL,
	@Error		BIT = 0 OUTPUT
AS
BEGIN
	
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_MeasurementCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @MeasurementName = TRIM(@MeasurementName);

	IF EXISTS (SELECT * FROM App.Measurement WHERE MeasurementName = @MeasurementName)
	BEGIN
		SET @WarningMessage = CONCAT(@MeasurementName, ' already exists!');
		PRINT @WarningMessage;
		SET @MeasurementId = (
							SELECT TOP (1) @MeasurementId
							FROM App.Measurement
							WHERE MeasurementName = @MeasurementName
						);
		RETURN;
	END;

	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.Measurement
			(
				MeasurementId,
				MeasurementName
			)
			VALUES
			(
				@MeasurementId,
				@MeasurementName
			)

			SET @MeasurementId = SCOPE_IDENTITY();
			PRINT CONCAT(@MeasurementName, ' added successfully!');
		COMMIT TRANSACTION @StoredProcedureName;
	END TRY

	BEGIN CATCH

		IF @@TRANCOUNT > 0
		BEGIN
			ROLLBACK TRANSACTION @StoredProcedureName;
		END;

		SET @Error = 1;

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
END