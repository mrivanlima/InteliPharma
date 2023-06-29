
CREATE   PROCEDURE App.usp_api_ZipCodeUpdateById
	@ZipCodeId		INT,
	@ZipCodeCode	CHAR(8),
	@StreetId		INT,
	@ZipCodeFrom	VARCHAR(50),
	@ZipCodeTo		VARCHAR(50)
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_ZipCodeUpdateById';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @ZipCodeCode = TRIM(@ZipCodeCode);

	IF NOT EXISTS (SELECT * FROM App.ZipCode WHERE ZipCodeId = @ZipCodeId)
	BEGIN
		SET @ErrorMessage = CONCAT(@ZipCodeId, ' ', 'not found!');
		THROW 50005, @ErrorMessage, 1;
	END
	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			UPDATE z
				SET ZipCodeCode = @ZipCodeCode,
					StreetId = @StreetId,
					ZipCodeFrom = @ZipCodeFrom,
					ZipCodeTo = @ZipCodeTo 
			FROM App.ZipCode z
			WHERE ZipCodeId = @ZipCodeId

			PRINT CONCAT(@ZipCodeCode, ' ', 'updated successfully!');
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