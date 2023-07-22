
CREATE   PROCEDURE App.usp_api_PrescriptionTypeUpdateById
	@PrescriptionTypeId   TINYINT      NOT NULL,
    @PrescriptionTypeName VARCHAR (20) NOT NULL
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_PrescriptionTypeUpdateById';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @PrescriptionTypeName = TRIM(@PrescriptionTypeName);

	IF NOT EXISTS (SELECT * FROM App.PrescriptionType WHERE PrescriptionTypeId = @PrescriptionTypeId)
	BEGIN
		SET @ErrorMessage = CONCAT(@PrescriptionTypeId, ' ', 'not found!');
		THROW 50005, @ErrorMessage, 1;
	END
	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			UPDATE p
				SET PrescriptionTypeName = @PrescriptionTypeName
			FROM App.PrescriptionType p 
			WHERE PrescriptionTypeId = @PrescriptionTypeId

			PRINT CONCAT(@PrescriptionTypeName, ' ', 'updated successfully!');
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