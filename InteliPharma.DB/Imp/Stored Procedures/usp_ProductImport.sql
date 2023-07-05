
CREATE   PROCEDURE imp.usp_ProductImport
AS
BEGIN
SELECT DISTINCT
[App].[Capitalize_First_Letter](TRIM(c.produto)) Prod,
LOWER(App.replace_special_char(TRIM(c.produto))) As Produto
FROM [db_a9b211_intelipharma].[Imp].[Conformidade] c (nolock)
ORDER BY 1;
END;