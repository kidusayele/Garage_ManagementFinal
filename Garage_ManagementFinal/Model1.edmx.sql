
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 03/20/2024 23:26:49
-- Generated from EDMX file: C:\Users\kidus\OneDrive\Desktop\Garage_ManagementFinal\Garage_ManagementFinal\Model1.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [Garagedb];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_Entry_Formorder_service]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[order_service] DROP CONSTRAINT [FK_Entry_Formorder_service];
GO
IF OBJECT_ID(N'[dbo].[FK_Entry_Formorder_stkitem]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[order_stkitem] DROP CONSTRAINT [FK_Entry_Formorder_stkitem];
GO
IF OBJECT_ID(N'[dbo].[FK_service_tableorder_service]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[order_service] DROP CONSTRAINT [FK_service_tableorder_service];
GO
IF OBJECT_ID(N'[dbo].[FK_Stockorder_stkitem]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[order_stkitem] DROP CONSTRAINT [FK_Stockorder_stkitem];
GO
IF OBJECT_ID(N'[dbo].[FK_Stockpurchase]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[purchases] DROP CONSTRAINT [FK_Stockpurchase];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Entry_Form]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Entry_Form];
GO
IF OBJECT_ID(N'[dbo].[order_service]', 'U') IS NOT NULL
    DROP TABLE [dbo].[order_service];
GO
IF OBJECT_ID(N'[dbo].[order_stkitem]', 'U') IS NOT NULL
    DROP TABLE [dbo].[order_stkitem];
GO
IF OBJECT_ID(N'[dbo].[purchases]', 'U') IS NOT NULL
    DROP TABLE [dbo].[purchases];
GO
IF OBJECT_ID(N'[dbo].[recipts]', 'U') IS NOT NULL
    DROP TABLE [dbo].[recipts];
GO
IF OBJECT_ID(N'[dbo].[service_table]', 'U') IS NOT NULL
    DROP TABLE [dbo].[service_table];
GO
IF OBJECT_ID(N'[dbo].[Stocks]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Stocks];
GO
IF OBJECT_ID(N'[dbo].[users]', 'U') IS NOT NULL
    DROP TABLE [dbo].[users];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Entry_Form'
CREATE TABLE [dbo].[Entry_Form] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [plate_no] nvarchar(max)  NOT NULL,
    [Brand] nvarchar(max)  NOT NULL,
    [Owner_name] nvarchar(max)  NOT NULL,
    [phone] nvarchar(max)  NOT NULL,
    [Description] nvarchar(max)  NOT NULL,
    [Status] bit  NOT NULL,
    [date] datetime  NOT NULL,
    [Alpha] nvarchar(1)  NULL
);
GO

-- Creating table 'order_service'
CREATE TABLE [dbo].[order_service] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [status] bit  NOT NULL,
    [service_tableId] int  NOT NULL,
    [Entry_FormId] int  NOT NULL,
    [quantity] int  NULL,
    [Assistant_Mechanic] nvarchar(max)  NULL
);
GO

-- Creating table 'order_stkitem'
CREATE TABLE [dbo].[order_stkitem] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [quantity] float  NOT NULL,
    [status] bit  NOT NULL,
    [Entry_FormId] int  NOT NULL,
    [StockId] int  NOT NULL,
    [Alpha] nvarchar(1)  NULL
);
GO

-- Creating table 'purchases'
CREATE TABLE [dbo].[purchases] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [old_quantity] float  NOT NULL,
    [new_quantity] float  NOT NULL,
    [remain_quantity] float  NOT NULL,
    [price] float  NOT NULL,
    [total_price] float  NOT NULL,
    [date] datetime  NOT NULL,
    [StockId] int  NOT NULL
);
GO

-- Creating table 'recipts'
CREATE TABLE [dbo].[recipts] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [date] datetime  NOT NULL,
    [customer_Fullname] nvarchar(max)  NOT NULL,
    [Plate_no] nvarchar(max)  NOT NULL,
    [description] nvarchar(max)  NOT NULL,
    [quantity] float  NOT NULL,
    [price] float  NOT NULL,
    [total] float  NOT NULL,
    [vat] float  NOT NULL,
    [tot_withvat] float  NOT NULL,
    [status] bit  NULL,
    [EntryFormId] int  NULL,
    [Alpha] nvarchar(1)  NULL
);
GO

