USE [master]
GO
/****** Object:  Database [ClickToBuy]    Script Date: 6/29/2020 12:09:35 PM ******/
CREATE DATABASE [ClickToBuy]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ClickToBuy', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\ClickToBuy.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ClickToBuy_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\ClickToBuy_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ClickToBuy] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ClickToBuy].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ClickToBuy] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ClickToBuy] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ClickToBuy] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ClickToBuy] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ClickToBuy] SET ARITHABORT OFF 
GO
ALTER DATABASE [ClickToBuy] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ClickToBuy] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ClickToBuy] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ClickToBuy] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ClickToBuy] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ClickToBuy] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ClickToBuy] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ClickToBuy] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ClickToBuy] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ClickToBuy] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ClickToBuy] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ClickToBuy] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ClickToBuy] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ClickToBuy] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ClickToBuy] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ClickToBuy] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [ClickToBuy] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ClickToBuy] SET RECOVERY FULL 
GO
ALTER DATABASE [ClickToBuy] SET  MULTI_USER 
GO
ALTER DATABASE [ClickToBuy] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ClickToBuy] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ClickToBuy] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ClickToBuy] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ClickToBuy] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ClickToBuy', N'ON'
GO
ALTER DATABASE [ClickToBuy] SET QUERY_STORE = OFF
GO
USE [ClickToBuy]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [ClickToBuy]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 6/29/2020 12:09:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[BrandId] [int] NOT NULL,
	[ConditionId] [int] NOT NULL,
	[CloseTypeId] [int] NOT NULL,
	[RegularPrice] [real] NOT NULL,
	[OfferPrice] [real] NULL,
	[Link] [nvarchar](max) NULL,
	[ProductDetails] [nvarchar](2000) NOT NULL,
	[Quantity] [int] NOT NULL,
	[CustomerId] [int] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StockProducts]    Script Date: 6/29/2020 12:09:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockProducts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[PurchaseId] [int] NULL,
 CONSTRAINT [PK_StockProducts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[NonProductInStock]    Script Date: 6/29/2020 12:09:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[NonProductInStock]
                                AS
                                Select * 
                                FROM Products
                                WHERE Id NOT IN (SELECT StockProducts.ProductId FROM StockProducts)
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 6/29/2020 12:09:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Admins]    Script Date: 6/29/2020 12:09:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admins](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ContactNo] [nvarchar](14) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](14) NOT NULL,
	[Picture] [nvarchar](max) NULL,
	[CountryId] [int] NOT NULL,
	[CityId] [int] NOT NULL,
	[Address] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_Admins] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Brands]    Script Date: 6/29/2020 12:09:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brands](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
	[Origin] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_Brands] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 6/29/2020 12:09:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
	[CategoryId] [int] NULL,
	[Description] [nvarchar](1000) NOT NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cities]    Script Date: 6/29/2020 12:09:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cities](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[CountryId] [int] NOT NULL,
 CONSTRAINT [PK_Cities] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CloseTypes]    Script Date: 6/29/2020 12:09:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CloseTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_CloseTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Conditions]    Script Date: 6/29/2020 12:09:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Conditions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_Conditions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 6/29/2020 12:09:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Coupons]    Script Date: 6/29/2020 12:09:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Coupons](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CouponNumber] [nvarchar](30) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[Amount] [real] NOT NULL,
 CONSTRAINT [PK_Coupons] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerBillingAddresses]    Script Date: 6/29/2020 12:09:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerBillingAddresses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[BillingAddress] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_CustomerBillingAddresses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 6/29/2020 12:09:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Contact] [nvarchar](14) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Pictuer] [nvarchar](max) NULL,
	[GenderId] [int] NOT NULL,
	[JoinDate] [datetime2](7) NOT NULL,
	[CustomerIPAddress] [nvarchar](max) NULL,
	[CountryId] [int] NOT NULL,
	[CityId] [int] NOT NULL,
	[Address] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeliveryCharges]    Script Date: 6/29/2020 12:09:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeliveryCharges](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CityId] [int] NOT NULL,
	[Ammount] [real] NOT NULL,
 CONSTRAINT [PK_DeliveryCharges] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Genders]    Script Date: 6/29/2020 12:09:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](6) NOT NULL,
 CONSTRAINT [PK_Genders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 6/29/2020 12:09:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 6/29/2020 12:09:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderNo] [nvarchar](50) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[CouponNumber] [nvarchar](20) NULL,
	[DeliveryChargeId] [int] NOT NULL,
	[OrderDate] [datetime2](7) NOT NULL,
	[Status] [bit] NOT NULL,
	[CustomerBillingAddressId] [int] NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductPhotos]    Script Date: 6/29/2020 12:09:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductPhotos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Photo] [nvarchar](30) NULL,
	[ProductId] [int] NOT NULL,
	[Featured] [bit] NOT NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [PK_ProductPhotos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchaseItems]    Script Date: 6/29/2020 12:09:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchaseItems](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PurchaseId] [int] NULL,
	[ProductId] [int] NOT NULL,
	[Price] [real] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_PurchaseItems] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchasePayments]    Script Date: 6/29/2020 12:09:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchasePayments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PurchaseId] [int] NOT NULL,
	[Date] [datetime2](7) NOT NULL,
	[DueAmount] [real] NOT NULL,
	[PayAmount] [real] NOT NULL,
 CONSTRAINT [PK_PurchasePayments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Purchases]    Script Date: 6/29/2020 12:09:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Purchases](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PurchaseNumber] [nvarchar](10) NOT NULL,
	[SupplierId] [int] NOT NULL,
	[Date] [datetime2](7) NOT NULL,
	[PurchasePaymentId] [int] NULL,
 CONSTRAINT [PK_Purchases] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReturnProducts]    Script Date: 6/29/2020 12:09:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReturnProducts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_ReturnProducts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sliders]    Script Date: 6/29/2020 12:09:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sliders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PhotoName] [nvarchar](50) NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [PK_Sliders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Suppliers]    Script Date: 6/29/2020 12:09:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suppliers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](40) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[ContactNo] [nvarchar](14) NOT NULL,
	[Address] [nvarchar](2000) NOT NULL,
 CONSTRAINT [PK_Suppliers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tags]    Script Date: 6/29/2020 12:09:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tags](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[TagName] [nvarchar](2000) NOT NULL,
 CONSTRAINT [PK_Tags] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200305103922_AddModel_Country_City', N'3.1.2')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200306163101_AddModel_Brand', N'3.1.2')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200306170337_AddModel_Category', N'3.1.2')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200306190357_AddModel_Gender', N'3.1.2')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200307061317_AddModel_Customer', N'3.1.2')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200307075951_Modify_Customer', N'3.1.2')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200307091935_ModifyMode_Customer', N'3.1.2')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200308052854_AddModel_Condition', N'3.1.2')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200308062855_AddModel_CloseType', N'3.1.2')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200308091132_AddModel_Product', N'3.1.2')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200308091624_UpdateModel_Product', N'3.1.2')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200308182303_AddModel_StockProduct', N'3.1.2')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200309050744_UpdateModel_StockProduct_Product', N'3.1.2')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200309071236_AddView_NonProductInStock', N'3.1.2')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200309174625_AddModel_Supplier', N'3.1.2')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200309203445_Model_Purchase_PurchaseItem_PurchasePayment', N'3.1.2')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200310164235_AddAllModel', N'3.1.2')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200312065020_UpdateModel_PurchasePayment', N'3.1.2')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200312065445_UpdateModel_PurchaseItem', N'3.1.2')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200312150323_Modify_Purchase_PurchasePayment', N'3.1.2')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200312153348_Modify_Purchase_StockProduct', N'3.1.2')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200312170239_ModifyModel', N'3.1.2')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200314074137_AddModel_Admin', N'3.1.2')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200519142917_UM_Category', N'3.1.2')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200525034459_AM_Slider', N'3.1.2')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200527145549_UM_Slider', N'3.1.2')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200528054048_AM_ProductPhoto', N'3.1.2')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200528061719_UM_Product', N'3.1.2')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200609065705_UM_Product2', N'3.1.2')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200612062746_UM_Order', N'3.1.4')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200613081000_UM_Product_Customer', N'3.1.4')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200615042542_UM_Order_C_B_A', N'3.1.4')
