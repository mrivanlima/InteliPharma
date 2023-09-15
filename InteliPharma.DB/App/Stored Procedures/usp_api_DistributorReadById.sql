
CREATE   PROCEDURE App.usp_api_DistributorReadById
	@DistributorId	INT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	DistributorId,
			DistributorName,
			AddressId,
			CNPJ,
			StateSubscription
	FROM App.Distributor
	WHERE DistributorId = @DistributorId;
END;
