
CREATE   PROCEDURE App.usp_api_MedicationTypeUpdateById
	@MedicationTypeId	TINYINT,
	@MedicationTypeName	VARCHAR(20)
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR (100) = 'usp_api_MedicationTypeUpdateById';
	DECLARE @ErrorMessage			VARCHAR (100) = CONCAT('Error ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR (100);

	SET @MedicationTypeName = TRIM(@MedicationTypeName);

	IF NOT EXISTS (SELECT * FROM App.MedicationType WHERE MedicationTypeId = @MedicationTypeId)
	BEGIN
		SET @ErrorMessage = CONCAT(@MedicationTypeId, ' not found!');
		THROW 50005, @ErrorMessage, 1;
	END

	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			UPDATE m
			SET MedicationTypeName = @MedicationTypeName
			FROM App.MedicationType m
			WHERE MedicationTypeId = @MedicationTypeId

			PRINT CONCAT(@MedicationTypeName, ' updated successfully!');
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