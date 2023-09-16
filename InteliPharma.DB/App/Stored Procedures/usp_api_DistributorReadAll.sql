
CREATE   PROCEDURE App.usp_api_DistributorReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	DistributorId,
			DistributorName,
			AddressId,
			CNPJ,
			StateSubscription
	FROM App.Distributor;
END;
