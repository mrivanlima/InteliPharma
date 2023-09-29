
CREATE   PROCEDURE App.usp_api_DiseaseCreate
	@DiseaseId	INT				= NULL OUTPUT,
	@DiseaseName	VARCHAR(50)	= NULL,
	@Error		BIT = 0 OUTPUT
AS
BEGIN
	
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_DiseaseCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @DiseaseName = TRIM(@DiseaseName);

	IF EXISTS (SELECT * FROM App.Disease WHERE DiseaseName = @DiseaseName)
	BEGIN
		SET @WarningMessage = CONCAT(@DiseaseName, ' already exists!');
		PRINT @WarningMessage;
		SET @DiseaseId = (
							SELECT TOP (1) @DiseaseId
							FROM App.Disease
							WHERE DiseaseName = @DiseaseName
						);
		RETURN;
	END;

	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.Disease
			(
				DiseaseName
			)
			VALUES
			(
				@DiseaseName
			)

			SET @DiseaseId = SCOPE_IDENTITY();
			PRINT CONCAT(@DiseaseName, ' added successfully!');
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