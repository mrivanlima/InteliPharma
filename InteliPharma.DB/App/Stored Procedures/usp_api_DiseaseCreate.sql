
CREATE   PROCEDURE App.usp_api_DiseaseCreate
	@DiseaseId INT					= NULL OUTPUT,
	@DieseaseName VARCHAR(50)		= NULL
AS
BEGIN
	
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_DiseaseCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @DieseaseName = TRIM(@DieseaseName);

	IF EXISTS (SELECT * FROM App.Disease WHERE DieseaseName = @DieseaseName)
	BEGIN
		SET @WarningMessage = CONCAT(@DieseaseName, ' already exists!');
		PRINT @WarningMessage;
		SET @DiseaseId = (
							SELECT TOP (1) @DiseaseId
							FROM App.Disease
							WHERE DieseaseName = @DieseaseName
						);
		RETURN;
	END;

	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.Disease
			(
				DieseaseName
			)
			VALUES
			(
				@DieseaseName
			)

			SET @DiseaseId = SCOPE_IDENTITY();
			PRINT CONCAT(@DieseaseName, ' added successfully!');
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