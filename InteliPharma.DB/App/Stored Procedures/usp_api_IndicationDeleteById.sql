
CREATE   PROCEDURE App.usp_api_IndicationDeleteById
	@IndicationId	INT
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_IndicationDeleteById';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);


	IF NOT EXISTS (SELECT * FROM App.Indication WHERE IndicationId = @IndicationId)
	BEGIN
		SET @ErrorMessage = CONCAT(@IndicationId, ' not found!');
		THROW 50005, @ErrorMessage, 1;
	END

	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			DELETE i
			FROM App.Indication i
			WHERE IndicationId = @IndicationId

			PRINT CONCAT(@IndicationId, ' Deleted successfully!');
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
END
