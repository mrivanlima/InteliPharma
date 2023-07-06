CREATE   PROCEDURE [Imp].[usp_LaboratoryImport]
AS
BEGIN
INSERT INTO [App].[Laboratory]
(
	[LaboratoryName],
	[LaboratoryNameASCII],
	[CNPJ]
)
SELECT DISTINCT 
	[App].[Capitalize_First_Letter](REPLACE(TRIM(c.laboratorio), '"', '')) Laboratorio,
	[App].[Capitalize_First_Letter](App.replace_special_char(REPLACE(TRIM(c.laboratorio), '"', ''))) LaboratorioASCII,
	TRIM(CNPJ) AS CNPJ
FROM [db_a9b211_intelipharma].[Imp].[Conformity] c (nolock)
WHERE c.laboratorio IS NOT NULL
AND c.laboratorio NOT IN ('Genérico', 'Similar')
ORDER BY 1; 
END;