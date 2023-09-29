
CREATE   PROCEDURE App.usp_api_DosageCreate
	@DosageId	INT					= NULL OUTPUT,
	@DosageValue	VARCHAR(100),
	@Error		BIT = 0 OUTPUT
AS
BEGIN
	
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_DosageCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @DosageValue = TRIM(@DosageValue);

	IF EXISTS (SELECT * FROM App.Dosage WHERE DosageId = @DosageValue)
	BEGIN
		SET @WarningMessage = CONCAT(@DosageValue, ' already exists!');
		PRINT @WarningMessage;
		SET @DosageId = (
							SELECT TOP (1) @DosageId
							FROM App.Dosage
							WHERE DosageValue = @DosageValue
						);
		RETURN;
	END;

	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.Dosage
			(
				DosageValue
			)
			VALUES
			(
				@DosageValue
			)

			SET @DosageId = SCOPE_IDENTITY();
			PRINT CONCAT(@DosageValue, ' added successfully!');
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