SET IDENTITY_INSERT [dbo].[Admins] ON 

INSERT [dbo].[Admins] ([Id], [Name], [ContactNo], [Email], [Password], [Picture], [CountryId], [CityId], [Address]) VALUES (1, N'Md Al Amin', N'01743909821', N'al-amin@gmail.com', N'12345', N'AdminPicture/images.jpg', 1, 1, N'Mirpur 2')
SET IDENTITY_INSERT [dbo].[Admins] OFF
SET IDENTITY_INSERT [dbo].[Brands] ON 

INSERT [dbo].[Brands] ([Id], [Name], [Origin], [Description]) VALUES (1, N'Apple', N'California', N'NA')
INSERT [dbo].[Brands] ([Id], [Name], [Origin], [Description]) VALUES (2, N'Nokia', N'Finland', N'NA')
INSERT [dbo].[Brands] ([Id], [Name], [Origin], [Description]) VALUES (3, N'Sony', N'Tokyo ', N'NA')
INSERT [dbo].[Brands] ([Id], [Name], [Origin], [Description]) VALUES (4, N'A4Tech', N'New Taipei, Taiwan.', N'NA')
INSERT [dbo].[Brands] ([Id], [Name], [Origin], [Description]) VALUES (5, N'Kingston', N'United States', N'NA')
INSERT [dbo].[Brands] ([Id], [Name], [Origin], [Description]) VALUES (7, N'Bajaj', N'Pune', N'NA')
INSERT [dbo].[Brands] ([Id], [Name], [Origin], [Description]) VALUES (8, N'Yamaha', N'Japan', N'NA')
SET IDENTITY_INSERT [dbo].[Brands] OFF
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([Id], [Name], [CategoryId], [Description], [Status]) VALUES (1, N'Electronic', NULL, N'All type of electronic product is hare. ', 1)
INSERT [dbo].[Categories] ([Id], [Name], [CategoryId], [Description], [Status]) VALUES (2, N'TV', 1, N'All type of TV list is hare.', 1)
INSERT [dbo].[Categories] ([Id], [Name], [CategoryId], [Description], [Status]) VALUES (3, N'Multimedia phone', 1, N'Na', 1)
INSERT [dbo].[Categories] ([Id], [Name], [CategoryId], [Description], [Status]) VALUES (4, N'Smart Phone', 1, N'NA', 1)
INSERT [dbo].[Categories] ([Id], [Name], [CategoryId], [Description], [Status]) VALUES (5, N'Computer', 1, N'All Type of computer is hare.', 1)
INSERT [dbo].[Categories] ([Id], [Name], [CategoryId], [Description], [Status]) VALUES (6, N'Vehicle', NULL, N'All type of vehicle is hare', 1)
INSERT [dbo].[Categories] ([Id], [Name], [CategoryId], [Description], [Status]) VALUES (7, N'Cloth', NULL, N'All kind of cloth item is hare.', 1)
INSERT [dbo].[Categories] ([Id], [Name], [CategoryId], [Description], [Status]) VALUES (8, N'Motor Cycle', 6, N'All type of motor cycle item is hare.', 1)
INSERT [dbo].[Categories] ([Id], [Name], [CategoryId], [Description], [Status]) VALUES (17, N'EarPhone', 1, N'All type of earphone is the hare.', 1)
SET IDENTITY_INSERT [dbo].[Categories] OFF
SET IDENTITY_INSERT [dbo].[Cities] ON 

INSERT [dbo].[Cities] ([Id], [Name], [CountryId]) VALUES (1, N'Dhaka', 1)
INSERT [dbo].[Cities] ([Id], [Name], [CountryId]) VALUES (2, N'Chittagong', 1)
INSERT [dbo].[Cities] ([Id], [Name], [CountryId]) VALUES (3, N'Shylet', 1)
INSERT [dbo].[Cities] ([Id], [Name], [CountryId]) VALUES (4, N'Lakshmipur', 1)
SET IDENTITY_INSERT [dbo].[Cities] OFF
SET IDENTITY_INSERT [dbo].[CloseTypes] ON 

INSERT [dbo].[CloseTypes] ([Id], [Name], [Description]) VALUES (1, N'Sold', N'NA')
INSERT [dbo].[CloseTypes] ([Id], [Name], [Description]) VALUES (2, N'Available', N'NA')
INSERT [dbo].[CloseTypes] ([Id], [Name], [Description]) VALUES (3, N'KK', N'NA')
SET IDENTITY_INSERT [dbo].[CloseTypes] OFF
SET IDENTITY_INSERT [dbo].[Conditions] ON 

INSERT [dbo].[Conditions] ([Id], [Name], [Description]) VALUES (1, N'Brand New', N'All type of product are brand new.')
INSERT [dbo].[Conditions] ([Id], [Name], [Description]) VALUES (2, N'Used', N'In there all type of used product.')
INSERT [dbo].[Conditions] ([Id], [Name], [Description]) VALUES (4, N'Non Used', N'Na')
SET IDENTITY_INSERT [dbo].[Conditions] OFF
SET IDENTITY_INSERT [dbo].[Countries] ON 

INSERT [dbo].[Countries] ([Id], [Name]) VALUES (1, N'Bangladesh')
INSERT [dbo].[Countries] ([Id], [Name]) VALUES (4, N'India')
INSERT [dbo].[Countries] ([Id], [Name]) VALUES (3, N'USA')
SET IDENTITY_INSERT [dbo].[Countries] OFF
SET IDENTITY_INSERT [dbo].[CustomerBillingAddresses] ON 

