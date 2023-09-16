
CREATE   PROCEDURE App.usp_api_MedicationTypeCreate
	@MedicationTypeId	TINYINT			= NULL OUTPUT,
	@MedicationTypeName	VARCHAR(20)
AS
BEGIN
	
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_MedicationTypeCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @MedicationTypeName = TRIM(@MedicationTypeName);

	IF EXISTS (SELECT * FROM App.MedicationType WHERE MedicationTypeName = @MedicationTypeName)
	BEGIN
		SET @WarningMessage = CONCAT(@MedicationTypeName, ' already exists!');
		PRINT @WarningMessage;
		SET @MedicationTypeId = (
							SELECT TOP (1) @MedicationTypeId
							FROM App.MedicationType
							WHERE MedicationTypeName = @MedicationTypeName
						);
		RETURN;
	END;

	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.MedicationType
			(
				MedicationTypeId,
				MedicationTypeName
			)
			VALUES
			(
				@MedicationTypeId,
				@MedicationTypeName
			)

			SET @MedicationTypeId = SCOPE_IDENTITY();
			PRINT CONCAT(@MedicationTypeName, ' added successfully!');
		COMMIT TRANSACTION @StoredProcedureName;
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
END