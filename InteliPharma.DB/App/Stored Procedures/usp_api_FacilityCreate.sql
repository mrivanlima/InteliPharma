
CREATE   PROCEDURE App.usp_api_FacilityCreate
	@FacilityId	INT					= NULL OUTPUT,
	@FacilityName	VARCHAR(100)	= NULL,
	@AddressId	INT					= NULL,
	@Error		BIT = 0 OUTPUT
AS
BEGIN
	
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_FacilityCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @FacilityName = TRIM(@FacilityName);

	IF EXISTS (SELECT * FROM App.Facility WHERE FacilityName = @FacilityName)
	BEGIN
		SET @WarningMessage = CONCAT(@FacilityName, ' already exists!');
		PRINT @WarningMessage;
		SET @FacilityId = (
							SELECT TOP (1) @FacilityId
							FROM App.Facility
							WHERE FacilityName = @FacilityName
						);
		RETURN;
	END;

	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.Facility
			(
				FacilityName,
				AddressId
			)
			VALUES
			(
				@FacilityName,
				@AddressId
			)

			SET @FacilityId = SCOPE_IDENTITY();
			PRINT CONCAT(@FacilityName, ' added successfully!');
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