
CREATE   PROCEDURE App.usp_api_LaboratoryCreate
	@LaboratoryId	INT						= NULL OUTPUT,
	@LaboratoryName	VARCHAR(500),
	@LaboratoryNameASCII	VARCHAR(500),
	@AddressId	INT							= NULL,
	@CNPJ	VARCHAR(30)						= NULL,
	@StateSubscription	VARCHAR(50)			= NULL
AS
BEGIN
	
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_LaboratoryCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @LaboratoryName = TRIM(@LaboratoryName);

	IF EXISTS (SELECT * FROM App.Laboratory WHERE LaboratoryName = @LaboratoryName)
	BEGIN
		SET @WarningMessage = CONCAT(@LaboratoryName, ' already exists!');
		PRINT @WarningMessage;
		SET @LaboratoryId = (
							SELECT TOP (1) @LaboratoryId
							FROM App.Laboratory
							WHERE LaboratoryName = @LaboratoryName
						);
		RETURN;
	END;

	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.Laboratory
			(
				LaboratoryName,
				LaboratoryNameASCII,
				AddressId,
				CNPJ,
				StateSubscription
			)
			VALUES
			(
				@LaboratoryName,
				@LaboratoryNameASCII,
				@AddressId,
				@CNPJ,
				@StateSubscription
			)

			SET @LaboratoryId = SCOPE_IDENTITY();
			PRINT CONCAT(@LaboratoryName, ' added successfully!');
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