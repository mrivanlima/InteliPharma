
CREATE   PROCEDURE App.usp_api_PrescriptionCreate
	@PrescriptionId   BIGINT NOT NULL,
    @ProfessionalId   INT    NOT NULL,
    @PatientId        INT    NOT NULL,
    @PrescriptionDate DATE   NOT NULL
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_PrescriptionCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	
	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.Prescription
			(
				PrescriptionId,
				ProfessionalId,
				PatientId,
				PrescriptionDate
			)
			VALUES
			(
				@PrescriptionId,
				@ProfessionalId,
				@PatientId,
				@PrescriptionDate
			)

			SET @PrescriptionId = SCOPE_IDENTITY();
			PRINT CONCAT(@PrescriptionId, ' ', 'added successfully!');
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