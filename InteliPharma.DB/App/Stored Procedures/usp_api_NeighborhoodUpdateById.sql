
CREATE   PROCEDURE App.usp_api_NeighborhoodUpdateById
	@NeighborhoodId		SMALLINT,
	@CityId				SMALLINT,
	@NeighborhoodName	VARCHAR(50),
	@Longitude			DECIMAL(12,9),
	@Latitude			DECIMAL(12,9)
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'sp_api_NeighborhoodUpdateById';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @NeighborhoodName = TRIM(@NeighborhoodName);

	IF NOT EXISTS (SELECT * FROM App.Neighborhood WHERE NeighborhoodId = @NeighborhoodId)
	BEGIN
		SET @ErrorMessage = CONCAT(@NeighborhoodId, ' ', 'not found!');
		THROW 50005, @ErrorMessage, 1;
	END
	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			UPDATE n
				SET n.NeighborhoodName = @NeighborhoodName,
					n.CityId = @CityId,
				    n.Longitude = @Longitude,
					n.Latitude = @Latitude
			FROM App.Neighborhood n 
			WHERE NeighborhoodId = @NeighborhoodId

			PRINT CONCAT(@NeighborhoodName, ' ', 'updated successfully!');
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