
CREATE   PROCEDURE App.usp_api_TransporterUpdateById
	@TransporterId		SMALLINT,
	@AddressId			INT,
	@TransporterName	VARCHAR(30),
	@ANTTCode			VARCHAR(20) = NULL,
	@CNPJ				VARCHAR(20) = NULL,
	@StateSubscription  VARCHAR(20) = NULL
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_TransporterUpdateById';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @TransporterName = TRIM(@TransporterName);

	IF NOT EXISTS (SELECT * FROM App.Transporter WHERE TransporterId = @TransporterId)
	BEGIN
		SET @ErrorMessage = CONCAT(@TransporterId, ' ', 'not found!');
		THROW 50005, @ErrorMessage, 1;
	END
	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			UPDATE t
				SET AddressId = @AddressId,
					TransporterName = @TransporterName,
					ANTTCode = @ANTTCode,
					CNPJ = @CNPJ,
					StateSubscription = @StateSubscription	    
			FROM App.Transporter t
			WHERE TransporterId = @TransporterId

			PRINT CONCAT(@TransporterName, ' ', 'updated successfully!');
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