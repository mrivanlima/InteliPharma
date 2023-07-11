
CREATE   PROCEDURE App.usp_api_TransporterReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	TransporterId,
			AddressId,
			TransporterName,
			ANTTCode,
			CNPJ,
			StateSubscription
	FROM App.Transporter;
END;