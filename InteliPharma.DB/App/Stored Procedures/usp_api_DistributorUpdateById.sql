
CREATE   PROCEDURE App.usp_api_DistributorUpdateById
	@DistributorId	INT,
	@DistributorName	VARCHAR(500),
	@AddressId	INT,
	@CNPJ	VARCHAR(30)					= NULL,
	@StateSubscription	VARCHAR(50)		= NULL
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR (100) = 'usp_api_DistributorUpdateById';
	DECLARE @ErrorMessage			VARCHAR (100) = CONCAT('Error ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR (100);

	SET @DistributorName = TRIM(@DistributorName);

	IF NOT EXISTS (SELECT * FROM App.Distributor WHERE DistributorId = @DistributorId)
	BEGIN
		SET @ErrorMessage = CONCAT(@DistributorId, ' not found!');
		THROW 50005, @ErrorMessage, 1;
	END

	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			UPDATE d
			SET DistributorName = @DistributorName,
				AddressId = @AddressId,
				CNPJ = @CNPJ,
				StateSubscription = @StateSubscription
			FROM App.Distributor d
			WHERE DistributorId = @DistributorId

			PRINT CONCAT(@DistributorName, ' updated successfully!');
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