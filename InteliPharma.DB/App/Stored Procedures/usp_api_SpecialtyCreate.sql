
CREATE   PROCEDURE App.usp_api_SpecialtyCreate
	@SpecialtyId   SMALLINT		NOT NULL,     
    @SpecialtyName VARCHAR (50) NULL
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_SpecialtyCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @SpecialtyName = TRIM(@SpecialtyName);

	IF EXISTS (SELECT * FROM App.Specialty WHERE SpecialtyName = @SpecialtyName)
	BEGIN
		SET @WarningMessage = CONCAT(@SpecialtyName, ' ', 'already exists!');
		PRINT @WarningMessage;
		SET @SpecialtyId = (
							SELECT TOP (1) SpecialtyId 
							FROM App.Specialty 
							WHERE SpecialtyName = @SpecialtyName
						);
		RETURN;
	END;
	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.Specialty
			(
				SpecialtyId,
				SpecialtyName
			)
			VALUES
			(
				@SpecialtyId,
				@SpecialtyName
			)

			SET @SpecialtyId = SCOPE_IDENTITY();
			PRINT CONCAT(@SpecialtyName, ' ', 'added successfully!');
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