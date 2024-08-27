CREATE TABLE [dbo].[Categories] (
    [CategoryId]   INT            IDENTITY (1, 1) NOT NULL,
    [CategoryName] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_dbo.Categories] PRIMARY KEY CLUSTERED ([CategoryId] ASC)

);
GO

CREATE TABLE [dbo].[Products] (
    [ProductId]   INT            IDENTITY (1, 1) NOT NULL,
    [ProductName] NVARCHAR (MAX) NULL,
    [CategoryId]  INT            NOT NULL,
    CONSTRAINT [PK_dbo.Products] PRIMARY KEY CLUSTERED ([ProductId] ASC)
);
GO
CREATE TABLE [dbo].[OrderMasters] (
    [OrderMasterId] INT            IDENTITY (1, 1) NOT NULL,
    [OrderDate]     DATETIME       NOT NULL,
    [Note]          NVARCHAR (MAX) NULL,
    [Image]         NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_dbo.OrderMasters] PRIMARY KEY CLUSTERED ([OrderMasterId] ASC)
);
GO
CREATE TABLE [dbo].[OrderDetails] (
    [OrderDetailId] INT             IDENTITY (1, 1) NOT NULL,
    [OrderMasterId] INT             NOT NULL,
    [ProductId]     INT             NOT NULL,
    [Quantity]      INT             NOT NULL,
    [UnitPrice]     DECIMAL (18, 2) NOT NULL,
    CONSTRAINT [PK_dbo.OrderDetails] PRIMARY KEY CLUSTERED ([OrderDetailId] ASC),
    CONSTRAINT [FK_dbo.OrderDetails_dbo.OrderMasters_OrderMasterId] FOREIGN KEY ([OrderMasterId]) REFERENCES [dbo].[OrderMasters] ([OrderMasterId]) ON DELETE CASCADE
);
GO
CREATE NONCLUSTERED INDEX [IX_OrderMasterId]
    ON [dbo].[OrderDetails]([OrderMasterId] ASC);
GO
