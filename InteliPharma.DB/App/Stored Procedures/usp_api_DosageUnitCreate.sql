
CREATE   PROCEDURE App.usp_api_DosageUnitCreate
	@DosageUnitId SMALLINT			= NULL OUTPUT,
	@UnitName VARCHAR(40)			= NULL,
	@UnitAbbrev VARCHAR(5)			= NULL
AS
BEGIN
	
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_DosageUnitCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @UnitName = TRIM(@UnitName);

	IF EXISTS (SELECT * FROM App.DosageUnit WHERE UnitName = @UnitName)
	BEGIN
		SET @WarningMessage = CONCAT(@UnitName, ' already exists!');
		PRINT @WarningMessage;
		SET @DosageUnitId = (
							SELECT TOP (1) @DosageUnitId
							FROM App.DosageUnit
							WHERE DosageUnitId = @DosageUnitId
						);
		RETURN;
	END;

	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.DosageUnit
			(
				UnitName,
				UnitAbbrev
			)
			VALUES
			(
				@UnitName,
				@UnitAbbrev
			)

			SET @DosageUnitId = SCOPE_IDENTITY();
			PRINT CONCAT(@UnitName, ' added successfully!');
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