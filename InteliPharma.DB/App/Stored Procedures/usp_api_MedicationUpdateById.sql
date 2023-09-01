
CREATE   PROCEDURE App.usp_api_MedicationUpdateById
	@MedicationId INT					NOT NULL,
	@DrugId INT							NOT NULL,
	@ClassificationId TINYINT			NOT NULL,
	@ManufacturerId SMALLINT			NOT NULL,
	@MedicationTypeId TINYINT			NOT NULL,
	@AgeUsageId INT						NOT NULL,
	@PharmaceuticalAdministrationId INT	NOT NULL,
	@PharmaceuticalFormId INT			NOT NULL,
	@ActivePrincipleId INT				NOT NULL,
	@IndicationId INT					NOT NULL,
	@AgeUsageDescription VARCHAR(100)	NULL,
	@Threshold VARCHAR(100)				NULL
AS
BEGIN


	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR (100) = 'usp_api_MedicationUpdateById';
	DECLARE @ErrorMessage			VARCHAR (100) = CONCAT('Error ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR (100);

	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			UPDATE m
			SET	MedicationId = @MedicationId,
				DrugId = @DrugId,
				ClassificationId = @ClassificationId,
				ManufacturerId = @ManufacturerId,
				MedicationTypeId = @MedicationTypeId,
				AgeUsageId = @AgeUsageId,
				PharmaceuticalAdministrationId = @PharmaceuticalAdministrationId,
				PharmaceuticalFormId = @PharmaceuticalFormId,
				ActivePrincipleId = @ActivePrincipleId,
				IndicationId = @IndicationId,
				AgeUsageDescription = @AgeUsageDescription,
				Threshold = @Threshold
			FROM App.Medication m
			WHERE MedicationId = @MedicationId

			PRINT CONCAT(@MedicationId, ' updated successfully!');
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