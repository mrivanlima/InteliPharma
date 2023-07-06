CREATE   PROCEDURE stg.usp_Staging_Medication
AS
BEGIN
INSERT INTO stg.Medication
(
	[NomeDoProduto]
	,[PrincipioAtivo]
	,[PrincipioAtivoNoAccent]
	,[Registro]
	,[Processo]
	,[ProcessoNoAccent]
	,[CNPJ]
	,[Situacao]
	,[Vencimento]
)
SELECT  
     [NomeDoProduto]
    ,[PrincipioAtivo] 
    ,upper(replace([PrincipioAtivo], '"', ''))
    ,[Registro]
    ,[Processo]
	,replace(replace(replace([Processo], '/', ''), '-', ''), '.', '')
    ,[CNPJ]
    ,[Situacao]
    ,[Vencimento]
FROM [db_a9b211_intelipharma].[Imp].[consulta_medicamento]

END;