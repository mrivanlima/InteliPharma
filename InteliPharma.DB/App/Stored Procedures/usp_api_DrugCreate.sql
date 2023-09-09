
CREATE   PROCEDURE App.usp_api_DrugCreate
	@DrugId INT					= NULL OUTPUT,
	@DrugName VARCHAR(50)		= NULL
AS
BEGIN
	
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_DrugCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @DrugName = TRIM(@DrugName);

	IF EXISTS (SELECT * FROM App.Drug WHERE DrugId = @DrugName)
	BEGIN
		SET @WarningMessage = CONCAT(@DrugName, ' already exists!');
		PRINT @WarningMessage;
		SET @DrugId = (
							SELECT TOP (1) @DrugId
							FROM App.Drug
							WHERE DrugId = @DrugName
						);
		RETURN;
	END;

	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.Drug
			(
				DrugName
			)
			VALUES
			(
				@DrugName
			)

			SET @DrugId = SCOPE_IDENTITY();
			PRINT CONCAT(@DrugName, ' added successfully!');
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