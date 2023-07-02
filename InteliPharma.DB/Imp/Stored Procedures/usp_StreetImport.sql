CREATE   PROCEDURE imp.usp_StreetImport
AS
BEGIN

INSERT INTO App.Street
(
	NeighborhoodId,
	StreetName,
	StreetNameASCII,
	ZipCodeCode
)
SELECT DISTINCT 
       n.NeighborhoodId,
       z.logradouro AS StreetName,
	   App.replace_special_char(z.logradouro) AS StreetNameASCII,
	   z.Cep
FROM [db_a9b211_intelipharma].App.Neighborhood n
	JOIN [db_a9b211_intelipharma].App.City c
		ON c.CityId = n.CityId
	JOIN [db_a9b211_intelipharma].App.[State] s
		ON s.StateId = c.StateId
	JOIN [db_a9b211_intelipharma].[Imp].[ZipCodeInfo] z
		ON TRIM(REPLACE(z.uf, '- Povoado', '')) = s.StateAbbreviation 
		AND z.bairro = n.NeighborhoodName
		AND z.localidade = c.CityName
		AND logradouro IS NOT NULL
ORDER BY n.NeighborhoodId, z.logradouro
END;