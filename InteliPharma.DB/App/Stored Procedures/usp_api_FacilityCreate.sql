
CREATE   PROCEDURE App.usp_api_FacilityCreate
	@FacilityId	INT					= NULL OUTPUT,
	@Facilityname	VARCHAR(100)	= NULL,
	@AddressId	INT					= NULL
AS
BEGIN
	
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_FacilityCreate';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	SET @Facilityname = TRIM(@Facilityname);

	IF EXISTS (SELECT * FROM App.Facility WHERE Facilityname = @Facilityname)
	BEGIN
		SET @WarningMessage = CONCAT(@Facilityname, ' already exists!');
		PRINT @WarningMessage;
		SET @FacilityId = (
							SELECT TOP (1) @FacilityId
							FROM App.Facility
							WHERE Facilityname = @Facilityname
						);
		RETURN;
	END;

	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName
			INSERT INTO App.Facility
			(
				Facilityname,
				AddressId
			)
			VALUES
			(
				@Facilityname,
				@AddressId
			)

			SET @FacilityId = SCOPE_IDENTITY();
			PRINT CONCAT(@Facilityname, ' added successfully!');
		COMMIT TRANSACTION @StoredProcedureName;
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