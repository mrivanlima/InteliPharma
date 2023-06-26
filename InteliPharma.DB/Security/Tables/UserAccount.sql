CREATE TABLE [Security].[UserAccount] (
    [UserId]      INT           NOT NULL,
    [FirstName]   VARCHAR (100) NOT NULL,
    [Middlename]  VARCHAR (100) NULL,
    [LastName]    VARCHAR (100) NOT NULL,
    [Gender]      CHAR (1)      NULL,
    [DateOfBirth] DATETIME      NULL,
    [CPF]         VARCHAR (11)  NULL,
    [RG]          VARCHAR (40)  NULL,
    CONSTRAINT [PK_UserAccount] PRIMARY KEY CLUSTERED ([UserId] ASC),
    CONSTRAINT [FK_UserAccountUserLogin] FOREIGN KEY ([UserId]) REFERENCES [Security].[UserLogin] ([UserId]),
    CONSTRAINT [UQ_CPF] UNIQUE NONCLUSTERED ([CPF] ASC)
);

