CREATE TABLE [Imp].[ZipCodeInfo] (
    [cep]         VARCHAR (40)  NULL,
    [logradouro]  VARCHAR (MAX) NULL,
    [complemento] VARCHAR (MAX) NULL,
    [bairro]      VARCHAR (MAX) NULL,
    [localidade]  VARCHAR (MAX) NULL,
    [uf]          VARCHAR (MAX) NULL,
    [ibge]        VARCHAR (MAX) NULL,
    [gia]         VARCHAR (MAX) NULL,
    [ddd]         VARCHAR (MAX) NULL,
    [siafi]       VARCHAR (MAX) NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_ZipCodeInfoCep]
    ON [Imp].[ZipCodeInfo]([cep] ASC);

