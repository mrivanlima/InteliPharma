
CREATE   PROCEDURE App.usp_api_IndicationCreate
	@IndicationId INT						NOT NULL,
	@IndicationDescription VARCHAR(100)		NOT NULL
AS
BEGIN
	
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_IndicationCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @IndicationId = TRIM(@IndicationId);

	IF EXISTS (SELECT * FROM App.Indication WHERE IndicationDescription = @IndicationDescription)
	BEGIN
		SET @WarningMessage = CONCAT(@IndicationDescription, ' already exists!');
		PRINT @WarningMessage;
		SET @IndicationId = (
							SELECT TOP (1) @IndicationId
							FROM App.Indication
							WHERE IndicationDescription = @IndicationId
						);
		RETURN;
	END;

	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.Indication
			(
				IndicationId,
				IndicationDescription
			)
			VALUES
			(
				@IndicationId,
				@IndicationDescription
			)

			SET @IndicationId = SCOPE_IDENTITY();
			PRINT CONCAT(@IndicationDescription, ' added successfully!');
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