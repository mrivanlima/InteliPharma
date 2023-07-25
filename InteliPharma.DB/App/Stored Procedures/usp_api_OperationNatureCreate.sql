
CREATE   PROCEDURE App.usp_api_OperationNatureCreate
	@OperationNatureId   SMALLINT      NOT NULL,
    @OperationNatureName VARCHAR (200) NOT NULL
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_OperationNatureCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @OperationNatureName = TRIM(@OperationNatureName);

	IF EXISTS (SELECT * FROM App.OperationNature WHERE OperationNatureName = @OperationNatureName)
	BEGIN
		SET @WarningMessage = CONCAT(@OperationNatureName, ' ', 'already exists!');
		PRINT @WarningMessage;
		SET @OperationNatureId = (
							SELECT TOP (1) OperationNatureId 
							FROM App.OperationNature 
							WHERE OperationNatureName = @OperationNatureName
						);
		RETURN;
	END;
	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.OperationNature
			(
				OperationNatureId,
				OperationNatureName
			)
			VALUES
			(
				@OperationNatureId,
				@OperationNatureName
			)

			SET @OperationNatureId = SCOPE_IDENTITY();
			PRINT CONCAT(@OperationNatureName, ' ', 'added successfully!');
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