
CREATE   PROCEDURE App.usp_api_StoreCreate
	@StoreId		INT,
    @StoreName		VARCHAR (200) NOT NULL,
    @AddressId		INT           NOT NULL
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_StoreCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @StoreName = TRIM(@StoreName);

	IF EXISTS (SELECT * FROM App.Store WHERE StoreName = @StoreName)
	BEGIN
		SET @WarningMessage = CONCAT(@StoreName, ' ', 'already exists!');
		PRINT @WarningMessage;
		SET @StoreId = (
							SELECT TOP (1) StoreId 
							FROM App.Store 
							WHERE StoreName = @StoreName
						);
		RETURN;
	END;
	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.Store
			(
				StoreId,
				StoreName,
				AddressId
			)
			VALUES
			(
				@StoreId,
				@StoreName,
				@AddressId
			)

			SET @StoreId = SCOPE_IDENTITY();
			PRINT CONCAT(@StoreName, ' ', 'added successfully!');
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