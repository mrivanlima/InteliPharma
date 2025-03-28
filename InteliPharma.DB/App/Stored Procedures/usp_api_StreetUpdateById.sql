﻿
CREATE   PROCEDURE App.usp_api_StreetUpdateById
	@StreetId		INT,
	@NeighborhoodId	SMALLINT,
	@StreetName		VARCHAR(50),
	@Longitude		DECIMAL(12,9),
	@Latitude		DECIMAL(12,9)
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_StreetUpdateById';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @StreetName = TRIM(@StreetName);

	IF NOT EXISTS (SELECT * FROM App.Street WHERE StreetId = @StreetId)
	BEGIN
		SET @ErrorMessage = CONCAT(@StreetId, ' ', 'not found!');
		THROW 50005, @ErrorMessage, 1;
	END
	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			UPDATE s
				SET NeighborhoodId	= @NeighborhoodId,
					StreetName = @StreetName,
					Longitude = @Longitude,
					Latitude = @Latitude
			FROM App.Street s 
			WHERE StreetId = @StreetId

			PRINT CONCAT(@StreetName, ' ', 'updated successfully!');
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