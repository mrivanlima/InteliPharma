
CREATE   PROCEDURE App.usp_api_MedicationPrescriptionTypeCreate
	@MedicationId	INT,
	@PrescriptionId	BIGINT,
	@PrescriptionTypeId	TINYINT				= NULL,
	@Quantity	TINYINT						= NULL,
	@MedicationPrescriptionTypeId	BIGINT	= NULL OUTPUT,
	@Error		BIT = 0 OUTPUT
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_MedicationPrescriptionTypeCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);


	IF EXISTS (
	           SELECT * 
	           FROM app.MedicationPrescriptionType 
			   WHERE MedicationId = @MedicationId 
			   AND PrescriptionId = @PrescriptionId 
			   AND PrescriptionTypeId = @PrescriptionTypeId)
	BEGIN
		SET @WarningMessage = 'MedicationPrescriptionType already exists!';
		PRINT @WarningMessage;
		SET @MedicationPrescriptionTypeId = (
							SELECT TOP 1 MedicationPrescriptionTypeId
						    FROM app.MedicationPrescriptionType 
						    WHERE MedicationId = @MedicationId 
						    AND PrescriptionId = @PrescriptionId 
						    AND PrescriptionTypeId = @PrescriptionTypeId
						);
		RETURN;
	END;

	BEGIN TRY 
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.MedicationPrescriptionType
			(
				MedicationId,
				PrescriptionId,
				PrescriptionTypeId,
				Quantity
			)
			VALUES
			(
				@MedicationId,
				@PrescriptionId,
				@PrescriptionTypeId,
				@Quantity
			)

			SET @MedicationPrescriptionTypeId = SCOPE_IDENTITY();
			PRINT CONCAT(@MedicationPrescriptionTypeId, ' ', 'added sucessfully!');
		COMMIT TRANSACTION @StoredProcedureName
	END TRY 

	BEGIN CATCH

		IF @@TRANCOUNT > 0
		BEGIN 
			ROLLBACK TRANSACTION @StoredProcedureName;
		END;

		SET @Error = 1;

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
