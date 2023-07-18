
CREATE   PROCEDURE App.usp_api_ProfessionalTypeUpdateById
	@ProfessionalTypeId   TINYINT      NOT NULL,
    @ProfessionalTypeName VARCHAR (50) NULL
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_ProfessionalTypeUpdateById';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @ProfessionalTypeName = TRIM(@ProfessionalTypeName);

	IF NOT EXISTS (SELECT * FROM App.ProfessionalType WHERE ProfessionalTypeId = @ProfessionalTypeId)
	BEGIN
		SET @ErrorMessage = CONCAT(@ProfessionalTypeId, ' ', 'not found!');
		THROW 50005, @ErrorMessage, 1;
	END
	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			UPDATE p
				SET ProfessionalTypeName = @ProfessionalTypeName
			FROM App.ProfessionalType p 
			WHERE ProfessionalTypeId = @ProfessionalTypeId

			PRINT CONCAT(@ProfessionalTypeName, ' ', 'updated successfully!');
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