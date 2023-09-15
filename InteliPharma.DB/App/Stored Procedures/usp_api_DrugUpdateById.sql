
CREATE   PROCEDURE App.usp_api_DrugUpdateById
	@DrugId	INT,
	@DrugName	VARCHAR(50)
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR (100) = 'usp_api_DrugUpdateById';
	DECLARE @ErrorMessage			VARCHAR (100) = CONCAT('Error ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR (100);

	SET @DrugName = TRIM(@DrugName);

	IF NOT EXISTS (SELECT * FROM App.Drug WHERE DrugName = @DrugName)
	BEGIN
		SET @ErrorMessage = CONCAT(@DrugId, ' not found!');
		THROW 50005, @ErrorMessage, 1;
	END

	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			UPDATE d
			SET DrugName = @DrugName
			FROM App.Drug d
			WHERE DrugId = @DrugId

			PRINT CONCAT(@DrugName, ' updated successfully!');
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