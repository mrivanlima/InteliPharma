﻿
CREATE   PROCEDURE App.usp_api_ProfessionalUpdateById
	@ProfessionalId					INT			 NOT NULL,
    @ProfessionalName				VARCHAR (50) NULL,
    @ProfessionalAssociationNumber	VARCHAR (20) NULL
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_ProfessionalUpdateById';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @ProfessionalName = TRIM(@ProfessionalName);

	IF NOT EXISTS (SELECT * FROM App.Professional WHERE ProfessionalId = @ProfessionalId)
	BEGIN
		SET @ErrorMessage = CONCAT(@ProfessionalId, ' ', 'not found!');
		THROW 50005, @ErrorMessage, 1;
	END
	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			UPDATE p
				SET 
					ProfessionalName = @ProfessionalName,
					ProfessionalAssociationNumber = @ProfessionalAssociationNumber
			FROM App.Professional p 
			WHERE ProfessionalId = @ProfessionalId

			PRINT CONCAT(@ProfessionalName, ' ', 'updated successfully!');
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