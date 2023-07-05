CREATE   PROCEDURE imp.usp_ActivePrincipleImport
AS
BEGIN
SELECT *
FROM
(
	SELECT DISTINCT 
		[App].[Capitalize_First_Letter](REPLACE(REPLACE(TRIM(v.value), '"', ''), '-', '')) AS Principle,
		[App].[Capitalize_First_Letter](App.replace_special_char(REPLACE(TRIM(v.value), '"', ''))) ActivePrincipleASCII
	FROM [db_a9b211_intelipharma].[Imp].[Conformidade] c (nolock)
		CROSS APPLY STRING_SPLIT(SUBSTANCIA, ';') v
) AS a
WHERE NULLIF(a.Principle, '') IS NOT NULL
ORDER BY 1; 
END;