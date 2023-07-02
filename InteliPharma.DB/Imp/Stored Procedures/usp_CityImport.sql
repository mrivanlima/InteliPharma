CREATE   PROCEDURE imp.usp_CityImport
AS
BEGIN

	INSERT INTO App.City
	(
		StateId,
		CityName,
		CityNameAscII
	)
	SELECT DISTINCT 
		s.StateId,
		localidade AS CityName, 
		App.replace_special_char(localidade) AS CityNameASCII
	FROM [db_a9b211_intelipharma].[Imp].[ZipCodeInfo] z (NOLOCK)
		JOIN [db_a9b211_intelipharma].App.[State] s
			ON TRIM(REPLACE(z.uf, '- Povoado', '')) = s.StateAbbreviation
	ORDER BY 1, 2
END;