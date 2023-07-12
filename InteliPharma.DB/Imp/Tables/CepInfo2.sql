CREATE TABLE [Imp].[CepInfo2] (
    [CepId]       INT           IDENTITY (1, 1) NOT NULL,
    [CidadeNome]  VARCHAR (MAX) NULL,
    [ibge]        VARCHAR (MAX) NULL,
    [ddd]         VARCHAR (MAX) NULL,
    [estadoSigla] VARCHAR (MAX) NULL,
    [Altitude]    VARCHAR (MAX) NULL,
    [longitude]   VARCHAR (MAX) NULL,
    [bairro]      VARCHAR (MAX) NULL,
    [complemento] VARCHAR (MAX) NULL,
    [cep]         VARCHAR (MAX) NULL,
    [logradouro]  VARCHAR (MAX) NULL,
    [latitude]    VARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([CepId] ASC)
);

