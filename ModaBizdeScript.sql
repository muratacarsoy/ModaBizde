USE [master]
GO
/****** Object:  Database [ModaBizde]    Script Date: 29.11.2016 23:45:13 ******/
CREATE DATABASE [ModaBizde]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ModaBizde', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\ModaBizde.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ModaBizde_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\ModaBizde_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ModaBizde] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ModaBizde].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ModaBizde] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ModaBizde] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ModaBizde] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ModaBizde] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ModaBizde] SET ARITHABORT OFF 
GO
ALTER DATABASE [ModaBizde] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ModaBizde] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ModaBizde] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ModaBizde] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ModaBizde] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ModaBizde] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ModaBizde] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ModaBizde] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ModaBizde] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ModaBizde] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ModaBizde] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ModaBizde] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ModaBizde] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ModaBizde] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ModaBizde] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ModaBizde] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ModaBizde] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ModaBizde] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ModaBizde] SET  MULTI_USER 
GO
ALTER DATABASE [ModaBizde] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ModaBizde] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ModaBizde] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ModaBizde] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [ModaBizde] SET DELAYED_DURABILITY = DISABLED 
GO
USE [ModaBizde]
GO
/****** Object:  UserDefinedFunction [dbo].[SplitWords]    Script Date: 29.11.2016 23:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SplitWords](@metin varchar(max))
   RETURNS @kelimeler TABLE (
      pos smallint primary key,
      kelime varchar(max)
   )
AS
BEGIN
   DECLARE
      @pos smallint,
      @i smallint,
      @j smallint,
      @s varchar(max)

   SET @pos = 1
   WHILE @pos <= LEN(@metin) 
   BEGIN 
      SET @i = CHARINDEX(' ', @metin, @pos)
      SET @j = CHARINDEX(',', @metin, @pos)
      IF @i > 0 OR @j > 0
      BEGIN
         IF @i = 0 OR (@j > 0 AND @j < @i)
            SET @i = @j

         IF @i > @pos
         BEGIN
            SET @s = SUBSTRING(@metin, @pos, @i - @pos)

            INSERT INTO @kelimeler
            VALUES (@pos, @s)
         END 
         SET @pos = @i + 1

         WHILE @pos < LEN(@metin)
            AND SUBSTRING(@metin, @pos, 1) IN (' ', ',')
            SET @pos = @pos + 1 
      END 
      ELSE 
      BEGIN 
         INSERT INTO @kelimeler 
         VALUES (@pos, SUBSTRING(@metin, @pos, LEN(@metin) - @pos + 1))

         SET @pos = LEN(@metin) + 1 
      END 
   END 
   RETURN 
END

GO
/****** Object:  Table [dbo].[Beden]    Script Date: 29.11.2016 23:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Beden](
	[BedenID] [int] IDENTITY(1,1) NOT NULL,
	[BedenBoyu] [varchar](max) NULL,
 CONSTRAINT [PK_Beden] PRIMARY KEY CLUSTERED 
(
	[BedenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BedenvsUrun]    Script Date: 29.11.2016 23:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BedenvsUrun](
	[BedenID] [int] NULL,
	[UrunID] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Blog]    Script Date: 29.11.2016 23:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Blog](
	[BlogID] [int] IDENTITY(1,1) NOT NULL,
	[UyeID] [int] NULL,
	[BlogAdi] [varchar](max) NULL,
	[BlogResmi] [varchar](max) NULL,
	[Tarih] [datetime] NULL CONSTRAINT [DF_Blog_Tarih]  DEFAULT (getdate()),
	[OnBilgi] [varchar](max) NULL,
	[Icerik] [varchar](max) NULL,
	[BlogGrubuID] [int] NULL,
 CONSTRAINT [PK_Blog] PRIMARY KEY CLUSTERED 
(
	[BlogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BlogGrubu]    Script Date: 29.11.2016 23:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BlogGrubu](
	[BlogGrubuID] [int] IDENTITY(1,1) NOT NULL,
	[GrupAdi] [varchar](max) NULL,
 CONSTRAINT [PK_BlogGrubu] PRIMARY KEY CLUSTERED 
(
	[BlogGrubuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BlogTag]    Script Date: 29.11.2016 23:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlogTag](
	[BlogTagID] [int] IDENTITY(1,1) NOT NULL,
	[BlogID] [int] NULL,
	[TagID] [int] NULL,
 CONSTRAINT [PK_BlogTag] PRIMARY KEY CLUSTERED 
(
	[BlogTagID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BlogYorum]    Script Date: 29.11.2016 23:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BlogYorum](
	[BlogYorumID] [int] IDENTITY(1,1) NOT NULL,
	[BlogID] [int] NULL,
	[UyeID] [int] NULL,
	[Yorum] [varchar](max) NULL,
	[Tarih] [datetime] NULL,
 CONSTRAINT [PK_BlogYorum] PRIMARY KEY CLUSTERED 
(
	[BlogYorumID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Fatura]    Script Date: 29.11.2016 23:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Fatura](
	[FaturaID] [int] IDENTITY(1,1) NOT NULL,
	[Tarih] [datetime] NULL CONSTRAINT [DF_Fatura_Tarih]  DEFAULT (getdate()),
	[TcKimlik] [char](11) NULL,
	[KdvOrani] [real] NULL CONSTRAINT [DF_Fatura_KdvOrani]  DEFAULT ((0.08)),
	[ToplamTutar] [money] NULL,
	[KargoID] [int] NULL,
	[OdemeSekli] [varchar](max) NULL,
 CONSTRAINT [PK_Fatura] PRIMARY KEY CLUSTERED 
(
	[FaturaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FaturaDetay]    Script Date: 29.11.2016 23:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FaturaDetay](
	[DetayID] [int] IDENTITY(1,1) NOT NULL,
	[FaturaID] [int] NULL,
	[UrunId] [int] NULL,
	[Miktar] [int] NULL,
 CONSTRAINT [PK_FaturaDetay] PRIMARY KEY CLUSTERED 
(
	[DetayID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Kargo]    Script Date: 29.11.2016 23:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Kargo](
	[KargoID] [int] IDENTITY(1,1) NOT NULL,
	[KargoAdi] [varchar](max) NULL,
	[Aciklama] [varchar](max) NULL,
 CONSTRAINT [PK_Kargo] PRIMARY KEY CLUSTERED 
(
	[KargoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Kategori]    Script Date: 29.11.2016 23:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Kategori](
	[KategoriID] [int] IDENTITY(1,1) NOT NULL,
	[KategoriAdi] [varchar](max) NULL,
 CONSTRAINT [PK_Kategori] PRIMARY KEY CLUSTERED 
(
	[KategoriID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Marka]    Script Date: 29.11.2016 23:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Marka](
	[MarkaID] [int] IDENTITY(1,1) NOT NULL,
	[MarkaAdi] [varchar](max) NULL,
 CONSTRAINT [PK_Marka] PRIMARY KEY CLUSTERED 
(
	[MarkaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Musteri]    Script Date: 29.11.2016 23:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Musteri](
	[TcKimlik] [char](11) NOT NULL,
	[AdSoyad] [varchar](max) NULL,
	[Adres] [varchar](max) NULL,
	[Telefon] [varchar](max) NULL,
	[Email] [varchar](max) NULL,
	[Kurum] [varchar](max) NULL,
 CONSTRAINT [PK_Musteri] PRIMARY KEY CLUSTERED 
(
	[TcKimlik] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OneCikanUrunler]    Script Date: 29.11.2016 23:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OneCikanUrunler](
	[CikanID] [int] IDENTITY(1,1) NOT NULL,
	[UrunID] [int] NULL,
 CONSTRAINT [PK_OneCikanUrunler] PRIMARY KEY CLUSTERED 
(
	[CikanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Renk]    Script Date: 29.11.2016 23:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Renk](
	[RenkID] [int] IDENTITY(1,1) NOT NULL,
	[RenkAdi] [varchar](max) NULL,
 CONSTRAINT [PK_Renk] PRIMARY KEY CLUSTERED 
(
	[RenkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RenkvsUrun]    Script Date: 29.11.2016 23:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RenkvsUrun](
	[RenkID] [int] NULL,
	[UrunID] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SiparisDurum]    Script Date: 29.11.2016 23:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SiparisDurum](
	[DurumID] [int] IDENTITY(1,1) NOT NULL,
	[FaturaID] [int] NOT NULL,
	[OnayVeriliyor] [bit] NULL,
	[Onaylandi] [bit] NULL,
	[KargoyaVerildi] [bit] NULL,
	[IptalEdildi] [bit] NULL,
	[Hazirlaniyor] [bit] NULL,
	[IadeEdildi] [bit] NULL,
 CONSTRAINT [PK_SiparisDurum] PRIMARY KEY CLUSTERED 
(
	[DurumID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tag]    Script Date: 29.11.2016 23:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tag](
	[TagID] [int] IDENTITY(1,1) NOT NULL,
	[TagAdi] [varchar](max) NULL,
	[TagAramaSayisi] [int] NULL CONSTRAINT [DF_Tag_TagAramaSayisi]  DEFAULT ((0)),
 CONSTRAINT [PK_Tag] PRIMARY KEY CLUSTERED 
(
	[TagID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Urun]    Script Date: 29.11.2016 23:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Urun](
	[UrunID] [int] IDENTITY(1,1) NOT NULL,
	[UrunAdi] [varchar](max) NULL,
	[BitisSuresi] [datetime] NULL,
	[BirimFiyat] [money] NULL,
	[MarkaID] [int] NULL,
	[Tarih] [date] NULL CONSTRAINT [DF_Urun_Tarih]  DEFAULT (getdate()),
	[Aciklama] [varchar](max) NULL,
	[GrupID] [int] NULL,
	[DepoyaGirenMiktar] [int] NULL,
	[KullanilanMiktar] [int] NULL,
	[NetMiktar] [int] NULL,
	[GoruntulenmeSayisi] [int] NULL CONSTRAINT [DF_Urun_GoruntulenmeSayisi]  DEFAULT ((0)),
	[Begeniler] [int] NULL CONSTRAINT [DF_Urun_Begeniler]  DEFAULT ((0)),
	[FiyatPuani] [float] NULL,
	[DegerPuani] [float] NULL,
	[KalitePuani] [float] NULL,
 CONSTRAINT [PK_Urun] PRIMARY KEY CLUSTERED 
(
	[UrunID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UrunGorseli]    Script Date: 29.11.2016 23:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UrunGorseli](
	[GorselID] [int] IDENTITY(1,1) NOT NULL,
	[UrunID] [int] NULL,
	[GorselAdres] [varchar](max) NULL,
 CONSTRAINT [PK_UrunGorseli] PRIMARY KEY CLUSTERED 
(
	[GorselID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UrunGrubu]    Script Date: 29.11.2016 23:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UrunGrubu](
	[GrupID] [int] IDENTITY(1,1) NOT NULL,
	[GrupAdi] [varchar](max) NULL,
	[KategoriID] [int] NULL,
 CONSTRAINT [PK_UrunGrubu] PRIMARY KEY CLUSTERED 
(
	[GrupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UrunPuan]    Script Date: 29.11.2016 23:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UrunPuan](
	[PuanID] [int] IDENTITY(1,1) NOT NULL,
	[UyeID] [int] NULL,
	[UrunID] [int] NULL,
	[FiyatPuani] [float] NULL CONSTRAINT [DF_UrunPuan_FiyatPuani]  DEFAULT ((-1)),
	[DegerPuani] [float] NULL CONSTRAINT [DF_UrunPuan_DegerPuani]  DEFAULT ((-1)),
	[KalitePuani] [float] NULL CONSTRAINT [DF_UrunPuan_KalitePuani]  DEFAULT ((-1)),
	[Begeni] [bit] NULL CONSTRAINT [DF_UrunPuan_Begeni]  DEFAULT ((0)),
	[Baslik] [varchar](max) NULL,
	[Yorum] [varchar](max) NULL,
	[Tarih] [datetime] NULL,
 CONSTRAINT [PK_UrunPuan] PRIMARY KEY CLUSTERED 
(
	[PuanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UrunTag]    Script Date: 29.11.2016 23:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UrunTag](
	[UrunTagID] [int] IDENTITY(1,1) NOT NULL,
	[TagID] [int] NULL,
	[UrunID] [int] NULL,
 CONSTRAINT [PK_UrunTag] PRIMARY KEY CLUSTERED 
(
	[UrunTagID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Uye]    Script Date: 29.11.2016 23:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Uye](
	[UyeID] [int] IDENTITY(1,1) NOT NULL,
	[KullaniciAdi] [varchar](max) NULL,
	[Sifre] [varchar](max) NULL,
	[Tarih] [datetime] NULL CONSTRAINT [DF_Uye_Tarih]  DEFAULT (getdate()),
	[Mail] [varchar](max) NULL,
	[Songiris] [datetime] NULL,
	[AdSoyad] [varchar](max) NULL,
	[TcKimlik] [char](11) NULL,
	[Engelli] [bit] NULL CONSTRAINT [DF_Uye_Engelli]  DEFAULT ((0)),
	[BlogYazmaDuzenleme] [bit] NULL CONSTRAINT [DF_Uye_BlogYazmaDuzenleme]  DEFAULT ((0)),
	[BlogYonetme] [bit] NULL CONSTRAINT [DF_Uye_BlogYonetme]  DEFAULT ((0)),
	[UrunGirmeDuzenleme] [bit] NULL CONSTRAINT [DF_Uye_UrunGirmeDuzenleme]  DEFAULT ((0)),
	[UrunSilme] [bit] NULL CONSTRAINT [DF_Uye_UrunSilme]  DEFAULT ((0)),
	[FaturaIslemleri] [bit] NULL CONSTRAINT [DF_Uye_FaturaIslemleri]  DEFAULT ((0)),
	[SiteUnsurlari] [bit] NULL CONSTRAINT [DF_Uye_SiteUnsurlari]  DEFAULT ((0)),
	[Yetkilendirme] [bit] NULL CONSTRAINT [DF_Uye_Yetkilendirme]  DEFAULT ((0)),
 CONSTRAINT [PK_Uye] PRIMARY KEY CLUSTERED 
(
	[UyeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Beden] ON 

INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (1, N'xxSmall')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (2, N'xSmall')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (3, N'Medium')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (4, N'Large')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (5, N'Xlarge')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (6, N'XXLarge')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (7, N'3xLarge')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (8, N'3/4 Yaş')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (9, N'4/5 Yaş')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (10, N'5/6 Yaş')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (11, N'6/7 Yaş')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (12, N'7/8 Yaş')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (13, N'8/9 Yaş')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (14, N'9/10 Yaş')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (15, N'50')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (16, N'52')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (17, N'STD')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (18, N'80 cm')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (19, N'85 cm')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (20, N'90 cm')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (21, N'95 cm')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (22, N'100 cm')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (23, N'105 cm')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (24, N'67 Bel')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (25, N'70 Bel')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (26, N'72 Bel')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (27, N'75 Bel')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (28, N'78 Bel')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (29, N'80 Bel')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (30, N'83 Bel')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (31, N'85 Bel')
INSERT [dbo].[Beden] ([BedenID], [BedenBoyu]) VALUES (32, N'88 Bel')
SET IDENTITY_INSERT [dbo].[Beden] OFF
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (1, 1)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (2, 1)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 1)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (1, 2)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (2, 2)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (2, 34)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 34)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (4, 34)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (5, 34)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (4, 35)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (1, 1)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (2, 1)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 1)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (1, 2)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (2, 2)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (5, 35)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (2, 36)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (4, 36)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (6, 36)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (24, 37)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 13)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (4, 13)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (5, 13)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (6, 13)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (2, 12)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 12)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (4, 12)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (5, 12)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (6, 12)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 14)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (4, 14)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (5, 14)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (6, 14)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 15)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (4, 15)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 16)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (4, 16)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (5, 16)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (6, 16)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (7, 16)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (8, 17)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (9, 17)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (10, 17)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (11, 17)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (12, 17)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (14, 17)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (1, 1)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (2, 2)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 1)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (25, 37)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (26, 37)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (27, 37)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (28, 37)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 2)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (1, 1)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (2, 1)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 1)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (1, 2)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (1, 2)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (29, 37)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (30, 37)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (31, 37)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (32, 37)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (2, 38)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (1, 1)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (2, 1)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 1)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (1, 2)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (2, 2)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 38)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (4, 38)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (5, 38)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (2, 39)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 39)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (1, 1)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (2, 1)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 1)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (1, 2)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (2, 2)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 2)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (4, 39)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (5, 39)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (1, 1)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (2, 1)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 1)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (1, 2)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (2, 2)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 13)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (4, 13)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (5, 13)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (6, 13)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (2, 12)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 12)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (4, 12)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (5, 12)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (6, 12)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 14)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (4, 14)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (5, 14)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (6, 14)
GO
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 15)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (4, 15)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 16)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (4, 16)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (5, 16)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (6, 16)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (7, 16)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (8, 17)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (9, 17)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (10, 17)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (11, 17)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (12, 17)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (14, 17)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (2, 22)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 22)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (5, 22)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (6, 22)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (2, 23)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 23)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (4, 23)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (5, 23)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (2, 27)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 27)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (5, 27)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (6, 27)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (7, 27)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 30)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (4, 30)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (5, 30)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (6, 30)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 31)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (4, 31)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (5, 31)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (6, 31)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 32)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (4, 32)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (5, 32)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (6, 32)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (7, 32)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (2, 33)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 33)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (4, 33)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (5, 33)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (6, 33)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (7, 33)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (2, 18)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 18)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (4, 18)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (5, 18)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (6, 18)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (2, 19)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 19)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (4, 19)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (5, 19)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 20)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (4, 20)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 21)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (4, 21)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (5, 21)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (6, 21)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (17, 24)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (2, 25)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 25)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (4, 25)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (5, 25)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (6, 25)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (7, 25)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (2, 26)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (3, 26)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (4, 26)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (5, 26)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (6, 26)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (18, 28)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (19, 28)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (20, 28)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (21, 28)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (22, 28)
INSERT [dbo].[BedenvsUrun] ([BedenID], [UrunID]) VALUES (23, 28)
SET IDENTITY_INSERT [dbo].[Blog] ON 

INSERT [dbo].[Blog] ([BlogID], [UyeID], [BlogAdi], [BlogResmi], [Tarih], [OnBilgi], [Icerik], [BlogGrubuID]) VALUES (4, 2, N'Renkli elbiselerle 4 hafta sonu kombini', N'http://www.buseterim.com.tr/posts/hf_03_04_680.jpg', CAST(N'2016-11-20 17:17:26.320' AS DateTime), N'<span class="headline">Sonbaharın gelmesi ile birlikte kısa botlar da tekrar gün yüzüne çıkmaya başladı. Mevsim geçişlerinde eteklerin, elbiselerin ve şortların da altına giyerek cool bir görünüm elde edebileceğiniz botlarda bu sezon trend ise yine bilekte botlar!</span>', N'<span class="headline">Sonbaharın gelmesi ile birlikte kısa botlar da tekrar gün yüzüne çıkmaya başladı. Mevsim geçişlerinde eteklerin, elbiselerin ve şortların da altına giyerek cool bir görünüm elde edebileceğiniz botlarda bu sezon trend ise yine bilekte botlar!</span>
<span class="txt"><p>Christian Dior’un iki sezon önceki defilesi ile tanımıştık aslında bu trendi… Şeffaf topuklu plastik görünümlü botları sezonun en hit parçası olmuştu.</p>
<p>Bilekten bot bilek hizasından biraz daha uzun olan botlar oluyor. O sebeple bilek yapınızı daha ince ve bacaklarınızı daha uzun gösterebiliyor. O dönemden beri de bilekten botlar trend olmayı sürdürüyor. Bu sezon ise tamamen deri ya da yumuşak, esnek güderiden yapılan bilekten botlar yine daha önce de olduğu gibi kalın kısa topuklarla tasarlandı.</p>
<p><strong>NASIL KOMBİNLERİM?</strong></p>
<p>Mini elbiselerin altına giyebileceğiniz gibi kot pantolonunuzla tercih edebilirsiniz. Özellikle culotte tipi pantolonlar ile oldukça iyi bir ikili oluşturuyorlar. Kalın topuklu olmaları sizi hem şık gösterecek hem de rahat ettirecektir.</p>
<p>&nbsp;Son olarak, eğer bilek kısmınızın kalın oluşundan şikayetçiyseniz bu trend sizin için çok doğru olmayabilir. O takdirde tam olarak bilekte biten kısa botlar sizi daha iyi gösterecektir.&nbsp;</p>
</span>', 2)
INSERT [dbo].[Blog] ([BlogID], [UyeID], [BlogAdi], [BlogResmi], [Tarih], [OnBilgi], [Icerik], [BlogGrubuID]) VALUES (5, 4, N'Trend alarmı: Bilekte botlar', N'http://www.buseterim.com.tr/posts/bilekten_botlar_kapak_680.jpg', CAST(N'2016-11-22 17:18:14.900' AS DateTime), N'<span class=headline>Sonbaharın gelmesi ile birlikte kısa botlar da tekrar gün yüzüne çıkmaya başladı. Mevsim geçişlerinde eteklerin, elbiselerin ve şortların da altına giyerek cool bir görünüm elde edebileceğiniz botlarda bu sezon trend ise yine bilekte botlar!</span>', N'<span class="txt">
<p>Christian Dior’un iki sezon önceki defilesi ile tanımıştık aslında bu trendi… Şeffaf topuklu plastik görünümlü botları sezonun en hit parçası olmuştu.</p>
<p>Bilekten bot bilek hizasından biraz daha uzun olan botlar oluyor. O sebeple bilek yapınızı daha ince ve bacaklarınızı daha uzun gösterebiliyor. O dönemden beri de bilekten botlar trend olmayı sürdürüyor. Bu sezon ise tamamen deri ya da yumuşak, esnek güderiden yapılan bilekten botlar yine daha önce de olduğu gibi kalın kısa topuklarla tasarlandı.</p>
<p><strong>NASIL KOMBİNLERİM?</strong></p>
<p>Mini elbiselerin altına giyebileceğiniz gibi kot pantolonunuzla tercih edebilirsiniz. Özellikle culotte tipi pantolonlar ile oldukça iyi bir ikili oluşturuyorlar. Kalın topuklu olmaları sizi hem şık gösterecek hem de rahat ettirecektir.</p>
<p>&nbsp;Son olarak, eğer bilek kısmınızın kalın oluşundan şikayetçiyseniz bu trend sizin için çok doğru olmayabilir. O takdirde tam olarak bilekte biten kısa botlar sizi daha iyi gösterecektir.&nbsp;</p>
</span>', 4)
INSERT [dbo].[Blog] ([BlogID], [UyeID], [BlogAdi], [BlogResmi], [Tarih], [OnBilgi], [Icerik], [BlogGrubuID]) VALUES (6, 4, N'Pastel bir kışa hazır mısınız?', N'http://www.buseterim.com.tr/posts/sezonun_ikilisi_680.jpg', CAST(N'2016-11-28 17:19:10.373' AS DateTime), N'<span class="headline">Bu sezon bizi hafifletecek, sakinleştirecek ve her zamankinden daha genç ve zarif gösterecek bir rüyaya dalıyoruz! Sezonun favori ikilisi açık renk kot parçalar ile pastel renkte parçalar oluyor.</span>', N'<span class="txt">
<p>Özellikle pudra pembesi renginin açık renk kotlarla uyumunu sevmeyeniniz var mı ki? Lise yıllarına bizi sürükleyen bu ikili şimdi modern zamanların şehirli kadın figürlerine bürünmeye hazır.</p>
<p>Sonbaharın sonlarında ve kış döneminde büyük beden örgü ya da yünlü pudra rengi kazaklarla birlikte çok daha trend bir görünüm kazanacak bu ikiliye bu sezon dolaplarınızda yer vermenin tam zamanı.</p>
<p><strong>NASIL KOMBİNLERİM?</strong></p>
<p>Bu ikiliyi siyah bir botla tamamlayarak zıt görünümün gücünden destek alabilirsiniz ve daha grunge ve asi bir hava yaratabilirsiniz.</p>
<p>Geçmişin ruhunu bir tık daha ileriye taşımak adına benzer tonlarda renkli çoraplar ve sneakerlar ile kullanabilirsiniz. Bot ya da düz taban ayakkabılar ile birlikte daha spor bir stil sergileyecek olan sezonun favori ikilisi renkli ve eğlenceli bir topuklu ile de sizi günün yıldızı yapabilir. Seçim size kalmış!&nbsp;</p>
</span>', 4)
INSERT [dbo].[Blog] ([BlogID], [UyeID], [BlogAdi], [BlogResmi], [Tarih], [OnBilgi], [Icerik], [BlogGrubuID]) VALUES (7, 4, N'COS''un ilham kaynağı ünlü ressam', N'http://www.buseterim.com.tr/posts/cos_guggenheim_680.jpg', CAST(N'2016-11-29 20:31:38.213' AS DateTime), N'<span class="headline">Guggenheim Müzesi’nin gelmiş geçmiş en büyük retrospektif sergilerinden biri olma özelliğine sahip, ABD’li ressam Agnes Martin sergisinin sponsoru olan COS, sanatçıdan ilham alan, kadın ve erkek parçalarını içeren toplam 12 parçalık bir kapsül koleksiyon hazırladı.</span>', N'<span class="txt">
                <p>
	20. yüzyılın önde gelen ressamlarından olan Agnes Martin vizyoner bir sanatçı olarak çalışmalarıyla soyut dışavurumcu &nbsp;ve minimalist akımlar arasında bir köprü oluşturdu. Narin renk paleti, geometrik çizgi ve örgüleri ile tanınan sanatçı uzun yıllardır COS tasarım ekibine ilham kaynağı oluyor.</p>
<p>
	Koleksiyonda kullanılan her bir tekstil baskısı, COS tasarım ekibi tarafından Agnes Martin’in belirli eserleri referans alınarak geliştirildi. Sanatçının kompozisyonunu yeniden canlandırmak için keten ve kanvas gibi natürel kumaşlar ile yumuşak renkler koleksiyonda ön plana çıkarıldı. Martin’ in eserlerinde yansıtılan sakin, organik ve düzensiz havayı yakalamak için kareler ve çizgiler elde çizildi ve dikildi. Koleksiyonun silueti, kalıpları geniş kesimli çalışıldı, bitirişler ise tıpkı sanatçının giydiği tarzda iş kıyafetlerinden ilham alınarak tasarlandı.</p>
<p>
	COS x Agnes Martin koleksiyonu 7 Ekim itibariyle Guggenheim Müze mağazasında, dünya çapında belirli mağazalarda satışa sunuldu. &nbsp;&nbsp;</p>
			          </span>', 3)
SET IDENTITY_INSERT [dbo].[Blog] OFF
SET IDENTITY_INSERT [dbo].[BlogGrubu] ON 

INSERT [dbo].[BlogGrubu] ([BlogGrubuID], [GrupAdi]) VALUES (1, N'Alışveriş')
INSERT [dbo].[BlogGrubu] ([BlogGrubuID], [GrupAdi]) VALUES (2, N'Stil Önerileri')
INSERT [dbo].[BlogGrubu] ([BlogGrubuID], [GrupAdi]) VALUES (3, N'Tasarım')
INSERT [dbo].[BlogGrubu] ([BlogGrubuID], [GrupAdi]) VALUES (4, N'Trendler')
INSERT [dbo].[BlogGrubu] ([BlogGrubuID], [GrupAdi]) VALUES (5, N'Kendin Yap')
INSERT [dbo].[BlogGrubu] ([BlogGrubuID], [GrupAdi]) VALUES (6, N'Düğünler')
SET IDENTITY_INSERT [dbo].[BlogGrubu] OFF
SET IDENTITY_INSERT [dbo].[BlogTag] ON 

INSERT [dbo].[BlogTag] ([BlogTagID], [BlogID], [TagID]) VALUES (5, 4, 78)
INSERT [dbo].[BlogTag] ([BlogTagID], [BlogID], [TagID]) VALUES (6, 4, 77)
INSERT [dbo].[BlogTag] ([BlogTagID], [BlogID], [TagID]) VALUES (7, 5, 77)
INSERT [dbo].[BlogTag] ([BlogTagID], [BlogID], [TagID]) VALUES (8, 5, 76)
INSERT [dbo].[BlogTag] ([BlogTagID], [BlogID], [TagID]) VALUES (9, 6, 14)
INSERT [dbo].[BlogTag] ([BlogTagID], [BlogID], [TagID]) VALUES (10, 6, 57)
SET IDENTITY_INSERT [dbo].[BlogTag] OFF
SET IDENTITY_INSERT [dbo].[Fatura] ON 

INSERT [dbo].[Fatura] ([FaturaID], [Tarih], [TcKimlik], [KdvOrani], [ToplamTutar], [KargoID], [OdemeSekli]) VALUES (1, CAST(N'2016-11-08 00:00:00.000' AS DateTime), N'20419976772', 0.08, 594.0000, 1, N'BankaKarti')
INSERT [dbo].[Fatura] ([FaturaID], [Tarih], [TcKimlik], [KdvOrani], [ToplamTutar], [KargoID], [OdemeSekli]) VALUES (3, CAST(N'2016-08-11 00:00:00.000' AS DateTime), N'21548424548', NULL, 154.0000, 3, N'Havale')
INSERT [dbo].[Fatura] ([FaturaID], [Tarih], [TcKimlik], [KdvOrani], [ToplamTutar], [KargoID], [OdemeSekli]) VALUES (4, CAST(N'2016-12-12 00:00:00.000' AS DateTime), N'34527896544', NULL, 200.0000, 4, N'Kredkartı')
INSERT [dbo].[Fatura] ([FaturaID], [Tarih], [TcKimlik], [KdvOrani], [ToplamTutar], [KargoID], [OdemeSekli]) VALUES (7, CAST(N'2016-12-12 00:00:00.000' AS DateTime), N'32145698752', 0.05, 135.0000, 2, N'Havale')
INSERT [dbo].[Fatura] ([FaturaID], [Tarih], [TcKimlik], [KdvOrani], [ToplamTutar], [KargoID], [OdemeSekli]) VALUES (8, CAST(N'2016-11-09 15:19:50.293' AS DateTime), N'35469872541', 0.18, 100.0000, 3, N'BankaKarti')
INSERT [dbo].[Fatura] ([FaturaID], [Tarih], [TcKimlik], [KdvOrani], [ToplamTutar], [KargoID], [OdemeSekli]) VALUES (9, CAST(N'2016-11-09 15:24:26.750' AS DateTime), N'98752146325', 0.1, 152.0000, 1, N'Eft')
INSERT [dbo].[Fatura] ([FaturaID], [Tarih], [TcKimlik], [KdvOrani], [ToplamTutar], [KargoID], [OdemeSekli]) VALUES (10, CAST(N'2016-11-09 14:55:44.573' AS DateTime), N'14785236987', 5, 100.0000, 1, N'nakit')
INSERT [dbo].[Fatura] ([FaturaID], [Tarih], [TcKimlik], [KdvOrani], [ToplamTutar], [KargoID], [OdemeSekli]) VALUES (11, CAST(N'2016-11-09 15:18:32.310' AS DateTime), N'85631478963', 0.05, 500.0000, 2, N'Kredikartı')
INSERT [dbo].[Fatura] ([FaturaID], [Tarih], [TcKimlik], [KdvOrani], [ToplamTutar], [KargoID], [OdemeSekli]) VALUES (12, CAST(N'2016-11-09 15:19:37.590' AS DateTime), N'12578963456', 0.1, 750.0000, 2, N'Eft')
INSERT [dbo].[Fatura] ([FaturaID], [Tarih], [TcKimlik], [KdvOrani], [ToplamTutar], [KargoID], [OdemeSekli]) VALUES (16, CAST(N'2016-11-17 17:48:24.117' AS DateTime), N'14785236987', NULL, NULL, 1, N'Kredi Kartı')
INSERT [dbo].[Fatura] ([FaturaID], [Tarih], [TcKimlik], [KdvOrani], [ToplamTutar], [KargoID], [OdemeSekli]) VALUES (17, CAST(N'2016-11-18 03:36:06.873' AS DateTime), N'           ', 0.08, NULL, 1, N'Kredi Kartı')
INSERT [dbo].[Fatura] ([FaturaID], [Tarih], [TcKimlik], [KdvOrani], [ToplamTutar], [KargoID], [OdemeSekli]) VALUES (19, CAST(N'2016-11-18 04:12:04.353' AS DateTime), N'14445555522', 0.08, 356.2812, 3, N'Kredi Kartı')
INSERT [dbo].[Fatura] ([FaturaID], [Tarih], [TcKimlik], [KdvOrani], [ToplamTutar], [KargoID], [OdemeSekli]) VALUES (20, CAST(N'2016-11-18 04:15:08.610' AS DateTime), N'14445555522', 0.08, 356.2812, 2, N'Kredi Kartı')
INSERT [dbo].[Fatura] ([FaturaID], [Tarih], [TcKimlik], [KdvOrani], [ToplamTutar], [KargoID], [OdemeSekli]) VALUES (21, CAST(N'2016-11-18 04:17:56.070' AS DateTime), N'24567893178', 0.08, 356.2812, 4, N'Kredi Kartı')
INSERT [dbo].[Fatura] ([FaturaID], [Tarih], [TcKimlik], [KdvOrani], [ToplamTutar], [KargoID], [OdemeSekli]) VALUES (22, CAST(N'2016-11-18 04:50:50.703' AS DateTime), N'16165165150', 0.08, 194.3352, 1, N'Kredi Kartı')
INSERT [dbo].[Fatura] ([FaturaID], [Tarih], [TcKimlik], [KdvOrani], [ToplamTutar], [KargoID], [OdemeSekli]) VALUES (23, CAST(N'2016-11-18 18:21:49.493' AS DateTime), N'25340150247', 0.08, 194.3352, 2, N'Kredi Kartı')
INSERT [dbo].[Fatura] ([FaturaID], [Tarih], [TcKimlik], [KdvOrani], [ToplamTutar], [KargoID], [OdemeSekli]) VALUES (24, CAST(N'2016-11-26 02:33:43.480' AS DateTime), N'54515156815', 0.08, 48.5892, 1, N'Kredi Kartı')
INSERT [dbo].[Fatura] ([FaturaID], [Tarih], [TcKimlik], [KdvOrani], [ToplamTutar], [KargoID], [OdemeSekli]) VALUES (25, CAST(N'2016-11-27 16:34:00.850' AS DateTime), N'16165165150', 0.08, 650.1384, 1, N'Kredi Kartı')
SET IDENTITY_INSERT [dbo].[Fatura] OFF
SET IDENTITY_INSERT [dbo].[FaturaDetay] ON 

INSERT [dbo].[FaturaDetay] ([DetayID], [FaturaID], [UrunId], [Miktar]) VALUES (1, 1, 1, 1)
INSERT [dbo].[FaturaDetay] ([DetayID], [FaturaID], [UrunId], [Miktar]) VALUES (6, 7, 2, 1)
INSERT [dbo].[FaturaDetay] ([DetayID], [FaturaID], [UrunId], [Miktar]) VALUES (7, 8, 11, 1)
INSERT [dbo].[FaturaDetay] ([DetayID], [FaturaID], [UrunId], [Miktar]) VALUES (9, 11, 1, 1)
INSERT [dbo].[FaturaDetay] ([DetayID], [FaturaID], [UrunId], [Miktar]) VALUES (10, 1, 2, 3)
INSERT [dbo].[FaturaDetay] ([DetayID], [FaturaID], [UrunId], [Miktar]) VALUES (12, 19, 21, 2)
INSERT [dbo].[FaturaDetay] ([DetayID], [FaturaID], [UrunId], [Miktar]) VALUES (13, 19, 13, 1)
INSERT [dbo].[FaturaDetay] ([DetayID], [FaturaID], [UrunId], [Miktar]) VALUES (14, 20, 21, 2)
INSERT [dbo].[FaturaDetay] ([DetayID], [FaturaID], [UrunId], [Miktar]) VALUES (15, 20, 13, 1)
INSERT [dbo].[FaturaDetay] ([DetayID], [FaturaID], [UrunId], [Miktar]) VALUES (16, 21, 21, 2)
INSERT [dbo].[FaturaDetay] ([DetayID], [FaturaID], [UrunId], [Miktar]) VALUES (17, 21, 13, 1)
INSERT [dbo].[FaturaDetay] ([DetayID], [FaturaID], [UrunId], [Miktar]) VALUES (18, 22, 21, 1)
INSERT [dbo].[FaturaDetay] ([DetayID], [FaturaID], [UrunId], [Miktar]) VALUES (19, 22, 13, 1)
INSERT [dbo].[FaturaDetay] ([DetayID], [FaturaID], [UrunId], [Miktar]) VALUES (20, 23, 13, 1)
INSERT [dbo].[FaturaDetay] ([DetayID], [FaturaID], [UrunId], [Miktar]) VALUES (21, 23, 21, 1)
INSERT [dbo].[FaturaDetay] ([DetayID], [FaturaID], [UrunId], [Miktar]) VALUES (22, 24, 26, 1)
INSERT [dbo].[FaturaDetay] ([DetayID], [FaturaID], [UrunId], [Miktar]) VALUES (23, 25, 14, 2)
INSERT [dbo].[FaturaDetay] ([DetayID], [FaturaID], [UrunId], [Miktar]) VALUES (24, 25, 18, 1)
INSERT [dbo].[FaturaDetay] ([DetayID], [FaturaID], [UrunId], [Miktar]) VALUES (25, 25, 30, 1)
SET IDENTITY_INSERT [dbo].[FaturaDetay] OFF
SET IDENTITY_INSERT [dbo].[Kargo] ON 

INSERT [dbo].[Kargo] ([KargoID], [KargoAdi], [Aciklama]) VALUES (1, N'ARAS', NULL)
INSERT [dbo].[Kargo] ([KargoID], [KargoAdi], [Aciklama]) VALUES (2, N'Yurtiçi', NULL)
INSERT [dbo].[Kargo] ([KargoID], [KargoAdi], [Aciklama]) VALUES (3, N'PTT', NULL)
INSERT [dbo].[Kargo] ([KargoID], [KargoAdi], [Aciklama]) VALUES (4, N'MNG', NULL)
INSERT [dbo].[Kargo] ([KargoID], [KargoAdi], [Aciklama]) VALUES (5, N'DHL', NULL)
SET IDENTITY_INSERT [dbo].[Kargo] OFF
SET IDENTITY_INSERT [dbo].[Kategori] ON 

INSERT [dbo].[Kategori] ([KategoriID], [KategoriAdi]) VALUES (1, N'Erkek')
INSERT [dbo].[Kategori] ([KategoriID], [KategoriAdi]) VALUES (2, N'Bayan     ')
INSERT [dbo].[Kategori] ([KategoriID], [KategoriAdi]) VALUES (3, N'Cocuk     ')
INSERT [dbo].[Kategori] ([KategoriID], [KategoriAdi]) VALUES (4, N'Ayakkabı')
INSERT [dbo].[Kategori] ([KategoriID], [KategoriAdi]) VALUES (5, N'Aksesuar')
SET IDENTITY_INSERT [dbo].[Kategori] OFF
SET IDENTITY_INSERT [dbo].[Marka] ON 

INSERT [dbo].[Marka] ([MarkaID], [MarkaAdi]) VALUES (1, N'Adidas')
INSERT [dbo].[Marka] ([MarkaID], [MarkaAdi]) VALUES (2, N'Puma')
INSERT [dbo].[Marka] ([MarkaID], [MarkaAdi]) VALUES (3, N'Hammel')
INSERT [dbo].[Marka] ([MarkaID], [MarkaAdi]) VALUES (4, N'Nike')
INSERT [dbo].[Marka] ([MarkaID], [MarkaAdi]) VALUES (5, N'Colins')
INSERT [dbo].[Marka] ([MarkaID], [MarkaAdi]) VALUES (6, N'Ltb')
INSERT [dbo].[Marka] ([MarkaID], [MarkaAdi]) VALUES (7, N'Mavi')
INSERT [dbo].[Marka] ([MarkaID], [MarkaAdi]) VALUES (8, N'Defacto')
INSERT [dbo].[Marka] ([MarkaID], [MarkaAdi]) VALUES (9, N'Diesel')
INSERT [dbo].[Marka] ([MarkaID], [MarkaAdi]) VALUES (10, N'Koton')
SET IDENTITY_INSERT [dbo].[Marka] OFF
INSERT [dbo].[Musteri] ([TcKimlik], [AdSoyad], [Adres], [Telefon], [Email], [Kurum]) VALUES (N'           ', N'mmm', N'mmmmm', N'', N'knknkjn', N'kkk')
INSERT [dbo].[Musteri] ([TcKimlik], [AdSoyad], [Adres], [Telefon], [Email], [Kurum]) VALUES (N'12578963456', N'kadir', N'izmir', N'85693478965', NULL, NULL)
INSERT [dbo].[Musteri] ([TcKimlik], [AdSoyad], [Adres], [Telefon], [Email], [Kurum]) VALUES (N'14445555522', N'Cemal Kara', N'Deneme Adres ', N'05447888888', NULL, N'Deneme Kurum')
INSERT [dbo].[Musteri] ([TcKimlik], [AdSoyad], [Adres], [Telefon], [Email], [Kurum]) VALUES (N'14660574532', N'Dilek Duven', N'İstanbul', N'2125468945', NULL, NULL)
INSERT [dbo].[Musteri] ([TcKimlik], [AdSoyad], [Adres], [Telefon], [Email], [Kurum]) VALUES (N'14785236987', N'ceylan', N'istanbul', N'05366660188', NULL, NULL)
INSERT [dbo].[Musteri] ([TcKimlik], [AdSoyad], [Adres], [Telefon], [Email], [Kurum]) VALUES (N'15789634563', N'gamze', N'istanbul', N'05966602867', NULL, NULL)
INSERT [dbo].[Musteri] ([TcKimlik], [AdSoyad], [Adres], [Telefon], [Email], [Kurum]) VALUES (N'16165165150', N'Murat Acarsoy', N'Yenice Mh. Fatih Sultan Mehmet Cd. Türlü Sk. Uğur Apt. No: 1/4 D:5', N'5362854569', NULL, NULL)
INSERT [dbo].[Musteri] ([TcKimlik], [AdSoyad], [Adres], [Telefon], [Email], [Kurum]) VALUES (N'18565421236', N'Seda Sayan', N'İstanbul', N'2129653242', NULL, NULL)
INSERT [dbo].[Musteri] ([TcKimlik], [AdSoyad], [Adres], [Telefon], [Email], [Kurum]) VALUES (N'19952457857', N'Oğuz Atay', N'istanbul', N'25425425425', NULL, NULL)
INSERT [dbo].[Musteri] ([TcKimlik], [AdSoyad], [Adres], [Telefon], [Email], [Kurum]) VALUES (N'20419976772', N'emre kanat', N'giresun', N'53552255221', NULL, NULL)
INSERT [dbo].[Musteri] ([TcKimlik], [AdSoyad], [Adres], [Telefon], [Email], [Kurum]) VALUES (N'21548424548', N'Elif Kamber', N'samsun', N'14578523565', NULL, NULL)
INSERT [dbo].[Musteri] ([TcKimlik], [AdSoyad], [Adres], [Telefon], [Email], [Kurum]) VALUES (N'23564547899', N'furkan', N'kayseri', N'35468221563', NULL, NULL)
INSERT [dbo].[Musteri] ([TcKimlik], [AdSoyad], [Adres], [Telefon], [Email], [Kurum]) VALUES (N'24563251589', N'Ahmet  Yılmaz', N'Ankara', N'3126589635', NULL, NULL)
INSERT [dbo].[Musteri] ([TcKimlik], [AdSoyad], [Adres], [Telefon], [Email], [Kurum]) VALUES (N'24567893158', N'Mustafa', N'antalya', N'12345678963', NULL, NULL)
INSERT [dbo].[Musteri] ([TcKimlik], [AdSoyad], [Adres], [Telefon], [Email], [Kurum]) VALUES (N'24567893178', N'Arzu Kara', N'Deneme Adres 2 ', N'05447888111', NULL, N'Deneme Kurum')
INSERT [dbo].[Musteri] ([TcKimlik], [AdSoyad], [Adres], [Telefon], [Email], [Kurum]) VALUES (N'25340150247', N'Selim Kiraz', N'Deneme Adres 20 ', N'0544 789 41 42', NULL, N'')
INSERT [dbo].[Musteri] ([TcKimlik], [AdSoyad], [Adres], [Telefon], [Email], [Kurum]) VALUES (N'25896347896', N'erdem', N'karabük', N'12345678936', NULL, NULL)
INSERT [dbo].[Musteri] ([TcKimlik], [AdSoyad], [Adres], [Telefon], [Email], [Kurum]) VALUES (N'32145698752', N'ali', N'istanbul', N'87542153310', NULL, NULL)
INSERT [dbo].[Musteri] ([TcKimlik], [AdSoyad], [Adres], [Telefon], [Email], [Kurum]) VALUES (N'32215648648', N'murat', N'istanbul', N'23564891654', NULL, NULL)
INSERT [dbo].[Musteri] ([TcKimlik], [AdSoyad], [Adres], [Telefon], [Email], [Kurum]) VALUES (N'34527896544', N'Gamze', N'asdfghjkl', N'12524528789', NULL, NULL)
INSERT [dbo].[Musteri] ([TcKimlik], [AdSoyad], [Adres], [Telefon], [Email], [Kurum]) VALUES (N'35469872541', N'merve', N'bolu', N'25468975123', NULL, NULL)
INSERT [dbo].[Musteri] ([TcKimlik], [AdSoyad], [Adres], [Telefon], [Email], [Kurum]) VALUES (N'45823697855', N'merve', N'ankara', N'85693645689', NULL, NULL)
INSERT [dbo].[Musteri] ([TcKimlik], [AdSoyad], [Adres], [Telefon], [Email], [Kurum]) VALUES (N'54515156815', N'Feride Salim', N'Deneme Adres 123 ', N'5376551178', N'feride.salim@hotmail.com', N'')
INSERT [dbo].[Musteri] ([TcKimlik], [AdSoyad], [Adres], [Telefon], [Email], [Kurum]) VALUES (N'65489231456', N'selçuk', N'tokat', N'23654878979', NULL, NULL)
INSERT [dbo].[Musteri] ([TcKimlik], [AdSoyad], [Adres], [Telefon], [Email], [Kurum]) VALUES (N'78546321325', N'Ceylan', N'ardahan', N'21225489638', NULL, NULL)
INSERT [dbo].[Musteri] ([TcKimlik], [AdSoyad], [Adres], [Telefon], [Email], [Kurum]) VALUES (N'7894561237 ', N'sinem', N'ankara', N'15789645236', NULL, NULL)
INSERT [dbo].[Musteri] ([TcKimlik], [AdSoyad], [Adres], [Telefon], [Email], [Kurum]) VALUES (N'78963254236', N'hakan', N'izmir', N'78963215786', NULL, NULL)
INSERT [dbo].[Musteri] ([TcKimlik], [AdSoyad], [Adres], [Telefon], [Email], [Kurum]) VALUES (N'85631478963', N'kamil', N'manisa', N'05486937569', NULL, NULL)
INSERT [dbo].[Musteri] ([TcKimlik], [AdSoyad], [Adres], [Telefon], [Email], [Kurum]) VALUES (N'86514256312', N'seda', N'sivas', N'12354899632', NULL, NULL)
INSERT [dbo].[Musteri] ([TcKimlik], [AdSoyad], [Adres], [Telefon], [Email], [Kurum]) VALUES (N'98752146325', N'refika', N'elazığ', N'25647889212', NULL, NULL)
SET IDENTITY_INSERT [dbo].[OneCikanUrunler] ON 

INSERT [dbo].[OneCikanUrunler] ([CikanID], [UrunID]) VALUES (2, 13)
INSERT [dbo].[OneCikanUrunler] ([CikanID], [UrunID]) VALUES (3, 16)
INSERT [dbo].[OneCikanUrunler] ([CikanID], [UrunID]) VALUES (4, 17)
INSERT [dbo].[OneCikanUrunler] ([CikanID], [UrunID]) VALUES (5, 21)
INSERT [dbo].[OneCikanUrunler] ([CikanID], [UrunID]) VALUES (6, 22)
INSERT [dbo].[OneCikanUrunler] ([CikanID], [UrunID]) VALUES (7, 25)
INSERT [dbo].[OneCikanUrunler] ([CikanID], [UrunID]) VALUES (8, 26)
INSERT [dbo].[OneCikanUrunler] ([CikanID], [UrunID]) VALUES (9, 30)
SET IDENTITY_INSERT [dbo].[OneCikanUrunler] OFF
SET IDENTITY_INSERT [dbo].[Renk] ON 

INSERT [dbo].[Renk] ([RenkID], [RenkAdi]) VALUES (1, N'Mavi')
INSERT [dbo].[Renk] ([RenkID], [RenkAdi]) VALUES (2, N'Sarı')
INSERT [dbo].[Renk] ([RenkID], [RenkAdi]) VALUES (3, N'Beyaz')
INSERT [dbo].[Renk] ([RenkID], [RenkAdi]) VALUES (4, N'Siyah')
INSERT [dbo].[Renk] ([RenkID], [RenkAdi]) VALUES (5, N'Bordo')
INSERT [dbo].[Renk] ([RenkID], [RenkAdi]) VALUES (6, N'Lacivert')
INSERT [dbo].[Renk] ([RenkID], [RenkAdi]) VALUES (7, N'Kırmızı')
INSERT [dbo].[Renk] ([RenkID], [RenkAdi]) VALUES (8, N'Mor')
INSERT [dbo].[Renk] ([RenkID], [RenkAdi]) VALUES (9, N'Turuncu')
INSERT [dbo].[Renk] ([RenkID], [RenkAdi]) VALUES (10, N'Pembe')
INSERT [dbo].[Renk] ([RenkID], [RenkAdi]) VALUES (11, N'Gri')
INSERT [dbo].[Renk] ([RenkID], [RenkAdi]) VALUES (12, N'Yeşil')
INSERT [dbo].[Renk] ([RenkID], [RenkAdi]) VALUES (13, N'Açık Mavi')
INSERT [dbo].[Renk] ([RenkID], [RenkAdi]) VALUES (14, N'Açık Yeşil')
INSERT [dbo].[Renk] ([RenkID], [RenkAdi]) VALUES (15, N'Açık Kırmızı')
INSERT [dbo].[Renk] ([RenkID], [RenkAdi]) VALUES (16, N'Kahverengi')
INSERT [dbo].[Renk] ([RenkID], [RenkAdi]) VALUES (17, N'Açık Kahverengi')
INSERT [dbo].[Renk] ([RenkID], [RenkAdi]) VALUES (18, N'Koyu Lacivert')
INSERT [dbo].[Renk] ([RenkID], [RenkAdi]) VALUES (19, N'Koyu Kırmızı')
INSERT [dbo].[Renk] ([RenkID], [RenkAdi]) VALUES (20, N'Koyu Yeşil')
INSERT [dbo].[Renk] ([RenkID], [RenkAdi]) VALUES (21, N'Koyu Mavi')
INSERT [dbo].[Renk] ([RenkID], [RenkAdi]) VALUES (22, N'Koyu Sarı')
INSERT [dbo].[Renk] ([RenkID], [RenkAdi]) VALUES (23, N'Koyu Pembe')
INSERT [dbo].[Renk] ([RenkID], [RenkAdi]) VALUES (24, N'Ekru')
SET IDENTITY_INSERT [dbo].[Renk] OFF
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (1, 1)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (2, 1)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (3, 1)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (4, 2)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (4, 34)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (1, 2)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (1, 1)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (2, 1)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (3, 1)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (4, 2)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (5, 35)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (1, 2)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (5, 11)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (6, 11)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (18, 13)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (7, 12)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (4, 12)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (4, 14)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (11, 16)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (6, 15)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (1, 17)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (1, 1)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (2, 1)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (3, 1)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (4, 2)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (12, 36)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (1, 1)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (2, 2)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (2, 1)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (1, 1)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (2, 1)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (3, 1)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (4, 2)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (21, 37)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (1, 2)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (1, 1)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (2, 1)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (3, 1)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (4, 2)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (11, 38)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (1, 2)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (1, 1)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (2, 1)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (3, 1)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (4, 2)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (11, 39)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (1, 2)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (5, 11)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (6, 11)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (18, 13)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (7, 12)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (4, 12)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (4, 14)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (11, 16)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (6, 15)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (1, 17)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (3, 18)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (4, 18)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (2, 19)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (4, 22)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (6, 23)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (24, 27)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (19, 30)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (21, 30)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (1, 31)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (6, 31)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (10, 32)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (5, 33)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (6, 19)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (4, 20)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (11, 21)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (10, 24)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (20, 25)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (11, 26)
INSERT [dbo].[RenkvsUrun] ([RenkID], [UrunID]) VALUES (16, 28)
SET IDENTITY_INSERT [dbo].[SiparisDurum] ON 

INSERT [dbo].[SiparisDurum] ([DurumID], [FaturaID], [OnayVeriliyor], [Onaylandi], [KargoyaVerildi], [IptalEdildi], [Hazirlaniyor], [IadeEdildi]) VALUES (1, 14, 0, 0, 0, 0, 0, 1)
INSERT [dbo].[SiparisDurum] ([DurumID], [FaturaID], [OnayVeriliyor], [Onaylandi], [KargoyaVerildi], [IptalEdildi], [Hazirlaniyor], [IadeEdildi]) VALUES (2, 16, 1, 0, 0, 0, 0, 0)
INSERT [dbo].[SiparisDurum] ([DurumID], [FaturaID], [OnayVeriliyor], [Onaylandi], [KargoyaVerildi], [IptalEdildi], [Hazirlaniyor], [IadeEdildi]) VALUES (3, 17, 1, 0, 0, 0, 0, 0)
INSERT [dbo].[SiparisDurum] ([DurumID], [FaturaID], [OnayVeriliyor], [Onaylandi], [KargoyaVerildi], [IptalEdildi], [Hazirlaniyor], [IadeEdildi]) VALUES (5, 19, 1, 0, 0, 0, 0, 0)
INSERT [dbo].[SiparisDurum] ([DurumID], [FaturaID], [OnayVeriliyor], [Onaylandi], [KargoyaVerildi], [IptalEdildi], [Hazirlaniyor], [IadeEdildi]) VALUES (6, 20, 1, 0, 0, 0, 0, 0)
INSERT [dbo].[SiparisDurum] ([DurumID], [FaturaID], [OnayVeriliyor], [Onaylandi], [KargoyaVerildi], [IptalEdildi], [Hazirlaniyor], [IadeEdildi]) VALUES (7, 21, 1, 0, 0, 0, 0, 0)
INSERT [dbo].[SiparisDurum] ([DurumID], [FaturaID], [OnayVeriliyor], [Onaylandi], [KargoyaVerildi], [IptalEdildi], [Hazirlaniyor], [IadeEdildi]) VALUES (8, 22, 1, 0, 0, 0, 0, 0)
INSERT [dbo].[SiparisDurum] ([DurumID], [FaturaID], [OnayVeriliyor], [Onaylandi], [KargoyaVerildi], [IptalEdildi], [Hazirlaniyor], [IadeEdildi]) VALUES (9, 23, 1, 0, 0, 0, 0, 0)
INSERT [dbo].[SiparisDurum] ([DurumID], [FaturaID], [OnayVeriliyor], [Onaylandi], [KargoyaVerildi], [IptalEdildi], [Hazirlaniyor], [IadeEdildi]) VALUES (10, 24, 1, 0, 0, 0, 0, 0)
INSERT [dbo].[SiparisDurum] ([DurumID], [FaturaID], [OnayVeriliyor], [Onaylandi], [KargoyaVerildi], [IptalEdildi], [Hazirlaniyor], [IadeEdildi]) VALUES (11, 25, 1, 0, 0, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[SiparisDurum] OFF
SET IDENTITY_INSERT [dbo].[Tag] ON 

INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (1, N'kazak', 5)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (2, N'gömlek', 1)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (3, N'yeşil', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (4, N'deneme', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (6, N'Adidas', 4)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (7, N'Eşofman', 1)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (8, N'Takımı', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (9, N'Trainer', 1)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (10, N'Dolgulu', 2)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (11, N'Hibrit', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (12, N'Kapüşonlu', 2)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (13, N'Kaz', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (14, N'Mont', 11)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (15, N'Tüyü', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (16, N'Ceket', 2)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (17, N'Colins', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (18, N'Erkek', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (19, N'Gri', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (20, N'Çift', 1)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (21, N'Defacto', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (22, N'Taraflı', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (23, N'Çizgili', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (24, N'Balıkçı', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (25, N'Basic', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (26, N'Yaka', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (27, N'Kadife', 1)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (28, N'Koton', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (29, N'Desenli', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (30, N'Triko', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (31, N'Cep', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (32, N'Detaylı', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (33, N'16/17', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (34, N'Beşiktaş', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (35, N'Deplasman', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (36, N'Forma', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (37, N'Fenerbahçe', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (38, N'İç', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (39, N'Saha', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (40, N'Bel', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (41, N'Pantolon', 5)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (42, N'Skinny', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (43, N'Süper', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (44, N'Yüksek', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (45, N'Şal', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (46, N'Trend', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (47, N'Ekoseli', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (48, N'Yelek', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (49, N'Kapitone', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (50, N'Kemer', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (51, N'Bayan', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (52, N'Dolgu', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (53, N'Club', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (54, N'Line', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (55, N'London', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (56, N'Isabella', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (57, N'Kot', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (58, N'Ltb', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (59, N'Nice', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (60, N'Wash', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (61, N'Dowera', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (62, N'Shirt', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (63, N'Jakarlı', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (64, N'Mavi', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (65, N'Dar', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (66, N'Dirsek', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (67, N'Kesim', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (68, N'Yamalı', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (69, N'Bee', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (70, N'Classic', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (71, N'Hammel', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (72, N'Hybrid', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (73, N'JKT', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (74, N'Womens', 0)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (75, N'Çorap', 3)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (76, N'Bot', 1)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (77, N'Trend', 2)
INSERT [dbo].[Tag] ([TagID], [TagAdi], [TagAramaSayisi]) VALUES (78, N'Ayakkabı', 0)
SET IDENTITY_INSERT [dbo].[Tag] OFF
SET IDENTITY_INSERT [dbo].[Urun] ON 

INSERT [dbo].[Urun] ([UrunID], [UrunAdi], [BitisSuresi], [BirimFiyat], [MarkaID], [Tarih], [Aciklama], [GrupID], [DepoyaGirenMiktar], [KullanilanMiktar], [NetMiktar], [GoruntulenmeSayisi], [Begeniler], [FiyatPuani], [DegerPuani], [KalitePuani]) VALUES (1, N'Mavi Kot', CAST(N'2016-11-30 00:00:00.000' AS DateTime), 145.0000, 7, CAST(N'2016-11-08' AS Date), N'Güzel Ürün Alın', 1, 185, 10, 175, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Urun] ([UrunID], [UrunAdi], [BitisSuresi], [BirimFiyat], [MarkaID], [Tarih], [Aciklama], [GrupID], [DepoyaGirenMiktar], [KullanilanMiktar], [NetMiktar], [GoruntulenmeSayisi], [Begeniler], [FiyatPuani], [DegerPuani], [KalitePuani]) VALUES (2, N'Mont', CAST(N'2016-12-30 00:00:00.000' AS DateTime), 135.0000, 5, CAST(N'2016-11-08' AS Date), N'Mükemmel Ürünler', 5, 200, 180, 20, 2, NULL, NULL, NULL, NULL)
INSERT [dbo].[Urun] ([UrunID], [UrunAdi], [BitisSuresi], [BirimFiyat], [MarkaID], [Tarih], [Aciklama], [GrupID], [DepoyaGirenMiktar], [KullanilanMiktar], [NetMiktar], [GoruntulenmeSayisi], [Begeniler], [FiyatPuani], [DegerPuani], [KalitePuani]) VALUES (11, N'Çizgili Kazak', CAST(N'2017-03-30 00:00:00.000' AS DateTime), 44.9900, 8, CAST(N'2016-11-09' AS Date), N'Dar kesim kalıbı ve çizgili deseni ile hem şıklığı yakalayacağınız hem de tarz bir görünüm elde edeceğiniz DeFacto triko kazak.', 10, 110, 30, 80, 42, NULL, NULL, NULL, NULL)
INSERT [dbo].[Urun] ([UrunID], [UrunAdi], [BitisSuresi], [BirimFiyat], [MarkaID], [Tarih], [Aciklama], [GrupID], [DepoyaGirenMiktar], [KullanilanMiktar], [NetMiktar], [GoruntulenmeSayisi], [Begeniler], [FiyatPuani], [DegerPuani], [KalitePuani]) VALUES (12, N'Çift Taraflı Gömlek', CAST(N'2017-02-11 00:00:00.000' AS DateTime), 44.9900, 8, CAST(N'2016-11-09' AS Date), N'Çift taraflı kullanım özelliği ile size bir gömlekten fazlasını sunan DeFacto erkek çift taraflı gömlek.', 12, 200, 7, 193, 3, NULL, NULL, NULL, NULL)
INSERT [dbo].[Urun] ([UrunID], [UrunAdi], [BitisSuresi], [BirimFiyat], [MarkaID], [Tarih], [Aciklama], [GrupID], [DepoyaGirenMiktar], [KullanilanMiktar], [NetMiktar], [GoruntulenmeSayisi], [Begeniler], [FiyatPuani], [DegerPuani], [KalitePuani]) VALUES (13, N'Balıkçı Yaka Basic Kazak', CAST(N'2017-03-12 00:00:00.000' AS DateTime), 29.9900, 8, CAST(N'2016-11-09' AS Date), N'Boğazlı modeli ve şık tasarımı ile soğuk kış günlerinde hem sizi ısıtacak hem de trend bir görünüm katacak DeFacto bayan boğazlı kazak.', 10, 100, 25, 75, 23, 1, NULL, NULL, NULL)
INSERT [dbo].[Urun] ([UrunID], [UrunAdi], [BitisSuresi], [BirimFiyat], [MarkaID], [Tarih], [Aciklama], [GrupID], [DepoyaGirenMiktar], [KullanilanMiktar], [NetMiktar], [GoruntulenmeSayisi], [Begeniler], [FiyatPuani], [DegerPuani], [KalitePuani]) VALUES (14, N'Kadife Gömlek', CAST(N'2017-04-11 00:00:00.000' AS DateTime), 44.9900, 8, CAST(N'2016-11-09' AS Date), N'Trend modeli ve dar kesimiyle stilinizi tamamlayabileceğiniz DeFacto erkek kadife gömlek.', 12, 45, 7, 38, 38, NULL, NULL, NULL, NULL)
INSERT [dbo].[Urun] ([UrunID], [UrunAdi], [BitisSuresi], [BirimFiyat], [MarkaID], [Tarih], [Aciklama], [GrupID], [DepoyaGirenMiktar], [KullanilanMiktar], [NetMiktar], [GoruntulenmeSayisi], [Begeniler], [FiyatPuani], [DegerPuani], [KalitePuani]) VALUES (15, N'Balıkçı Yaka Kazak', CAST(N'2017-04-15 00:00:00.000' AS DateTime), 39.9900, 10, CAST(N'2016-11-09' AS Date), N'Uzun Kollu, Rahat Kesim Kazak', 11, 180, 15, 165, 22, NULL, NULL, NULL, NULL)
INSERT [dbo].[Urun] ([UrunID], [UrunAdi], [BitisSuresi], [BirimFiyat], [MarkaID], [Tarih], [Aciklama], [GrupID], [DepoyaGirenMiktar], [KullanilanMiktar], [NetMiktar], [GoruntulenmeSayisi], [Begeniler], [FiyatPuani], [DegerPuani], [KalitePuani]) VALUES (16, N'Desenli Triko Kazak', CAST(N'2017-04-16 00:00:00.000' AS DateTime), 69.9900, 10, CAST(N'2016-11-09' AS Date), N'Bisiklet Yaka, Uzun Kollu Triko Kazak', 11, 90, 20, 70, 19, NULL, NULL, NULL, NULL)
INSERT [dbo].[Urun] ([UrunID], [UrunAdi], [BitisSuresi], [BirimFiyat], [MarkaID], [Tarih], [Aciklama], [GrupID], [DepoyaGirenMiktar], [KullanilanMiktar], [NetMiktar], [GoruntulenmeSayisi], [Begeniler], [FiyatPuani], [DegerPuani], [KalitePuani]) VALUES (17, N'Cep Detaylı Gömlek', CAST(N'2017-05-01 00:00:00.000' AS DateTime), 29.9900, 10, CAST(N'2016-11-09' AS Date), N'Klasik Yaka, Dar Kesim, Düz, Kısa Kollu, Cep Detaylı Gömlek', 14, 150, 22, 128, 38, 1, 5, 4, 4)
INSERT [dbo].[Urun] ([UrunID], [UrunAdi], [BitisSuresi], [BirimFiyat], [MarkaID], [Tarih], [Aciklama], [GrupID], [DepoyaGirenMiktar], [KullanilanMiktar], [NetMiktar], [GoruntulenmeSayisi], [Begeniler], [FiyatPuani], [DegerPuani], [KalitePuani]) VALUES (18, N'Beşiktaş 16/17 Deplasman Forma', CAST(N'2017-06-18 00:00:00.000' AS DateTime), 155.0000, 1, CAST(N'2016-11-13' AS Date), N'Beşiktaş taraftarının çok sevdiği ve uzun süredir beklediği siyah “nostalji forma”, 2016-2017 futbol sezonunda taraftarlarla yeniden buluşuyor.', 17, 200, 47, 153, 36, NULL, NULL, NULL, NULL)
INSERT [dbo].[Urun] ([UrunID], [UrunAdi], [BitisSuresi], [BirimFiyat], [MarkaID], [Tarih], [Aciklama], [GrupID], [DepoyaGirenMiktar], [KullanilanMiktar], [NetMiktar], [GoruntulenmeSayisi], [Begeniler], [FiyatPuani], [DegerPuani], [KalitePuani]) VALUES (19, N'Fenerbahçe 16/17 İç Saha Forma', CAST(N'2017-06-19 00:00:00.000' AS DateTime), 155.0000, 1, CAST(N'2016-11-13' AS Date), N'Fenerbahçe’nin vazgeçilmezi Efsane Çubuklu Forma tasarımında, efsane oyuncu Lefter Küçükandonyadis ile birlikte anılan çubuklu formadan esinlenildi ve uzun zaman sonra ince çubuklar kullanıldı.', 17, 200, 64, 136, 56, NULL, NULL, NULL, NULL)
INSERT [dbo].[Urun] ([UrunID], [UrunAdi], [BitisSuresi], [BirimFiyat], [MarkaID], [Tarih], [Aciklama], [GrupID], [DepoyaGirenMiktar], [KullanilanMiktar], [NetMiktar], [GoruntulenmeSayisi], [Begeniler], [FiyatPuani], [DegerPuani], [KalitePuani]) VALUES (20, N'Classic Bee Womens Hybrid JKT', CAST(N'2017-06-11 00:00:00.000' AS DateTime), 139.9900, 3, CAST(N'2016-11-13' AS Date), N'hummel® CLASSIC BEE WOMENS HYBRID JKT is a clever hybrid of the classic windbreaker and the fleece jacket featuring the best from both worlds.', 6, 120, 12, 108, 38, 1, 3, 4, 5)
INSERT [dbo].[Urun] ([UrunID], [UrunAdi], [BitisSuresi], [BirimFiyat], [MarkaID], [Tarih], [Aciklama], [GrupID], [DepoyaGirenMiktar], [KullanilanMiktar], [NetMiktar], [GoruntulenmeSayisi], [Begeniler], [FiyatPuani], [DegerPuani], [KalitePuani]) VALUES (21, N'Gri Erkek Ceket', CAST(N'2017-04-04 00:00:00.000' AS DateTime), 149.9500, 5, CAST(N'2016-11-13' AS Date), N'Colins Erkek Ceketi ürünü %85 Pamuk %15 Poliester içermektedir.', 21, 140, 13, 127, 109, 1, NULL, NULL, NULL)
INSERT [dbo].[Urun] ([UrunID], [UrunAdi], [BitisSuresi], [BirimFiyat], [MarkaID], [Tarih], [Aciklama], [GrupID], [DepoyaGirenMiktar], [KullanilanMiktar], [NetMiktar], [GoruntulenmeSayisi], [Begeniler], [FiyatPuani], [DegerPuani], [KalitePuani]) VALUES (22, N'Dirsek Yamalı Dar Kesim Kadife Ceket', CAST(N'2017-01-17 00:00:00.000' AS DateTime), 49.9900, 8, CAST(N'2016-11-13' AS Date), N'Dirseğindeki yama ayrıntısı ve üzerinize oturan şık kesimiyle tarzınızı yansıtabileceğiniz DeFacto erkek ceket.', 21, 120, 14, 106, 93, NULL, NULL, NULL, NULL)
INSERT [dbo].[Urun] ([UrunID], [UrunAdi], [BitisSuresi], [BirimFiyat], [MarkaID], [Tarih], [Aciklama], [GrupID], [DepoyaGirenMiktar], [KullanilanMiktar], [NetMiktar], [GoruntulenmeSayisi], [Begeniler], [FiyatPuani], [DegerPuani], [KalitePuani]) VALUES (23, N'Yüksek Bel Süper Skinny Pantolon', CAST(N'2017-02-06 00:00:00.000' AS DateTime), 29.9900, 8, CAST(N'2016-11-13' AS Date), N'Yüksek belli modeli ve şık tarzı ile kısa body ve bluzlarla rahatlıkla kombinlenebilen DeFacto bayan pantolon.', 24, 110, 28, 82, 79, 0, 5, 5, 5)
INSERT [dbo].[Urun] ([UrunID], [UrunAdi], [BitisSuresi], [BirimFiyat], [MarkaID], [Tarih], [Aciklama], [GrupID], [DepoyaGirenMiktar], [KullanilanMiktar], [NetMiktar], [GoruntulenmeSayisi], [Begeniler], [FiyatPuani], [DegerPuani], [KalitePuani]) VALUES (24, N'Trend Şal', CAST(N'2017-08-19 00:00:00.000' AS DateTime), 19.9900, 8, CAST(N'2016-11-13' AS Date), N'Düz modeli ve trend görünümü ile sizi stil sahibi yapacak ve tüm kombinlerinizle rahatça kullanabileceğiniz DeFacto bayan şal.', 9, 115, 17, 98, 45, NULL, NULL, NULL, NULL)
INSERT [dbo].[Urun] ([UrunID], [UrunAdi], [BitisSuresi], [BirimFiyat], [MarkaID], [Tarih], [Aciklama], [GrupID], [DepoyaGirenMiktar], [KullanilanMiktar], [NetMiktar], [GoruntulenmeSayisi], [Begeniler], [FiyatPuani], [DegerPuani], [KalitePuani]) VALUES (25, N'Ekoseli Gömlek', CAST(N'2017-01-19 00:00:00.000' AS DateTime), 39.9900, 8, CAST(N'2016-11-14' AS Date), N'Dar kesimi sayesinde üzerinizde fit bir görünüm sağlayacak, kareli deseni ile trend olabileceğiniz DeFacto erkek gömlek.', 12, 180, 8, 172, 68, 1, 5, 3.5, 4.5)
INSERT [dbo].[Urun] ([UrunID], [UrunAdi], [BitisSuresi], [BirimFiyat], [MarkaID], [Tarih], [Aciklama], [GrupID], [DepoyaGirenMiktar], [KullanilanMiktar], [NetMiktar], [GoruntulenmeSayisi], [Begeniler], [FiyatPuani], [DegerPuani], [KalitePuani]) VALUES (26, N'Triko Yelek', CAST(N'2017-09-16 00:00:00.000' AS DateTime), 44.9900, 8, CAST(N'2016-11-14' AS Date), N'Şık modeli ve rahat kullanımı ile chino pantolonlarınızla kolayca kombinleyebileceğiniz bayan DeFacto triko yelek.', 28, 140, 33, 107, 42, NULL, NULL, NULL, NULL)
INSERT [dbo].[Urun] ([UrunID], [UrunAdi], [BitisSuresi], [BirimFiyat], [MarkaID], [Tarih], [Aciklama], [GrupID], [DepoyaGirenMiktar], [KullanilanMiktar], [NetMiktar], [GoruntulenmeSayisi], [Begeniler], [FiyatPuani], [DegerPuani], [KalitePuani]) VALUES (27, N'Kapitone Yelek', CAST(N'2017-01-18 00:00:00.000' AS DateTime), 59.9900, 8, CAST(N'2016-11-14' AS Date), N'Kapitoneli kumaşı ile çok şık duran, üzerinizde fit bir görünüm sağlayan, cep detaylı ve boğazlı DeFacto bayan yelek.', 28, 100, 15, 85, 52, 2, 4.333333333333333, 3.6666666666666665, 3.6666666666666665)
INSERT [dbo].[Urun] ([UrunID], [UrunAdi], [BitisSuresi], [BirimFiyat], [MarkaID], [Tarih], [Aciklama], [GrupID], [DepoyaGirenMiktar], [KullanilanMiktar], [NetMiktar], [GoruntulenmeSayisi], [Begeniler], [FiyatPuani], [DegerPuani], [KalitePuani]) VALUES (28, N'Trend Kemer', CAST(N'2017-02-04 00:00:00.000' AS DateTime), 14.9900, 8, CAST(N'2016-11-14' AS Date), N'Kıyafetlerinizle kombinleyerek trend bir görünüm elde edeceğiniz, DeFacto bayan kemer.', 32, 230, 102, 128, 45, 0, 5, 4, 4)
INSERT [dbo].[Urun] ([UrunID], [UrunAdi], [BitisSuresi], [BirimFiyat], [MarkaID], [Tarih], [Aciklama], [GrupID], [DepoyaGirenMiktar], [KullanilanMiktar], [NetMiktar], [GoruntulenmeSayisi], [Begeniler], [FiyatPuani], [DegerPuani], [KalitePuani]) VALUES (30, N'Trainer Eşofman Takımı', CAST(N'2017-06-23 00:00:00.000' AS DateTime), 357.0000, 1, CAST(N'2016-11-20' AS Date), N'Bu erkeklere özel eşofman takımı ile kaslarını dengeli biçimde sıcak tut. Teri vücuttan atan kumaş ve daralan paça detayıyla bu eşofman takımı, gün boyu rahat olmanı sağlar.', 41, 150, 41, 109, 5, 0, NULL, NULL, NULL)
INSERT [dbo].[Urun] ([UrunID], [UrunAdi], [BitisSuresi], [BirimFiyat], [MarkaID], [Tarih], [Aciklama], [GrupID], [DepoyaGirenMiktar], [KullanilanMiktar], [NetMiktar], [GoruntulenmeSayisi], [Begeniler], [FiyatPuani], [DegerPuani], [KalitePuani]) VALUES (31, N'Trainer Eşofman Takımı', CAST(N'2017-06-15 00:00:00.000' AS DateTime), 357.0000, 1, CAST(N'2016-11-20' AS Date), N'Bu erkeklere özel eşofman takımı ile kaslarını dengeli biçimde sıcak tut. Teri vücuttan atan kumaş ve daralan paça detayıyla bu eşofman takımı, gün boyu rahat olmanı sağlar.', 41, 150, 24, 126, 0, 0, NULL, NULL, NULL)
INSERT [dbo].[Urun] ([UrunID], [UrunAdi], [BitisSuresi], [BirimFiyat], [MarkaID], [Tarih], [Aciklama], [GrupID], [DepoyaGirenMiktar], [KullanilanMiktar], [NetMiktar], [GoruntulenmeSayisi], [Begeniler], [FiyatPuani], [DegerPuani], [KalitePuani]) VALUES (32, N'Hibrit Kaz Tüyü Dolgulu Kapüşonlu Mont', CAST(N'2017-05-02 00:00:00.000' AS DateTime), 669.0000, 1, CAST(N'2016-11-20' AS Date), N'Kadın outdoor mont, kaz tüyü dolguya ve dokuma polyester kaplamaya sahiptir. Kollarda ve sırtta soft shell malzeme yer alır. Tam boy fermuarlı mont yüksek kaliteli kaz tüyü dolguludur. Lastikli kapüşonu, kolları ve bel kenar bağcıkları ile soğuğa karşı korur.', 6, 110, 8, 102, 1, 0, NULL, NULL, NULL)
INSERT [dbo].[Urun] ([UrunID], [UrunAdi], [BitisSuresi], [BirimFiyat], [MarkaID], [Tarih], [Aciklama], [GrupID], [DepoyaGirenMiktar], [KullanilanMiktar], [NetMiktar], [GoruntulenmeSayisi], [Begeniler], [FiyatPuani], [DegerPuani], [KalitePuani]) VALUES (33, N'Jakarlı Kazak', CAST(N'2017-08-08 00:00:00.000' AS DateTime), 119.9900, 7, CAST(N'2016-11-20' AS Date), N'Jakarlı Kazak', 10, 90, 7, 83, 2, 0, NULL, NULL, NULL)
INSERT [dbo].[Urun] ([UrunID], [UrunAdi], [BitisSuresi], [BirimFiyat], [MarkaID], [Tarih], [Aciklama], [GrupID], [DepoyaGirenMiktar], [KullanilanMiktar], [NetMiktar], [GoruntulenmeSayisi], [Begeniler], [FiyatPuani], [DegerPuani], [KalitePuani]) VALUES (34, N'Bayan Mont', CAST(N'2017-04-05 00:00:00.000' AS DateTime), 99.9000, 5, CAST(N'2016-11-22' AS Date), N'Dış:%100 Poliamid /Astar %100 Poliester içerikli olup kış günlerinde sizi sıcak tutar.', 6, 110, 16, 94, 13, 0, NULL, NULL, NULL)
INSERT [dbo].[Urun] ([UrunID], [UrunAdi], [BitisSuresi], [BirimFiyat], [MarkaID], [Tarih], [Aciklama], [GrupID], [DepoyaGirenMiktar], [KullanilanMiktar], [NetMiktar], [GoruntulenmeSayisi], [Begeniler], [FiyatPuani], [DegerPuani], [KalitePuani]) VALUES (35, N'Bayan Kazak', CAST(N'2017-04-06 00:00:00.000' AS DateTime), 39.9000, 5, CAST(N'2016-11-22' AS Date), N'%77 Pamuk %17 Yün %6 Poliamid içeriği ile teninize rahat gelen ve rengi ile şık görünmenizi sağlayan ürünün fiyatı oldukça uygundur.', 11, 70, 23, 47, 0, 0, NULL, NULL, NULL)
INSERT [dbo].[Urun] ([UrunID], [UrunAdi], [BitisSuresi], [BirimFiyat], [MarkaID], [Tarih], [Aciklama], [GrupID], [DepoyaGirenMiktar], [KullanilanMiktar], [NetMiktar], [GoruntulenmeSayisi], [Begeniler], [FiyatPuani], [DegerPuani], [KalitePuani]) VALUES (36, N'Dowera Shirt', CAST(N'2017-09-12 00:00:00.000' AS DateTime), 59.9000, 6, CAST(N'2016-11-22' AS Date), N'%100 Pamuk içeriği ile rahat dokunuşu ve şık görünümü mevcuttur.', 12, 80, 11, 69, 3, 0, NULL, NULL, NULL)
INSERT [dbo].[Urun] ([UrunID], [UrunAdi], [BitisSuresi], [BirimFiyat], [MarkaID], [Tarih], [Aciklama], [GrupID], [DepoyaGirenMiktar], [KullanilanMiktar], [NetMiktar], [GoruntulenmeSayisi], [Begeniler], [FiyatPuani], [DegerPuani], [KalitePuani]) VALUES (37, N'Isabella Nice Wash', CAST(N'2017-08-05 00:00:00.000' AS DateTime), 119.9000, 6, CAST(N'2016-11-22' AS Date), N'%2.5 Elastan %22 Polyester % 75.5 Pamuk içeriği ile şık görünüm sunmaktadır', 15, 120, 12, 108, 2, 0, NULL, NULL, NULL)
INSERT [dbo].[Urun] ([UrunID], [UrunAdi], [BitisSuresi], [BirimFiyat], [MarkaID], [Tarih], [Aciklama], [GrupID], [DepoyaGirenMiktar], [KullanilanMiktar], [NetMiktar], [GoruntulenmeSayisi], [Begeniler], [FiyatPuani], [DegerPuani], [KalitePuani]) VALUES (38, N'London Line Club Kapüşonlu Ceket', CAST(N'2017-04-06 00:00:00.000' AS DateTime), 292.0000, 1, CAST(N'2016-11-22' AS Date), N'Erkeklere özel bu tenis ceketi maçtan önce kaslarını sıcak tutmanı sağlar. Tam boy fermuarlı kapüşonlu üst, omuzlarında modern, sade bir görünüm sunan karyoka dikişlere sahiptir. Ayarlanabilir bağcıklı kapüşon, soğuğu ve rüzgarı dışarıda bırakmanı sağlar.', 21, 64, 2, 62, 7, 0, NULL, NULL, NULL)
INSERT [dbo].[Urun] ([UrunID], [UrunAdi], [BitisSuresi], [BirimFiyat], [MarkaID], [Tarih], [Aciklama], [GrupID], [DepoyaGirenMiktar], [KullanilanMiktar], [NetMiktar], [GoruntulenmeSayisi], [Begeniler], [FiyatPuani], [DegerPuani], [KalitePuani]) VALUES (39, N'Bayan Dolgu Mont', CAST(N'2017-05-03 00:00:00.000' AS DateTime), 69.9900, 10, CAST(N'2016-11-22' AS Date), N'Cep Detaylı, Kapşonlu Mont, %100 Polyester ve kış günlerinde sizi sıcak tutacak derecede kaliteli ve şık tasarımlı...', 6, 180, 41, 139, 3, 0, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Urun] OFF
SET IDENTITY_INSERT [dbo].[UrunGorseli] ON 

INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (1, 1, N'http://www.firmasec.com/resim/1/denim-sm-631-jeans-erkek-kot-pantolon-c811c1c9-tmbdr.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (2, 1, N'http://www.firmasec.com/resim/1/denim-sm-631-jeans-erkek-kot-pantolon-c811c1c9-tmbdr.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (3, 1, N'http://www.firmasec.com/resim/1/denim-sm-631-jeans-erkek-kot-pantolon-c811c1c9-tmbdr.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (4, 1, N'http://www.firmasec.com/resim/1/denim-sm-631-jeans-erkek-kot-pantolon-c811c1c9-tmbdr.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (5, 2, N'http://sanalzade.com/wp-content/uploads/2012/12/mont-121.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (6, 2, N'http://sanalzade.com/wp-content/uploads/2012/12/mont-121.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (7, 2, N'http://sanalzade.com/wp-content/uploads/2012/12/mont-121.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (8, 2, N'http://sanalzade.com/wp-content/uploads/2012/12/mont-121.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (21, 11, N'http://dfcdn.defacto.com.tr/3/G3775_IN75_16CW_03_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (22, 11, N'http://dfcdn.defacto.com.tr/3/G3775_IN75_16CW_02_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (23, 11, N'http://dfcdn.defacto.com.tr/3/G3775_IN75_16CW_01_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (24, 11, N'http://dfcdn.defacto.com.tr/3/G3775_IN75_16CW_02_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (25, 12, N'http://dfcdn.defacto.com.tr/3/G0435_RD85_16WN_01_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (26, 12, N'http://dfcdn.defacto.com.tr/3/G0435_RD85_16WN_02_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (27, 12, N'http://dfcdn.defacto.com.tr/3/G0435_RD85_16WN_03_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (28, 13, N'http://dfcdn.defacto.com.tr/3/G0008_IN20_16CW_01_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (29, 13, N'http://dfcdn.defacto.com.tr/3/G0008_IN20_16CW_02_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (30, 13, N'http://dfcdn.defacto.com.tr/3/G0008_IN20_16CW_03_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (31, 15, N'http://img-kotonw.mncdn.com/static/product-images/9020486025246/7KAK92544HT720-G01-large1-V01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (32, 15, N'http://img-kotonw.mncdn.com/static/product-images/9020486516766/7KAK92544HT720-G02-large2-V01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (33, 15, N'http://img-kotonw.mncdn.com/static/product-images/9020487303198/7KAK92544HT720-G03-large3-V01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (34, 14, N'http://dfcdn.defacto.com.tr/3/G0858_BK27_16WN_01_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (35, 14, N'http://dfcdn.defacto.com.tr/3/G0858_BK27_16WN_02_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (36, 14, N'http://dfcdn.defacto.com.tr/3/G0858_BK27_16WN_03_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (37, 16, N'http://img-kotonw.mncdn.com/static/product-images/9033374695454/7KAK92570HT030-G01-large1-V01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (38, 16, N'http://img-kotonw.mncdn.com/static/product-images/9033374990366/7KAK92570HT030-G02-large2-V01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (39, 16, N'http://img-kotonw.mncdn.com/static/product-images/9033375514654/7KAK92570HT030-G03-large3-V01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (40, 17, N'http://img-kotonw.mncdn.com/static/product-images/8979780042782/7KKB66391GW33A-G01-large1-V01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (41, 17, N'http://img-kotonw.mncdn.com/static/product-images/8979780796446/7KKB66391GW33A-G02-large2-V01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (42, 18, N'https://feo.rnd-cdn.com/adidas/mnresize/1500/1500/Content/media/ProductImg/original/BG8471-besiktas-1617-deplasman-forma-636027033353362782.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (43, 18, N'https://feo.rnd-cdn.com/adidas/mnresize/1500/1500/Content/media/ProductImg/original/BG8471-bjk-16-away-ss-blackwhite-636016001623296497.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (44, 19, N'https://feo.rnd-cdn.com/adidas/mnresize/1500/1500/Content/media/ProductImg/original/BD6909-fenerbahce-1617-ic-saha-forma-636045145993130662.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (45, 19, N'https://feo.rnd-cdn.com/adidas/mnresize/1500/1500/Content/media/ProductImg/original/BD6909-fenerbahce-1617-ic-saha-forma-636045146351412220.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (46, 20, N'http://www.hummel.net//upload/images/product_image/zoom/44/1449730695/81744/80-829-2001/classic-bee-womens-hybrid-jkt.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (47, 20, N'http://www.hummel.net//upload/images/product_image/zoom/45/1449730697/81745/80-829-2001_1/classic-bee-womens-hybrid-jkt.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (48, 21, N'https://img-colinstr.mncdn.com/Assets/Branch/Thumbs/gri_erkek_ceket_77392.jpeg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (49, 21, N'https://img-colinstr.mncdn.com/Assets/Branch/Thumbs/gri_erkek_ceket_77393.jpeg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (50, 21, N'https://img-colinstr.mncdn.com/Assets/Branch/Thumbs/gri_erkek_ceket_77394.jpeg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (51, 22, N'http://dfcdn.defacto.com.tr/3/E3493_BK27_15AU_01_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (52, 22, N'http://dfcdn.defacto.com.tr/3/E3493_BK27_15AU_02_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (53, 22, N'http://dfcdn.defacto.com.tr/3/E3493_BK27_15AU_03_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (54, 23, N'http://dfcdn.defacto.com.tr/3/F7438_NV149_16WN_01_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (55, 23, N'http://dfcdn.defacto.com.tr/3/F7438_NV149_16WN_02_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (56, 23, N'http://dfcdn.defacto.com.tr/3/F7438_NV149_16WN_03_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (57, 24, N'http://dfcdn.defacto.com.tr/3/F5151_BR252_15WN_01_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (58, 24, N'http://dfcdn.defacto.com.tr/3/F5151_BR252_15WN_01_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (59, 25, N'http://dfcdn.defacto.com.tr/3/G1173_GN550_16WN_03_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (60, 25, N'http://dfcdn.defacto.com.tr/3/G1173_GN550_16WN_01_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (61, 25, N'http://dfcdn.defacto.com.tr/3/G1173_GN550_16WN_02_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (62, 26, N'http://dfcdn.defacto.com.tr/3/G3369_GR210_16WN_01_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (63, 26, N'http://dfcdn.defacto.com.tr/3/G3369_GR210_16WN_02_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (64, 26, N'http://dfcdn.defacto.com.tr/3/G3369_GR210_16WN_03_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (65, 27, N'http://dfcdn.defacto.com.tr/3/D7289_ER30_15SP_01_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (66, 27, N'http://dfcdn.defacto.com.tr/3/D7289_ER30_15SP_02_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (67, 27, N'http://dfcdn.defacto.com.tr/3/D7289_ER30_15SP_03_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (68, 28, N'http://dfcdn.defacto.com.tr/3/G1077_BN220_16AU_02_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (69, 28, N'http://dfcdn.defacto.com.tr/3/G1077_BN220_16AU_01_01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (70, 30, N'https://feo.rnd-cdn.com/adidas/mnresize/1500/1500/Content/media/ProductImg/original/AY3012-adidas-trainer-esofman-takimi-636053223170489168.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (71, 30, N'https://feo.rnd-cdn.com/adidas/mnresize/1500/1500/Content/media/ProductImg/original/AY3012-adidas-trainer-esofman-takimi-636053316882546000.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (72, 30, N'https://feo.rnd-cdn.com/adidas/mnresize/1500/1500/Content/media/ProductImg/original/AY3012-adidas-trainer-esofman-takimi-636053755530232784.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (73, 31, N'https://feo.rnd-cdn.com/adidas/mnresize/1500/1500/Content/media/ProductImg/original/AY3011-adidas-trainer-esofman-takimi-636053223146268877.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (74, 31, N'https://feo.rnd-cdn.com/adidas/mnresize/1500/1500/Content/media/ProductImg/original/AY3011-adidas-trainer-esofman-takimi-636053316838483451.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (75, 31, N'https://feo.rnd-cdn.com/adidas/mnresize/1500/1500/Content/media/ProductImg/original/AY3011-adidas-trainer-esofman-takimi-636053756080078198.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (76, 32, N'https://feo.rnd-cdn.com/adidas/mnresize/1500/1500/Content/media/ProductImg/original/AZ6264-adidas-hibrit-kaz-tuyu-dolgulu-kapusonlu-mont-636118575570893088.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (77, 32, N'https://feo.rnd-cdn.com/adidas/mnresize/1500/1500/Content/media/ProductImg/original/AZ6264-adidas-hibrit-kaz-tuyu-dolgulu-kapusonlu-mont-636118575585268058.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (78, 32, N'https://feo.rnd-cdn.com/adidas/mnresize/1500/1500/Content/media/ProductImg/original/AZ6264-adidas-hibrit-kaz-tuyu-dolgulu-kapusonlu-mont-636118575575580623.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (79, 33, N'//sky-static.mavi.com/sys-master/maviTrImages/h3e/hf1/8911924101150/070293-21598_image_1.jpg_Default-ZoomProductImage')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (80, 33, N'https://sky-static.mavi.com/sys-master/maviTrImages/he0/h20/8911921512478/070293-21598_image_4.jpg_Default-MainProductImage')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (81, 34, N'https://img-colinstr.mncdn.com/Assets/Branch/Thumbs/siyah_bayan_mont_79682.jpeg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (82, 34, N'https://img-colinstr.mncdn.com/Assets/Branch/Thumbs/siyah_bayan_mont_79683.jpeg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (83, 34, N'https://img-colinstr.mncdn.com/Assets/Branch/Thumbs/siyah_bayan_mont_79684.jpeg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (84, 35, N'https://img-colinstr.mncdn.com/Assets/Branch/Thumbs/colins_bordo_bayan_kazak_78942.jpeg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (85, 35, N'https://img-colinstr.mncdn.com/Assets/Branch/Thumbs/colins_bordo_bayan_kazak_78943.jpeg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (86, 35, N'https://img-colinstr.mncdn.com/Assets/Branch/Thumbs/colins_bordo_bayan_kazak_78944.jpeg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (87, 36, N'http://shop.ltbjeans.com/UPLOAD/PRODUCT/2013/thumb/011178615760880000_1243_2_large.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (88, 36, N'http://shop.ltbjeans.com/UPLOAD/PRODUCT/2013/thumb/011178615760880000_1243_1_large.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (89, 36, N'http://shop.ltbjeans.com/UPLOAD/PRODUCT/2013/thumb/011178615760880000_1243_3_large.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (90, 36, N'http://shop.ltbjeans.com/UPLOAD/PRODUCT/2013/thumb/011178615760880000_1243_4_large.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (91, 37, N'http://shop.ltbjeans.com/UPLOAD/PRODUCT/2013/thumb/100950449135644207_1_large.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (92, 37, N'http://shop.ltbjeans.com/UPLOAD/PRODUCT/2013/thumb/100950449135644207_2_large.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (93, 37, N'http://shop.ltbjeans.com/UPLOAD/PRODUCT/2013/thumb/100950449135644207_4_large.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (94, 38, N'https://feo.rnd-cdn.com/adidas/mnresize/1500/1500/Content/media/ProductImg/original/AP9426-adidas-london-line-club-kapusonlu-ceket-636089223184130390.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (95, 38, N'https://feo.rnd-cdn.com/adidas/mnresize/1500/1500/Content/media/ProductImg/original/AP9426-adidas-london-line-club-kapusonlu-ceket-636089223314912325.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (96, 38, N'https://feo.rnd-cdn.com/adidas/mnresize/1500/1500/Content/media/ProductImg/original/AP9426-adidas-london-line-club-kapusonlu-ceket-636089223366318309.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (97, 39, N'http://img-kotonw.mncdn.com/static/product-images/9050261553182/7KAK22016YW027-G01-zoom1-V01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (98, 39, N'http://img-kotonw.mncdn.com/static/product-images/9050261684254/7KAK22016YW027-G02-zoom2-V01.jpg')
INSERT [dbo].[UrunGorseli] ([GorselID], [UrunID], [GorselAdres]) VALUES (99, 39, N'http://img-kotonw.mncdn.com/static/product-images/9050262339614/7KAK22016YW027-G03-zoom3-V01.jpg')
SET IDENTITY_INSERT [dbo].[UrunGorseli] OFF
SET IDENTITY_INSERT [dbo].[UrunGrubu] ON 

INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (1, N'Kot', 1)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (3, N'Kaban', 1)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (5, N'Mont', 1)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (6, N'Mont', 2)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (7, N'Bot', 4)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (8, N'Bere', 5)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (9, N'Şal', 5)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (10, N'Kazak', 1)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (11, N'Kazak', 2)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (12, N'Gömlek', 1)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (13, N'Gömlek', 2)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (14, N'Gömlek', 3)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (15, N'Kot', 2)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (16, N'Kaban', 2)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (17, N'Forma', 1)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (18, N'Forma', 2)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (19, N'Forma', 3)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (20, N'Ev Ayakkabısı', 4)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (21, N'Ceket', 1)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (22, N'Ceket', 2)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (23, N'Pantolon', 1)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (24, N'Pantolon', 2)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (25, N'Pantolon', 3)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (26, N'Ayakkabı', 4)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (27, N'Yelek', 1)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (28, N'Yelek', 2)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (29, N'Yelek', 3)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (30, N'Atlet', 1)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (31, N'Atlet', 2)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (32, N'Kemer', 5)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (33, N'Spor Ayakkabı', 4)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (34, N'Terlik', 4)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (35, N'Sandalet', 4)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (36, N'Şapka', 5)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (37, N'Atkı', 5)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (38, N'Eldiven', 5)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (39, N'Saat', 5)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (40, N'Cüzdan', 5)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (41, N'Eşofman', 1)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (42, N'Eşofman', 2)
INSERT [dbo].[UrunGrubu] ([GrupID], [GrupAdi], [KategoriID]) VALUES (43, N'Eşofman', 3)
SET IDENTITY_INSERT [dbo].[UrunGrubu] OFF
SET IDENTITY_INSERT [dbo].[UrunPuan] ON 

INSERT [dbo].[UrunPuan] ([PuanID], [UyeID], [UrunID], [FiyatPuani], [DegerPuani], [KalitePuani], [Begeni], [Baslik], [Yorum], [Tarih]) VALUES (1, 4, 27, 4, 4, 4, 1, N'', N'', NULL)
INSERT [dbo].[UrunPuan] ([PuanID], [UyeID], [UrunID], [FiyatPuani], [DegerPuani], [KalitePuani], [Begeni], [Baslik], [Yorum], [Tarih]) VALUES (2, 3, 27, 5, 5, 3, 0, NULL, NULL, NULL)
INSERT [dbo].[UrunPuan] ([PuanID], [UyeID], [UrunID], [FiyatPuani], [DegerPuani], [KalitePuani], [Begeni], [Baslik], [Yorum], [Tarih]) VALUES (3, 2, 27, 4, 2, 4, 1, NULL, NULL, NULL)
INSERT [dbo].[UrunPuan] ([PuanID], [UyeID], [UrunID], [FiyatPuani], [DegerPuani], [KalitePuani], [Begeni], [Baslik], [Yorum], [Tarih]) VALUES (5, 4, 25, 5, 3, 4, NULL, N'__', N'güzel bence', NULL)
INSERT [dbo].[UrunPuan] ([PuanID], [UyeID], [UrunID], [FiyatPuani], [DegerPuani], [KalitePuani], [Begeni], [Baslik], [Yorum], [Tarih]) VALUES (6, 5, 25, 5, 4, 5, 1, N'', N'Fiyatı çok uygun ve renk deseni gayet güzel', NULL)
INSERT [dbo].[UrunPuan] ([PuanID], [UyeID], [UrunID], [FiyatPuani], [DegerPuani], [KalitePuani], [Begeni], [Baslik], [Yorum], [Tarih]) VALUES (7, 4, 17, 5, 4, 4, 0, N'çok şeker', N'yaa bayıldım', NULL)
INSERT [dbo].[UrunPuan] ([PuanID], [UyeID], [UrunID], [FiyatPuani], [DegerPuani], [KalitePuani], [Begeni], [Baslik], [Yorum], [Tarih]) VALUES (8, 5, 28, 5, 4, 4, 0, N'...', N'fiyatı çok uygun', NULL)
INSERT [dbo].[UrunPuan] ([PuanID], [UyeID], [UrunID], [FiyatPuani], [DegerPuani], [KalitePuani], [Begeni], [Baslik], [Yorum], [Tarih]) VALUES (9, 3, 23, 5, 5, 5, 0, N'', N'', CAST(N'2016-11-19 22:01:56.020' AS DateTime))
INSERT [dbo].[UrunPuan] ([PuanID], [UyeID], [UrunID], [FiyatPuani], [DegerPuani], [KalitePuani], [Begeni], [Baslik], [Yorum], [Tarih]) VALUES (10, 5, 20, 3, 4, 5, 1, N'', N'', CAST(N'2016-11-20 01:08:26.690' AS DateTime))
INSERT [dbo].[UrunPuan] ([PuanID], [UyeID], [UrunID], [FiyatPuani], [DegerPuani], [KalitePuani], [Begeni], [Baslik], [Yorum], [Tarih]) VALUES (11, 5, 21, -1, -1, -1, 1, N'', N'', NULL)
INSERT [dbo].[UrunPuan] ([PuanID], [UyeID], [UrunID], [FiyatPuani], [DegerPuani], [KalitePuani], [Begeni], [Baslik], [Yorum], [Tarih]) VALUES (12, 5, 17, -1, -1, -1, 1, N'', N'', NULL)
INSERT [dbo].[UrunPuan] ([PuanID], [UyeID], [UrunID], [FiyatPuani], [DegerPuani], [KalitePuani], [Begeni], [Baslik], [Yorum], [Tarih]) VALUES (13, 5, 13, -1, -1, -1, 1, N'', N'', NULL)
SET IDENTITY_INSERT [dbo].[UrunPuan] OFF
SET IDENTITY_INSERT [dbo].[UrunTag] ON 

INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (1, 6, 32)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (2, 10, 32)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (3, 11, 32)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (4, 12, 32)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (5, 13, 32)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (6, 14, 32)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (7, 15, 32)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (8, 16, 21)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (9, 17, 21)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (10, 18, 21)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (11, 19, 21)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (12, 2, 12)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (13, 20, 12)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (14, 21, 12)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (15, 22, 12)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (16, 1, 11)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (17, 21, 11)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (18, 23, 11)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (19, 1, 13)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (20, 21, 13)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (21, 24, 13)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (22, 25, 13)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (23, 26, 13)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (24, 2, 14)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (25, 21, 14)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (26, 27, 14)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (27, 1, 15)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (28, 24, 15)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (29, 26, 15)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (30, 28, 15)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (31, 1, 16)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (32, 28, 16)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (33, 29, 16)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (34, 30, 16)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (35, 2, 17)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (36, 28, 17)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (37, 31, 17)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (38, 32, 17)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (39, 6, 18)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (40, 33, 18)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (41, 34, 18)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (42, 35, 18)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (43, 36, 18)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (44, 6, 19)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (45, 33, 19)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (46, 36, 19)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (47, 37, 19)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (48, 38, 19)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (49, 39, 19)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (50, 21, 23)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (51, 40, 23)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (52, 41, 23)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (53, 42, 23)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (54, 43, 23)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (55, 44, 23)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (56, 21, 24)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (57, 45, 24)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (58, 46, 24)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (59, 2, 25)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (60, 21, 25)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (61, 47, 25)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (62, 21, 26)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (63, 30, 26)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (64, 48, 26)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (65, 21, 27)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (66, 48, 27)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (67, 49, 27)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (68, 21, 28)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (69, 46, 28)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (70, 50, 28)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (71, 6, 30)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (72, 7, 30)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (73, 8, 30)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (74, 9, 30)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (75, 14, 39)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (76, 28, 39)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (77, 51, 39)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (78, 52, 39)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (79, 6, 38)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (80, 12, 38)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (81, 16, 38)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (82, 53, 38)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (83, 54, 38)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (84, 55, 38)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (85, 56, 37)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (86, 57, 37)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (87, 58, 37)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (88, 59, 37)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (89, 60, 37)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (90, 2, 36)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (91, 58, 36)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (92, 61, 36)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (93, 62, 36)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (94, 1, 35)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (95, 17, 35)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (96, 51, 35)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (97, 14, 34)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (98, 17, 34)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (99, 51, 34)
GO
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (100, 1, 33)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (101, 63, 33)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (102, 64, 33)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (103, 6, 31)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (104, 7, 31)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (105, 8, 31)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (106, 9, 31)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (107, 16, 22)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (108, 21, 22)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (109, 27, 22)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (110, 65, 22)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (111, 66, 22)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (112, 67, 22)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (113, 68, 22)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (114, 14, 20)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (115, 69, 20)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (116, 70, 20)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (117, 71, 20)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (118, 72, 20)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (119, 73, 20)
INSERT [dbo].[UrunTag] ([UrunTagID], [TagID], [UrunID]) VALUES (120, 74, 20)
SET IDENTITY_INSERT [dbo].[UrunTag] OFF
SET IDENTITY_INSERT [dbo].[Uye] ON 

INSERT [dbo].[Uye] ([UyeID], [KullaniciAdi], [Sifre], [Tarih], [Mail], [Songiris], [AdSoyad], [TcKimlik], [Engelli], [BlogYazmaDuzenleme], [BlogYonetme], [UrunGirmeDuzenleme], [UrunSilme], [FaturaIslemleri], [SiteUnsurlari], [Yetkilendirme]) VALUES (1, N'oguz_kara', N'1234', CAST(N'2016-11-08 13:57:25.867' AS DateTime), N'oguzhan@hotmil.com', CAST(N'2016-11-01 00:00:00.000' AS DateTime), N'Oğuz Kara', N'19952457857', 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[Uye] ([UyeID], [KullaniciAdi], [Sifre], [Tarih], [Mail], [Songiris], [AdSoyad], [TcKimlik], [Engelli], [BlogYazmaDuzenleme], [BlogYonetme], [UrunGirmeDuzenleme], [UrunSilme], [FaturaIslemleri], [SiteUnsurlari], [Yetkilendirme]) VALUES (2, N'Dursun_Emre', N'14523', CAST(N'2016-11-08 13:58:20.490' AS DateTime), N'dursun.emre@hotmail.com', CAST(N'2016-11-01 00:00:00.000' AS DateTime), N'Emre Kanat', N'20419976772', 0, 1, 1, 1, 1, 1, 0, 0)
INSERT [dbo].[Uye] ([UyeID], [KullaniciAdi], [Sifre], [Tarih], [Mail], [Songiris], [AdSoyad], [TcKimlik], [Engelli], [BlogYazmaDuzenleme], [BlogYonetme], [UrunGirmeDuzenleme], [UrunSilme], [FaturaIslemleri], [SiteUnsurlari], [Yetkilendirme]) VALUES (3, N'Elif', N'2145', CAST(N'2016-11-08 13:59:32.430' AS DateTime), N'elif@hotmail.com', CAST(N'2016-11-01 00:00:00.000' AS DateTime), N'Elif Kamber', N'21548424548', 0, 0, 0, 1, 1, 0, 0, 0)
INSERT [dbo].[Uye] ([UyeID], [KullaniciAdi], [Sifre], [Tarih], [Mail], [Songiris], [AdSoyad], [TcKimlik], [Engelli], [BlogYazmaDuzenleme], [BlogYonetme], [UrunGirmeDuzenleme], [UrunSilme], [FaturaIslemleri], [SiteUnsurlari], [Yetkilendirme]) VALUES (4, N'Gamze', N'1245', CAST(N'2016-11-08 14:00:16.447' AS DateTime), N'gamze@hotmai.com', CAST(N'2016-11-01 00:00:00.000' AS DateTime), N'Gamze Mıhcı', N'34527896544', 0, 1, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[Uye] ([UyeID], [KullaniciAdi], [Sifre], [Tarih], [Mail], [Songiris], [AdSoyad], [TcKimlik], [Engelli], [BlogYazmaDuzenleme], [BlogYonetme], [UrunGirmeDuzenleme], [UrunSilme], [FaturaIslemleri], [SiteUnsurlari], [Yetkilendirme]) VALUES (5, N'Murat', N'1234', CAST(N'2016-11-16 18:47:11.383' AS DateTime), N'murat.acarsoy@gmail.com', NULL, N'Murat Acarsoy', N'16165165150', 0, 1, 1, 1, 1, 1, 1, 1)
INSERT [dbo].[Uye] ([UyeID], [KullaniciAdi], [Sifre], [Tarih], [Mail], [Songiris], [AdSoyad], [TcKimlik], [Engelli], [BlogYazmaDuzenleme], [BlogYonetme], [UrunGirmeDuzenleme], [UrunSilme], [FaturaIslemleri], [SiteUnsurlari], [Yetkilendirme]) VALUES (10, N'_misafir14445555522', NULL, NULL, N'cemal.kara@gmail.com', NULL, N'Cemal Kara', N'14445555522', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Uye] ([UyeID], [KullaniciAdi], [Sifre], [Tarih], [Mail], [Songiris], [AdSoyad], [TcKimlik], [Engelli], [BlogYazmaDuzenleme], [BlogYonetme], [UrunGirmeDuzenleme], [UrunSilme], [FaturaIslemleri], [SiteUnsurlari], [Yetkilendirme]) VALUES (11, N'_misafir24567893178', NULL, NULL, N'arzu.kara@hotmail.com', NULL, N'Arzu Kara', N'24567893178', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Uye] ([UyeID], [KullaniciAdi], [Sifre], [Tarih], [Mail], [Songiris], [AdSoyad], [TcKimlik], [Engelli], [BlogYazmaDuzenleme], [BlogYonetme], [UrunGirmeDuzenleme], [UrunSilme], [FaturaIslemleri], [SiteUnsurlari], [Yetkilendirme]) VALUES (12, N'_misafir25340150247', NULL, NULL, N'selim.kiraz@gmail.com', NULL, N'Selim Kiraz', N'25340150247', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Uye] ([UyeID], [KullaniciAdi], [Sifre], [Tarih], [Mail], [Songiris], [AdSoyad], [TcKimlik], [Engelli], [BlogYazmaDuzenleme], [BlogYonetme], [UrunGirmeDuzenleme], [UrunSilme], [FaturaIslemleri], [SiteUnsurlari], [Yetkilendirme]) VALUES (13, N'_misafir54515156815', NULL, NULL, N'feride.salim@hotmail.com', NULL, N'Feride Salim', N'54515156815', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Uye] OFF
ALTER TABLE [dbo].[BlogYorum] ADD  CONSTRAINT [DF_BlogYorum_Tarih]  DEFAULT (getdate()) FOR [Tarih]
GO
ALTER TABLE [dbo].[BedenvsUrun]  WITH CHECK ADD  CONSTRAINT [FK_BedenvsUrun_Beden] FOREIGN KEY([BedenID])
REFERENCES [dbo].[Beden] ([BedenID])
GO
ALTER TABLE [dbo].[BedenvsUrun] CHECK CONSTRAINT [FK_BedenvsUrun_Beden]
GO
ALTER TABLE [dbo].[BedenvsUrun]  WITH CHECK ADD  CONSTRAINT [FK_BedenvsUrun_Urun] FOREIGN KEY([UrunID])
REFERENCES [dbo].[Urun] ([UrunID])
GO
ALTER TABLE [dbo].[BedenvsUrun] CHECK CONSTRAINT [FK_BedenvsUrun_Urun]
GO
ALTER TABLE [dbo].[Blog]  WITH CHECK ADD  CONSTRAINT [FK_Blog_BlogGrubu] FOREIGN KEY([BlogGrubuID])
REFERENCES [dbo].[BlogGrubu] ([BlogGrubuID])
GO
ALTER TABLE [dbo].[Blog] CHECK CONSTRAINT [FK_Blog_BlogGrubu]
GO
ALTER TABLE [dbo].[Blog]  WITH CHECK ADD  CONSTRAINT [FK_Blog_Uye] FOREIGN KEY([UyeID])
REFERENCES [dbo].[Uye] ([UyeID])
GO
ALTER TABLE [dbo].[Blog] CHECK CONSTRAINT [FK_Blog_Uye]
GO
ALTER TABLE [dbo].[BlogTag]  WITH CHECK ADD  CONSTRAINT [FK_BlogTag_Blog] FOREIGN KEY([BlogID])
REFERENCES [dbo].[Blog] ([BlogID])
GO
ALTER TABLE [dbo].[BlogTag] CHECK CONSTRAINT [FK_BlogTag_Blog]
GO
ALTER TABLE [dbo].[BlogTag]  WITH CHECK ADD  CONSTRAINT [FK_BlogTag_Tag] FOREIGN KEY([TagID])
REFERENCES [dbo].[Tag] ([TagID])
GO
ALTER TABLE [dbo].[BlogTag] CHECK CONSTRAINT [FK_BlogTag_Tag]
GO
ALTER TABLE [dbo].[BlogYorum]  WITH CHECK ADD  CONSTRAINT [FK_BlogYorum_Blog] FOREIGN KEY([BlogID])
REFERENCES [dbo].[Blog] ([BlogID])
GO
ALTER TABLE [dbo].[BlogYorum] CHECK CONSTRAINT [FK_BlogYorum_Blog]
GO
ALTER TABLE [dbo].[BlogYorum]  WITH CHECK ADD  CONSTRAINT [FK_BlogYorum_Uye] FOREIGN KEY([UyeID])
REFERENCES [dbo].[Uye] ([UyeID])
GO
ALTER TABLE [dbo].[BlogYorum] CHECK CONSTRAINT [FK_BlogYorum_Uye]
GO
ALTER TABLE [dbo].[Fatura]  WITH CHECK ADD  CONSTRAINT [FK_Fatura_Kargo] FOREIGN KEY([KargoID])
REFERENCES [dbo].[Kargo] ([KargoID])
GO
ALTER TABLE [dbo].[Fatura] CHECK CONSTRAINT [FK_Fatura_Kargo]
GO
ALTER TABLE [dbo].[Fatura]  WITH CHECK ADD  CONSTRAINT [FK_Fatura_Musteri] FOREIGN KEY([TcKimlik])
REFERENCES [dbo].[Musteri] ([TcKimlik])
GO
ALTER TABLE [dbo].[Fatura] CHECK CONSTRAINT [FK_Fatura_Musteri]
GO
ALTER TABLE [dbo].[FaturaDetay]  WITH CHECK ADD  CONSTRAINT [FK_FaturaDetay_Fatura] FOREIGN KEY([FaturaID])
REFERENCES [dbo].[Fatura] ([FaturaID])
GO
ALTER TABLE [dbo].[FaturaDetay] CHECK CONSTRAINT [FK_FaturaDetay_Fatura]
GO
ALTER TABLE [dbo].[FaturaDetay]  WITH CHECK ADD  CONSTRAINT [FK_FaturaDetay_Urun] FOREIGN KEY([UrunId])
REFERENCES [dbo].[Urun] ([UrunID])
GO
ALTER TABLE [dbo].[FaturaDetay] CHECK CONSTRAINT [FK_FaturaDetay_Urun]
GO
ALTER TABLE [dbo].[OneCikanUrunler]  WITH CHECK ADD  CONSTRAINT [FK_OneCikanUrunler_Urun] FOREIGN KEY([UrunID])
REFERENCES [dbo].[Urun] ([UrunID])
GO
ALTER TABLE [dbo].[OneCikanUrunler] CHECK CONSTRAINT [FK_OneCikanUrunler_Urun]
GO
ALTER TABLE [dbo].[RenkvsUrun]  WITH CHECK ADD  CONSTRAINT [FK_RenkvsUrun_Renk] FOREIGN KEY([RenkID])
REFERENCES [dbo].[Renk] ([RenkID])
GO
ALTER TABLE [dbo].[RenkvsUrun] CHECK CONSTRAINT [FK_RenkvsUrun_Renk]
GO
ALTER TABLE [dbo].[RenkvsUrun]  WITH CHECK ADD  CONSTRAINT [FK_RenkvsUrun_Urun] FOREIGN KEY([UrunID])
REFERENCES [dbo].[Urun] ([UrunID])
GO
ALTER TABLE [dbo].[RenkvsUrun] CHECK CONSTRAINT [FK_RenkvsUrun_Urun]
GO
ALTER TABLE [dbo].[Urun]  WITH CHECK ADD  CONSTRAINT [FK_Urun_Marka] FOREIGN KEY([MarkaID])
REFERENCES [dbo].[Marka] ([MarkaID])
GO
ALTER TABLE [dbo].[Urun] CHECK CONSTRAINT [FK_Urun_Marka]
GO
ALTER TABLE [dbo].[Urun]  WITH CHECK ADD  CONSTRAINT [FK_Urun_UrunGrubu] FOREIGN KEY([GrupID])
REFERENCES [dbo].[UrunGrubu] ([GrupID])
GO
ALTER TABLE [dbo].[Urun] CHECK CONSTRAINT [FK_Urun_UrunGrubu]
GO
ALTER TABLE [dbo].[UrunGorseli]  WITH CHECK ADD  CONSTRAINT [FK_UrunGorseli_Urun] FOREIGN KEY([UrunID])
REFERENCES [dbo].[Urun] ([UrunID])
GO
ALTER TABLE [dbo].[UrunGorseli] CHECK CONSTRAINT [FK_UrunGorseli_Urun]
GO
ALTER TABLE [dbo].[UrunGrubu]  WITH CHECK ADD  CONSTRAINT [FK_UrunGrubu_Kategori] FOREIGN KEY([KategoriID])
REFERENCES [dbo].[Kategori] ([KategoriID])
GO
ALTER TABLE [dbo].[UrunGrubu] CHECK CONSTRAINT [FK_UrunGrubu_Kategori]
GO
ALTER TABLE [dbo].[UrunPuan]  WITH CHECK ADD  CONSTRAINT [FK_UrunPuan_Urun] FOREIGN KEY([UrunID])
REFERENCES [dbo].[Urun] ([UrunID])
GO
ALTER TABLE [dbo].[UrunPuan] CHECK CONSTRAINT [FK_UrunPuan_Urun]
GO
ALTER TABLE [dbo].[UrunPuan]  WITH CHECK ADD  CONSTRAINT [FK_UrunPuan_Uye] FOREIGN KEY([UyeID])
REFERENCES [dbo].[Uye] ([UyeID])
GO
ALTER TABLE [dbo].[UrunPuan] CHECK CONSTRAINT [FK_UrunPuan_Uye]
GO
ALTER TABLE [dbo].[UrunTag]  WITH CHECK ADD  CONSTRAINT [FK_UrunTag_Tag] FOREIGN KEY([TagID])
REFERENCES [dbo].[Tag] ([TagID])
GO
ALTER TABLE [dbo].[UrunTag] CHECK CONSTRAINT [FK_UrunTag_Tag]
GO
ALTER TABLE [dbo].[UrunTag]  WITH CHECK ADD  CONSTRAINT [FK_UrunTag_Urun] FOREIGN KEY([UrunID])
REFERENCES [dbo].[Urun] ([UrunID])
GO
ALTER TABLE [dbo].[UrunTag] CHECK CONSTRAINT [FK_UrunTag_Urun]
GO
ALTER TABLE [dbo].[Uye]  WITH CHECK ADD  CONSTRAINT [FK_Uye_Musteri1] FOREIGN KEY([TcKimlik])
REFERENCES [dbo].[Musteri] ([TcKimlik])
GO
ALTER TABLE [dbo].[Uye] CHECK CONSTRAINT [FK_Uye_Musteri1]
GO
/****** Object:  StoredProcedure [dbo].[sp_EkonomikUrunler]    Script Date: 29.11.2016 23:45:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_EkonomikUrunler]
as
begin
	select top 3 UrunID, UrunAdi, BirimFiyat, 
	(select top 1 GorselAdres from UrunGorseli where UrunGorseli.UrunID = Urun.UrunID) as GorselAdres 
	from Urun where UrunID in
	(select max(UrunID) as UrunID from Urun group by GrupID)
	order by BirimFiyat
end

GO
/****** Object:  StoredProcedure [dbo].[sp_EnFazlaGoruntulenenler]    Script Date: 29.11.2016 23:45:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_EnFazlaGoruntulenenler]
as
begin
	select top 3 UrunID, UrunAdi, BirimFiyat,
	(select top 1 GorselAdres from UrunGorseli where Urun.UrunID = UrunGorseli.UrunID) as GorselAdres
	from Urun order by GoruntulenmeSayisi desc
end

GO
/****** Object:  StoredProcedure [dbo].[sp_EnYeniUrunler]    Script Date: 29.11.2016 23:45:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_EnYeniUrunler]
as
begin
	select top 3 UrunID, UrunAdi, BirimFiyat, 
	(select top 1 GorselAdres from UrunGorseli where Urun.UrunID = UrunGorseli.UrunID order by GorselID) as GorselAdres
	from Urun order by Tarih desc
end

GO
/****** Object:  StoredProcedure [dbo].[sp_IadeEt]    Script Date: 29.11.2016 23:45:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_IadeEt](@FaturaID int)
as
begin
	update SiparisDurum set Onaylandi=0,Hazirlaniyor=0,
	OnayVeriliyor=0,KargoyaVerildi=0,IptalEdildi=0,IadeEdildi=1
	where FaturaID=@FaturaID
	delete from Fatura where FaturaID=@FaturaID
end

GO
/****** Object:  StoredProcedure [dbo].[sp_IptalEt]    Script Date: 29.11.2016 23:45:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_IptalEt](@FaturaID int)
as
begin
	update SiparisDurum set Onaylandi=0,Hazirlaniyor=0,
	OnayVeriliyor=0,KargoyaVerildi=0,IptalEdildi=1,IadeEdildi=0
	where FaturaID=@FaturaID
	delete from Fatura where FaturaID=@FaturaID
end

GO
/****** Object:  StoredProcedure [dbo].[sp_KargoyaVer]    Script Date: 29.11.2016 23:45:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_KargoyaVer](@FaturaID int)
as
begin
	update SiparisDurum set Onaylandi=1,Hazirlaniyor=0,
	OnayVeriliyor=0,KargoyaVerildi=1,IptalEdildi=0,IadeEdildi=0
	where FaturaID=@FaturaID
end

GO
/****** Object:  StoredProcedure [dbo].[sp_Onaylama]    Script Date: 29.11.2016 23:45:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_Onaylama](@FaturaID int)
as
begin
	update SiparisDurum set Onaylandi=1,Hazirlaniyor=1,
	OnayVeriliyor=0,KargoyaVerildi=0,IptalEdildi=0,IadeEdildi=0
	where FaturaID=@FaturaID
end

GO
/****** Object:  StoredProcedure [dbo].[sp_OneCikanUrunler]    Script Date: 29.11.2016 23:45:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_OneCikanUrunler]
as
begin
	select UrunID, UrunAdi, 
	(select top 1 GorselAdres from UrunGorseli where Urun.UrunID = UrunGorseli.UrunID order by GorselID) as GorselAdres,
	(select top 1 GorselAdres from UrunGorseli where Urun.UrunID = UrunGorseli.UrunID order by GorselID desc) as GorselAdresHover,
	BirimFiyat, NetMiktar, Aciklama
	from Urun where UrunID in
	(select top 10 UrunID from OneCikanUrunler order by UrunID desc)
end

GO
/****** Object:  StoredProcedure [dbo].[sp_SatistakiUrunler]    Script Date: 29.11.2016 23:45:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_SatistakiUrunler]
as
begin
	declare @OrtalamaNetMiktar int
	select @OrtalamaNetMiktar = sum(NetMiktar) / count(*) from Urun
	select top 3 UrunID, UrunAdi, BirimFiyat, 
	(select top 1 GorselAdres from UrunGorseli where Urun.UrunID = UrunGorseli.UrunID order by GorselID) as GorselAdres
	from Urun where NetMiktar > @OrtalamaNetMiktar order by NetMiktar desc
end

GO
/****** Object:  StoredProcedure [dbo].[sp_UrunDetayBilgileri]    Script Date: 29.11.2016 23:45:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_UrunDetayBilgileri] (@urun_id int)
as
begin
	select UrunID, UrunAdi, Aciklama, BirimFiyat, Tarih,
	(select top 1 MarkaAdi from Marka where Urun.MarkaID = Marka.MarkaID) as Marka,
	GoruntulenmeSayisi, NetMiktar, Begeniler, FiyatPuani, DegerPuani, KalitePuani,
	(select top 1 GorselAdres from UrunGorseli where UrunGorseli.UrunID = Urun.UrunID order by GorselID ) as GorselAdres
	from Urun where UrunID = @urun_id
end

GO
/****** Object:  StoredProcedure [dbo].[sp_UrunGorseli2]    Script Date: 29.11.2016 23:45:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_UrunGorseli2] (@UrunID int)
as
select * from UrunGorseli where GorselID in
(select min(GorselID) from UrunGorseli where UrunID=@UrunID)

GO
/****** Object:  StoredProcedure [dbo].[sp_UrunGrubunaGoreUrun]    Script Date: 29.11.2016 23:45:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_UrunGrubunaGoreUrun]
as
select UrunID, UrunAdi, 
(select top 1 GorselAdres from UrunGorseli where UrunGorseli.UrunID = Urun.UrunID) as GorselAdres,
(select GrupAdi from UrunGrubu where UrunGrubu.GrupID = Urun.GrupID) as GrupAdi
from Urun where UrunID in
(select max(u.UrunID) from Urun u inner join UrunGrubu ug on u.GrupID = ug.GrupID group by GrupAdi) order by UrunID desc

GO
/****** Object:  Trigger [dbo].[tg_FaturaKesildiginde]    Script Date: 29.11.2016 23:45:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE trigger [dbo].[tg_FaturaKesildiginde]
on [dbo].[Fatura]
after insert
as
begin
	insert into SiparisDurum (FaturaID,OnayVeriliyor,Onaylandi,KargoyaVerildi,IptalEdildi,
	Hazirlaniyor,IadeEdildi)
	values ((select FaturaID from inserted),1,0,0,0,0,0)
end

GO
/****** Object:  Trigger [dbo].[tg_FaturaSil]    Script Date: 29.11.2016 23:45:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tg_FaturaSil]
on [dbo].[Fatura]
instead of delete
as
begin
	delete from FaturaDetay where FaturaID in (select FaturaID from deleted)
	delete from Fatura where FaturaID in(select FaturaID from deleted)
end

GO
/****** Object:  Trigger [dbo].[tg_StokArtir]    Script Date: 29.11.2016 23:45:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tg_StokArtir]
on [dbo].[FaturaDetay]
after delete
as
begin
	update Urun set KullanilanMiktar-=(select sum(miktar) from deleted) 
	where UrunID in (select UrunID from deleted)
end

GO
/****** Object:  Trigger [dbo].[tg_StokDusur]    Script Date: 29.11.2016 23:45:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE trigger [dbo].[tg_StokDusur]
on [dbo].[FaturaDetay]
after insert
as
begin
	update Urun set KullanilanMiktar+=(select sum(miktar) from inserted) 
	where UrunID in (select UrunID from inserted)
end

GO
/****** Object:  Trigger [dbo].[tg_ToplamTutarOlusturma]    Script Date: 29.11.2016 23:45:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tg_ToplamTutarOlusturma]
on [dbo].[FaturaDetay]
after insert,update
as
begin
	update Fatura set ToplamTutar=(1+KdvOrani)*
	(select sum(BirimFiyat*Miktar) from Urun u 
	inner join FaturaDetay fd on  u.UrunID=fd.UrunId 
	where FaturaID=(select FaturaID from inserted))
	where FaturaID=(select FaturaID from inserted)
end

GO
/****** Object:  Trigger [dbo].[tg_NetMiktarDuzenle]    Script Date: 29.11.2016 23:45:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE trigger [dbo].[tg_NetMiktarDuzenle]
on [dbo].[Urun]
after insert,update
as
begin
	update Urun set NetMiktar=(DepoyaGirenMiktar-KullanilanMiktar) where 
	UrunID in (select UrunID from inserted)

	declare @tagString varchar(max)
	(select top 1 @tagString = UrunAdi + ' ' + 
	(select top 1 MarkaAdi from Marka where Urun.MarkaID = Marka.MarkaID) + ' ' +
	(select top 1 GrupAdi from UrunGrubu where Urun.GrupID = UrunGrubu.GrupID) + ' '
	from Urun where UrunID = (select top 1 UrunID from inserted))

	insert into Tag(TagAdi, TagAramaSayisi)
	(select distinct kelime as TagAdi, 0 as TagAramaSayisi from dbo.SplitWords(@tagString) 
	where kelime not in (select TagAdi from Tag))

	insert into UrunTag(TagID, UrunID)
	(select TagID, (select top 1 UrunID from inserted) from Tag 
	where TagAdi in (select distinct kelime as TagAdi from dbo.SplitWords(@tagString))
	and (select count(*) from UrunTag where UrunTag.TagID = Tag.TagId and UrunTag.UrunID = (select top 1 UrunID from inserted)) = 0)
end

GO
/****** Object:  Trigger [dbo].[tg_UrunPuanDuzenle]    Script Date: 29.11.2016 23:45:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tg_UrunPuanDuzenle]
on [dbo].[UrunPuan]
after insert, update
as
begin
	update Urun set 
	Begeniler = (select count(*) from UrunPuan 
				where UrunID = (select top 1 UrunID from inserted) and Begeni = 1),
	FiyatPuani = (select sum(FiyatPuani) / count(FiyatPuani) from UrunPuan 
				where UrunID = (select top 1 UrunID from inserted) and FiyatPuani > 0),
	DegerPuani = (select sum(DegerPuani) / count(DegerPuani) from UrunPuan 
				where UrunID = (select top 1 UrunID from inserted) and DegerPuani > 0),
	KalitePuani = (select sum(KalitePuani) / count(KalitePuani) from UrunPuan 
				where UrunID = (select top 1 UrunID from inserted) and KalitePuani > 0)
	where UrunID = (select top 1 UrunID from inserted)
end

GO
USE [master]
GO
ALTER DATABASE [ModaBizde] SET  READ_WRITE 
GO
