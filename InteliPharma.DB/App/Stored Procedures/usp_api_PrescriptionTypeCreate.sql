
CREATE   PROCEDURE App.usp_api_PrescriptionTypeCreate
	@PrescriptionTypeId   TINYINT      NOT NULL,
    @PrescriptionTypeName VARCHAR (20) NOT NULL
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_PrescriptionTypeCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @PrescriptionTypeName = TRIM(@PrescriptionTypeName);

	IF EXISTS (SELECT * FROM App.PrescriptionType WHERE PrescriptionTypeName = @PrescriptionTypeName)
	BEGIN
		SET @WarningMessage = CONCAT(@PrescriptionTypeName, ' ', 'already exists!');
		PRINT @WarningMessage;
		SET @PrescriptionTypeId = (
							SELECT TOP (1) PrescriptionTypeId 
							FROM App.PrescriptionType 
							WHERE PrescriptionTypeName = @PrescriptionTypeName
						);
		RETURN;
	END;
	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.PrescriptionType
			(
				PrescriptionTypeId,
				PrescriptionTypeName
			)
			VALUES
			(
				@PrescriptionTypeId,
				@PrescriptionTypeName
			)

			SET @PrescriptionTypeId = SCOPE_IDENTITY();
			PRINT CONCAT(@PrescriptionTypeName, ' ', 'added successfully!');
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