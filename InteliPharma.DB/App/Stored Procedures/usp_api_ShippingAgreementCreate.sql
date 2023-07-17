
CREATE   PROCEDURE App.usp_api_ShippingAgreementCreate
	@ShippingAgreementId TINYINT      NOT NULL,
    @ShippingName        VARCHAR (30) NOT NULL
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_ShippingAgreementCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @ShippingName = TRIM(@ShippingName);

	IF EXISTS (SELECT * FROM App.ShippingAgreement WHERE ShippingName = @ShippingName)
	BEGIN
		SET @WarningMessage = CONCAT(@ShippingName, ' ', 'already exists!');
		PRINT @WarningMessage;
		SET @ShippingAgreementId = (
							SELECT TOP (1) ShippingAgreementId 
							FROM App.ShippingAgreement 
							WHERE ShippingName = @ShippingName
						);
		RETURN;
	END;
	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.ShippingAgreement
			(
				ShippingAgreementId,
				ShippingName
			)
			VALUES
			(
				@ShippingAgreementId,
				@ShippingName
			)

			SET @ShippingAgreementId = SCOPE_IDENTITY();
			PRINT CONCAT(@ShippingName, ' ', 'added successfully!');
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