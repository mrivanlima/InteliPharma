
CREATE   PROCEDURE App.usp_api_FacilityUpdateById
	@FacilityId	INT,
	@FacilityName	VARCHAR(100)	= NULL,
	@AddressId	INT					= NULL
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR (100) = 'usp_api_FacilityUpdateById';
	DECLARE @ErrorMessage			VARCHAR (100) = CONCAT('Error ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR (100);

	SET @FacilityName = TRIM(@FacilityName);

	IF NOT EXISTS (SELECT * FROM App.Facility WHERE FacilityName = @FacilityName)
	BEGIN
		SET @ErrorMessage = CONCAT(@FacilityId, ' not found!');
		THROW 50005, @ErrorMessage, 1;
	END

	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			UPDATE f
			SET FacilityName = @FacilityName,
				AddressId = @AddressId
			FROM App.Facility f
			WHERE FacilityId = @FacilityId

			PRINT CONCAT(@FacilityName, ' updated successfully!');
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