
CREATE   PROCEDURE App.usp_api_DosageUnitUpdateById
	@DosageUnitId SMALLINT			,
	@UnitName VARCHAR(40)			= NULL,
	@UnitAbbrev VARCHAR(5)			= NULL
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR (100) = 'usp_api_DosageUnitUpdateById';
	DECLARE @ErrorMessage			VARCHAR (100) = CONCAT('Error ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR (100);

	SET @UnitName = TRIM(@UnitName);

	IF NOT EXISTS (SELECT * FROM App.DosageUnit WHERE UnitName = @UnitName)
	BEGIN
		SET @ErrorMessage = CONCAT(@DosageUnitId, ' not found!');
		THROW 50005, @ErrorMessage, 1;
	END

	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			UPDATE d
			SET UnitName = @UnitName,
				UnitAbbrev = @UnitAbbrev
			FROM App.DosageUnit d
			WHERE DosageUnitId = @DosageUnitId

			PRINT CONCAT(@UnitName, ' updated successfully!');
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