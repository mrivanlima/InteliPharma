CREATE   PROCEDURE usp_api_ActivePrincipleCreate
	@ActivePrincipleId INT = NULL OUTPUT,
	@ActivePrincipleName VARCHAR(400),
	@ActivePrincipleASCII VARCHAR(400)
AS
BEGIN
	
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_ActivePrincipleCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @ActivePrincipleName = TRIM(@ActivePrincipleName);

	IF EXISTS (SELECT * FROM App.ActivePrinciple WHERE ActivePrincipleName = @ActivePrincipleName)
	BEGIN
		SET @WarningMessage = CONCAT(@ActivePrincipleName, ' ', 'already exists!');
		PRINT @WarningMessage;
		SET @ActivePrincipleId = (
										SELECT TOP (1) ActivePrincipleId
										FROM App.ActivePrinciple
										WHERE ActivePrincipleId = @ActivePrincipleId
									);
		RETURN;
	END;

	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.ActivePrinciple
			(
				ActivePrincipleName,
				[ActivePrincipleNameASCII]
			)
			VALUES
			(
				@ActivePrincipleName,
				@ActivePrincipleName
			)

		SET @ActivePrincipleId = SCOPE_IDENTITY();
		PRINT CONCAT(@ActivePrincipleName, ' ', 'added successfully!');
		COMMIT TRANSACTION @StoredProcedureName;
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
		BEGIN
			ROLLBACK TRANSACTION @StoredProcedureName;
		END

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