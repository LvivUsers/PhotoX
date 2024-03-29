/****** Object:  Database [PhotoX]    Script Date: 11/09/2011 16:15:51 ******/
CREATE DATABASE [PhotoX]
GO
ALTER DATABASE [PhotoX] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PhotoX].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PhotoX] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [PhotoX] SET ANSI_NULLS OFF
GO
ALTER DATABASE [PhotoX] SET ANSI_PADDING OFF
GO
ALTER DATABASE [PhotoX] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [PhotoX] SET ARITHABORT OFF
GO
ALTER DATABASE [PhotoX] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [PhotoX] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [PhotoX] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [PhotoX] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [PhotoX] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [PhotoX] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [PhotoX] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [PhotoX] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [PhotoX] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [PhotoX] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [PhotoX] SET  DISABLE_BROKER
GO
ALTER DATABASE [PhotoX] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [PhotoX] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [PhotoX] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [PhotoX] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [PhotoX] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [PhotoX] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [PhotoX] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [PhotoX] SET  READ_WRITE
GO
ALTER DATABASE [PhotoX] SET RECOVERY SIMPLE
GO
ALTER DATABASE [PhotoX] SET  MULTI_USER
GO
ALTER DATABASE [PhotoX] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [PhotoX] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'PhotoX', N'ON'
GO
USE [PhotoX]
GO
/****** Object:  Table [dbo].[Country]    Script Date: 11/09/2011 16:15:54 ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 11/09/2011 16:15:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](200) NOT NULL,
	[LastName] [nvarchar](200) NOT NULL,
	[MiddleName] [nvarchar](200) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[Password] [nvarchar](20) NOT NULL,
	[LastLoginDate] [datetime] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[System]    Script Date: 11/09/2011 16:15:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[System](
	[Version] [int] NOT NULL,
	[Updated] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Photographer]    Script Date: 11/09/2011 16:15:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Photographer](
	[UserId] [int] NOT NULL,
	[Summary] [nvarchar](1000) NOT NULL,
	[Keywords] [nvarchar](100) NOT NULL,
	[Phone] [nchar](12) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[City] [nvarchar](50) NOT NULL,
	[CountryId] [int] NOT NULL,
 CONSTRAINT [PK_Photographer] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Viewer]    Script Date: 11/09/2011 16:15:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Viewer](
	[UserId] [int] NOT NULL,
	[Phone] [nchar](12) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Viewer] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Administrator]    Script Date: 11/09/2011 16:15:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Administrator](
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_Administrator] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Avatar]    Script Date: 11/09/2011 16:15:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Avatar](
	[UserId] [int] NOT NULL,
	[Image] [binary](5000) NOT NULL,
 CONSTRAINT [PK_UserPhoto_1] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Album]    Script Date: 11/09/2011 16:15:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Album](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PhotographerId] [int] NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Description] [nvarchar](1000) NOT NULL,
	[DateCreated] [date] NOT NULL,
 CONSTRAINT [PK_Album] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Photo]    Script Date: 11/09/2011 16:15:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Photo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AlbumId] [int] NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Description] [nvarchar](200) NOT NULL,
	[DateCreated] [date] NOT NULL,
	[Image] [image] NOT NULL,
 CONSTRAINT [PK_Photo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Default [DF__User__LastLoginD__25869641]    Script Date: 11/09/2011 16:15:54 ******/
ALTER TABLE [dbo].[User] ADD  DEFAULT (getdate()) FOR [LastLoginDate]
GO
/****** Object:  ForeignKey [FK_Photographer_Country]    Script Date: 11/09/2011 16:15:54 ******/
ALTER TABLE [dbo].[Photographer]  WITH CHECK ADD  CONSTRAINT [FK_Photographer_Country] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([Id])
GO
ALTER TABLE [dbo].[Photographer] CHECK CONSTRAINT [FK_Photographer_Country]
GO
/****** Object:  ForeignKey [FK_Photographer_User]    Script Date: 11/09/2011 16:15:54 ******/
ALTER TABLE [dbo].[Photographer]  WITH CHECK ADD  CONSTRAINT [FK_Photographer_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Photographer] CHECK CONSTRAINT [FK_Photographer_User]
GO
/****** Object:  ForeignKey [FK_Viewer_User]    Script Date: 11/09/2011 16:15:54 ******/
ALTER TABLE [dbo].[Viewer]  WITH CHECK ADD  CONSTRAINT [FK_Viewer_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Viewer] CHECK CONSTRAINT [FK_Viewer_User]
GO
/****** Object:  ForeignKey [FK_Administrator_User]    Script Date: 11/09/2011 16:15:54 ******/
ALTER TABLE [dbo].[Administrator]  WITH CHECK ADD  CONSTRAINT [FK_Administrator_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Administrator] CHECK CONSTRAINT [FK_Administrator_User]
GO
/****** Object:  ForeignKey [FK_UserPhoto_User]    Script Date: 11/09/2011 16:15:54 ******/
ALTER TABLE [dbo].[Avatar]  WITH CHECK ADD  CONSTRAINT [FK_UserPhoto_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Avatar] CHECK CONSTRAINT [FK_UserPhoto_User]
GO
/****** Object:  ForeignKey [FK_Album_Photographer]    Script Date: 11/09/2011 16:15:54 ******/
ALTER TABLE [dbo].[Album]  WITH CHECK ADD  CONSTRAINT [FK_Album_Photographer] FOREIGN KEY([PhotographerId])
REFERENCES [dbo].[Photographer] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Album] CHECK CONSTRAINT [FK_Album_Photographer]
GO
/****** Object:  ForeignKey [FK_Photo_Album]    Script Date: 11/09/2011 16:15:54 ******/
ALTER TABLE [dbo].[Photo]  WITH CHECK ADD  CONSTRAINT [FK_Photo_Album] FOREIGN KEY([AlbumId])
REFERENCES [dbo].[Album] ([Id])
GO
ALTER TABLE [dbo].[Photo] CHECK CONSTRAINT [FK_Photo_Album]
GO
