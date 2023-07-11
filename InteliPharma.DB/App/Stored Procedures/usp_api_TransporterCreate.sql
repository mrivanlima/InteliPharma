
CREATE   PROCEDURE App.usp_api_TransporterCreate
	@TransporterId		SMALLINT,
	@AddressId			INT,
	@TransporterName	VARCHAR(30),
	@ANTTCode			VARCHAR(20),
	@CNPJ				VARCHAR(20),
	@StateSubscription  VARCHAR(20)
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_TransporterCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @TransporterName = TRIM(@TransporterName);

	IF EXISTS (SELECT * FROM App.Transporter WHERE TransporterName = @TransporterName)
	BEGIN
		SET @WarningMessage = CONCAT(@TransporterName, ' ', 'already exists!');
		PRINT @WarningMessage;
		SET @TransporterId = (
							SELECT TOP (1) TransporterId
							FROM App.Transporter
							WHERE TransporterName = @TransporterName
						);
		RETURN;
	END;
	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.Transporter
			(
				TransporterId,
				AddressId,
				TransporterName,
				ANTTCode,
				CNPJ,
				StateSubscription
			)
			VALUES
			(
				@TransporterId,
				@AddressId,
				@TransporterName,
				@ANTTCode,
				@CNPJ,
				@StateSubscription
			)

			SET @TransporterId = SCOPE_IDENTITY();
			PRINT CONCAT(@TransporterName, ' ', 'added successfully!');
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