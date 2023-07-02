CREATE   PROCEDURE imp.usp_NeighborhoodImport
AS
BEGIN
	INSERT INTO App.Neighborhood
	(
		CityId,
		NeighborhoodName,
		NeighborhoodNameASCII
	)
	SELECT DISTINCT
			c.CityId,
			z.bairro,
			REPLACE(App.replace_special_char(bairro), '7º', 'setimo')  AS NeighborhoodNameASCII
	FROM [db_a9b211_intelipharma].App.City c
		JOIN [db_a9b211_intelipharma].App.[State] s
				ON s.StateId = c.StateId
		JOIN [db_a9b211_intelipharma].[Imp].[ZipCodeInfo] z
		    ON TRIM(REPLACE(z.uf, '- Povoado', '')) = s.StateAbbreviation
			AND z.localidade = c.CityName
			AND NULLIF(TRIM(z.bairro), '') IS NOT NULL
	ORDER BY c.CityId, z.bairro
END;