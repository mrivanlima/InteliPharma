
CREATE   PROCEDURE App.usp_api_ManufacturerUpdateById
	@ManufacturerId SMALLINT					NOT NULL,
	@ManufacturerName VARCHAR (100)				NOT NULL,
	@ManufacturerPhoneNumber VARCHAR(13)		NULL
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR (100) = 'usp_api_ManufacturerUpdateById';
	DECLARE @ErrorMessage			VARCHAR (100) = CONCAT('Error ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR (100);

	SET @ManufacturerName = TRIM(@ManufacturerName);

	IF NOT EXISTS (SELECT * FROM App.Manufacturer WHERE ManufacturerId = @ManufacturerId)
	BEGIN
		SET @ErrorMessage = CONCAT(@ManufacturerId, ' not found!');
		THROW 50005, @ErrorMessage, 1;
	END

	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			UPDATE m
			SET ManufacturerName = @ManufacturerName,
				ManufacturerPhoneNumber = @ManufacturerPhoneNumber
			FROM App.Manufacturer m
			WHERE ManufacturerId = @ManufacturerId

			PRINT CONCAT(@ManufacturerName, ' updated successfully!');
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