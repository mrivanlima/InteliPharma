
CREATE   PROCEDURE imp.usp_ZipCodeInfoCreate

	@cep varchar(max),
    @logradouro varchar(max),
    @complemento varchar(max),
    @bairro varchar(max),
    @plocalidade varchar(max),
    @uf varchar(max),
    @ibge varchar(max),
    @gia varchar(max),
    @ddd varchar(max),
    @siafi varchar(max)
AS
BEGIN

	IF NOT EXISTS (SELECT * FROM imp.ZipCodeInfo WHERE cep = @cep)
	BEGIN
		insert into imp.ZipCodeInfo
		(
			cep,
			logradouro,
			complemento,
			bairro,
			localidade,
			uf,
			ibge,
			gia,
			ddd,
			siafi
		)
		values 
		(
			@cep,
			@logradouro,
			@complemento,
			@bairro,
			@plocalidade,
			@uf,
			@ibge,
			@gia,
			@ddd,
			@siafi
		)
	END
END