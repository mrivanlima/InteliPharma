CREATE   PROCEDURE imp.usp_LaboratoryImport
AS
BEGIN
SELECT DISTINCT 
	[App].[Capitalize_First_Letter](c.laboratorio) Laboratorio,
	[App].[Capitalize_First_Letter](App.replace_special_char(TRIM(c.laboratorio))) LaboratorioASCII
FROM [db_a9b211_intelipharma].[Imp].[Conformidade] c (nolock)
	CROSS APPLY STRING_SPLIT(SUBSTANCIA, ';') v
ORDER BY 1; 
END;