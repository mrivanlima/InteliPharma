
CREATE   PROCEDURE App.usp_api_ManufacturerCreate
	@ManufacturerId	SMALLINT					= NULL OUTPUT,
	@ManufacturerName	VARCHAR(100),
	@ManufacturerPhoneNumber	VARCHAR(13)		= NULL,
	@Error		BIT = 0 OUTPUT
AS
BEGIN
	
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_MeanufacturerCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @ManufacturerName = TRIM(@ManufacturerName);

	IF EXISTS (SELECT * FROM App.Manufacturer WHERE ManufacturerName = @ManufacturerName)
	BEGIN
		SET @WarningMessage = CONCAT(@ManufacturerName, ' already exists!');
		PRINT @WarningMessage;
		SET @ManufacturerId = (
							SELECT TOP (1) @ManufacturerId
							FROM App.Manufacturer
							WHERE ManufacturerName = @ManufacturerName
						);
		RETURN;
	END;

	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.Manufacturer
			(
				ManufacturerName,
				ManufacturerPhoneNumber
			)
			VALUES
			(
				@ManufacturerName,
				@ManufacturerPhoneNumber
			)

			SET @ManufacturerId = SCOPE_IDENTITY();
			PRINT CONCAT(@ManufacturerName, ' added successfully!');
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