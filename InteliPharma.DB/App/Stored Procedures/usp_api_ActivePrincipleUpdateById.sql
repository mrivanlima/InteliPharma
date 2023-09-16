
CREATE   PROCEDURE App.usp_api_ActivePrincipleUpdateById
	@ActivePrincipleId INT,
	@ActivePrincipleName VARCHAR(400),
	@ActivePrincipleASCII VARCHAR(400)
AS
BEGIN
	
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_ActivePrincipleUpdateById';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @ActivePrincipleName = TRIM(@ActivePrincipleName);

	IF NOT EXISTS (SELECT * FROM App.ActivePrinciple WHERE ActivePrincipleId = @ActivePrincipleId)
	BEGIN
		SET @ErrorMessage = CONCAT(@ActivePrincipleId, ' ', 'not found!');
		THROW 50005, @ErrorMessage, 1;
	END

	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			UPDATE ap
				SET ActivePrincipleName = @ActivePrincipleName,
					ActivePrincipleNameASCII = @ActivePrincipleASCII
			FROM App.ActivePrinciple ap
			WHERE ActivePrincipleId = @ActivePrincipleId

			PRINT CONCAT(@ActivePrincipleName, ' ', 'updated successfully!');
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