-- Creating table 'service_table'
CREATE TABLE [dbo].[service_table] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [service_name] nvarchar(max)  NOT NULL,
    [price] float  NOT NULL,
    [status] bit  NOT NULL
);
GO

-- Creating table 'Stocks'
CREATE TABLE [dbo].[Stocks] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [name] nvarchar(max)  NOT NULL,
    [quantity] float  NOT NULL,
    [price] float  NOT NULL,
    [type] bit  NOT NULL,
    [buy_price] float  NULL
);
GO

-- Creating table 'users'
CREATE TABLE [dbo].[users] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Firstname] nvarchar(max)  NOT NULL,
    [Lastname] nvarchar(max)  NOT NULL,
    [email] nvarchar(max)  NOT NULL,
    [username] nvarchar(max)  NOT NULL,
    [password] nvarchar(max)  NOT NULL,
    [gender] nvarchar(max)  NOT NULL,
    [phone_no] nvarchar(max)  NOT NULL,
    [role] nvarchar(max)  NOT NULL,
    [status] bit  NOT NULL,
    [ResetPasswordCode] nvarchar(max)  NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'Entry_Form'
ALTER TABLE [dbo].[Entry_Form]
ADD CONSTRAINT [PK_Entry_Form]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'order_service'
ALTER TABLE [dbo].[order_service]
ADD CONSTRAINT [PK_order_service]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'order_stkitem'
ALTER TABLE [dbo].[order_stkitem]
ADD CONSTRAINT [PK_order_stkitem]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'purchases'
ALTER TABLE [dbo].[purchases]
ADD CONSTRAINT [PK_purchases]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'recipts'
ALTER TABLE [dbo].[recipts]
ADD CONSTRAINT [PK_recipts]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'service_table'
ALTER TABLE [dbo].[service_table]
ADD CONSTRAINT [PK_service_table]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Stocks'
ALTER TABLE [dbo].[Stocks]
ADD CONSTRAINT [PK_Stocks]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'users'
ALTER TABLE [dbo].[users]
ADD CONSTRAINT [PK_users]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [Entry_FormId] in table 'order_service'
ALTER TABLE [dbo].[order_service]
ADD CONSTRAINT [FK_Entry_Formorder_service]
    FOREIGN KEY ([Entry_FormId])
    REFERENCES [dbo].[Entry_Form]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Entry_Formorder_service'
CREATE INDEX [IX_FK_Entry_Formorder_service]
ON [dbo].[order_service]
    ([Entry_FormId]);
GO

-- Creating foreign key on [Entry_FormId] in table 'order_stkitem'
ALTER TABLE [dbo].[order_stkitem]
ADD CONSTRAINT [FK_Entry_Formorder_stkitem]
    FOREIGN KEY ([Entry_FormId])
    REFERENCES [dbo].[Entry_Form]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Entry_Formorder_stkitem'
CREATE INDEX [IX_FK_Entry_Formorder_stkitem]
ON [dbo].[order_stkitem]
    ([Entry_FormId]);
GO

-- Creating foreign key on [service_tableId] in table 'order_service'
ALTER TABLE [dbo].[order_service]
ADD CONSTRAINT [FK_service_tableorder_service]
    FOREIGN KEY ([service_tableId])
    REFERENCES [dbo].[service_table]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_service_tableorder_service'
CREATE INDEX [IX_FK_service_tableorder_service]
ON [dbo].[order_service]
    ([service_tableId]);
GO

-- Creating foreign key on [StockId] in table 'order_stkitem'
ALTER TABLE [dbo].[order_stkitem]
ADD CONSTRAINT [FK_Stockorder_stkitem]
    FOREIGN KEY ([StockId])
    REFERENCES [dbo].[Stocks]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Stockorder_stkitem'
CREATE INDEX [IX_FK_Stockorder_stkitem]
ON [dbo].[order_stkitem]
    ([StockId]);
GO

-- Creating foreign key on [StockId] in table 'purchases'
ALTER TABLE [dbo].[purchases]
ADD CONSTRAINT [FK_Stockpurchase]
    FOREIGN KEY ([StockId])
    REFERENCES [dbo].[Stocks]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Stockpurchase'
CREATE INDEX [IX_FK_Stockpurchase]
ON [dbo].[purchases]
    ([StockId]);
GO
Alter table order_stkitem
Add Orderedby nvarchar(max)
Alter table order_stkitem
Add date datetime;
-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------
alter table Entry_Form 
Add code int;
alter table Entry_Form 
Add region nvarchar(3);