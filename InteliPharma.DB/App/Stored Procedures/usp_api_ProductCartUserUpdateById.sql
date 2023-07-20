﻿
CREATE   PROCEDURE App.usp_api_ProductCartUserUpdateById
	@ProductCartUserId BIGINT   NOT NULL,
    @ProductId         BIGINT   NOT NULL,
    @CartId            BIGINT   NOT NULL,
    @UserId            INT      NOT NULL,
    @AddedOn           DATETIME NULL,
    @Active            BIT      NULL
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @StoredProcedureName	VARCHAR(100) = 'usp_api_ProductCartUserUpdateById';
	DECLARE @ErrorMessage			VARCHAR(100) = CONCAT('Error', ' ', @StoredProcedureName);
	DECLARE @WarningMessage			VARCHAR(100);

	

	IF NOT EXISTS (SELECT * FROM App.ProductCartUser WHERE ProductCartUserId = @ProductCartUserId)
	BEGIN
		SET @ErrorMessage = CONCAT(@ProductCartUserId, ' ', 'not found!');
		THROW 50005, @ErrorMessage, 1;
	END
	
	BEGIN TRY
		BEGIN TRANSACTION @StoredProcedureName

			UPDATE p
				SET ProductCartUserId = @ProductCartUserId,
					ProductId = @ProductId,
					CartId = @CartId,
					UserId = @UserId,
					AddedOn = @AddedOn,
					Active = @Active
			FROM App.ProductCartUser p
			WHERE ProductCartUserId = @ProductCartUserId

			PRINT CONCAT(@ProductCartUserId, ' ', 'updated successfully!');
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