
CREATE   PROCEDURE App.usp_api_FacilityContactCreate
	@FacilityContactId	BIGINT	= NULL OUTPUT,
	@FacilityId	INT,
	@ContactId	BIGINT			= NULL
AS
BEGIN
	
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_FacilityContactCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	IF EXISTS (
	           SELECT * 
	           FROM app.FaciltiyContact 
			   WHERE FacilityId = @FacilityId
			   AND ContactId = @ContactId)
	BEGIN
		SET @WarningMessage = 'FacilityContact already exists!';
		PRINT @WarningMessage;
		SET @FacilityContactId = (
							SELECT TOP 1 FaciltiyContactId
						    FROM app.FaciltiyContact
						    WHERE FacilityId = @FacilityId
							AND ContactId = @ContactId
						);
		RETURN;
	END;

	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.FaciltiyContact
			(
				FacilityId,
				ContactId
			)
			VALUES
			(
				@FacilityId,
				@ContactId
			)

			SET @FacilityContactId = SCOPE_IDENTITY();
			PRINT CONCAT(@FacilityContactId, ' added successfully!');
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