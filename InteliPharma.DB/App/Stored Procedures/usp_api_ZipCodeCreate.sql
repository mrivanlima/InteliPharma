CREATE PROCEDURE App.usp_api_ZipCodeCreate
	@ZipCodeId		INT,
	@ZipCodeCode	CHAR(8),
	@StreetId		INT,
	@ZipCodeFrom	VARCHAR(50),
	@ZipCodeTo		VARCHAR(50)
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_ZipCodeCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @ZipCodeCode= TRIM(@ZipCodeCode);

	IF EXISTS (SELECT * FROM App.ZipCode WHERE ZipCodeCode = @ZipCodeCode)
	BEGIN 
		SET @WarningMessage = CONCAT(@ZipCodeCode, ' ', 'already exists!');
		PRINT @WarningMessage;
		SET @ZipCodeId = (
							SELECT 	TOP (1)	@ZipCodeId
							FROM App.ZipCode
							WHERE ZipCodeCode = @ZipCodeCode
						 );
		RETURN;
	END;

	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.ZipCode
			(
				ZipCodeId,
				ZipCodeCode,
				StreetId,
				ZipCodeFrom,
				ZipCodeTo
			)
			VALUES
			(
				@ZipCodeId,
				@ZipCodeCode,
				@StreetId,
				@ZipCodeFrom,
				@ZipCodeTo
			)

			SET @ZipCodeId = SCOPE_IDENTITY();
			PRINT CONCAT(@ZipCodeCode, ' ', 'added successfully!');
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

