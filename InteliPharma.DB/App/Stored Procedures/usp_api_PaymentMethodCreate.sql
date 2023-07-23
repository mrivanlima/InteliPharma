
CREATE   PROCEDURE App.usp_api_PaymentMethodCreate
	 @PaymentMethodId   TINYINT      NOT NULL,
	 @PaymentMethodName VARCHAR (20) NOT NULL
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_PaymentMethodCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @PaymentMethodName = TRIM(@PaymentMethodName);

	IF EXISTS (SELECT * FROM App.PaymentMethod WHERE PaymentMethodName = @PaymentMethodName)
	BEGIN
		SET @WarningMessage = CONCAT(@PaymentMethodName, ' ', 'already exists!');
		PRINT @WarningMessage;
		SET @PaymentMethodId = (
							SELECT TOP (1) PaymentMethodId 
							FROM App.PaymentMethod 
							WHERE PaymentMethodName = @PaymentMethodName
						);
		RETURN;
	END;
	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.PaymentMethod
			(
				PaymentMethodId,
				PaymentMethodName
			)
			VALUES
			(
				@PaymentMethodId,
				@PaymentMethodName
			)

			SET @PaymentMethodId = SCOPE_IDENTITY();
			PRINT CONCAT(@PaymentMethodName, ' ', 'added successfully!');
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