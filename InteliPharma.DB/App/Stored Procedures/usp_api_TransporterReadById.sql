
CREATE   PROCEDURE App.usp_api_TransporterReadById
	@TransporterId SMALLINT
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
	FROM App.Transporter
	WHERE TransporterId = @TransporterId;
END;