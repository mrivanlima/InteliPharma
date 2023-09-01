
CREATE   PROCEDURE App.usp_api_LaboratoryUpdateById
	@LaboratoryId INT					NOT NULL,
	@LaboratoryName VARCHAR(500)		NOT NULL,
	@LaboratoryNameASCII VARCHAR(500)	NOT NULL,
	@AddressId INT						NULL,
	@CNPJ VARCHAR(30)					NULL,
	@StateSubscription VARCHAR(50)		NULL
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR (100) = 'usp_api_LaboratoryUpdateById';
	DECLARE @ErrorMessage			VARCHAR (100) = CONCAT('Error ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR (100);

	SET @LaboratoryName = TRIM(@LaboratoryName);

	IF NOT EXISTS (SELECT * FROM App.Laboratory WHERE LaboratoryId = @LaboratoryId)
	BEGIN
		SET @ErrorMessage = CONCAT(@LaboratoryId, ' not found!');
		THROW 50005, @ErrorMessage, 1;
	END

	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			UPDATE l
			SET LaboratoryName = @LaboratoryName,
				LaboratoryNameASCII = @LaboratoryNameASCII,
				AddressId = @AddressId,
				CNPJ = @CNPJ,
				StateSubscription = @StateSubscription
			FROM App.Laboratory l
			WHERE LaboratoryId = @LaboratoryId

			PRINT CONCAT(@LaboratoryName, ' updated successfully!');
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