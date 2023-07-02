CREATE   PROCEDURE imp.usp_NeighborhoodImport
AS
BEGIN
	INSERT INTO App.Neighborhood
	(
		CityId,
		NeighborhoodName,
		NeighborhoodNameASCII
	)
	SELECT
			c.CityId,
			z.bairro,
			App.replace_special_char(bairro) AS NeighborhoodNameASCII
	FROM [db_a9b211_intelipharma].App.City c
		JOIN [db_a9b211_intelipharma].[Imp].[ZipCodeInfo] z
			ON z.localidade = c.CityName
		JOIN [db_a9b211_intelipharma].App.[State] s
				ON TRIM(REPLACE(z.uf, '- Povoado', '')) = s.StateAbbreviation
	ORDER BY s.StateId, c.CityId, z.bairro
END;