﻿
CREATE   PROCEDURE App.usp_api_FacilityDeleteById
	@FacilityId INT
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_FacilityDeleteById';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);


	IF NOT EXISTS (SELECT * FROM App.Facility WHERE FacilityId = @FacilityId)
	BEGIN
		SET @ErrorMessage = CONCAT(@FacilityId, ' not found!');
		THROW 50005, @ErrorMessage, 1;
	END

	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			DELETE f
			FROM App.Facility f
			WHERE FacilityId = @FacilityId

			PRINT CONCAT(@FacilityId, ' Deleted successfully!');
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
END
