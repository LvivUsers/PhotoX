USE [master]
GO
/****** Object:  Database [PhotoXDb]    Script Date: 10/17/2011 23:29:06 ******/
CREATE DATABASE [PhotoXDb] ON  PRIMARY 
( NAME = N'PhotoXDb', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\PhotoXDb.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'PhotoXDb_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\PhotoXDb_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [PhotoXDb] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PhotoXDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PhotoXDb] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [PhotoXDb] SET ANSI_NULLS OFF
GO
ALTER DATABASE [PhotoXDb] SET ANSI_PADDING OFF
GO
ALTER DATABASE [PhotoXDb] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [PhotoXDb] SET ARITHABORT OFF
GO
ALTER DATABASE [PhotoXDb] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [PhotoXDb] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [PhotoXDb] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [PhotoXDb] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [PhotoXDb] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [PhotoXDb] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [PhotoXDb] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [PhotoXDb] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [PhotoXDb] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [PhotoXDb] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [PhotoXDb] SET  DISABLE_BROKER
GO
ALTER DATABASE [PhotoXDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [PhotoXDb] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [PhotoXDb] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [PhotoXDb] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [PhotoXDb] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [PhotoXDb] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [PhotoXDb] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [PhotoXDb] SET  READ_WRITE
GO
ALTER DATABASE [PhotoXDb] SET RECOVERY SIMPLE
GO
ALTER DATABASE [PhotoXDb] SET  MULTI_USER
GO
ALTER DATABASE [PhotoXDb] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [PhotoXDb] SET DB_CHAINING OFF
GO
USE [PhotoXDb]
GO
/****** Object:  Table [dbo].[User]    Script Date: 10/17/2011 23:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](200) NOT NULL,
	[LastName] [nvarchar](200) NOT NULL,
	[MiddleName] [nvarchar](200) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[Password] [binary](500) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[City]    Script Date: 10/17/2011 23:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[City](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Country]    Script Date: 10/17/2011 23:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contact]    Script Date: 10/17/2011 23:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contact](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[EMail] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Photographer]    Script Date: 10/17/2011 23:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Photographer](
	[Id] [int] NOT NULL,
	[Summary] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Photographer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Address]    Script Date: 10/17/2011 23:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Address](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[CityId] [int] NOT NULL,
	[Country] [int] NOT NULL,
 CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Administrator]    Script Date: 10/17/2011 23:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Administrator](
	[Id] [int] NOT NULL,
 CONSTRAINT [PK_Administrator] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserPhoto]    Script Date: 10/17/2011 23:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserPhoto](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Image] [binary](5000) NOT NULL,
 CONSTRAINT [PK_UserPhoto] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Phone]    Script Date: 10/17/2011 23:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Phone](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ContactId] [int] NOT NULL,
	[Number] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_Phone] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KeyWord]    Script Date: 10/17/2011 23:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KeyWord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PhotographerId] [int] NOT NULL,
	[Value] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_KeyWord] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Template]    Script Date: 10/17/2011 23:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Template](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PhotographerId] [int] NOT NULL,
 CONSTRAINT [PK_Template] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Album]    Script Date: 10/17/2011 23:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Album](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PhotographerId] [int] NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Description] [nvarchar](1000) NULL,
	[Date] [date] NOT NULL,
 CONSTRAINT [PK_Album] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AddressCountryCity]    Script Date: 10/17/2011 23:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AddressCountryCity](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AddressId] [int] NOT NULL,
	[CountryId] [int] NOT NULL,
	[CityId] [int] NOT NULL,
 CONSTRAINT [PK_AddressCountryCity] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Photo]    Script Date: 10/17/2011 23:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Photo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AlbumId] [int] NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Description] [nvarchar](200) NULL,
	[Date] [date] NOT NULL,
	[Image] [binary](8000) NOT NULL,
 CONSTRAINT [PK_Photo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  ForeignKey [FK_Contact_User]    Script Date: 10/17/2011 23:29:08 ******/
ALTER TABLE [dbo].[Contact]  WITH CHECK ADD  CONSTRAINT [FK_Contact_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Contact] CHECK CONSTRAINT [FK_Contact_User]
GO
/****** Object:  ForeignKey [FK_Photographer_User]    Script Date: 10/17/2011 23:29:08 ******/
ALTER TABLE [dbo].[Photographer]  WITH CHECK ADD  CONSTRAINT [FK_Photographer_User] FOREIGN KEY([Id])
REFERENCES [dbo].[User] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Photographer] CHECK CONSTRAINT [FK_Photographer_User]
GO
/****** Object:  ForeignKey [FK_Address_User]    Script Date: 10/17/2011 23:29:08 ******/
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_User]
GO
/****** Object:  ForeignKey [FK_Administrator_User]    Script Date: 10/17/2011 23:29:08 ******/
ALTER TABLE [dbo].[Administrator]  WITH CHECK ADD  CONSTRAINT [FK_Administrator_User] FOREIGN KEY([Id])
REFERENCES [dbo].[User] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Administrator] CHECK CONSTRAINT [FK_Administrator_User]
GO
/****** Object:  ForeignKey [FK_UserPhoto_User]    Script Date: 10/17/2011 23:29:08 ******/
ALTER TABLE [dbo].[UserPhoto]  WITH CHECK ADD  CONSTRAINT [FK_UserPhoto_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserPhoto] CHECK CONSTRAINT [FK_UserPhoto_User]
GO
/****** Object:  ForeignKey [FK_Phone_Contact]    Script Date: 10/17/2011 23:29:08 ******/
ALTER TABLE [dbo].[Phone]  WITH CHECK ADD  CONSTRAINT [FK_Phone_Contact] FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contact] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Phone] CHECK CONSTRAINT [FK_Phone_Contact]
GO
/****** Object:  ForeignKey [FK_KeyWord_Photographer]    Script Date: 10/17/2011 23:29:08 ******/
ALTER TABLE [dbo].[KeyWord]  WITH CHECK ADD  CONSTRAINT [FK_KeyWord_Photographer] FOREIGN KEY([PhotographerId])
REFERENCES [dbo].[Photographer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[KeyWord] CHECK CONSTRAINT [FK_KeyWord_Photographer]
GO
/****** Object:  ForeignKey [FK_Template_Photographer]    Script Date: 10/17/2011 23:29:08 ******/
ALTER TABLE [dbo].[Template]  WITH CHECK ADD  CONSTRAINT [FK_Template_Photographer] FOREIGN KEY([PhotographerId])
REFERENCES [dbo].[Photographer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Template] CHECK CONSTRAINT [FK_Template_Photographer]
GO
/****** Object:  ForeignKey [FK_Album_Photographer]    Script Date: 10/17/2011 23:29:08 ******/
ALTER TABLE [dbo].[Album]  WITH CHECK ADD  CONSTRAINT [FK_Album_Photographer] FOREIGN KEY([PhotographerId])
REFERENCES [dbo].[Photographer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Album] CHECK CONSTRAINT [FK_Album_Photographer]
GO
/****** Object:  ForeignKey [FK_AddressCountryCity_Address]    Script Date: 10/17/2011 23:29:08 ******/
ALTER TABLE [dbo].[AddressCountryCity]  WITH CHECK ADD  CONSTRAINT [FK_AddressCountryCity_Address] FOREIGN KEY([AddressId])
REFERENCES [dbo].[Address] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AddressCountryCity] CHECK CONSTRAINT [FK_AddressCountryCity_Address]
GO
/****** Object:  ForeignKey [FK_AddressCountryCity_City]    Script Date: 10/17/2011 23:29:08 ******/
ALTER TABLE [dbo].[AddressCountryCity]  WITH CHECK ADD  CONSTRAINT [FK_AddressCountryCity_City] FOREIGN KEY([CityId])
REFERENCES [dbo].[City] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AddressCountryCity] CHECK CONSTRAINT [FK_AddressCountryCity_City]
GO
/****** Object:  ForeignKey [FK_AddressCountryCity_Country]    Script Date: 10/17/2011 23:29:08 ******/
ALTER TABLE [dbo].[AddressCountryCity]  WITH CHECK ADD  CONSTRAINT [FK_AddressCountryCity_Country] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AddressCountryCity] CHECK CONSTRAINT [FK_AddressCountryCity_Country]
GO
/****** Object:  ForeignKey [FK_Photo_Album]    Script Date: 10/17/2011 23:29:08 ******/
ALTER TABLE [dbo].[Photo]  WITH CHECK ADD  CONSTRAINT [FK_Photo_Album] FOREIGN KEY([AlbumId])
REFERENCES [dbo].[Album] ([Id])
GO
ALTER TABLE [dbo].[Photo] CHECK CONSTRAINT [FK_Photo_Album]
GO