INSERT [dbo].[CustomerBillingAddresses] ([Id], [CustomerId], [BillingAddress]) VALUES (3, 12, N'H# 505, Collage Road, Shylet Sadar.')
INSERT [dbo].[CustomerBillingAddresses] ([Id], [CustomerId], [BillingAddress]) VALUES (4, 12, N'H# 220, Dhanmondi 32.')
INSERT [dbo].[CustomerBillingAddresses] ([Id], [CustomerId], [BillingAddress]) VALUES (5, 13, N'H# 440, Doctor Para, Rode 6, Chittagong.')
INSERT [dbo].[CustomerBillingAddresses] ([Id], [CustomerId], [BillingAddress]) VALUES (6, 14, N'H# 660, School Road, Alonkar')
INSERT [dbo].[CustomerBillingAddresses] ([Id], [CustomerId], [BillingAddress]) VALUES (7, 15, N'H# 660, Collage Road')
SET IDENTITY_INSERT [dbo].[CustomerBillingAddresses] OFF
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([Id], [Name], [Contact], [Email], [Password], [Pictuer], [GenderId], [JoinDate], [CustomerIPAddress], [CountryId], [CityId], [Address]) VALUES (12, N'Customer 1', N'01754321234', N'customer1@gmail.com', N'12345', N'customerPicture/rida.jpg', 1, CAST(N'2020-06-13T00:00:00.0000000' AS DateTime2), N'::1', 1, 1, N'Collage Road, Dhanmondi 32.')
INSERT [dbo].[Customers] ([Id], [Name], [Contact], [Email], [Password], [Pictuer], [GenderId], [JoinDate], [CustomerIPAddress], [CountryId], [CityId], [Address]) VALUES (13, N'Customer 2', N'01765432123', N'customer2@gmail.com', N'12345', N'customerPicture/images.jpg', 2, CAST(N'2020-06-15T00:00:00.0000000' AS DateTime2), N'::1', 1, 2, N'Alonkar, Chittagong.')
INSERT [dbo].[Customers] ([Id], [Name], [Contact], [Email], [Password], [Pictuer], [GenderId], [JoinDate], [CustomerIPAddress], [CountryId], [CityId], [Address]) VALUES (14, N'Customer 3', N'01743909765', N'customer3@gmail.com', N'12345', N'customerPicture/business.jpg', 1, CAST(N'2020-06-28T00:00:00.0000000' AS DateTime2), N'::1', 1, 2, N'H# 884, Collage Road')
INSERT [dbo].[Customers] ([Id], [Name], [Contact], [Email], [Password], [Pictuer], [GenderId], [JoinDate], [CustomerIPAddress], [CountryId], [CityId], [Address]) VALUES (15, N'Customer 4', N'01743525321', N'customer4@gmail.com', N'12345', N'customerpicture/NoImageFound.png', 1, CAST(N'2020-06-29T00:00:00.0000000' AS DateTime2), N'::1', 1, 1, N'H# 990, Collage Road, Dhaka')
SET IDENTITY_INSERT [dbo].[Customers] OFF
SET IDENTITY_INSERT [dbo].[DeliveryCharges] ON 

INSERT [dbo].[DeliveryCharges] ([Id], [CityId], [Ammount]) VALUES (1, 1, 50)
INSERT [dbo].[DeliveryCharges] ([Id], [CityId], [Ammount]) VALUES (2, 2, 100)
INSERT [dbo].[DeliveryCharges] ([Id], [CityId], [Ammount]) VALUES (3, 3, 100)
INSERT [dbo].[DeliveryCharges] ([Id], [CityId], [Ammount]) VALUES (4, 4, 100)
SET IDENTITY_INSERT [dbo].[DeliveryCharges] OFF
SET IDENTITY_INSERT [dbo].[Genders] ON 

INSERT [dbo].[Genders] ([Id], [Name]) VALUES (2, N'Female')
INSERT [dbo].[Genders] ([Id], [Name]) VALUES (1, N'Male')
SET IDENTITY_INSERT [dbo].[Genders] OFF
SET IDENTITY_INSERT [dbo].[OrderDetails] ON 

INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (7, 5, 14, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (8, 5, 4, 3)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (9, 6, 7, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (10, 6, 5, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (11, 7, 7, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (12, 7, 27, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (13, 8, 25, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (14, 8, 4, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (15, 9, 28, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (16, 9, 14, 3)
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([Id], [OrderNo], [CustomerId], [CouponNumber], [DeliveryChargeId], [OrderDate], [Status], [CustomerBillingAddressId]) VALUES (5, N'10002', 12, N'Na', 3, CAST(N'2020-06-15T00:00:00.0000000' AS DateTime2), 1, 3)
INSERT [dbo].[Orders] ([Id], [OrderNo], [CustomerId], [CouponNumber], [DeliveryChargeId], [OrderDate], [Status], [CustomerBillingAddressId]) VALUES (6, N'10003', 12, N'Na', 1, CAST(N'2020-06-15T00:00:00.0000000' AS DateTime2), 0, 4)
INSERT [dbo].[Orders] ([Id], [OrderNo], [CustomerId], [CouponNumber], [DeliveryChargeId], [OrderDate], [Status], [CustomerBillingAddressId]) VALUES (7, N'10004', 13, N'Na', 2, CAST(N'2020-06-15T00:00:00.0000000' AS DateTime2), 1, 5)
INSERT [dbo].[Orders] ([Id], [OrderNo], [CustomerId], [CouponNumber], [DeliveryChargeId], [OrderDate], [Status], [CustomerBillingAddressId]) VALUES (8, N'10005', 14, N'Na', 2, CAST(N'2020-06-28T00:00:00.0000000' AS DateTime2), 1, 6)
INSERT [dbo].[Orders] ([Id], [OrderNo], [CustomerId], [CouponNumber], [DeliveryChargeId], [OrderDate], [Status], [CustomerBillingAddressId]) VALUES (9, N'10006', 15, N'Na', 1, CAST(N'2020-06-29T00:00:00.0000000' AS DateTime2), 1, 7)
SET IDENTITY_INSERT [dbo].[Orders] OFF
SET IDENTITY_INSERT [dbo].[ProductPhotos] ON 

INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (4, N'productphotos/nokia-5130-e.jpg', 1, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (5, N'productphotos/41knl.jpg', 1, 0, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (6, N'productphotos/keyboard.jpg', 5, 0, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (9, N'productphotos/2003.jpg', 4, 0, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (10, N'productphotos/290.jpg', 4, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (11, N'productphotos/n73-1.jpg', 2, 0, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (12, N'productphotos/n73.jpg', 2, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (13, N'productphotos/A4TECH.jpg', 5, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (14, N'productphotos/712JlBDtl8L.jpg', 3, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (15, N'productphotos/download.jpg', 3, 0, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (16, N'productphotos/Nokia220-4.jpg', 7, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (17, N'productphotos/nokia220-2.jpg', 7, 0, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (18, N'productphotos/Nokia220-1.jpg', 7, 0, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (19, N'productphotos/nokia6-1.jpg', 8, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (20, N'productphotos/nokia61-2.jpg', 8, 0, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (21, N'productphotos/Nokia61-3.jpg', 8, 0, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (22, N'productphotos/nokia72-3.jpg', 9, 0, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (23, N'productphotos/Nokia72-1.jpg', 9, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (24, N'productphotos/nokia1-1.jpg', 10, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (25, N'productphotos/nokia1-2.jpg', 10, 0, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (26, N'productphotos/nokia21-1.jpg', 11, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (27, N'productphotos/nokia21-3.jpg', 11, 0, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (28, N'productphotos/Nokia32-3.jpg', 12, 0, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (29, N'productphotos/nokia32-2.png', 12, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (30, N'productphotos/nokia_51-2.jpg', 13, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (31, N'productphotos/NOKIA51-3.jpg', 13, 0, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (32, N'productphotos/Nokia106-2.jpg', 14, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (33, N'productphotos/Nokia106-4.jpg', 14, 0, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (34, N'productphotos/Pulsar150-1.jpg', 15, 0, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (36, N'productphotos/Pulsar150-3.jpg', 15, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (37, N'productphotos/PulsarNS-1.jpg', 16, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (38, N'productphotos/PulsarNS-2.jpg', 16, 0, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (42, N'productphotos/SXL1-1.jpg', 17, 0, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (43, N'productphotos/SXL1-3.jpg', 17, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (44, N'productphotos/SXperiaL2-1.jpg', 18, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (45, N'productphotos/sxperial2-2.jpg', 18, 0, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (52, N'productphotos/YF 125-2.jpg', 19, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (54, N'productphotos/YMT15-4.jpg', 20, 0, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (55, N'productphotos/YMT15-5.jpg', 20, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (60, N'productphotos/Y15v3-1.jpg', 21, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (61, N'productphotos/9t.webp', 23, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (62, N'productphotos/sony32.jpg', 24, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (63, N'productphotos/1.jpg', 25, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (64, N'productphotos/dow.jpg', 26, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (65, N'productphotos/da.jpg', 28, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (66, N'productphotos/dow90.jpg', 27, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (67, N'productphotos/120.jpg', 29, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (69, N'productphotos/imanS.jpg', 30, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (70, N'productphotos/d70N.jpg', 31, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (71, N'productphotos/d400.jpg', 32, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (72, N'productphotos/d0n.jpg', 33, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (73, N'productphotos/d00nX.jpg', 34, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (74, N'productphotos/d810F.jpg', 35, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (75, N'productphotos/d70fx.jpg', 36, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (77, N'productphotos/G11760-1.jpg', 37, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (78, N'productphotos/n100mini.jpg', 38, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (79, N'productphotos/OP54-3.jpg', 39, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (80, N'productphotos/N60F-3.jpg', 40, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (81, N'productphotos/3300N.jpg', 41, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (82, N'productphotos/9200F.jpg', 42, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (83, N'productphotos/KL7M.jpg', 43, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (84, N'productphotos/MK820-1.jpg', 44, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (85, N'productphotos/HU7P.jpg', 45, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (86, N'productphotos/HU30.jpg', 46, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (87, N'productphotos/HU50.jpg', 47, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (88, N'productphotos/HS28i.jpg', 48, 1, 1)
INSERT [dbo].[ProductPhotos] ([Id], [Photo], [ProductId], [Featured], [Status]) VALUES (89, N'productphotos/99.jpg', 49, 1, 1)
SET IDENTITY_INSERT [dbo].[ProductPhotos] OFF
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (1, N'Nokia XpressMusic 5130c', 3, 2, 1, 2, 4000, 0, N'NA', N'Nice Phone.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (2, N'Nokia N73', 3, 2, 1, 2, 5000, 0, N'NA', N'Nice phone.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (3, N'Sony Xperia Z', 4, 3, 1, 2, 7000, 0, N'NA', N'Nice smart phone.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (4, N'A4Tech Wireless Mouse', 5, 4, 1, 2, 400, 0, N'NA', N'NA', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (5, N'A4Tech Keyboard', 5, 4, 1, 2, 400, 0, N'NA', N'NA', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (7, N'Nokia 220 4G', 3, 2, 1, 2, 2500, 0, N'NA', N'Nice multimedia phone.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (8, N'Nokia 6.1', 4, 2, 1, 2, 8000, 0, N'NA', N'Nice smartphone. ', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (9, N'Nokia 7.2', 4, 2, 1, 2, 8000, 0, N'NA', N'Nice smartphone.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (10, N'Nokia 1', 4, 2, 1, 2, 6000, 0, N'NA', N'Nice smartphone.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (11, N'Nokia 2.1', 4, 2, 1, 2, 7000, 0, N'NA', N'Nice smartphone', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (12, N'Nokia 3.2', 4, 2, 1, 2, 7500, 0, N'NA', N'Nice smartphone.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (13, N'Nokia 5.1', 4, 2, 1, 2, 7000, 0, N'NA', N'Nice smartphone.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (14, N'Nokia 106', 3, 2, 1, 2, 1500, 0, N'NA', N'Nice multimedia phone.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (15, N'Pulsar 150cc', 8, 7, 1, 2, 150000, 0, N'NA', N'Nice bike.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (16, N'Pulsar NS 160cc', 8, 7, 1, 2, 200000, 0, N'NA', N'Nice bike.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (17, N'Sony Xperia L1', 4, 3, 1, 2, 8000, 0, N'NA', N'Nice smartphone.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (18, N'Sony Xperia L2', 4, 3, 1, 2, 8500, 0, N'NA', N'Nice smartphone.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (19, N'Yamaha Fascino 125cc', 8, 8, 1, 2, 80000, 0, N'NA', N'Nice bike.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (20, N'Yamaha MT 15', 8, 8, 1, 2, 250000, 0, N'NA', N'Nice bike', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (21, N'Yamaha R15 V3', 8, 8, 1, 2, 200000, 0, N'NA', N'Nice bike', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (23, N'Test Product', 2, 3, 1, 2, 30000, 28000, N'NA', N'NA', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (24, N'Sony Bravia ', 2, 3, 1, 2, 21000, 19000, N'NA', N'R302E 32 Inch LED TV.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (25, N'Sony Bravia KD', 2, 3, 1, 2, 38000, 36000, N'NA', N'W660E 40 inch', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (26, N'SONY KD - 43X7500F', 2, 3, 1, 2, 54000, 50000, N'NA', N'43 Inch 4K HD Smart TV', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (27, N'ACER K202HQL ', 2, 3, 1, 2, 20000, 17000, N'NA', N'19.5 inch HD LED TV', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (28, N'Sony LC2 ', 2, 3, 1, 2, 22000, 18000, N'NA', N'LED Curved 27 Inch ', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (29, N'Wireless Mouse G3-200N', 5, 4, 1, 2, 700, 650, N'NA', N'Add a touch of sporty look to your computer peripherals with the Vivid Collection. The bright & rich colors will bring a delightful look to your desktop or notebook computer.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (30, N'Wireless Mouse G3-200NS', 5, 4, 1, 2, 900, 800, N'NA', N'Add a touch of sporty look to your computer peripherals with the Vivid Collection. The bright & rich colors will bring a delightful look to your desktop or notebook computer.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (31, N'Wireless Mouse G3-270N', 5, 4, 1, 2, 800, 700, N'NA', N'Add a touch of sporty look to your computer peripherals with the Vivid Collection. The bright & rich colors will bring a delightful look to your desktop or notebook computer.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (32, N'Wireless Mouse G3-400NS', 5, 4, 1, 2, 800, 750, N'NA', N'Add a touch of sporty look to your computer peripherals with the Vivid Collection. The bright & rich colors will bring a delightful look to your desktop or notebook computer.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (33, N'Wireless Mouse G3-310N', 5, 4, 1, 2, 900, 850, N'NA', N'Add a touch of sporty look to your computer peripherals with the Vivid Collection. The bright & rich colors will bring a delightful look to your desktop or notebook computer.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (34, N'Wireless Mouse G7-600NX', 5, 4, 1, 2, 900, 0, N'NA', N'Add a touch of sporty look to your computer peripherals with the Vivid Collection. The bright & rich colors will bring a delightful look to your desktop or notebook computer.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (35, N'Wireless Silent Mouse G10-810FS', 5, 4, 1, 2, 800, 0, N'NA', N'Want to reduce pressure, start from the hand. A comfortable and classic black mouse, combined with powerful functions, help you to cope with messy work easily.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (36, N'Wired Mouse N-70FX', 5, 4, 1, 2, 700, 0, N'NA', N'Contoured shape is for maximum comfort and support. The sturdy scroll wheel with rubber makes sure that your hand will not slip when scrolling.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (37, N'Rechargeable 2.4G Mouse G11-760N', 5, 4, 1, 2, 700, 0, N'NA', N'Want to reduce pressure, start from the hand. A comfortable and classic black mouse, combined with powerful functions, help you to cope with messy work easily.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (38, N'Wired Mouse N-100 Mini', 5, 4, 1, 2, 800, 0, N'NA', N'Contoured shape is for maximum comfort and support. The sturdy scroll wheel with rubber makes sure that your hand will not slip when scrolling.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (39, N'Wired Mouse OP-540NU', 5, 4, 1, 2, 700, 0, N'NA', N'The A4tech optical wheel Mouse with hyper-fast scrolling for increased productivity. A nearly frictionless scroll wheel lets you fly through long documents and Web pages with a single flick. Experience smoother cursor control on virtually any surface. Contoured design gives you more support and control.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (40, N'Wired Mouse N-60F Mini', 5, 4, 1, 2, 700, 0, N'NA', N'Contoured shape is for maximum comfort and support. The sturdy scroll wheel with rubber makes sure that your hand will not slip when scrolling.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (41, N'Wireless Desktop 3300N', 5, 4, 1, 2, 600, 0, N'NA', N'Comfortable full-size keyboard and easy-to-carry 
mouse with snap-on wireless receiver  increase freedom,  
so you can work comfortably away from your computer.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (42, N'Wireless Desktop 9200F', 5, 4, 1, 2, 600, 0, N'NA', N'Comfortable full-size keyboard and easy-to-carry 
mouse with snap-on wireless receiver  increase freedom,  
so you can work comfortably away from your computer.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (43, N'Audio Multimedia Keyboard KL-7MUU', 5, 4, 1, 2, 700, 0, N'NA', N'Ultra Slim Keycap Structure provides comfortable typing. Now it is time to update your Keyboard.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (44, N'HD Metallic Earphone MK-820', 17, 4, 1, 2, 900, 0, N'NA', N'Enables you to listen to music comfortably at lower volumes even in loud environments.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (45, N'Stereo Headset HU-7P', 17, 4, 1, 2, 1000, 0, N'NA', N'Adds balance and tone to your favorite tunes and clarity to your calls. Stunning Sound. Superior Comfort! Fully compatible with applications such as calls, Skype, Messenger and other conversations online.', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (46, N'Stereo HU-30', 17, 4, 1, 2, 1000, 0, N'NA', N'Play, pause, rec, stop, eject! Amazing quality. Stunning Sound. Superior Comfort! The soft ear-pad covers comfortably on-ear to provide absolute sound quality as if you'' re in your own world. In-Line Mic is great for messenger on the PC!', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (47, N'Stereo HU-50', 17, 4, 1, 2, 1200, 0, N'NA', N'Play, pause, rec, stop, eject! Amazing quality. Stunning Sound. Superior Comfort! The soft ear-pad covers comfortably on-ear to provide absolute sound quality as if you'' re in your own world. In-Line Mic is great for messenger on the PC!', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (48, N'Stereo HS-28i', 17, 4, 1, 2, 900, 0, N'NA', N'Play, pause, rec, stop, eject! Amazing quality. Stunning Sound. Superior Comfort! The soft ear-pad covers comfortably on ear to provide absolute sound quality as if you'' re in your own world. In-Line Mic is great for messenger on the PC!', 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [CategoryId], [BrandId], [ConditionId], [CloseTypeId], [RegularPrice], [OfferPrice], [Link], [ProductDetails], [Quantity], [CustomerId]) VALUES (49, N'Test Product 2', 17, 5, 1, 2, 600, 0, N'NA', N'NA', 0, NULL)
SET IDENTITY_INSERT [dbo].[Products] OFF
SET IDENTITY_INSERT [dbo].[PurchaseItems] ON 

INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (5, 3, 1, 1500, 2)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (6, 3, 2, 2000, 2)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (7, 4, 2, 1500, 3)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (8, 5, 3, 6000, 3)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (9, 5, 4, 300, 3)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (10, 6, 3, 6000, 2)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (11, 7, 14, 1200, 6)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (12, 7, 10, 2000, 3)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (13, 8, 7, 1500, 5)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (14, 8, 4, 500, 3)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (15, 9, 5, 300, 6)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (16, 9, 11, 6000, 5)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (17, 9, 12, 6500, 5)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (18, 9, 13, 7000, 5)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (19, 9, 8, 7000, 5)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (20, 9, 9, 7000, 5)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (21, 9, 17, 7000, 5)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (22, 9, 18, 7500, 5)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (23, 10, 15, 140000, 2)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (24, 10, 16, 150000, 2)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (25, 10, 19, 70000, 2)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (26, 10, 20, 200000, 2)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (27, 10, 21, 180000, 2)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (28, 11, 4, 300, 2)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (29, 11, 14, 1500, 3)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (30, 12, 23, 26000, 4)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (31, 13, 27, 15000, 4)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (32, 13, 24, 16000, 4)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (33, 13, 25, 34000, 4)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (34, 13, 26, 47000, 4)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (35, 13, 28, 15000, 4)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (36, 14, 43, 600, 5)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (37, 14, 44, 700, 5)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (38, 14, 37, 600, 5)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (39, 15, 46, 500, 6)
INSERT [dbo].[PurchaseItems] ([Id], [PurchaseId], [ProductId], [Price], [Quantity]) VALUES (40, 15, 14, 1300, 6)
SET IDENTITY_INSERT [dbo].[PurchaseItems] OFF
SET IDENTITY_INSERT [dbo].[PurchasePayments] ON 

INSERT [dbo].[PurchasePayments] ([Id], [PurchaseId], [Date], [DueAmount], [PayAmount]) VALUES (1, 3, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 7000)
INSERT [dbo].[PurchasePayments] ([Id], [PurchaseId], [Date], [DueAmount], [PayAmount]) VALUES (2, 4, CAST(N'2020-03-14T00:00:00.0000000' AS DateTime2), 0, 4500)
INSERT [dbo].[PurchasePayments] ([Id], [PurchaseId], [Date], [DueAmount], [PayAmount]) VALUES (3, 5, CAST(N'2020-06-04T00:00:00.0000000' AS DateTime2), 0, 18900)
INSERT [dbo].[PurchasePayments] ([Id], [PurchaseId], [Date], [DueAmount], [PayAmount]) VALUES (4, 6, CAST(N'2020-06-04T00:00:00.0000000' AS DateTime2), 2000, 10000)
INSERT [dbo].[PurchasePayments] ([Id], [PurchaseId], [Date], [DueAmount], [PayAmount]) VALUES (5, 7, CAST(N'2020-06-05T00:00:00.0000000' AS DateTime2), 0, 13200)
INSERT [dbo].[PurchasePayments] ([Id], [PurchaseId], [Date], [DueAmount], [PayAmount]) VALUES (6, 8, CAST(N'2020-06-05T00:00:00.0000000' AS DateTime2), 0, 9000)
INSERT [dbo].[PurchasePayments] ([Id], [PurchaseId], [Date], [DueAmount], [PayAmount]) VALUES (7, 9, CAST(N'2020-06-13T00:00:00.0000000' AS DateTime2), 800, 241000)
INSERT [dbo].[PurchasePayments] ([Id], [PurchaseId], [Date], [DueAmount], [PayAmount]) VALUES (8, 10, CAST(N'2020-02-13T00:00:00.0000000' AS DateTime2), 0, 1480000)
INSERT [dbo].[PurchasePayments] ([Id], [PurchaseId], [Date], [DueAmount], [PayAmount]) VALUES (9, 11, CAST(N'2020-06-13T00:00:00.0000000' AS DateTime2), 0, 5100)
INSERT [dbo].[PurchasePayments] ([Id], [PurchaseId], [Date], [DueAmount], [PayAmount]) VALUES (10, 12, CAST(N'2020-06-13T00:00:00.0000000' AS DateTime2), 4000, 100000)
INSERT [dbo].[PurchasePayments] ([Id], [PurchaseId], [Date], [DueAmount], [PayAmount]) VALUES (11, 13, CAST(N'2020-06-14T00:00:00.0000000' AS DateTime2), 0, 508000)
INSERT [dbo].[PurchasePayments] ([Id], [PurchaseId], [Date], [DueAmount], [PayAmount]) VALUES (12, 14, CAST(N'2020-06-28T00:00:00.0000000' AS DateTime2), 500, 9000)
INSERT [dbo].[PurchasePayments] ([Id], [PurchaseId], [Date], [DueAmount], [PayAmount]) VALUES (13, 15, CAST(N'2020-06-29T00:00:00.0000000' AS DateTime2), 800, 10000)
SET IDENTITY_INSERT [dbo].[PurchasePayments] OFF
SET IDENTITY_INSERT [dbo].[Purchases] ON 

INSERT [dbo].[Purchases] ([Id], [PurchaseNumber], [SupplierId], [Date], [PurchasePaymentId]) VALUES (3, N'100001', 1, CAST(N'2020-03-12T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Purchases] ([Id], [PurchaseNumber], [SupplierId], [Date], [PurchasePaymentId]) VALUES (4, N'100002', 1, CAST(N'2020-03-14T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Purchases] ([Id], [PurchaseNumber], [SupplierId], [Date], [PurchasePaymentId]) VALUES (5, N'100003', 2, CAST(N'2020-06-04T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Purchases] ([Id], [PurchaseNumber], [SupplierId], [Date], [PurchasePaymentId]) VALUES (6, N'100004', 2, CAST(N'2020-06-04T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Purchases] ([Id], [PurchaseNumber], [SupplierId], [Date], [PurchasePaymentId]) VALUES (7, N'100005', 3, CAST(N'2020-06-05T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Purchases] ([Id], [PurchaseNumber], [SupplierId], [Date], [PurchasePaymentId]) VALUES (8, N'100006', 3, CAST(N'2020-06-05T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Purchases] ([Id], [PurchaseNumber], [SupplierId], [Date], [PurchasePaymentId]) VALUES (9, N'100007', 2, CAST(N'2020-06-13T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Purchases] ([Id], [PurchaseNumber], [SupplierId], [Date], [PurchasePaymentId]) VALUES (10, N'100008', 1, CAST(N'2020-02-13T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Purchases] ([Id], [PurchaseNumber], [SupplierId], [Date], [PurchasePaymentId]) VALUES (11, N'100009', 3, CAST(N'2020-06-13T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Purchases] ([Id], [PurchaseNumber], [SupplierId], [Date], [PurchasePaymentId]) VALUES (12, N'100010', 3, CAST(N'2020-06-13T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Purchases] ([Id], [PurchaseNumber], [SupplierId], [Date], [PurchasePaymentId]) VALUES (13, N'100011', 1, CAST(N'2020-06-14T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Purchases] ([Id], [PurchaseNumber], [SupplierId], [Date], [PurchasePaymentId]) VALUES (14, N'100012', 3, CAST(N'2020-06-28T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Purchases] ([Id], [PurchaseNumber], [SupplierId], [Date], [PurchasePaymentId]) VALUES (15, N'100013', 1, CAST(N'2020-06-29T00:00:00.0000000' AS DateTime2), NULL)
SET IDENTITY_INSERT [dbo].[Purchases] OFF
SET IDENTITY_INSERT [dbo].[Sliders] ON 

INSERT [dbo].[Sliders] ([Id], [PhotoName], [Status]) VALUES (2, N'sliderphoto/3.jpg', 0)
INSERT [dbo].[Sliders] ([Id], [PhotoName], [Status]) VALUES (3, N'sliderphoto/2.png', 1)
INSERT [dbo].[Sliders] ([Id], [PhotoName], [Status]) VALUES (4, N'sliderphoto/3.png', 1)
SET IDENTITY_INSERT [dbo].[Sliders] OFF
SET IDENTITY_INSERT [dbo].[StockProducts] ON 

INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (5, 1, 2, 3)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (6, 2, 2, 3)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (7, 2, 3, 4)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (8, 3, 3, 5)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (9, 4, 3, 5)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (10, 3, 2, 6)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (11, 14, 6, 7)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (12, 10, 3, 7)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (13, 7, 5, 8)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (14, 4, 3, 8)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (15, 5, 6, 9)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (16, 11, 5, 9)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (17, 12, 5, 9)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (18, 13, 5, 9)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (19, 8, 5, 9)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (20, 9, 5, 9)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (21, 17, 5, 9)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (22, 18, 5, 9)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (23, 15, 2, 10)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (24, 16, 2, 10)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (25, 19, 2, 10)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (26, 20, 2, 10)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (27, 21, 2, 10)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (28, 4, 2, 11)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (29, 14, 3, 11)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (30, 23, 4, 12)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (31, 27, 4, 13)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (32, 24, 4, 13)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (33, 25, 4, 13)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (34, 26, 4, 13)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (35, 28, 4, 13)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (36, 43, 5, 14)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (37, 44, 5, 14)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (38, 37, 5, 14)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (39, 46, 6, 15)
INSERT [dbo].[StockProducts] ([Id], [ProductId], [Quantity], [PurchaseId]) VALUES (40, 14, 6, 15)
SET IDENTITY_INSERT [dbo].[StockProducts] OFF
SET IDENTITY_INSERT [dbo].[Suppliers] ON 

INSERT [dbo].[Suppliers] ([Id], [Name], [Email], [ContactNo], [Address]) VALUES (1, N'Pritam Karmakar', N'pritamkarmakar@gmail.com', N'01718139766', N'Lakshmipur Sadar.')
INSERT [dbo].[Suppliers] ([Id], [Name], [Email], [ContactNo], [Address]) VALUES (2, N'Md Saiful Islam', N'saifulislam@gmail.com', N'01743909843', N'Collage road, Maijdee sadar, Noakhali.')
INSERT [dbo].[Suppliers] ([Id], [Name], [Email], [ContactNo], [Address]) VALUES (3, N'Merajul', N'dawnmerajul@gmail.com', N'01750830844', N'Parbatipur, Dinajpur')
SET IDENTITY_INSERT [dbo].[Suppliers] OFF
/****** Object:  Index [IX_Admins_CityId]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_Admins_CityId] ON [dbo].[Admins]
(
	[CityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Admins_ContactNo_Email]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Admins_ContactNo_Email] ON [dbo].[Admins]
(
	[ContactNo] ASC,
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Admins_CountryId]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_Admins_CountryId] ON [dbo].[Admins]
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Brands_Name]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Brands_Name] ON [dbo].[Brands]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Categories_CategoryId]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_Categories_CategoryId] ON [dbo].[Categories]
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Categories_Name]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Categories_Name] ON [dbo].[Categories]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Cities_CountryId]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_Cities_CountryId] ON [dbo].[Cities]
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Cities_Name]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Cities_Name] ON [dbo].[Cities]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_CloseTypes_Name]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_CloseTypes_Name] ON [dbo].[CloseTypes]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Conditions_Name]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Conditions_Name] ON [dbo].[Conditions]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Countries_Name]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Countries_Name] ON [dbo].[Countries]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Coupons_CouponNumber]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Coupons_CouponNumber] ON [dbo].[Coupons]
(
	[CouponNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Coupons_CustomerId]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_Coupons_CustomerId] ON [dbo].[Coupons]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CustomerBillingAddresses_CustomerId]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_CustomerBillingAddresses_CustomerId] ON [dbo].[CustomerBillingAddresses]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Customers_CityId]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_Customers_CityId] ON [dbo].[Customers]
(
	[CityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Customers_CountryId]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_Customers_CountryId] ON [dbo].[Customers]
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Customers_Email_Name]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Customers_Email_Name] ON [dbo].[Customers]
(
	[Email] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Customers_GenderId]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_Customers_GenderId] ON [dbo].[Customers]
(
	[GenderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DeliveryCharges_CityId]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_DeliveryCharges_CityId] ON [dbo].[DeliveryCharges]
(
	[CityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Genders_Name]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Genders_Name] ON [dbo].[Genders]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrderDetails_OrderId]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_OrderDetails_OrderId] ON [dbo].[OrderDetails]
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrderDetails_ProductId]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_OrderDetails_ProductId] ON [dbo].[OrderDetails]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Orders_CustomerBillingAddressId]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_Orders_CustomerBillingAddressId] ON [dbo].[Orders]
(
	[CustomerBillingAddressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Orders_CustomerId]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_Orders_CustomerId] ON [dbo].[Orders]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Orders_DeliveryChargeId]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_Orders_DeliveryChargeId] ON [dbo].[Orders]
(
	[DeliveryChargeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Orders_OrderNo]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Orders_OrderNo] ON [dbo].[Orders]
(
	[OrderNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_ProductPhotos_Photo]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_ProductPhotos_Photo] ON [dbo].[ProductPhotos]
(
	[Photo] ASC
)
WHERE ([Photo] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProductPhotos_ProductId]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_ProductPhotos_ProductId] ON [dbo].[ProductPhotos]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Products_BrandId]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_Products_BrandId] ON [dbo].[Products]
(
	[BrandId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Products_CategoryId]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_Products_CategoryId] ON [dbo].[Products]
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Products_CloseTypeId]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_Products_CloseTypeId] ON [dbo].[Products]
(
	[CloseTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Products_ConditionId]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_Products_ConditionId] ON [dbo].[Products]
(
	[ConditionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Products_CustomerId]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_Products_CustomerId] ON [dbo].[Products]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Products_Name]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Products_Name] ON [dbo].[Products]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PurchaseItems_ProductId]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_PurchaseItems_ProductId] ON [dbo].[PurchaseItems]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PurchaseItems_PurchaseId]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_PurchaseItems_PurchaseId] ON [dbo].[PurchaseItems]
(
	[PurchaseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Purchases_PurchaseNumber]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Purchases_PurchaseNumber] ON [dbo].[Purchases]
(
	[PurchaseNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Purchases_PurchasePaymentId]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_Purchases_PurchasePaymentId] ON [dbo].[Purchases]
(
	[PurchasePaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Purchases_SupplierId]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_Purchases_SupplierId] ON [dbo].[Purchases]
(
	[SupplierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ReturnProducts_OrderId]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_ReturnProducts_OrderId] ON [dbo].[ReturnProducts]
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ReturnProducts_ProductId]    Script Date: 6/29/2020 12:09:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_ReturnProducts_ProductId] ON [dbo].[ReturnProducts]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Sliders_PhotoName]    Script Date: 6/29/2020 12:09:40 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Sliders_PhotoName] ON [dbo].[Sliders]
(
	[PhotoName] ASC
)
WHERE ([PhotoName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_StockProducts_ProductId]    Script Date: 6/29/2020 12:09:40 PM ******/
CREATE NONCLUSTERED INDEX [IX_StockProducts_ProductId] ON [dbo].[StockProducts]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_StockProducts_PurchaseId]    Script Date: 6/29/2020 12:09:40 PM ******/
CREATE NONCLUSTERED INDEX [IX_StockProducts_PurchaseId] ON [dbo].[StockProducts]
(
	[PurchaseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Suppliers_Email_ContactNo]    Script Date: 6/29/2020 12:09:40 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Suppliers_Email_ContactNo] ON [dbo].[Suppliers]
(
	[Email] ASC,
	[ContactNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Tags_ProductId]    Script Date: 6/29/2020 12:09:40 PM ******/
CREATE NONCLUSTERED INDEX [IX_Tags_ProductId] ON [dbo].[Tags]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Tags_TagName]    Script Date: 6/29/2020 12:09:40 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Tags_TagName] ON [dbo].[Tags]
(
	[TagName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Categories] ADD  DEFAULT (CONVERT([bit],(0))) FOR [Status]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (CONVERT([bit],(0))) FOR [Status]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((0)) FOR [CustomerBillingAddressId]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((0)) FOR [Quantity]
GO
ALTER TABLE [dbo].[PurchaseItems] ADD  DEFAULT ((0)) FOR [Quantity]
GO
ALTER TABLE [dbo].[PurchasePayments] ADD  DEFAULT (CONVERT([real],(0))) FOR [DueAmount]
GO
ALTER TABLE [dbo].[PurchasePayments] ADD  DEFAULT (CONVERT([real],(0))) FOR [PayAmount]
GO
ALTER TABLE [dbo].[Admins]  WITH CHECK ADD  CONSTRAINT [FK_Admins_Cities_CityId] FOREIGN KEY([CityId])
REFERENCES [dbo].[Cities] ([Id])
GO
ALTER TABLE [dbo].[Admins] CHECK CONSTRAINT [FK_Admins_Cities_CityId]
GO
ALTER TABLE [dbo].[Admins]  WITH CHECK ADD  CONSTRAINT [FK_Admins_Countries_CountryId] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Countries] ([Id])
GO
ALTER TABLE [dbo].[Admins] CHECK CONSTRAINT [FK_Admins_Countries_CountryId]
GO
ALTER TABLE [dbo].[Categories]  WITH CHECK ADD  CONSTRAINT [FK_Categories_Categories_CategoryId] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([Id])
GO
ALTER TABLE [dbo].[Categories] CHECK CONSTRAINT [FK_Categories_Categories_CategoryId]
GO
ALTER TABLE [dbo].[Cities]  WITH CHECK ADD  CONSTRAINT [FK_Cities_Countries_CountryId] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Countries] ([Id])
GO
ALTER TABLE [dbo].[Cities] CHECK CONSTRAINT [FK_Cities_Countries_CountryId]
GO
ALTER TABLE [dbo].[Coupons]  WITH CHECK ADD  CONSTRAINT [FK_Coupons_Customers_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[Coupons] CHECK CONSTRAINT [FK_Coupons_Customers_CustomerId]
GO
ALTER TABLE [dbo].[CustomerBillingAddresses]  WITH CHECK ADD  CONSTRAINT [FK_CustomerBillingAddresses_Customers_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[CustomerBillingAddresses] CHECK CONSTRAINT [FK_CustomerBillingAddresses_Customers_CustomerId]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Cities_CityId] FOREIGN KEY([CityId])
REFERENCES [dbo].[Cities] ([Id])
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Customers_Cities_CityId]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Countries_CountryId] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Countries] ([Id])
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Customers_Countries_CountryId]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Genders_GenderId] FOREIGN KEY([GenderId])
REFERENCES [dbo].[Genders] ([Id])
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Customers_Genders_GenderId]
GO
ALTER TABLE [dbo].[DeliveryCharges]  WITH CHECK ADD  CONSTRAINT [FK_DeliveryCharges_Cities_CityId] FOREIGN KEY([CityId])
REFERENCES [dbo].[Cities] ([Id])
GO
ALTER TABLE [dbo].[DeliveryCharges] CHECK CONSTRAINT [FK_DeliveryCharges_Cities_CityId]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders_OrderId] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders_OrderId]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Products_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Products_ProductId]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_CustomerBillingAddresses_CustomerBillingAddressId] FOREIGN KEY([CustomerBillingAddressId])
REFERENCES [dbo].[CustomerBillingAddresses] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_CustomerBillingAddresses_CustomerBillingAddressId]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customers_CustomerId]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_DeliveryCharges_DeliveryChargeId] FOREIGN KEY([DeliveryChargeId])
REFERENCES [dbo].[DeliveryCharges] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_DeliveryCharges_DeliveryChargeId]
GO
ALTER TABLE [dbo].[ProductPhotos]  WITH CHECK ADD  CONSTRAINT [FK_ProductPhotos_Products_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[ProductPhotos] CHECK CONSTRAINT [FK_ProductPhotos_Products_ProductId]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Brands_BrandId] FOREIGN KEY([BrandId])
REFERENCES [dbo].[Brands] ([Id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Brands_BrandId]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories_CategoryId] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([Id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories_CategoryId]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_CloseTypes_CloseTypeId] FOREIGN KEY([CloseTypeId])
REFERENCES [dbo].[CloseTypes] ([Id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_CloseTypes_CloseTypeId]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Conditions_ConditionId] FOREIGN KEY([ConditionId])
REFERENCES [dbo].[Conditions] ([Id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Conditions_ConditionId]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Customers_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Customers_CustomerId]
GO
ALTER TABLE [dbo].[PurchaseItems]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseItems_Products_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[PurchaseItems] CHECK CONSTRAINT [FK_PurchaseItems_Products_ProductId]
GO
ALTER TABLE [dbo].[PurchaseItems]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseItems_Purchases_PurchaseId] FOREIGN KEY([PurchaseId])
REFERENCES [dbo].[Purchases] ([Id])
GO
ALTER TABLE [dbo].[PurchaseItems] CHECK CONSTRAINT [FK_PurchaseItems_Purchases_PurchaseId]
GO
ALTER TABLE [dbo].[Purchases]  WITH CHECK ADD  CONSTRAINT [FK_Purchases_PurchasePayments_PurchasePaymentId] FOREIGN KEY([PurchasePaymentId])
REFERENCES [dbo].[PurchasePayments] ([Id])
GO
ALTER TABLE [dbo].[Purchases] CHECK CONSTRAINT [FK_Purchases_PurchasePayments_PurchasePaymentId]
GO
ALTER TABLE [dbo].[Purchases]  WITH CHECK ADD  CONSTRAINT [FK_Purchases_Suppliers_SupplierId] FOREIGN KEY([SupplierId])
REFERENCES [dbo].[Suppliers] ([Id])
GO
ALTER TABLE [dbo].[Purchases] CHECK CONSTRAINT [FK_Purchases_Suppliers_SupplierId]
GO
ALTER TABLE [dbo].[ReturnProducts]  WITH CHECK ADD  CONSTRAINT [FK_ReturnProducts_Orders_OrderId] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
GO
ALTER TABLE [dbo].[ReturnProducts] CHECK CONSTRAINT [FK_ReturnProducts_Orders_OrderId]
GO
ALTER TABLE [dbo].[ReturnProducts]  WITH CHECK ADD  CONSTRAINT [FK_ReturnProducts_Products_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[ReturnProducts] CHECK CONSTRAINT [FK_ReturnProducts_Products_ProductId]
GO
ALTER TABLE [dbo].[StockProducts]  WITH CHECK ADD  CONSTRAINT [FK_StockProducts_Products_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[StockProducts] CHECK CONSTRAINT [FK_StockProducts_Products_ProductId]
GO
ALTER TABLE [dbo].[StockProducts]  WITH CHECK ADD  CONSTRAINT [FK_StockProducts_Purchases_PurchaseId] FOREIGN KEY([PurchaseId])
REFERENCES [dbo].[Purchases] ([Id])
GO
ALTER TABLE [dbo].[StockProducts] CHECK CONSTRAINT [FK_StockProducts_Purchases_PurchaseId]
GO
ALTER TABLE [dbo].[Tags]  WITH CHECK ADD  CONSTRAINT [FK_Tags_Products_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[Tags] CHECK CONSTRAINT [FK_Tags_Products_ProductId]
GO
USE [master]
GO
ALTER DATABASE [ClickToBuy] SET  READ_WRITE 
GO
