﻿
CREATE   PROCEDURE App.usp_api_NeighborhoodCreate
	@NeighborhoodId		SMALLINT = NULL OUTPUT,
	@CityId				SMALLINT,
	@NeighborhoodName	VARCHAR(50),
	@Longitude			DECIMAL(12,9),
	@Latitude			DECIMAL(12,9)
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_NeighborhoodCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @NeighborhoodName = TRIM(@NeighborhoodName);

	IF EXISTS (SELECT * FROM App.Neighborhood WHERE NeighborhoodName = @NeighborhoodName)
	BEGIN
		SET @WarningMessage = CONCAT(@NeighborhoodName, ' ', 'already exists!');
		PRINT @WarningMessage;
		SET @NeighborhoodId = (
							SELECT TOP (1) NeighborhoodId 
							FROM App.Neighborhood 
							WHERE NeighborhoodName = @NeighborhoodName
						);
		RETURN;
	END;
	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.Neighborhood
			(
				CityId,
				NeighborhoodName,
				Longitude,
				Latitude
			)
			VALUES
			(
				@CityId,
				@NeighborhoodName,
				@Longitude,
				@Latitude	
			)

			SET @NeighborhoodId = SCOPE_IDENTITY();
			PRINT CONCAT(@NeighborhoodName, ' ', 'added successfully!');
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