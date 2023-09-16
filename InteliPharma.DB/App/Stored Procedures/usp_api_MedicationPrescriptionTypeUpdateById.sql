
CREATE   PROCEDURE App.usp_api_MedicationPrescriptionTypeUpdateById
	@MedicationId	INT,
	@PrescriptionId	BIGINT,
	@PrescriptionTypeId	TINYINT				= NULL,
	@Quantity	TINYINT						= NULL,
	@MedicationPrescriptionTypeId	BIGINT
AS
BEGIN


	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR (100) = 'usp_api_MedicationTypeUpdateById';
	DECLARE @ErrorMessage			VARCHAR (100) = CONCAT('Error ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR (100);

	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			UPDATE m
			SET	MedicationId = @MedicationId,
				PrescriptionId = @PrescriptionId,
				PrescriptionTypeId = @PrescriptionTypeId,
				Quantity = @Quantity
			FROM App.MedicationPrescriptionType m
			WHERE MedicationPrescriptionTypeId = @MedicationPrescriptionTypeId

			PRINT CONCAT(@MedicationPrescriptionTypeId, ' updated successfully!');
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