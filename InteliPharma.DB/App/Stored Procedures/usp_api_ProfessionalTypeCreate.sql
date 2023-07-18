
CREATE   PROCEDURE App.usp_api_ProfessionalTypeCreate
	@ProfessionalTypeId   TINYINT      NOT NULL,
    @ProfessionalTypeName VARCHAR (50) NULL
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_ProfessionalTypeCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @ProfessionalTypeName = TRIM(@ProfessionalTypeName);

	IF EXISTS (SELECT * FROM App.ProfessionalType WHERE ProfessionalTypeName = @ProfessionalTypeName)
	BEGIN
		SET @WarningMessage = CONCAT(@ProfessionalTypeName, ' ', 'already exists!');
		PRINT @WarningMessage;
		SET @ProfessionalTypeId = (
							SELECT TOP (1) ProfessionalTypeId 
							FROM App.ProfessionalType 
							WHERE ProfessionalTypeName = @ProfessionalTypeName
						);
		RETURN;
	END;
	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.ProfessionalType
			(
				ProfessionalTypeId,
				ProfessionalTypeName
			)
			VALUES
			(
				@ProfessionalTypeId,
				@ProfessionalTypeName
			)

			SET @ProfessionalTypeId = SCOPE_IDENTITY();
			PRINT CONCAT(@ProfessionalTypeName, ' ', 'added successfully!');
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