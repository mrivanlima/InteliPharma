CREATE TABLE [Security].[UserLogin] (
    [UserId]                INT           IDENTITY (1, 1) NOT NULL,
    [LoginName]             VARCHAR (40)  NOT NULL,
    [PasswordHash]          VARCHAR (250) NOT NULL,
    [PasswordSalt]          VARCHAR (100) NOT NULL,
    [ConfirmationToken]     VARCHAR (100) NULL,
    [TokenGenerationTime]   DATETIME      NULL,
    [EmailValidation]       BIT           NULL,
    [PasswordRecoveryToken] VARCHAR (100) NULL,
    [RecoveryTokenTime]     DATETIME      NULL,
    CONSTRAINT [PK_UserLogin] PRIMARY KEY CLUSTERED ([UserId] ASC),
    CONSTRAINT [UQ_LoginName] UNIQUE NONCLUSTERED ([LoginName] ASC)
);

