
CREATE   PROCEDURE App.usp_api_MedicationCreate
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

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_MedicationCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	IF EXISTS (
	           SELECT * 
	           FROM app.Medication 
			   WHERE DrugId = @DrugId 
			   AND ClassificationId = @ClassificationId 
			   AND ManufacturerId = @ManufacturerId
			   AND MedicationTypeId = @MedicationTypeId
			   AND AgeUsageId = @AgeUsageId
			   AND PharmaceuticalAdministrationId = @PharmaceuticalAdministrationId
			   AND PharmaceuticalFormId = @PharmaceuticalFormId
			   AND ActivePrincipleId = @ActivePrincipleId
			   AND IndicationId = @IndicationId)
	BEGIN
		SET @WarningMessage = 'Medication already exists!';
		PRINT @WarningMessage;
		SET @MedicationId = (
							SELECT TOP 1 MedicationId
						    FROM app.Medication
						    WHERE DrugId = @DrugId 
							AND ClassificationId = @ClassificationId 
							AND ManufacturerId = @ManufacturerId
							AND MedicationTypeId = @MedicationTypeId
							AND AgeUsageId = @AgeUsageId
							AND PharmaceuticalAdministrationId = @PharmaceuticalAdministrationId
							AND PharmaceuticalFormId = @PharmaceuticalFormId
							AND ActivePrincipleId = @ActivePrincipleId
							AND IndicationId = @IndicationId
						);
		RETURN;
	END;

	BEGIN TRY 
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.Medication
			(
				DrugId,
				ClassificationId,
				ManufacturerId,
				MedicationTypeId,
				AgeUsageId,
				PharmaceuticalAdministrationId,
				PharmaceuticalFormId,
				ActivePrincipleId,
				IndicationId,
				AgeUsageDescription,
				Threshold
			)
			VALUES
			(
				@DrugId,
				@ClassificationId,
				@ManufacturerId,
				@MedicationTypeId,
				@AgeUsageId,
				@PharmaceuticalAdministrationId,
				@PharmaceuticalFormId,
				@ActivePrincipleId,
				@IndicationId,
				@AgeUsageDescription,
				@Threshold
			)

			SET @MedicationId = SCOPE_IDENTITY();
			PRINT CONCAT(@MedicationId, ' ', 'added sucessfully!');
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
			ERROR_NUMBER(),
			ERROR_SEVERITY(),
			ERROR_STATE(),
			ERROR_PROCEDURE(),
			ERROR_LINE(),
			ERROR_MESSAGE(),
			SUSER_NAME(),
			GETDATE()
		);
		PRINT @ErrorMessage;
	END CATCH
END
