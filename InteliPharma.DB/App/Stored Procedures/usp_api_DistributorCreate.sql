
CREATE   PROCEDURE App.usp_api_DistributorCreate
	@DistributorId INT					= NULL OUTPUT,
	@DistributorName VARCHAR(500)		NOT NULL,
	@AddressId INT						NOT NULL,
	@CNPJ VARCHAR(30)					= NULL,
	@StateSubscription VARCHAR(50)		= NULL
AS
BEGIN
	
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_DistributorCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @DistributorName = TRIM(@DistributorId);

	IF EXISTS (SELECT * FROM App.Distributor WHERE DistributorName = @DistributorName)
	BEGIN
		SET @WarningMessage = CONCAT(@DistributorName, ' already exists!');
		PRINT @WarningMessage;
		SET @DistributorId = (
							SELECT TOP (1) @DistributorId
							FROM App.Distributor
							WHERE DistributorName = @DistributorName
						);
		RETURN;
	END;

	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.Distributor
			(
				DistributorName,
				AddressId,
				CNPJ,
				StateSubscription
			)
			VALUES
			(
				@DistributorName,
				@AddressId,
				@CNPJ,
				@StateSubscription
			)

			SET @DistributorId = SCOPE_IDENTITY();
			PRINT CONCAT(@DistributorName, ' added successfully!');
		COMMIT TRANSACTION @StoredProcedureName;
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