USE [master]
GO
/****** Object:  Database [StoreJavaDB]    Script Date: 27/10/2017 11:54:09 CH ******/
CREATE DATABASE [StoreJavaDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'StoreJavaDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\StoreJavaDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'StoreJavaDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\StoreJavaDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [StoreJavaDB] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [StoreJavaDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [StoreJavaDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [StoreJavaDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [StoreJavaDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [StoreJavaDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [StoreJavaDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [StoreJavaDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [StoreJavaDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [StoreJavaDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [StoreJavaDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [StoreJavaDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [StoreJavaDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [StoreJavaDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [StoreJavaDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [StoreJavaDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [StoreJavaDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [StoreJavaDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [StoreJavaDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [StoreJavaDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [StoreJavaDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [StoreJavaDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [StoreJavaDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [StoreJavaDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [StoreJavaDB] SET RECOVERY FULL 
GO
ALTER DATABASE [StoreJavaDB] SET  MULTI_USER 
GO
ALTER DATABASE [StoreJavaDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [StoreJavaDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [StoreJavaDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [StoreJavaDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [StoreJavaDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'StoreJavaDB', N'ON'
GO
ALTER DATABASE [StoreJavaDB] SET QUERY_STORE = OFF
GO
USE [StoreJavaDB]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [StoreJavaDB]
GO
/****** Object:  UserDefinedFunction [dbo].[fuConvertToUnsign]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--start function seo title


CREATE FUNCTION [dbo].[fuConvertToUnsign]
( @strInput NVARCHAR(4000) )
 RETURNS NVARCHAR(4000) 
 AS BEGIN IF @strInput IS NULL 
 RETURN @strInput IF @strInput = '' RETURN @strInput 
 DECLARE @RT NVARCHAR(4000) 
 DECLARE @SIGN_CHARS NCHAR(136) 
 DECLARE @UNSIGN_CHARS NCHAR (136)
  SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) 
  SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' 
  DECLARE @COUNTER int 
  DECLARE @COUNTER1 int 
  SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput))
   BEGIN SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) 
   BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) )
    BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1)
	 ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) 
	 BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END
	 

GO
/****** Object:  Table [dbo].[tblAccountAdmin]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAccountAdmin](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](100) NULL,
	[Password] [varchar](500) NULL,
	[Salt] [varchar](200) NULL,
	[Note] [nvarchar](500) NULL,
	[Status] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblAccountClient]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAccountClient](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[RealName] [nvarchar](100) NULL,
	[IDaccount] [varchar](300) NULL,
	[UserName] [nvarchar](100) NULL,
	[Password] [varchar](100) NULL,
	[Email] [varchar](100) NULL,
	[Salt] [varchar](100) NULL,
	[CreatedDate] [datetime] NULL,
	[Note] [nvarchar](500) NULL,
	[Status] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblCategory]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCategory](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[MetaTitle] [nvarchar](250) NULL,
	[ParentID] [bigint] NULL,
	[DisplayOrder] [int] NULL,
	[SeoTitle] [nvarchar](250) NULL,
	[CreatedDate] [datetime] NULL,
	[Status] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblProduct]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProduct](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Code] [varchar](20) NULL,
	[MetaTitle] [nvarchar](250) NULL,
	[Description] [ntext] NULL,
	[Images] [nvarchar](250) NULL,
	[MoreImages] [xml] NULL,
	[Price] [decimal](18, 0) NULL,
	[PromotionPrice] [decimal](18, 0) NULL,
	[IncludedVat] [bit] NULL,
	[Quantity] [int] NULL,
	[CategoryID] [bigint] NULL,
	[Detail] [ntext] NULL,
	[Warranty] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[Status] [bit] NOT NULL,
	[TopHot] [datetime] NULL,
	[ViewCount] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblSlide]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSlide](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Image] [nvarchar](250) NULL,
	[DisplayOrder] [int] NULL,
	[Link] [nvarchar](250) NULL,
	[Description] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[Status] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[tblAccountAdmin] ON 

INSERT [dbo].[tblAccountAdmin] ([ID], [UserName], [Password], [Salt], [Note], [Status]) VALUES (1, N'admin', N'u3€„[&èS‹;©b¬y₫|''4§w:‘XÍ~·E¾áPEµ&ê?.Åsx‡´r–_„M
oÑ^?Nçî', N'6406184B-9CDD-4C6F-8CA5-3570169AD30F', NULL, 1)
SET IDENTITY_INSERT [dbo].[tblAccountAdmin] OFF
SET IDENTITY_INSERT [dbo].[tblCategory] ON 

INSERT [dbo].[tblCategory] ([ID], [Name], [MetaTitle], [ParentID], [DisplayOrder], [SeoTitle], [CreatedDate], [Status]) VALUES (1, N'Thực phẩm thương hiệu lớn', N'Thuc-pham-thuong-hieu-lon', 0, 1, N'Thực phẩm thương hiệu lớn', CAST(N'2017-10-19T22:23:05.190' AS DateTime), 1)
INSERT [dbo].[tblCategory] ([ID], [Name], [MetaTitle], [ParentID], [DisplayOrder], [SeoTitle], [CreatedDate], [Status]) VALUES (2, N'Đồ gia dụng', N'Do-gia-dung', 0, 2, N'Đồ gia dụng', CAST(N'2017-10-19T22:28:24.930' AS DateTime), 1)
INSERT [dbo].[tblCategory] ([ID], [Name], [MetaTitle], [ParentID], [DisplayOrder], [SeoTitle], [CreatedDate], [Status]) VALUES (3, N'Rau củ quả', N'Rau-cu-qua', 0, 3, N'Rau củ quả', CAST(N'2017-10-19T22:30:23.053' AS DateTime), 1)
INSERT [dbo].[tblCategory] ([ID], [Name], [MetaTitle], [ParentID], [DisplayOrder], [SeoTitle], [CreatedDate], [Status]) VALUES (4, N'Rau', N'Rau', 3, 4, N'Rau', CAST(N'2017-10-19T22:34:20.977' AS DateTime), 1)
INSERT [dbo].[tblCategory] ([ID], [Name], [MetaTitle], [ParentID], [DisplayOrder], [SeoTitle], [CreatedDate], [Status]) VALUES (5, N'Trái cây', N'Trai-cay', 3, 5, N'Trái cây', CAST(N'2017-10-19T22:34:44.523' AS DateTime), 1)
INSERT [dbo].[tblCategory] ([ID], [Name], [MetaTitle], [ParentID], [DisplayOrder], [SeoTitle], [CreatedDate], [Status]) VALUES (6, N'Dụng cụ nhà bếp', N'Dung-cu-nha-bep', 0, 6, N'Dụng cụ nhà bếp', CAST(N'2017-10-19T22:36:54.143' AS DateTime), 1)
INSERT [dbo].[tblCategory] ([ID], [Name], [MetaTitle], [ParentID], [DisplayOrder], [SeoTitle], [CreatedDate], [Status]) VALUES (7, N'Đồ uống', N'Do-uong', 0, 7, N'Đồ uống', CAST(N'2017-10-19T22:41:59.930' AS DateTime), 1)
INSERT [dbo].[tblCategory] ([ID], [Name], [MetaTitle], [ParentID], [DisplayOrder], [SeoTitle], [CreatedDate], [Status]) VALUES (8, N'Nước ngọt', N'Nuoc-ngot', 7, 8, N'Nước ngọt', CAST(N'2017-10-19T22:42:54.150' AS DateTime), 1)
INSERT [dbo].[tblCategory] ([ID], [Name], [MetaTitle], [ParentID], [DisplayOrder], [SeoTitle], [CreatedDate], [Status]) VALUES (9, N'Nước ép trái cây', N'Nuoc-ep-trai-cay', 7, 9, N'Nước ép trái cây', CAST(N'2017-10-19T22:43:31.727' AS DateTime), 1)
INSERT [dbo].[tblCategory] ([ID], [Name], [MetaTitle], [ParentID], [DisplayOrder], [SeoTitle], [CreatedDate], [Status]) VALUES (10, N'Thức ăn thú cưng', N'Thuc-an-thu-cung', 0, 10, N'Thức ăn thú cưng', CAST(N'2017-10-19T22:44:10.527' AS DateTime), 1)
INSERT [dbo].[tblCategory] ([ID], [Name], [MetaTitle], [ParentID], [DisplayOrder], [SeoTitle], [CreatedDate], [Status]) VALUES (11, N'Thức ăn đông lạnh', N'Thuc-an-dong-lanh', 0, 11, N'Thức ăn đông lạnh', CAST(N'2017-10-19T22:44:44.187' AS DateTime), 1)
INSERT [dbo].[tblCategory] ([ID], [Name], [MetaTitle], [ParentID], [DisplayOrder], [SeoTitle], [CreatedDate], [Status]) VALUES (12, N'Bánh mì', N'Banh-mi', 0, 14, N'Bánh mì', CAST(N'2017-10-19T22:53:05.910' AS DateTime), 1)
INSERT [dbo].[tblCategory] ([ID], [Name], [MetaTitle], [ParentID], [DisplayOrder], [SeoTitle], [CreatedDate], [Status]) VALUES (13, N'Thức ăn nhẹ đông lạnh ', N'Thuc-an-nhe-dong-lanh', 11, 12, N'Thức ăn nhẹ đông lạnh', CAST(N'2017-10-19T22:54:24.120' AS DateTime), 1)
INSERT [dbo].[tblCategory] ([ID], [Name], [MetaTitle], [ParentID], [DisplayOrder], [SeoTitle], [CreatedDate], [Status]) VALUES (14, N'Thức ăn chay đông lạnh', N'Thuc-an-chay-dong-lanh', 11, 13, N'Thức ăn chay đông lạnh', CAST(N'2017-10-19T22:56:54.180' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[tblCategory] OFF
SET IDENTITY_INSERT [dbo].[tblProduct] ON 

INSERT [dbo].[tblProduct] ([ID], [Name], [Code], [MetaTitle], [Description], [Images], [MoreImages], [Price], [PromotionPrice], [IncludedVat], [Quantity], [CategoryID], [Detail], [Warranty], [CreatedDate], [Status], [TopHot], [ViewCount]) VALUES (1, N'Nước giải khát hương chanh Sprite chai 1.5L', NULL, N'Nuoc-giai-khat-huong-chanh-Sprite-chai-1.5L', N'<h3>Nước giải kh&aacute;t hương chanh Sprite chai 1.5L</h3>

<p><strong>Nước giải kh&aacute;t hương chanh Sprite</strong>&nbsp;với nguồn nguy&ecirc;n liệu&nbsp;được sản xuất theo d&acirc;y chuyền c&ocirc;ng nghệ hiện đại dưới quy tr&igrave;nh kiểm định nghi&ecirc;m ngặt.&nbsp;Sản phẩm&nbsp;l&agrave; thức uống giải kh&aacute;t gi&uacute;p bổ sung vitamin v&agrave; kho&aacute;ng chất tốt cho cơ thể. Sử dụng sản phẩm l&agrave; c&aacute;ch nhanh ch&oacute;ng để b&ugrave; nước cho cơ thể khi vận động nhiều hoặc chơi thể thao. Ngo&agrave;i ra, trong th&agrave;nh phần của sản phẩm&nbsp;kh&ocirc;ng chứa chất h&oacute;a học độc hại, đảm bảo an to&agrave;n cho sức khỏe người ti&ecirc;u d&ugrave;ng.</p>

<p>&nbsp;</p>

<p><img src="https://cdn02.static-adayroi.com/0/2016/11/08/1478573611296_2126666.jpg" style="height:141px; width:200px" /></p>

<p><em>Nước giải kh&aacute;t hương chanh Sprite</em></p>

<p>&nbsp;</p>

<p><strong>Nước giải kh&aacute;t hương chanh Sprite&nbsp;</strong>được đ&oacute;ng chai c&oacute; nắp vặn k&iacute;n tiện lợi trong việc sử dụng v&agrave; bảo quản. Sản phẩm do Vinmart ph&acirc;n phối lu&ocirc;n mang đến chất lượng&nbsp;tốt nhất cho người ti&ecirc;u d&ugrave;ng.</p>
', N'/JStore/Upload/images/Products/sprite1%2C5.jpg', N'', CAST(17 AS Decimal(18, 0)), CAST(15 AS Decimal(18, 0)), 0, 10, 13, N'', NULL, CAST(N'2017-10-20T00:12:37.047' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[tblProduct] ([ID], [Name], [Code], [MetaTitle], [Description], [Images], [MoreImages], [Price], [PromotionPrice], [IncludedVat], [Quantity], [CategoryID], [Detail], [Warranty], [CreatedDate], [Status], [TopHot], [ViewCount]) VALUES (2, N'Nước giải khát hương cam Fanta lon 330ml', NULL, N'Nuoc-giai-khat-huong-cam-Fanta-lon-330ml', N'<h2>Th&ocirc;ng số sản phẩm</h2>

<table id="tblGeneralAttribute">
	<tbody>
		<tr>
			<td><strong>Xuất xứ</strong></td>
			<td>Việt Nam</td>
		</tr>
		<tr>
			<td><strong>Hướng dẫn sử dụng</strong></td>
			<td>Ngon hơn khi uống lạnh</td>
		</tr>
		<tr>
			<td><strong>Hướng dẫn bảo quản</strong></td>
			<td>Bảo quản nơi kh&ocirc; r&aacute;o, tho&aacute;ng m&aacute;t</td>
		</tr>
		<tr>
			<td><strong>Quy c&aacute;ch đ&oacute;ng g&oacute;i</strong></td>
			<td>Lon</td>
		</tr>
		<tr>
			<td><strong>Th&agrave;nh phần nguy&ecirc;n liệu</strong></td>
			<td>Nước b&atilde;o h&ograve;a Co2, đường, đường m&iacute;a, chất tạo độ chua&hellip;</td>
		</tr>
		<tr>
			<td><strong>Hạn sử dụng</strong></td>
			<td>12 th&aacute;ng</td>
		</tr>
		<tr>
			<td><strong>Dung t&iacute;ch</strong></td>
			<td>330 (ml)</td>
		</tr>
	</tbody>
</table>

<h2>Th&ocirc;ng tin sản phẩm</h2>

<h3>Nước giải kh&aacute;t hương cam Fanta lon 330ml</h3>

<p><strong>Nước giải kh&aacute;t hương cam Fanta</strong>&nbsp;l&agrave; thức uống giải kh&aacute;t được nhiều người y&ecirc;u th&iacute;ch, mang đến cảm gi&aacute;c sảng kho&aacute;i, tươi mới sau những giờ ph&uacute;t l&agrave;m việc mệt mỏi, sau khi chơi thể thao. Sản phẩm được l&agrave;m từ c&aacute;c th&agrave;nh phần an to&agrave;n, đảm bảo chất lượng cao. Với vị gas nhẹ, c&ugrave;ng vị cam tự nhi&ecirc;n, đ&acirc;y l&agrave; thức uống thơm ngon&nbsp;cho cả gia đ&igrave;nh bạn.&nbsp;</p>

<p>&nbsp;</p>

<p><img src="https://cdn02.static-adayroi.com/0/2016/10/27/147754178639_3409127.jpg" style="height:211px; width:300px" /></p>

<p><em>Nước giải kh&aacute;t hương cam Fanta</em></p>

<p>&nbsp;</p>

<p><strong>Nước giải kh&aacute;t hương cam Fanta</strong>&nbsp;được đ&oacute;ng lon nhỏ gọn, vừa tay cầm, dễ d&agrave;ng mang theo b&ecirc;n m&igrave;nh để thưởng thức bất k&igrave; khi n&agrave;o. Đ&acirc;y sẽ l&agrave; lựa chọn tuyệt vời cho những buổi li&ecirc;n hoan, tiệc t&ugrave;ng c&ugrave;ng gia đ&igrave;nh, bạn b&egrave; hay đồng nghiệp.</p>
', N'/JStore/Upload/images/Products/fanta.jpg', N'', CAST(8 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)), 0, 15, 13, N'', NULL, CAST(N'2017-10-20T00:23:17.317' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[tblProduct] ([ID], [Name], [Code], [MetaTitle], [Description], [Images], [MoreImages], [Price], [PromotionPrice], [IncludedVat], [Quantity], [CategoryID], [Detail], [Warranty], [CreatedDate], [Status], [TopHot], [ViewCount]) VALUES (3, N'Nước uống hương vị trái cây nhiệt đới Pororo chai 235ml', NULL, N'Nuoc-uong-huong-vi-trai-cay-nhiet-doi-Pororo-chai-235ml', N'<h2>Th&ocirc;ng số sản phẩm</h2>

<table id="tblGeneralAttribute">
	<tbody>
		<tr>
			<td><strong>Xuất xứ</strong></td>
			<td>H&agrave;n Quốc</td>
		</tr>
		<tr>
			<td><strong>Hướng dẫn sử dụng</strong></td>
			<td>D&ugrave;ng uống trực tiếp, ngon hơn khi uống lạnh</td>
		</tr>
		<tr>
			<td><strong>Hướng dẫn bảo quản</strong></td>
			<td>Bảo quản nơi kh&ocirc; r&aacute;o tho&aacute;ng m&aacute;t</td>
		</tr>
		<tr>
			<td><strong>Quy c&aacute;ch đ&oacute;ng g&oacute;i</strong></td>
			<td>Chai</td>
		</tr>
		<tr>
			<td><strong>Th&agrave;nh phần nguy&ecirc;n liệu</strong></td>
			<td>Nước tinh khiết, đường, bột sữa, tr&aacute;i c&acirc;y nhiệt đới c&ocirc; đặc, hương cam qu&yacute;t tổng hương tr&aacute;i c&acirc;y nhiệt đới, polysacchare đậu n&agrave;nh, chất nhũ h&oacute;a, vitamin D3</td>
		</tr>
		<tr>
			<td><strong>Hạn sử dụng</strong></td>
			<td>6 th&aacute;ng</td>
		</tr>
		<tr>
			<td><strong>Dung t&iacute;ch</strong></td>
			<td>235 (ml)</td>
		</tr>
	</tbody>
</table>

<h2>Th&ocirc;ng tin sản phẩm</h2>

<h3>Nước uống hương vị tr&aacute;i c&acirc;y nhiệt đới Pororo chai 235ml</h3>

<p><strong>Nước uống hương vị tr&aacute;i c&acirc;y nhiệt đới Pororo</strong>&nbsp;l&agrave; sản phẩm nước giải kh&aacute;t của thương hiệu&nbsp;Paldo c&oacute; hương vị thơm ngon d&agrave;nh cho trẻ nhỏ. Sản phẩm&nbsp;c&oacute; hương vị thơm của sữa tươi h&ograve;a quyện c&ugrave;ng vị ngọt thơm của c&aacute;c loại tr&aacute;i c&acirc;y nhiệt đới, mang đến sự th&iacute;ch th&uacute; cho b&eacute;.&nbsp;Sản phẩm&nbsp;được sản xuất tr&ecirc;n d&acirc;y chuyền hiện đại, với nguồn nguy&ecirc;n liệu chọn lọc của H&agrave;n Quốc đảm bảo chất lượng. Sản phẩm kh&ocirc;ng c&oacute;&nbsp;ga, kh&ocirc;ng c&oacute; chất tạo m&agrave;u nh&acirc;n tạo, chứa vitamin D v&agrave; nhiều dưỡng chất kh&aacute;c tốt cho sức khỏe v&agrave; sự ph&aacute;t triển của trẻ.</p>

<p>&nbsp;</p>

<p><img src="https://cdn02.static-adayroi.com/0/2016/03/17/1458200127583_5640637.jpg" style="height:211px; width:300px" /></p>

<p><em>Nước uống hương vị tr&aacute;i c&acirc;y nhiệt đới Pororo</em></p>

<p><br />
<strong>Nước uống hương vị tr&aacute;i c&acirc;y nhiệt đới Pororo</strong>&nbsp;được đ&oacute;ng chai nhỏ tiện dụng n&ecirc;n c&aacute;c b&eacute; c&oacute; thể mang theo đi học, đi chơi hoặc khi luyện tập thể thao. Tr&ecirc;n chai c&ograve;n được trang tr&iacute; họa tiết vui nhộn, đẹp mắt, sẽ khiến c&aacute;c b&eacute; rất th&iacute;ch th&uacute; khi thưởng thức.</p>
', N'/JStore/Upload/images/Products/nuoceptraicaynhietdoi.jpg', N'', CAST(17 AS Decimal(18, 0)), CAST(15 AS Decimal(18, 0)), 0, 30, 13, N'', NULL, CAST(N'2017-10-20T00:29:24.800' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[tblProduct] ([ID], [Name], [Code], [MetaTitle], [Description], [Images], [MoreImages], [Price], [PromotionPrice], [IncludedVat], [Quantity], [CategoryID], [Detail], [Warranty], [CreatedDate], [Status], [TopHot], [ViewCount]) VALUES (4, N'Nước giải khát có gas Pepsi Cola lon 330ml', NULL, N'Nuoc-giai-khat-co-gas-Pepsi-Cola-lon-330ml', N'<h2>Th&ocirc;ng số sản phẩm</h2>

<table id="tblGeneralAttribute">
	<tbody>
		<tr>
			<td><strong>Xuất xứ</strong></td>
			<td>Việt Nam</td>
		</tr>
		<tr>
			<td><strong>Hướng dẫn sử dụng</strong></td>
			<td>D&ugrave;ng trực tiếp</td>
		</tr>
		<tr>
			<td><strong>Hướng dẫn bảo quản</strong></td>
			<td>Bảo quản nơi tho&aacute;ng m&aacute;t</td>
		</tr>
		<tr>
			<td><strong>Quy c&aacute;ch đ&oacute;ng g&oacute;i</strong></td>
			<td>Lon</td>
		</tr>
		<tr>
			<td><strong>Th&agrave;nh phần</strong></td>
			<td>Nước b&atilde;o h&ograve;a CO2, đường m&iacute;a, m&agrave;u thực phẩm, chất điều chỉnh độ axit, chất ổn định, hỗn hợp hương tự nhi&ecirc;n&hellip;</td>
		</tr>
		<tr>
			<td><strong>Hạn sử dụng</strong></td>
			<td>12 th&aacute;ng</td>
		</tr>
		<tr>
			<td><strong>Dung t&iacute;ch</strong></td>
			<td>330 (ml)</td>
		</tr>
	</tbody>
</table>

<h2>Th&ocirc;ng tin sản phẩm</h2>

<h3>Nước giải kh&aacute;t c&oacute; gas Pepsi Cola lon 330ml</h3>

<p><strong>Nước giải kh&aacute;t c&oacute; gas Pepsi Cola</strong>&nbsp;được l&agrave;m từ những th&agrave;nh phần v&agrave; hương liệu an to&agrave;n mang đến chất lượng tuyệt hảo cho sản phẩm. Ngo&agrave;i ra, th&agrave;nh phần c&oacute; trong&nbsp;<strong>Nước giải kh&aacute;t c&oacute; gas Pepsi Cola</strong>&nbsp;cũng kh&ocirc;ng chứa c&aacute;c chất bảo quản độc hại ảnh hưởng đến sức khỏe người ti&ecirc;u d&ugrave;ng, n&ecirc;n bạn ho&agrave;n to&agrave;n y&ecirc;n t&acirc;m khi sử dụng. Sản phẩm c&oacute; hương vị thơm ngon, hấp dẫn gi&uacute;p bạn giải tỏa cơn kh&aacute;t tức th&igrave; trong những ng&agrave;y n&oacute;ng bức. B&ecirc;n cạnh đ&oacute;,&nbsp;<strong>Nước giải kh&aacute;t c&oacute; gas Pepsi Cola</strong>&nbsp;cũng gi&uacute;p bạn cung cấp năng lượng cho một ng&agrave;y d&agrave;i hoạt động.&nbsp;Sản phẩm thuộc thương hiệu Pepsi Cola c&oacute; uy t&iacute;n tr&ecirc;n thị trường mang đến cho bạn sự y&ecirc;n t&acirc;m về chất lượng khi sử dụng. Ngo&agrave;i ra,&nbsp;<strong>Nước giải kh&aacute;t c&oacute; gas Pepsi Cola</strong>&nbsp;được đ&oacute;ng lon đẹp mắt v&agrave; tiện dụng hơn cho bạn trong việc bảo quản v&agrave; sử dụng.</p>

<p>&nbsp;</p>

<p><img src="https://cdn02.static-adayroi.com/0/2017/01/18/1484725320661_2411065.jpg" style="height:211px; width:300px" /></p>

<p><em>Nước giải kh&aacute;t c&oacute; gas Pepsi Cola</em></p>

<p>&nbsp;</p>

<p>​Pepsi&nbsp;l&agrave; nh&atilde;n hiệu nước giải kh&aacute;t hương Cola c&oacute; gas nổi tiếng to&agrave;n cầu. Với th&ocirc;ng điệp &lsquo;Sống Trọn Từng Gi&acirc;y&rsquo;, Pepsi kế thừa gi&aacute; trị lịch sử l&acirc;u đời của nh&atilde;n h&agrave;ng v&agrave; mang lại những trải nghiệm th&uacute; vị&nbsp; cho giới trẻ tr&ecirc;n c&aacute;c phương diện &acirc;m nhạc v&agrave; giải tr&iacute;, nhằm kết nối tr&aacute;i tim v&agrave; khối &oacute;c của c&aacute;c bạn trẻ, khuyến kh&iacute;ch họ nắm bắt v&agrave; tận hưởng từng khoảnh khắc th&uacute; vị của cuộc sống.</p>
', N'/JStore/Upload/images/Products/1499656666673_3861733.jpg', N'', CAST(18 AS Decimal(18, 0)), CAST(16 AS Decimal(18, 0)), 0, 35, 13, N'', NULL, CAST(N'2017-10-20T00:33:51.190' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[tblProduct] ([ID], [Name], [Code], [MetaTitle], [Description], [Images], [MoreImages], [Price], [PromotionPrice], [IncludedVat], [Quantity], [CategoryID], [Detail], [Warranty], [CreatedDate], [Status], [TopHot], [ViewCount]) VALUES (5, N'Trà bí đao Wonderfarm lon 310ml', NULL, N'Tra-bi-dao-Wonderfarm-lon-310ml', N'<h2>Th&ocirc;ng số sản phẩm</h2>

<table id="tblGeneralAttribute">
	<tbody>
		<tr>
			<td><strong>Xuất xứ</strong></td>
			<td>Việt Nam</td>
		</tr>
		<tr>
			<td><strong>Hướng dẫn sử dụng</strong></td>
			<td>D&ugrave;ng uống liền</td>
		</tr>
		<tr>
			<td><strong>Hướng dẫn bảo quản</strong></td>
			<td>Bảo quản nơi kh&ocirc; r&aacute;o v&agrave; tho&aacute;ng m&aacute;t</td>
		</tr>
		<tr>
			<td><strong>Quy c&aacute;ch đ&oacute;ng g&oacute;i</strong></td>
			<td>Lon</td>
		</tr>
		<tr>
			<td><strong>Th&agrave;nh phần nguy&ecirc;n liệu</strong></td>
			<td>Nước, đường, nước cốt b&iacute; đao c&ocirc; đặc, m&agrave;u tự nhi&ecirc;n</td>
		</tr>
		<tr>
			<td><strong>Dung t&iacute;ch</strong></td>
			<td>310 (ml)</td>
		</tr>
	</tbody>
</table>

<h2>Th&ocirc;ng tin sản phẩm</h2>

<h3>Tr&agrave; b&iacute; đao Wonderfarm lon 310ml</h3>

<p><strong>Tr&agrave; b&iacute; đao Wonderfarm</strong>&nbsp;được l&agrave;m từ c&aacute;c th&agrave;nh phần tự nhi&ecirc;n bao gồm nước, đường, bột b&iacute; đao nguy&ecirc;n chất... Vị ngọt thanh của đường h&ograve;a quyện với hương thơm m&aacute;t của b&iacute; đao mang lại cảm gi&aacute;c v&ocirc; c&ugrave;ng sảng kho&aacute;i mỗi khi thưởng thức. Đ&acirc;y l&agrave; một thức uống bổ dưỡng, gi&agrave;u chất chống oxy h&oacute;a, thanh lọc cơ thể v&agrave; c&oacute; t&aacute;c dụng giải kh&aacute;t hiệu quả.</p>

<p>&nbsp;</p>

<p><img src="https://cdn02.static-adayroi.com/0/2016/11/09/1478675611673_1307484.jpg" style="height:211px; width:300px" /></p>

<p><em>Tr&agrave; b&iacute; đao Wonderfarm</em></p>

<p>&nbsp;</p>

<p>Sản phẩm đặc biệt tốt cho sức khỏe v&agrave; ph&ugrave; hợp với mọi lứa tuổi.&nbsp;<strong>Tr&agrave; b&iacute; đao Wonderfarm</strong>&nbsp;đ&atilde; được đ&oacute;ng lon nhỏ tiện lợi, gi&uacute;p bạn dễ d&agrave;ng mang theo đi học, đi l&agrave;m hay trong những chuyến đi chơi xa.</p>
', N'/JStore/Upload/images/Products/148195198123_3670227.jpg', N'', CAST(16 AS Decimal(18, 0)), CAST(13 AS Decimal(18, 0)), 0, 40, 13, N'', NULL, CAST(N'2017-10-20T00:37:23.130' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[tblProduct] ([ID], [Name], [Code], [MetaTitle], [Description], [Images], [MoreImages], [Price], [PromotionPrice], [IncludedVat], [Quantity], [CategoryID], [Detail], [Warranty], [CreatedDate], [Status], [TopHot], [ViewCount]) VALUES (6, N'Nước giải khát Zero Coca Cola không đường lon 330ml', NULL, N'Nuoc-giai-khat-Zero-Coca-Cola-khong-duong-lon-330ml', N'<h2>Th&ocirc;ng số sản phẩm</h2>

<table id="tblGeneralAttribute">
	<tbody>
		<tr>
			<td><strong>Xuất xứ</strong></td>
			<td>Việt Nam</td>
		</tr>
		<tr>
			<td><strong>Hướng dẫn sử dụng</strong></td>
			<td>Uống trực tiếp</td>
		</tr>
		<tr>
			<td><strong>Hướng dẫn bảo quản</strong></td>
			<td>Bảo quản nơi kh&ocirc; r&aacute;o, tho&aacute;ng m&aacute;t</td>
		</tr>
		<tr>
			<td><strong>Quy c&aacute;ch đ&oacute;ng g&oacute;i</strong></td>
			<td>Lon</td>
		</tr>
		<tr>
			<td><strong>Th&agrave;nh phần nguy&ecirc;n liệu</strong></td>
			<td>Nước b&atilde;o h&ograve;a CO2, m&agrave;u tự nhi&ecirc;n, chất điều chỉnh độ axit, chất tạo ngọt tổng hợp, chất bảo quản</td>
		</tr>
		<tr>
			<td><strong>Dung t&iacute;ch</strong></td>
			<td>330 (ml)</td>
		</tr>
	</tbody>
</table>

<h2>Th&ocirc;ng tin sản phẩm</h2>

<h3>Nước giải kh&aacute;t Zero Coca Cola kh&ocirc;ng đường lon 330ml</h3>

<p><strong>Nước giải kh&aacute;t Zero Coca Cola kh&ocirc;ng đường​</strong>&nbsp;với hương vị thơm ngon, kh&ocirc;ng chỉ giải tỏa cơn kh&aacute;t trong những ng&agrave;y n&oacute;ng nực m&agrave; c&ograve;n cung cấp nguồn năng lượng c&ugrave;ng h&agrave;m lượng kho&aacute;ng chất dồi d&agrave;o. Sản phẩm c&oacute; lượng gas lớn gi&uacute;p xua tan mọi cảm gi&aacute;c mệt mỏi, căng thẳng ngay tức th&igrave;, đem lại cảm gi&aacute;c thoải m&aacute;i nhất sau mỗi lần sử dụng v&agrave;&nbsp;c&ograve;n gi&uacute;p bạn lấy lại năng lượng cho hoạt động h&agrave;ng ng&agrave;y.</p>

<p><img src="https://cdn02.static-adayroi.com/0/2017/07/31/1501497771568_3024550.jpg" style="height:211px; width:300px" /></p>

<p><strong>Nước giải kh&aacute;t Zero Coca Cola kh&ocirc;ng đường​</strong>&nbsp;với thiết kế lon nhỏ tiện dụng, sản phẩm c&oacute; thể mang theo trong những buổi tập thể thao hay những chuyến vui chơi, d&atilde; ngoại ngo&agrave;i trời đều ph&ugrave; hợp. Vỏ lon được sản xuất từ nguy&ecirc;n liệu sạch th&acirc;n thiện với m&ocirc;i trường, gi&uacute;p bảo quản nước giữ nguy&ecirc;n m&ugrave;i vị m&agrave; kh&ocirc;ng sợ hư hỏng.</p>
', N'/JStore/Upload/images/Products/1501497801691_4089288.jpg', N'', CAST(20 AS Decimal(18, 0)), CAST(18 AS Decimal(18, 0)), 0, 100, 13, N'', NULL, CAST(N'2017-10-20T00:39:29.630' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[tblProduct] ([ID], [Name], [Code], [MetaTitle], [Description], [Images], [MoreImages], [Price], [PromotionPrice], [IncludedVat], [Quantity], [CategoryID], [Detail], [Warranty], [CreatedDate], [Status], [TopHot], [ViewCount]) VALUES (7, N'Nước tăng lực Trâu Xanh Carabao lon 250ml', NULL, N'Nuoc-tang-luc-Trau-Xanh-Carabao-lon-250ml', N'<h2>Th&ocirc;ng số sản phẩm</h2>

<table id="tblGeneralAttribute">
	<tbody>
		<tr>
			<td><strong>Xuất xứ</strong></td>
			<td>Th&aacute;i Lan</td>
		</tr>
		<tr>
			<td><strong>Hướng dẫn sử dụng</strong></td>
			<td>Uống trực tiếp, ngon hơn khi uống lạnh. Sản phẩm kh&ocirc;ng ph&ugrave; hợp với người bệnh tiểu đường, trẻ nhỏ v&agrave; nười nhạy cảm với Caffein, kh&ocirc;ng sử dụng trước khi ngủ. Sản phẩm kh&ocirc;ng phải l&agrave; thuốc thay thế thuốc chữa bệnh</td>
		</tr>
		<tr>
			<td><strong>Hướng dẫn bảo quản</strong></td>
			<td>Bảo quản nơi kh&ocirc; r&aacute;o, tho&aacute;ng m&aacute;t</td>
		</tr>
		<tr>
			<td><strong>Quy c&aacute;ch đ&oacute;ng g&oacute;i</strong></td>
			<td>Lon</td>
		</tr>
		<tr>
			<td><strong>Th&agrave;nh phần</strong></td>
			<td>Nước, đường 43g, caffein, Taurine 1g, vitamin B6 8mg....</td>
		</tr>
		<tr>
			<td><strong>Dung t&iacute;ch</strong></td>
			<td>250 (ml)</td>
		</tr>
	</tbody>
</table>

<h2>Th&ocirc;ng tin sản phẩm</h2>

<h3>Nước tăng lực Tr&acirc;u Xanh Carabao lon 250ml</h3>

<p><strong>Nước tăng lực Tr&acirc;u Xanh Carabao</strong>&nbsp;được sản xuất theo c&ocirc;ng nghệ hiện đại, mọi kh&acirc;u từ tuyển chọn nguy&ecirc;n liệu tới chế biến, đ&oacute;ng bao b&igrave; đều diễn ra kh&eacute;p k&iacute;n dưới sự gi&aacute;m s&aacute;t v&agrave; kiểm tra nghi&ecirc;m ngặt.&nbsp;<strong>Nước tăng lực Tr&acirc;u Xanh Carabao</strong>&nbsp;l&agrave; thức uống giải kh&aacute;t gi&uacute;p bổ sung vitamin v&agrave; kho&aacute;ng chất tốt cho cơ thể. Sử dụng sản phẩm l&agrave; c&aacute;ch nhanh ch&oacute;ng để b&ugrave; nước cho cơ thể khi vận động nhiều hoặc chơi thể thao. Ngo&agrave;i ra, trong th&agrave;nh phần của sản phẩm&nbsp;kh&ocirc;ng chứa chất h&oacute;a học độc hại, đảm bảo an to&agrave;n cho sức khỏe người ti&ecirc;u d&ugrave;ng.</p>

<p><br />
<img alt="Nước tăng lực Trâu Xanh Carabao" src="https://cdn02.static-adayroi.com/0/2017/08/02/1501657868636_6829802.jpg" style="height:263px; width:300px" /><br />
<em>Nước tăng lực Tr&acirc;u Xanh Carabao</em></p>

<p><br />
<strong>Nước tăng lực Tr&acirc;u Xanh Carabao</strong>&nbsp;được đ&oacute;ng lon c&oacute; nắp bật&nbsp;tiện lợi trong việc sử dụng v&agrave; bảo quản. Với sản phẩm n&agrave;y, bạn c&oacute; thể d&ugrave;ng khi chơi thể thao, mang theo đi chơi, đi học...&nbsp;Sản phẩm do Vinmart ph&acirc;n phối lu&ocirc;n mang đến chất lượng&nbsp;tốt&nbsp;cho người ti&ecirc;u d&ugrave;ng.</p>

<p><br />
<img alt="Nước tăng lực Trâu Xanh Carabao" src="https://cdn02.static-adayroi.com/0/2017/08/02/1501657895885_2404450.jpg" style="height:146px; width:300px" /><br />
<em>Hương vị, thơm ngon</em></p>
', N'/JStore/Upload/images/Products/1501657999757_4588923.jpg', N'', CAST(30 AS Decimal(18, 0)), CAST(27 AS Decimal(18, 0)), 0, 30, 13, N'', NULL, CAST(N'2017-10-20T00:42:22.533' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[tblProduct] ([ID], [Name], [Code], [MetaTitle], [Description], [Images], [MoreImages], [Price], [PromotionPrice], [IncludedVat], [Quantity], [CategoryID], [Detail], [Warranty], [CreatedDate], [Status], [TopHot], [ViewCount]) VALUES (8, N'Nước tăng lực Sting Max Gold lon 330ml', NULL, N'Nuóc-tang-lục-Sting-Max-Gold-lon-330ml', N'<h2>Th&ocirc;ng số sản phẩm</h2>

<table id="tblGeneralAttribute">
	<tbody>
		<tr>
			<td><strong>Xuất xứ</strong></td>
			<td>Việt Nam</td>
		</tr>
		<tr>
			<td><strong>Hướng dẫn sử dụng</strong></td>
			<td>Uống trực tiếp. Ngon hơn khi uống lạnh</td>
		</tr>
		<tr>
			<td><strong>Hướng dẫn bảo quản</strong></td>
			<td>Bảo quản nơi kh&ocirc; r&aacute;o tho&aacute;ng m&aacute;t, tr&aacute;nh &aacute;nh nắng trực tiếp</td>
		</tr>
		<tr>
			<td><strong>Quy c&aacute;ch đ&oacute;ng g&oacute;i</strong></td>
			<td>Lon</td>
		</tr>
		<tr>
			<td><strong>Dung t&iacute;ch</strong></td>
			<td>330 (ml)</td>
		</tr>
	</tbody>
</table>

<h2>Th&ocirc;ng tin sản phẩm</h2>

<h3>Nước tăng lực Sting Max Gold lon 330ml</h3>

<p><strong>Nước tăng lực Sting Max Gold&nbsp;</strong>l&agrave; sản phẩm của C&ocirc;ng ty Pepsico Việt Nam. Sản phẩm được sản xuất tr&ecirc;n d&acirc;y chuyền hiện đại theo c&ocirc;ng nghệ ti&ecirc;n tiến, dưới sự gi&aacute;m s&aacute;t v&agrave; kiểm tra nghi&ecirc;m ngặt của c&aacute;c chuy&ecirc;n gia trong ng&agrave;nh c&ocirc;ng nghệ thực phẩm.&nbsp;Với taurine, inositol, vitamin B, kết hợp c&ugrave;ng nh&acirc;n s&acirc;m, nước tăng lực Sting mang đến nguồn năng lượng dồi d&agrave;o cho cơ thể. Sản phẩm hội tụ những phẩm chất tốt tối ưu&nbsp;của một loại nước tăng lực nổi tiếng, gi&uacute;p bạn lu&ocirc;n tr&agrave;n đầy năng lượng, vượt qua mệt mỏi.</p>

<p><br />
<img src="https://cdn02.static-adayroi.com/0/2017/08/18/1503059163521_7246941.jpg" style="height:208px; width:300px" /><br />
<em>Nước tăng lực Sting Max Gold</em></p>

<p><br />
<strong>Nước tăng lực Sting Max Gold</strong>&nbsp;kh&ocirc;ng sử dụng chất h&oacute;a học, chất bảo quản độc hại. Sản phẩm được đ&oacute;ng lon tiện dụng bạn c&oacute; thể mang theo khi đi học, đi l&agrave;m, du lịch&nbsp;hoặc trong c&aacute;c buổi tập thể dục đều ph&ugrave; hợp, vỏ lon l&agrave;m từ nguy&ecirc;n liệu sạch, kh&ocirc;ng lẫn tạp chất, đảm bảo cho sức khỏe người ti&ecirc;u d&ugrave;ng.</p>

<p><br />
<img alt="Nước tăng lực Sting max gold" src="https://cdn02.static-adayroi.com/0/2017/08/17/1502941808496_1658633.jpg" style="height:169px; width:300px" /><br />
<em>Gi&uacute;p bạn lu&ocirc;n tr&agrave;n đầy năng lượng, vượt qua mệt mỏi</em></p>
', N'/JStore/Upload/images/Products/1502941896536_2731868.jpg', N'', CAST(8 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)), 0, 50, 13, N'', NULL, CAST(N'2017-10-20T00:45:21.373' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[tblProduct] ([ID], [Name], [Code], [MetaTitle], [Description], [Images], [MoreImages], [Price], [PromotionPrice], [IncludedVat], [Quantity], [CategoryID], [Detail], [Warranty], [CreatedDate], [Status], [TopHot], [ViewCount]) VALUES (9, N'Trà sữa Latte Kirin chai 345ml', NULL, N'Tra-sua-Latte-Kirin-chai-345ml', N'<h2>Th&ocirc;ng số sản phẩm</h2>

<table id="tblGeneralAttribute">
	<tbody>
		<tr>
			<td><strong>Xuất xứ</strong></td>
			<td>Việt Nam</td>
		</tr>
		<tr>
			<td><strong>Hướng dẫn sử dụng</strong></td>
			<td>Lắc đều trước khi uống, ngon hơn khi uống lạnh</td>
		</tr>
		<tr>
			<td><strong>Hướng dẫn bảo quản</strong></td>
			<td>Nơi kh&ocirc; r&aacute;o, tho&aacute;ng m&aacute;t</td>
		</tr>
		<tr>
			<td><strong>Quy c&aacute;ch đ&oacute;ng g&oacute;i</strong></td>
			<td>Chai</td>
		</tr>
		<tr>
			<td><strong>Th&agrave;nh phần nguy&ecirc;n liệu</strong></td>
			<td>Nước tinh khiết, đường, sữa bột b&eacute;o, tr&agrave; đen, hương tr&agrave; tổng hợp, chất nhũ h&oacute;a, chất chống oxy h&oacute;a...</td>
		</tr>
		<tr>
			<td><strong>Dung t&iacute;ch</strong></td>
			<td>345 (ml)</td>
		</tr>
	</tbody>
</table>

<h2>Th&ocirc;ng tin sản phẩm</h2>

<h3>Tr&agrave; sữa Latte Kirin chai 345ml</h3>

<p><strong>Tr&agrave; sữa Latte Kirin</strong>&nbsp;l&agrave; thực phẩm nước giải kh&aacute;t thơm ngon, bổ dưỡng. Sản phẩm được sản xuất theo c&ocirc;ng nghệ Nhật Bản với hương vị đậm đ&agrave; của tr&agrave; thi&ecirc;n nhi&ecirc;n pha sữa. Bạn sẽ cảm nhận sự th&iacute;ch th&uacute; c&ugrave;ng với hương thơm nhẹ nh&agrave;ng, thanh khiết. Sử dụng sản phẩm khi uống lạnh sẽ thơm ngon v&agrave; khiến tinh thần sảng kho&aacute;i hơn.</p>

<p>&nbsp;</p>

<p><img src="https://cdn02.static-adayroi.com/0/2016/03/17/1458206139832_2242031.jpg" style="height:211px; width:300px" /></p>

<p><em>Tr&agrave; sữa Latte Kirin</em></p>

<p>&nbsp;</p>

<p><strong>Tr&agrave; sữa Latte Kirin&nbsp;</strong>được l&agrave;m từ th&agrave;nh phần thi&ecirc;n nhi&ecirc;n n&ecirc;n hiện tượng lắng đọng, m&agrave;u sắc thay đổi kh&ocirc;ng ảnh hưởng đến chất lượng sản phẩm.</p>
', N'/JStore/Upload/images/Products/1502940406459_4059655.jpg', N'', CAST(9 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)), 0, 30, 13, N'', NULL, CAST(N'2017-10-20T00:50:10.350' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[tblProduct] ([ID], [Name], [Code], [MetaTitle], [Description], [Images], [MoreImages], [Price], [PromotionPrice], [IncludedVat], [Quantity], [CategoryID], [Detail], [Warranty], [CreatedDate], [Status], [TopHot], [ViewCount]) VALUES (10, N'Nước uống Isotonic- 7Up Revive vị chanh muối chai 390 ml', NULL, N'Nuoc-uong-Isotonic--7Up-Revive-vi-chanh-muoi-chai-390-ml', N'<h2>Th&ocirc;ng số sản phẩm</h2>

<table id="tblGeneralAttribute">
	<tbody>
		<tr>
			<td><strong>Xuất xứ</strong></td>
			<td>Việt Nam</td>
		</tr>
		<tr>
			<td><strong>Hướng dẫn sử dụng</strong></td>
			<td>Ngon hơn khi uống lạnh, th&iacute;ch hợp giải kh&aacute;t ngay khi đổ mồ h&ocirc;i, mất nước v&agrave; mệt mỏi do thời tiết n&oacute;ng bức</td>
		</tr>
		<tr>
			<td><strong>Hướng dẫn bảo quản</strong></td>
			<td>Bảo quản nơi tho&aacute;ng m&aacute;t, tr&aacute;nh &aacute;nh nắng</td>
		</tr>
		<tr>
			<td><strong>Quy c&aacute;ch đ&oacute;ng g&oacute;i</strong></td>
			<td>Chai</td>
		</tr>
		<tr>
			<td><strong>Hương vị</strong></td>
			<td>Chanh muối</td>
		</tr>
		<tr>
			<td><strong>Th&agrave;nh phần nguy&ecirc;n liệu</strong></td>
			<td>Nước b&atilde;o h&ograve;a CO2, đường cucrose v&agrave; destrose, chất điều chỉnh độ axit (330), chất điện giải ( NaCl, 331iii, 340i), chất nhũ h&oacute;a (414, tinh bột biến t&iacute;nh, 445iii), chất bảo quản (211, 202, 385), hỗn hợp hương tự nhi&ecirc;n, hương chanh muối giống tự nhi&ecirc;n,...</td>
		</tr>
		<tr>
			<td><strong>Hạn sử dụng</strong></td>
			<td>6 th&aacute;ng</td>
		</tr>
		<tr>
			<td><strong>Dung t&iacute;ch</strong></td>
			<td>390 (ml)</td>
		</tr>
	</tbody>
</table>

<h2>Th&ocirc;ng tin sản phẩm</h2>

<h3>Nước uống Isotonic- 7Up Revive vị chanh muối chai 390 ml</h3>

<p><strong>Nước uống Isotonic- 7Up Revive vị chanh muối&nbsp;</strong>được sản xuất theo c&ocirc;ng nghệ hiện đại, mọi kh&acirc;u từ tuyển chọn nguy&ecirc;n liệu tới chế biến, đ&oacute;ng bao b&igrave;&nbsp;đều diễn ra kh&eacute;p k&iacute;n dưới sự gi&aacute;m s&aacute;t v&agrave; kiểm tra nghi&ecirc;m ngặt. Sản phẩm kh&ocirc;ng chứa h&oacute;a chất, chất bảo quản độc hại, đảm bảo an to&agrave;n cho sức khỏe người ti&ecirc;u d&ugrave;ng.&nbsp;Sản phẩm c&oacute; hương vị thơm ngon của những nguy&ecirc;n liệu tự nhi&ecirc;n được chọn lọc kỹ c&agrave;ng.&nbsp;<strong>Nước uống Isotonic- 7Up Revive vị chanh muối</strong>&nbsp;với c&ocirc;ng thức b&ugrave; nước I-hydro, mang lại cảm gi&aacute;c sảng kho&aacute;i để khơi bừng hứng khởi, sự kết hợp hương vị thơm ngon của chanh muối c&ugrave;ng c&aacute;c vitamin cần thiết (B3, B6, B12), kho&aacute;ng chất, chất điện giải (Natri, Kali), nước c&ugrave;ng với một lượng gas vừa đủ, gi&uacute;p b&ugrave; nước v&agrave; muối kho&aacute;ng để đ&aacute;nh tan cơn kh&aacute;t trong bạn.</p>

<p><img src="https://cdn02.static-adayroi.com/0/2016/11/23/1479873540965_3164581.jpg" style="height:211px; width:300px" /></p>

<p><em>Nước uống Isotonic- 7Up Revive vị chanh muối</em></p>

<p><strong>Nước uống Isotonic- 7Up Revive vị chanh muối</strong>&nbsp;c&oacute; thể sử dụng thay thế nước uống h&agrave;ng ng&agrave;y, để đảm bảo sự c&acirc;n bằng v&agrave;&nbsp;lấy lại năng lượng cho c&aacute;c&nbsp;hoạt động của&nbsp;cơ thể.&nbsp;<strong>Nước uống Isotonic - 7 Up Revive</strong>&nbsp;với thiết kế chai nhỏ tiện dụng, sản phẩm c&oacute; thể mang theo trong những buổi tập thể thao hay những chuyến vui chơi, d&atilde; ngoại ngo&agrave;i trời đều ph&ugrave; hợp.</p>
', N'/JStore/Upload/images/Products/147987364861_4998731.jpg', N'', CAST(12 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)), 0, 100, 13, N'', NULL, CAST(N'2017-10-20T00:52:54.240' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[tblProduct] ([ID], [Name], [Code], [MetaTitle], [Description], [Images], [MoreImages], [Price], [PromotionPrice], [IncludedVat], [Quantity], [CategoryID], [Detail], [Warranty], [CreatedDate], [Status], [TopHot], [ViewCount]) VALUES (11, N'Nước uống sữa trái cây bổ dưỡng hương cam Nutri Boost chai 297ml', NULL, N'Nuoc-uong-sua-trai-cay-bo-duong-huong-cam-Nutri-Boost-chai-297ml', N'<h2>Th&ocirc;ng số sản phẩm</h2>

<table id="tblGeneralAttribute">
	<tbody>
		<tr>
			<td><strong>Xuất xứ</strong></td>
			<td>Việt Nam</td>
		</tr>
		<tr>
			<td><strong>Hướng dẫn sử dụng</strong></td>
			<td>D&ugrave;ng uống liền, ngon hơn khi uống lạnh</td>
		</tr>
		<tr>
			<td><strong>Hướng dẫn bảo quản</strong></td>
			<td>Bảo quản nơi kh&ocirc; r&aacute;o, tho&aacute;ng m&aacute;t, tr&aacute;nh &aacute;nh nắng trực tiếp</td>
		</tr>
		<tr>
			<td><strong>Quy c&aacute;ch đ&oacute;ng g&oacute;i</strong></td>
			<td>Chai</td>
		</tr>
		<tr>
			<td><strong>Th&agrave;nh phần nguy&ecirc;n liệu</strong></td>
			<td>Nước, đường, sữa, nước t&aacute;o, chất tạo độ chua, hương cam tổng hợp, vitamin B3, vitamin B6, vitamin E&hellip;</td>
		</tr>
		<tr>
			<td><strong>Dung t&iacute;ch</strong></td>
			<td>297 (ml)</td>
		</tr>
	</tbody>
</table>

<h2>Th&ocirc;ng tin sản phẩm</h2>

<h3>Nước uống sữa tr&aacute;i c&acirc;y bổ dưỡng hương cam Nutri Boost chai 297ml</h3>

<p><strong>Nước uống sữa tr&aacute;i c&acirc;y bổ dưỡng hương cam Nutri Boost&nbsp;</strong>c&oacute; th&agrave;nh phần an to&agrave;n cho người d&ugrave;ng,&nbsp;hương vị cam&nbsp;thơm ngon, bổ dưỡng. Sản phẩm gi&uacute;p cơ thể b&ugrave; đắp nước, bổ sung năng lượng, vitamin B3, B6, E, C rất c&oacute; lợi cho cơ thể, gi&uacute;p xua tan cơn kh&aacute;t v&agrave; cảm gi&aacute;c mệt mỏi.&nbsp;<strong>Nước uống sữa tr&aacute;i c&acirc;y bổ dưỡng hương cam Nutri Boost</strong>&nbsp;được sản xuất tr&ecirc;n quy tr&igrave;nh c&ocirc;ng nghệ hiện đại, được kiểm duyệt chặt chẽ. Sản phẩm&nbsp;đảm bảo chất lượng an to&agrave;n, kh&ocirc;ng c&oacute; đường h&oacute;a học, kh&ocirc;ng chứa h&oacute;a chất độc hại, mang đến sự an t&acirc;m cho bạn.&nbsp;</p>

<p>&nbsp;</p>

<p><img src="https://cdn02.static-adayroi.com/0/2016/01/25/1453713297778_4161503.jpg" style="height:211px; width:300px" /></p>

<p><em>Nước uống sữa tr&aacute;i c&acirc;y bổ dưỡng hương cam Nutri Boost</em></p>

<p>&nbsp;</p>

<p><strong>Nước uống sữa tr&aacute;i c&acirc;y bổ dưỡng hương cam Nutri Boost</strong>&nbsp;được đ&oacute;ng chai k&iacute;n đ&aacute;o, dễ bảo quản v&agrave; d&ugrave;ng được l&acirc;u. Người d&ugrave;ng c&oacute; thể mang theo dễ d&agrave;ng khi đi học, đi l&agrave;m hay trong những chuyến đi chơi picnic, gi&uacute;p bạn bổ sung năng lượng v&agrave;&nbsp;giải tỏa cơn kh&aacute;t mọi l&uacute;c.&nbsp;Sản phẩm do VinMart&nbsp;ph&acirc;n phối lu&ocirc;n mang đến chất lượng&nbsp;tốt nhất cho người ti&ecirc;u d&ugrave;ng.</p>
', N'/JStore/Upload/images/Products/1475291143617_3142485.jpg', N'', CAST(8 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)), 0, 30, 9, N'', NULL, CAST(N'2017-10-20T00:55:43.633' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[tblProduct] ([ID], [Name], [Code], [MetaTitle], [Description], [Images], [MoreImages], [Price], [PromotionPrice], [IncludedVat], [Quantity], [CategoryID], [Detail], [Warranty], [CreatedDate], [Status], [TopHot], [ViewCount]) VALUES (12, N'Nước táo ép Vfresh hộp 1L', NULL, N'Nuoc-tao-ep-Vfresh-hop-1L', N'<h2>Th&ocirc;ng số sản phẩm</h2>

<table id="tblGeneralAttribute">
	<tbody>
		<tr>
			<td><strong>Xuất xứ</strong></td>
			<td>Việt Nam</td>
		</tr>
		<tr>
			<td><strong>Hướng dẫn sử dụng</strong></td>
			<td>D&ugrave;ng trực tiếp, lắc đều trước khi uống, ngon hơn khi uống lạnh</td>
		</tr>
		<tr>
			<td><strong>Hướng dẫn bảo quản</strong></td>
			<td>Bảo quản nơi kh&ocirc; tho&aacute;ng, sau khi mở hộp bảo quản trong tủ lạnh v&agrave; d&ugrave;ng trong v&ograve;ng 3 ng&agrave;y</td>
		</tr>
		<tr>
			<td><strong>Quy c&aacute;ch đ&oacute;ng g&oacute;i</strong></td>
			<td>Hộp</td>
		</tr>
		<tr>
			<td><strong>Th&agrave;nh phần nguy&ecirc;n liệu</strong></td>
			<td>Nước t&aacute;o &eacute;p từ nước t&aacute;o c&ocirc; đặc, hương liệu tổng hợp d&ugrave;ng cho thực phẩm, chất oxy h&oacute;a</td>
		</tr>
		<tr>
			<td><strong>Nh&atilde;n hiệu</strong></td>
			<td>Vfresh</td>
		</tr>
		<tr>
			<td><strong>Dung t&iacute;ch</strong></td>
			<td>1 (L)</td>
		</tr>
	</tbody>
</table>

<h2>Th&ocirc;ng tin sản phẩm</h2>

<h3>Nước t&aacute;o &eacute;p Vfresh hộp 1L</h3>

<p><strong>Nước t&aacute;o &eacute;p Vfresh</strong>&nbsp;c&oacute; hương vị ngọt ng&agrave;o, thơm m&aacute;t từ những tr&aacute;i t&aacute;o tươi ngon n&ecirc;n được người ti&ecirc;u d&ugrave;ng nhiều lứa tuổi y&ecirc;u th&iacute;ch. Sản phẩm ho&agrave;n to&agrave;n kh&ocirc;ng chứa chất bảo quản n&ecirc;n bạn c&oacute; thể y&ecirc;n t&acirc;m sử dụng&nbsp;cho gia đ&igrave;nh m&igrave;nh.&nbsp;Nước t&aacute;o &eacute;p chứa nhi&ecirc;̀u khoáng ch&acirc;́t, dinh dưỡng, ch&acirc;́t ch&ocirc;́ng oxy hóa n&ecirc;n r&acirc;́t có lợi cho cơ th&ecirc;̉. Trong nước t&aacute;o &eacute;p c&oacute; lượng vitamin C cao,&nbsp;m&ocirc;̣t chất chống oxy h&oacute;a tốt cho h&ecirc;̣ mi&ecirc;̃n dịch và cơ thể, gi&uacute;p ph&ograve;ng ngừa ung thư một c&aacute;ch hiệu quả. Đặc biệt, nước t&aacute;o &eacute;p r&acirc;́t tốt cho h&ecirc;̣ ti&ecirc;u h&oacute;a v&agrave; h&agrave;m lượng malic axit thấp, ph&acirc;n t&aacute;n dễ d&agrave;ng trong cơ thể n&ecirc;n c&ograve;n gi&uacute;p giữ g&igrave;n v&oacute;c d&aacute;ng một c&aacute;ch hiệu quả.</p>

<p><img src="https://cdn02.static-adayroi.com/0/2017/04/03/1491192878819_5262670.jpg" style="height:211px; width:300px" /></p>

<p><em>Nước t&aacute;o &eacute;p Vfresh</em></p>

<p><strong>Nước t&aacute;o &eacute;p Vfresh</strong>&nbsp;được thiết kế hộp 1L&nbsp;tiện dụng v&agrave; tiết kiệm cho gia đ&igrave;nh bạn. Vỏ hộp được l&agrave;m bằng giấy tr&aacute;ng nh&ocirc;m, gi&uacute;p bảo quản nước &eacute;p lu&ocirc;n giữ được hương vị tự nhi&ecirc;n thơm ngon, đem lại sự y&ecirc;n t&acirc;m cho người sử dụng.&nbsp;Sản phẩm do Vinmart ph&acirc;n phối lu&ocirc;n mang đến chất lượng&nbsp;tốt nhất cho người ti&ecirc;u d&ugrave;ng.</p>
', N'/JStore/Upload/images/Products/1491193270772_5729227.jpg', N'', CAST(39 AS Decimal(18, 0)), CAST(35 AS Decimal(18, 0)), 0, 100, 9, N'', NULL, CAST(N'2017-10-20T01:03:18.940' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[tblProduct] ([ID], [Name], [Code], [MetaTitle], [Description], [Images], [MoreImages], [Price], [PromotionPrice], [IncludedVat], [Quantity], [CategoryID], [Detail], [Warranty], [CreatedDate], [Status], [TopHot], [ViewCount]) VALUES (13, N'Nước cam ép 10% Twister Pepsico chai 350ml', NULL, N'Nuoc-cam-ep-10%-Twister-Pepsico-chai-350ml', N'<h2>Th&ocirc;ng số sản phẩm</h2>

<table id="tblGeneralAttribute">
	<tbody>
		<tr>
			<td><strong>Xuất xứ</strong></td>
			<td>Việt Nam</td>
		</tr>
		<tr>
			<td><strong>Hướng dẫn sử dụng</strong></td>
			<td>D&ugrave;ng uống trực tiếp, lắc đều trước khi sử dụng</td>
		</tr>
		<tr>
			<td><strong>Hướng dẫn bảo quản</strong></td>
			<td>Bảo quản nơi kh&ocirc; r&aacute;o, tho&aacute;ng m&aacute;t</td>
		</tr>
		<tr>
			<td><strong>Quy c&aacute;ch đ&oacute;ng g&oacute;i</strong></td>
			<td>Chai</td>
		</tr>
		<tr>
			<td><strong>Th&agrave;nh phần nguy&ecirc;n liệu</strong></td>
			<td>Nước, đường m&iacute;a, nước cam h&ograve;a nguy&ecirc;n từ nước cam c&ocirc; đặc, chất ổn định, chất điều chỉnh độ axit&hellip;</td>
		</tr>
		<tr>
			<td><strong>Hạn sử dụng</strong></td>
			<td>6 th&aacute;ng</td>
		</tr>
		<tr>
			<td><strong>Dung t&iacute;ch</strong></td>
			<td>350 (ml)</td>
		</tr>
	</tbody>
</table>

<h2>Th&ocirc;ng tin sản phẩm</h2>

<h3>Nước cam &eacute;p 10% Twister Pepsico chai 350ml</h3>

<p><strong>Nước cam &eacute;p Twister</strong>&nbsp;được chiết xuất từ những t&eacute;p cam tươi nguy&ecirc;n chất tươi ngon v&agrave; bổ dưỡng. Sản phẩm bổ sung th&ecirc;m nhiều vitamin v&agrave; năng lượng cho cơ thể.&nbsp;<strong>Nước cam &eacute;p Twister</strong>&nbsp;với nguồn nguy&ecirc;n liệu tự nhi&ecirc;n được lựa chọn cẩn thận kết hợp c&ocirc;ng nghệ sản xuất hiện đại, mang lại&nbsp;thức uống c&oacute; hương vị thơm&nbsp;ngon, tốt cho sức khỏe. Sản phẩm được sản xuất dựa tr&ecirc;n d&acirc;y chuyền c&ocirc;ng nghệ hiện đại, kh&eacute;p k&iacute;n, khử tr&ugrave;ng cao n&ecirc;n bạn ho&agrave;n to&agrave;n y&ecirc;n t&acirc;m khi sử dụng. Khi thưởng thức&nbsp;<strong>Nước cam &eacute;p Twister&nbsp;</strong>gi&uacute;p xua tan mọi cảm gi&aacute;c mệt mỏi, căng thẳng ngay tức th&igrave;, đem lại cảm gi&aacute;c thoải m&aacute;i nhất cho bạn&nbsp;sau mỗi lần sử dụng.</p>

<p>&nbsp;</p>

<p><img src="https://img.adayroi.com/0/2015/11/16/1447669531884_5291743.jpg" style="height:211px; width:300px" /></p>

<p><em>Nước cam &eacute;p 10% Twister Pepsico</em></p>

<p>&nbsp;</p>

<p>Sản phẩm của Pepsico -&nbsp;thương hiệu nước giải kh&aacute;t uy t&iacute;n tại Việt Nam đ&atilde; trở th&agrave;nh một c&aacute;i t&ecirc;n quen thuộc với mọi nh&agrave;,&nbsp;đảm bảo mang đến một trải nghiệm thưởng thức tuyệt vời cho người d&ugrave;ng.</p>
', N'/JStore/Upload/images/Products/1468987129638_1686055.jpg', N'', CAST(10 AS Decimal(18, 0)), CAST(9 AS Decimal(18, 0)), 0, 113, 9, N'', NULL, CAST(N'2017-10-20T01:05:30.910' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[tblProduct] ([ID], [Name], [Code], [MetaTitle], [Description], [Images], [MoreImages], [Price], [PromotionPrice], [IncludedVat], [Quantity], [CategoryID], [Detail], [Warranty], [CreatedDate], [Status], [TopHot], [ViewCount]) VALUES (14, N'Nước dừa xiêm hương vị sen Cocoxim hộp 330ml', NULL, N'Nuoc-dua-xiem-huong-vi-sen-Cocoxim-hop-330ml', N'<h2>Th&ocirc;ng số sản phẩm</h2>

<table id="tblGeneralAttribute">
	<tbody>
		<tr>
			<td><strong>Xuất xứ</strong></td>
			<td>Việt Nam</td>
		</tr>
		<tr>
			<td><strong>Hướng dẫn sử dụng</strong></td>
			<td>D&ugrave;ng trực tiếp, ngon hơn khi d&ugrave;ng lạnh</td>
		</tr>
		<tr>
			<td><strong>Hướng dẫn bảo quản</strong></td>
			<td>Bảo quản nơi kh&ocirc; r&aacute;o tho&aacute;ng m&aacute;t, tr&aacute;nh &aacute;nh nắng trực tiếp</td>
		</tr>
		<tr>
			<td><strong>Quy c&aacute;ch đ&oacute;ng g&oacute;i</strong></td>
			<td>Hộp</td>
		</tr>
		<tr>
			<td><strong>Hương vị</strong></td>
			<td>Hương vị sen</td>
		</tr>
		<tr>
			<td><strong>Th&agrave;nh phần nguy&ecirc;n liệu</strong></td>
			<td>Nước dừa, đường, hương tự nhi&ecirc;n v&agrave; giống tự nhi&ecirc;n, chất chống oxy h&oacute;a,...</td>
		</tr>
		<tr>
			<td><strong>Dung t&iacute;ch</strong></td>
			<td>330 (ml)</td>
		</tr>
	</tbody>
</table>

<h2>Th&ocirc;ng tin sản phẩm</h2>

<h3>Nước dừa xi&ecirc;m hương vị sen Cocoxim hộp 330ml</h3>

<p><strong>Nước dừa xi&ecirc;m hương vị sen Cocoxim</strong>&nbsp;được sản xuất theo c&ocirc;ng nghệ hiện đại, mọi kh&acirc;u từ tuyển chọn nguy&ecirc;n liệu tới chế biến, đ&oacute;ng bao b&igrave;&nbsp;đều diễn ra kh&eacute;p k&iacute;n dưới sự gi&aacute;m s&aacute;t v&agrave; kiểm tra nghi&ecirc;m ngặt. Sản phẩm kh&ocirc;ng chứa h&oacute;a chất, chất bảo quản độc hại, đảm bảo an to&agrave;n cho sức khỏe người ti&ecirc;u d&ugrave;ng.&nbsp;Sản phẩm c&oacute; hương vị&nbsp;của những nguy&ecirc;n liệu tự nhi&ecirc;n được chọn lọc kỹ c&agrave;ng, sẽ mang lại cho bạn những ph&uacute;t giải tr&iacute; v&agrave; thưởng thức&nbsp;thật tuyệt vời b&ecirc;n cạnh bạn b&egrave; hoặc người th&acirc;n.&nbsp;</p>

<p><img src="https://cdn02.static-adayroi.com/0/2016/11/30/148049538139_6094635.jpg" style="height:211px; width:300px" /></p>

<p><em>Nước dừa xi&ecirc;m hương vị sen Cocoxim</em></p>

<p><strong>Nước dừa xi&ecirc;m hương vị sen Cocoxim</strong>&nbsp;gi&uacute;p bạn nhanh ch&oacute;ng xua tan cơn kh&aacute;t, gi&uacute;p b&ugrave; nước trong c&aacute;c hoạt động h&agrave;ng ng&agrave;y, ngo&agrave;i ra sản phẩm được đ&oacute;ng hộp tiện lợi cho việc sử dụng v&agrave; bảo quản.</p>
', N'/JStore/Upload/images/Products/1506309638125_2120226.jpg', N'', CAST(12 AS Decimal(18, 0)), CAST(11 AS Decimal(18, 0)), 0, 114, 9, N'', NULL, CAST(N'2017-10-20T01:08:32.087' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[tblProduct] ([ID], [Name], [Code], [MetaTitle], [Description], [Images], [MoreImages], [Price], [PromotionPrice], [IncludedVat], [Quantity], [CategoryID], [Detail], [Warranty], [CreatedDate], [Status], [TopHot], [ViewCount]) VALUES (15, N'Nước dâu với miếng dâu Dellos chai 500ml', NULL, N'Nuoc-dau-voi-mieng-dau-Dellos-chai-500ml', N'<h2>Th&ocirc;ng số sản phẩm</h2>

<table id="tblGeneralAttribute">
	<tbody>
		<tr>
			<td><strong>Xuất xứ</strong></td>
			<td>H&agrave;n Quốc</td>
		</tr>
		<tr>
			<td><strong>Hướng dẫn sử dụng</strong></td>
			<td>D&ugrave;ng uống trực tiếp. Lắc đều trước khi uống. Ngon hơn khi uống lạnh</td>
		</tr>
		<tr>
			<td><strong>Hướng dẫn bảo quản</strong></td>
			<td>Bảo quản nơi tho&aacute;ng m&aacute;t, tr&aacute;nh tiếp x&uacute;c trực tiếp với &aacute;nh s&aacute;ng, bảo quản lạnh sau khi mở nắp</td>
		</tr>
		<tr>
			<td><strong>Quy c&aacute;ch đ&oacute;ng g&oacute;i</strong></td>
			<td>Chai</td>
		</tr>
		<tr>
			<td><strong>Th&agrave;nh phần nguy&ecirc;n liệu</strong></td>
			<td>Nước, đường tinh luyện, d&acirc;u miếng, d&acirc;u c&ocirc; đặc, chất điều chỉnh độ acid...</td>
		</tr>
		<tr>
			<td><strong>Hạn sử dụng</strong></td>
			<td>24 th&aacute;ng</td>
		</tr>
		<tr>
			<td><strong>Dung t&iacute;ch</strong></td>
			<td>500 (ml)</td>
		</tr>
	</tbody>
</table>

<h2>Th&ocirc;ng tin sản phẩm</h2>

<h3>Nước d&acirc;u với miếng d&acirc;u Dellos chai 500ml</h3>

<p><strong>Nước d&acirc;u với miếng d&acirc;u Dellos​&nbsp;</strong>với&nbsp;th&agrave;nh phần nguy&ecirc;n liệu được lựa chọn kỹ lưỡng, kh&ocirc;ng chứa h&oacute;a chất độc hại, an to&agrave;n cho người d&ugrave;ng. Sản phẩm được sản xuất tr&ecirc;n quy tr&igrave;nh c&ocirc;ng nghệ hiện đại,&nbsp;kiểm duyệt chặt chẽ, đảm bảo chất lượng, được ưa chuộng tr&ecirc;n thị trường.&nbsp;<strong>Nước d&acirc;u với miếng d&acirc;u Dellos​​</strong>&nbsp;c&oacute; th&agrave;nh phần tự nhi&ecirc;n từ nước, đường tinh luyện, d&acirc;u miếng, d&acirc;u c&ocirc; đặc... Sản phẩm&nbsp;c&oacute; vị ngọt, thanh m&aacute;t, kh&ocirc;ng chứa chất b&eacute;o với lượng calo thấp.&nbsp;<strong>Nước d&acirc;u với miếng d&acirc;u Dellos​</strong>&nbsp;gi&uacute;p cơ thể b&ugrave; đắp nước, bổ sung năng lượng, một số vitamin c&oacute; lợi, gi&uacute;p xua tan cơn kh&aacute;t v&agrave; cảm gi&aacute;c mệt mỏi.</p>

<p>&nbsp;</p>

<p><img src="https://cdn02.static-adayroi.com/0/2017/03/14/148948113076_1877977.jpg" style="height:211px; width:300px" /></p>

<p><em>Nước d&acirc;u với miếng d&acirc;u Dellos​</em></p>

<p>&nbsp;</p>

<p><strong>Nước d&acirc;u với miếng d&acirc;u Dellos​​​</strong>&nbsp;được đ&oacute;ng chai k&iacute;n đ&aacute;o, c&oacute; thể bảo quản dễ d&agrave;ng nơi kh&ocirc; m&aacute;t hay trong ngăn m&aacute;t tủ lạnh m&agrave; kh&ocirc;ng sợ sản phẩm hư hỏng hay biến chất. Người d&ugrave;ng c&oacute; thể mang theo dễ d&agrave;ng khi đi học, đi l&agrave;m hay trong những chuyến đi chơi, picnic.&nbsp;Sản phẩm do VinMart ph&acirc;n phối lu&ocirc;n mang đến chất lượng&nbsp;tốt nhất cho người ti&ecirc;u d&ugrave;ng.</p>
', N'/JStore/Upload/images/Products/1489211260516_5299734.jpg', N'', CAST(20 AS Decimal(18, 0)), CAST(18 AS Decimal(18, 0)), 0, 115, 9, N'', NULL, CAST(N'2017-10-20T01:11:08.513' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[tblProduct] ([ID], [Name], [Code], [MetaTitle], [Description], [Images], [MoreImages], [Price], [PromotionPrice], [IncludedVat], [Quantity], [CategoryID], [Detail], [Warranty], [CreatedDate], [Status], [TopHot], [ViewCount]) VALUES (16, N'Mcdonalds', NULL, N'mcdonalds', N'<hr />
<p>&nbsp;</p>

<p><strong>Tại McDonald&rsquo;s, ch&uacute;ng t&ocirc;i tin rằng thực phẩm ngon phải đến từ nguy&ecirc;n liệu chọn lọc. Ch&iacute;nh v&igrave; thế ch&uacute;ng t&ocirc;i lu&ocirc;n ch&uacute; trọng đến nguồn nguy&ecirc;n liệu của m&igrave;nh v&agrave; cam kết mang tới cho bạn những bữa ăn ngon miệng v&agrave; chất lượng nhất.</strong></p>

<p>100% THỊT B&Ograve; NHẬP KHẨU</p>

<p>L&aacute;t thịt b&ograve; ngon l&agrave;nh kẹp trong phần burger của ch&uacute;ng t&ocirc;i được l&agrave;m 100% từ thịt b&ograve; &Uacute;c. Bạn sẽ được thưởng thức sự mềm mại, thơm b&eacute;o từ l&aacute;t cắt ngon nhất của phần thịt chất lượng cao. Ch&uacute;ng t&ocirc;i chỉ n&ecirc;m ch&uacute;t muối v&agrave; ti&ecirc;u để giữ nguy&ecirc;n vị ngọt tự nhi&ecirc;n của thịt.</p>

<p>&nbsp;</p>

<p>VỊ NGON LỪNG DANH THẾ GIỚI</p>

<p>M&oacute;n khoai t&acirc;y chi&ecirc;n (French Fries) lừng danh thế giới của ch&uacute;ng t&ocirc;i được chế biến từ loại khoai t&acirc;y Russet Burbank thượng hạng v&agrave; được chi&ecirc;n bằng 100% dầu thực vật. Bạn cũng c&oacute; thể y&ecirc;u cầu m&oacute;n khoai t&acirc;y chi&ecirc;n của m&igrave;nh kh&ocirc;ng k&egrave;m muối khi đặt m&oacute;n với nh&acirc;n vi&ecirc;n nh&agrave; h&agrave;ng.</p>

<p><img alt="" src="https://mcdonalds.vn/sites/all/themes/mcd/images/where-it-come-2.jpg" style="height:262px; width:300px" /></p>

<p>&nbsp;</p>

<p><img alt="" src="https://mcdonalds.vn/sites/all/themes/mcd/images/where-it-come-1.jpg" style="height:275px; width:309px" /></p>

<p>MỀM NGON TUYỆT VỜI</p>

<p>Với Chicken McNuggets v&agrave; c&aacute;c m&oacute;n g&agrave; r&aacute;n thơm ngon kh&aacute;c của Mcdonald, ch&uacute;ng t&ocirc;i chỉ sử dụng thịt g&agrave; &iacute;t b&eacute;o, chứa nhiều protein, được kiểm định thường xuy&ecirc;n kỹ c&agrave;ng v&agrave; lựa chọn gắt gao từ nguồn cung cấp an to&agrave;n, nhằm đảm bảo rằng, bạn sẽ lu&ocirc;n thưởng thức c&ugrave;ng một hương vị đậm đ&agrave;, độc đ&aacute;o tại bất cứ cửa h&agrave;ng n&agrave;o v&agrave;o bất cứ thời điểm n&agrave;o.</p>

<p>PHI L&Ecirc; C&Aacute; THƯỢNG HẠNG</p>

<p>V&igrave; ch&uacute;ng t&ocirc;i chỉ đ&aacute;nh bắt nguồn c&aacute; trắng thượng hạng, sống tr&ecirc;n tầng mặt nước ngo&agrave;i khơi biển Atlantic v&agrave; Pacific cho m&oacute;n Filet-O-Fish nổi tiếng. Với kiểu đ&aacute;nh bắt n&agrave;y, ch&uacute;ng t&ocirc;i đảm bảo nguồn nguy&ecirc;n liệu kh&ocirc;ng bị cạn kiệt, v&igrave; thế bạn c&oacute; thể thưởng thức c&ugrave;ng một hương vị c&aacute; thơm ngon trong hằng thập kỷ tới.</p>

<p>&nbsp;</p>

<p>ĐẶC BIỆT HƠN VỚI HƯƠNG VỊ TƯƠI XANH VIỆT NAM</p>

<p>Được trồng ri&ecirc;ng tại n&ocirc;ng trại tại Đ&agrave; Lạt, những b&uacute;p rau xanh tươi được chuyển đến nh&agrave; h&agrave;ng McDonald&rsquo;s h&agrave;ng ng&agrave;y, để mang đến cho bạn bữa ăn chất lượng v&agrave; tươi ngon nhất.</p>

<p><img alt="" src="https://mcdonalds.vn/sites/all/themes/mcd/images/where-it-come-3.png" style="height:219px; width:300px" /></p>

<p>&nbsp;</p>

<p>&nbsp;</p>
', N'/JStore/Upload/images/Products/sides.png', N'', CAST(50 AS Decimal(18, 0)), CAST(40 AS Decimal(18, 0)), 0, 100, 1, N'', NULL, CAST(N'2017-10-20T01:26:08.127' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[tblProduct] ([ID], [Name], [Code], [MetaTitle], [Description], [Images], [MoreImages], [Price], [PromotionPrice], [IncludedVat], [Quantity], [CategoryID], [Detail], [Warranty], [CreatedDate], [Status], [TopHot], [ViewCount]) VALUES (17, N'KFC', NULL, N'KFC', N'<p>KFC l&agrave; cụm từ viết tắt của Kentucky Fried Chicken - G&agrave; R&aacute;n Kentucky, một trong c&aacute;c thương hiệu thuộc Tập đo&agrave;n Yum Brands Inc (Hoa Kỳ). KFC chuy&ecirc;n về c&aacute;c sản phẩm g&agrave; r&aacute;n v&agrave; nướng, với c&aacute;c m&oacute;n ăn k&egrave;m theo v&agrave; c&aacute;c loại sandwiches chế biến từ thịt g&agrave; tươi. Hiện nay đang c&oacute; hơn 20.000 nh&agrave; h&agrave;ng KFC tại 109 quốc gia v&agrave; v&ugrave;ng l&atilde;nh thổ tr&ecirc;n to&agrave;n thế giới.<br />
<br />
KFC nổi tiếng thế giới với c&ocirc;ng thức chế biến g&agrave; r&aacute;n truyền thống Original Recipe, được tạo bởi c&ugrave;ng một c&ocirc;ng thức pha trộn b&iacute; mật 11 loại thảo mộc v&agrave; gia vị kh&aacute;c nhau do Đại t&aacute; Harland Sanders ho&agrave;n thiện hơn nửa thế kỷ trước. Ngo&agrave;i thực đơn g&agrave; r&aacute;n, KFC c&ograve;n đa dạng h&oacute;a sản phẩm tạo n&ecirc;n thực đơn v&ocirc; c&ugrave;ng phong ph&uacute; d&agrave;nh cho người ti&ecirc;u d&ugrave;ng tr&ecirc;n to&agrave;n thế giới c&oacute; thể thưởng thức hơn 300 m&oacute;n ăn kh&aacute;c nhau từ m&oacute;n g&agrave; nướng tại thị trường Việt Nam cho tới sandwich c&aacute; hồi tại Nhật Bản.</p>

<p><img alt="09092014162926.png" src="http://www.kfcvietnam.com.vn/asset/news/09092014162926.png" style="height:226px; width:300px" /></p>

<p><img alt="09092014162933.png" src="http://www.kfcvietnam.com.vn/asset/news/09092014162933.png" style="height:250px; width:300px" /></p>

<p>&nbsp;</p>

<p>B&ecirc;n cạnh những m&oacute;n ăn truyền thống như g&agrave; r&aacute;n v&agrave; Bơ-gơ, đến với thị trường Việt Nam, KFC đ&atilde; chế biến th&ecirc;m một số m&oacute;n để phục vụ những thức ăn hợp khẩu vị người Việt như: G&agrave; Big&lsquo;n Juicy, G&agrave; Gi&ograve;n Kh&ocirc;ng Xương, Cơm G&agrave; KFC, Bắp Cải Trộn &hellip; Một số m&oacute;n mới cũng đ&atilde; được ph&aacute;t triển v&agrave; giới thiệu tại thị trường Việt Nam, g&oacute;p phần l&agrave;m tăng th&ecirc;m sự đa dạng trong danh mục thực đơn, như: Bơ-gơ T&ocirc;m, Lipton, B&aacute;nh Egg Tart.</p>

<p>Năm 1997, KFC đ&atilde; khai trương nh&agrave; h&agrave;ng đầu ti&ecirc;n tại Th&agrave;nh phố Hồ Ch&iacute; Minh. Đến nay, hệ thống c&aacute;c nh&agrave; h&agrave;ng của KFC đ&atilde; ph&aacute;t triển tới hơn 140 nh&agrave; h&agrave;ng, c&oacute; mặt tại hơn 19 tỉnh/th&agrave;nh phố lớn tr&ecirc;n cả nước, sử dụng hơn 3.000 lao động đồng thời cũng tạo th&ecirc;m nhiều việc l&agrave;m trong ng&agrave;nh c&ocirc;ng nghiệp bổ trợ tại Việt Nam.</p>
', N'/JStore/Upload/images/Products/3982_290715155847_combojpg.jpg', N'', CAST(75 AS Decimal(18, 0)), CAST(70 AS Decimal(18, 0)), 0, 10, 1, N'', NULL, CAST(N'2017-10-20T01:29:48.503' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[tblProduct] ([ID], [Name], [Code], [MetaTitle], [Description], [Images], [MoreImages], [Price], [PromotionPrice], [IncludedVat], [Quantity], [CategoryID], [Detail], [Warranty], [CreatedDate], [Status], [TopHot], [ViewCount]) VALUES (18, N'Cà phê Highland', NULL, N'Ca-phe-Highland', N'<p><strong>Thương hi&ecirc;̣u bắt ngu&ocirc;̀n từ c&agrave; ph&ecirc; Vi&ecirc;̣t Nam</strong></p>

<p>&nbsp;</p>

<p>Highlands Coffee được sinh ra từ niềm đam m&ecirc; bất tận với hạt c&agrave; ph&ecirc; Việt Nam. Bắt đầu với sản phẩm c&agrave; ph&ecirc; đ&oacute;ng g&oacute;i tại H&agrave; N&ocirc;̣i v&agrave;o năm 2000, ch&uacute;ng t&ocirc;i đ&atilde; nhanh ch&oacute;ng ph&aacute;t triển v&agrave; mở rộng th&agrave;nh thương hiệu qu&aacute;n c&agrave; ph&ecirc; nổi tiếng v&agrave; kh&ocirc;ng ngừng mở rộng hoạt động trong v&agrave; ngo&agrave;i nước từ năm 2002.</p>

<p>&nbsp;</p>

<p>Qua một chặng đường d&agrave;i, ch&uacute;ng t&ocirc;i đ&atilde; kh&ocirc;ng ngừng mang đến những sản phẩm c&agrave; ph&ecirc; thơm ngon, s&aacute;nh đượm trong kh&ocirc;ng gian thoải m&aacute;i v&agrave; lịch sự. Những ly cafe của ch&uacute;ng t&ocirc;i kh&ocirc;ng chỉ đơn thuần l&agrave; thức uống quen thuộc m&agrave; c&ograve;n mang tr&ecirc;n m&igrave;nh một sứ mệnh văn h&oacute;a phản &aacute;nh một phần nếp sống hiện đại của người Việt Nam.</p>

<p>&nbsp;</p>

<p>Đến nay, Highlands Coffee vẫn duy tr&igrave; kh&acirc;u ph&acirc;n loại c&agrave; ph&ecirc; bằng tay để chọn ra từng hạt c&agrave; ph&ecirc; chất lượng nhất, rang mới mỗi ng&agrave;y v&agrave; phục vụ qu&yacute; kh&aacute;ch với nụ cười rạng rỡ tr&ecirc;n m&ocirc;i. B&iacute; quyết th&agrave;nh c&ocirc;ng của ch&uacute;ng t&ocirc;i l&agrave; đ&acirc;y: cửa h&agrave;ng tuyệt vời, sản phẩm tuyệt hảo v&agrave; dịch vụ chu đ&aacute;o với mức gi&aacute; ph&ugrave; hợp!</p>
', N'/JStore/Upload/images/Products/HCO-7454-PSD-WEB.png', N'', CAST(50 AS Decimal(18, 0)), CAST(45 AS Decimal(18, 0)), 0, 10, 1, N'', NULL, CAST(N'2017-10-20T01:37:15.073' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[tblProduct] ([ID], [Name], [Code], [MetaTitle], [Description], [Images], [MoreImages], [Price], [PromotionPrice], [IncludedVat], [Quantity], [CategoryID], [Detail], [Warranty], [CreatedDate], [Status], [TopHot], [ViewCount]) VALUES (19, N'Vinamilk', NULL, N'Vinamilk', N'<p>TẦM NH&Igrave;N</p>

<p>&ldquo;Trở th&agrave;nh biểu tượng niềm tin h&agrave;ng đầu Việt Nam về sản phẩm dinh dưỡng v&agrave; sức khỏe phục vụ cuộc sống con người&ldquo;</p>

<p>SỨ MỆNH</p>

<p>&ldquo;Vinamilk cam kết mang đến cho cộng đồng nguồn dinh dưỡng v&agrave; chất lượng cao cấp h&agrave;ng đầu bằng ch&iacute;nh sự tr&acirc;n trọng, t&igrave;nh y&ecirc;u v&agrave; tr&aacute;ch nhiệm cao của m&igrave;nh với cuộc sống con người v&agrave; x&atilde; hội&rdquo;</p>

<p><img alt="Bà Mai Kiều Liên" src="https://www.vinamilk.com.vn/static/uploads/translate/1439895569-e29f67b7862650334b9907157ac388e95a8209e22657ab9eb4512834b1dc6d59.png" title="Bà Mai Kiều Liên" /></p>
', N'/JStore/Upload/images/Products/icon_mobile_app.png', N'', CAST(28 AS Decimal(18, 0)), CAST(20 AS Decimal(18, 0)), 0, 50, 1, N'', NULL, CAST(N'2017-10-20T01:42:12.977' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[tblProduct] ([ID], [Name], [Code], [MetaTitle], [Description], [Images], [MoreImages], [Price], [PromotionPrice], [IncludedVat], [Quantity], [CategoryID], [Detail], [Warranty], [CreatedDate], [Status], [TopHot], [ViewCount]) VALUES (20, N'Nestle', NULL, N'Nestle', N'<h1>Về ch&uacute;ng t&ocirc;i</h1>

<p>Nestl&eacute; l&agrave; tập đo&agrave;n thực phẩm v&agrave; thức uống lớn nhất thế giới. Ch&uacute;ng t&ocirc;i c&oacute; hơn 2000 nh&atilde;n hiệu kh&aacute;c nhau, từ c&aacute;c thương hiệu biểu tượng to&agrave;n cầu cho đến c&aacute;c thương hiệu địa phương được y&ecirc;u th&iacute;ch, v&agrave; ch&uacute;ng t&ocirc;i đang hiện diện tại 191 quốc gia tr&ecirc;n to&agrave;n thế giới.</p>

<h2>Mục đ&iacute;ch của Nestl&eacute;</h2>

<p>&nbsp;</p>

<p>Mục đ&iacute;ch của ch&uacute;ng t&ocirc;i l&agrave; n&acirc;ng cao chất lượng cuộc sống v&agrave; g&oacute;p phần v&agrave;o một tương lai khỏe mạnh hơn. Ch&uacute;ng t&ocirc;i mong muốn tạo ra một thế giới tốt đẹp v&agrave; khỏe mạnh hơn. Ch&uacute;ng t&ocirc;i cũng mong muốn truyền cảm hứng cho mọi người sống l&agrave;nh mạnh hơn. Đ&acirc;y l&agrave; c&aacute;ch ch&uacute;ng t&ocirc;i đ&oacute;ng g&oacute;p cho x&atilde; hội trong khi vẫn đảm bảo sự th&agrave;nh c&ocirc;ng l&acirc;u d&agrave;i trong kinh doanh của Nestl&eacute;.</p>

<p><img src="https://www.nestle.com.vn/asset-library/PublishingImages/AboutUs/about-us-landing-purpose-boys.jpg" style="height:145px; width:300px" /></p>
', N'/JStore/Upload/images/Products/category-brands.png', N'', CAST(35 AS Decimal(18, 0)), CAST(30 AS Decimal(18, 0)), 0, 30, 1, N'', NULL, CAST(N'2017-10-20T01:44:40.520' AS DateTime), 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[tblProduct] OFF
SET IDENTITY_INSERT [dbo].[tblSlide] ON 

INSERT [dbo].[tblSlide] ([ID], [Image], [DisplayOrder], [Link], [Description], [CreatedDate], [Status]) VALUES (1, N'/JStore/Upload/images/1.jpg', 1, N'http://localhost:8084/JStore', N'Các Loại Thực Phẩm Sấy Khô', CAST(N'2017-10-19T23:09:54.977' AS DateTime), 1)
INSERT [dbo].[tblSlide] ([ID], [Image], [DisplayOrder], [Link], [Description], [CreatedDate], [Status]) VALUES (2, N'/JStore/Upload/images/2.jpg', 1, N'http://localhost:8084/JStore', N'Rau củ cung cấp chất xơ , luôn cần thiết cho đời s', CAST(N'2017-10-19T23:13:53.783' AS DateTime), 1)
INSERT [dbo].[tblSlide] ([ID], [Image], [DisplayOrder], [Link], [Description], [CreatedDate], [Status]) VALUES (5, N'/JStore/Upload/images/3.jpg', 1, N'http://localhost:8084/JStore', N'Nước giải khát', CAST(N'2017-10-19T23:18:32.033' AS DateTime), 1)
INSERT [dbo].[tblSlide] ([ID], [Image], [DisplayOrder], [Link], [Description], [CreatedDate], [Status]) VALUES (6, N'/JStore/Upload/images/banhmi.jpg', 1, N'http://localhost:8084/JStore', N'Đồ ăn sáng quen thuộc của người Việt', CAST(N'2017-10-19T23:29:10.437' AS DateTime), 1)
INSERT [dbo].[tblSlide] ([ID], [Image], [DisplayOrder], [Link], [Description], [CreatedDate], [Status]) VALUES (7, N'/JStore/Upload/images/lovisong.jpg', 1, N'http://localhost:8084/JStore', N'Đồ chế biến thức ăn tiện dụng', CAST(N'2017-10-19T23:34:06.570' AS DateTime), 1)
INSERT [dbo].[tblSlide] ([ID], [Image], [DisplayOrder], [Link], [Description], [CreatedDate], [Status]) VALUES (10, N'/JStore/Upload/images/Products/1468987129638_1686055.jpg', 1, N'', N'', CAST(N'2017-10-24T13:08:33.110' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[tblSlide] OFF
ALTER TABLE [dbo].[tblAccountAdmin] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[tblAccountClient] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[tblAccountClient] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[tblCategory] ADD  DEFAULT ((0)) FOR [DisplayOrder]
GO
ALTER TABLE [dbo].[tblCategory] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[tblCategory] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[tblProduct] ADD  DEFAULT ((0)) FOR [Price]
GO
ALTER TABLE [dbo].[tblProduct] ADD  DEFAULT ((0)) FOR [PromotionPrice]
GO
ALTER TABLE [dbo].[tblProduct] ADD  DEFAULT ((0)) FOR [IncludedVat]
GO
ALTER TABLE [dbo].[tblProduct] ADD  DEFAULT ((0)) FOR [Quantity]
GO
ALTER TABLE [dbo].[tblProduct] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[tblProduct] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[tblSlide] ADD  DEFAULT ((1)) FOR [DisplayOrder]
GO
ALTER TABLE [dbo].[tblSlide] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[tblSlide] ADD  DEFAULT ((1)) FOR [Status]
GO
/****** Object:  StoredProcedure [dbo].[customPage]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[customPage]
@current_page bigint,
@limit bigint,
@name nvarchar(200)
as
begin
declare @total_record bigint
declare @total_page bigint
declare @start bigint 

if @name is not null 
set @total_record = (select count(*) from tblProduct where Name like '%'+@name+'%')
else if @name is null 
set @total_record = (select count(*) from tblProduct)

set @total_page = CEILING(CAST(@total_record as decimal)/CAST(@limit as decimal))

if @current_page>@total_page
begin
set @current_page = @total_page 
end
else if @current_page<1
begin 
set @current_page = 1
end

set @start = (@current_page-1)*@limit

if @name is not null 
begin 
;WITH Numberedtblcontact AS
(
    SELECT
	    *,
        ROW_NUMBER() OVER (ORDER BY id) AS RowNumber
    FROM
        tblProduct where Name like '%'+@name+'%'
)select top(@limit)* from Numberedtblcontact where  RowNumber BETWEEN  @start and @start+@limit
end

else if @name is null 
begin 
;WITH Numberedtblcontact AS
(
    SELECT
	    *,
        ROW_NUMBER() OVER (ORDER BY id) AS RowNumber
    FROM
        tblProduct 
)select top(@limit)* from Numberedtblcontact where  RowNumber BETWEEN  @start and @start+@limit
end

return @total_page
end

GO
/****** Object:  StoredProcedure [dbo].[uspDataIDtblProduct]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[uspDataIDtblProduct]
@ID bigint
as
begin
select * from tblProduct where ID=@ID
end

GO
/****** Object:  StoredProcedure [dbo].[uspDatatblAccountAdmin]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[uspDatatblAccountAdmin]
as
begin
select * from tblAccountAdmin
end

GO
/****** Object:  StoredProcedure [dbo].[uspDatatblAccountClient]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[uspDatatblAccountClient]
as
begin
select * from tblAccountClient
end

GO
/****** Object:  StoredProcedure [dbo].[uspDatatblCategory]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--start procedure tblCategory
create procedure [dbo].[uspDatatblCategory]
as
begin
select * from tblCategory
end

GO
/****** Object:  StoredProcedure [dbo].[uspDatatblCategoryOrder]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[uspDatatblCategoryOrder]
as
begin
select * from tblCategory order by DisplayOrder ASC
end

GO
/****** Object:  StoredProcedure [dbo].[uspDatatblCategoryParentID]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[uspDatatblCategoryParentID]
@ID bigint
as
begin
select * from tblCategory where ParentID=@ID order by DisplayOrder ASC
end

GO
/****** Object:  StoredProcedure [dbo].[uspDatatblProduct]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--start procedure tblProduct

create procedure [dbo].[uspDatatblProduct]
as
begin
select * from tblProduct
end

GO
/****** Object:  StoredProcedure [dbo].[uspDatatblProductCategory]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[uspDatatblProductCategory]
@ID bigint
as
begin
select * from tblProduct where CategoryID=@ID order by ID ASC
end

GO
/****** Object:  StoredProcedure [dbo].[uspDatatblSlide]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--start procedure tblSlide
create procedure [dbo].[uspDatatblSlide]
as
begin
select * from tblSlide
end

GO
/****** Object:  StoredProcedure [dbo].[uspDeletetblAccountAdmin]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[uspDeletetblAccountAdmin]
@ID bigint 
as
begin
set nocount on
begin try
delete tblAccountAdmin where ID=@ID
return 1
end try
begin catch
return -1
end catch
end

GO
/****** Object:  StoredProcedure [dbo].[uspDeletetblAccountClient]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[uspDeletetblAccountClient]
@ID bigint
as
begin
delete from tblAccountClient where ID=@ID
return 1
end

GO
/****** Object:  StoredProcedure [dbo].[uspDeletetblCategory]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[uspDeletetblCategory]
@ID bigint
as
begin
delete from tblCategory where ID=@ID
return 1
end

--end procedure tblCategory

--go
--create table tblContent
--(
--ID bigint identity primary key ,
--Name nvarchar(250),
--MetaTitle varchar(250),
--Description nvarchar(550),
--Images nvarchar(250),
--CategoryID bigint,
--Detail ntext,
--Warranty int,
--CreatedDate datetime default getdate(),
--CreatedBy varchar(50),
--ModifiedDate datetime,
--ModifiedBy varchar(50),
--MetaKeywords nvarchar(250),
--MetaDescriptions nchar(250),
--Status bit not null default 1,
--TopHot datetime,
--ViewCount int,
--Tags nvarchar(500)
--)
--go
--create table tblTag
--(
--ID varchar(100),
--Name nvarchar(100)
--) 
--go
--create table tblContentTag
--(
--ContentID bigint identity primary key,
--TagID varchar(100) 
--)
--go
--create table tblAbout
--(
--ID bigint identity primary key ,
--Name nvarchar(250),
--MetaTitle varchar(250),
--Description nvarchar(550),
--Detail ntext,
--CreatedDate datetime default getdate(),
--CreatedBy varchar(50),
--ModifiedDate datetime,
--ModifiedBy varchar(50),
--MetaKeywords nvarchar(250),
--MetaDescriptions nchar(250),
--Status bit not null default 1
--)
--go
--create table tblContact
--(
--ID int identity primary key,
--Content ntext,
--Status bit not null default 1
--)
--go
--create table tblFeedback
--(
--ID int identity primary key,
--Name nvarchar(50),
--Phone nvarchar(50),
--Email nvarchar(50),
--Address nvarchar(50),
--Content nvarchar(250),
--CreatedDate datetime default getdate(),
--Status bit not null default 1
--)

GO
/****** Object:  StoredProcedure [dbo].[uspDeletetblProduct]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[uspDeletetblProduct]
@ID bigint
as
begin
delete from tblProduct where ID=@ID
return 1
end

--end procedure tblProduct

GO
/****** Object:  StoredProcedure [dbo].[uspDeletetblSlide]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[uspDeletetblSlide]
@ID bigint
as
begin
delete from tblSlide where ID=@ID
return 1
end

--end procedure tblSlide
--go
--create table tblAds
--(
--ID int identity primary key,
--Image nvarchar(250),
--DisplayOrder int default 1,
--Link nvarchar(250),
--Description nvarchar(50),
--CreatedDate datetime default getdate(),
--Status bit not null default 1
--)
--go

--create table tblMenuType
--(
--ID int identity primary key,
--Name nvarchar(50)
--)
--go
--create table tblMenu
--(
--ID int identity primary key,
--Text nvarchar(50),
--Link nvarchar(250),
--DisplayOrder int ,
--Target nvarchar(50),
--Status bit not null default 1,
--TypeID int 
--)
--go
--create table tblFooter
--(
--ID varchar(50) primary key,
--Content ntext,
--Status bit not null default 1
--)
--go
--create table tblSystemConfig
--(
--ID varchar(50),
--Name nvarchar(50),
--Type varchar(50),
--Value nvarchar(250),
--Status bit not null default 1 
--)
--go
--create table tblOrderBy
--(
--ID bigint identity primary key,
--CreatedDate datetime default getdate(),
--CustomerID bigint,
--ShipName nvarchar(50),
--ShipMobile varchar(50),
--ShipAddress nvarchar(250),
--ShipEmail nvarchar(100),
--Status bit not null default 1
--)

GO
/****** Object:  StoredProcedure [dbo].[uspInserttblAccountAdmin]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--start procedure account admin

create procedure [dbo].[uspInserttblAccountAdmin]
@UserName nvarchar(100),
@Password varchar(500)
as
begin
set nocount on
declare @salt uniqueidentifier = newid()
begin try
insert into tblAccountAdmin(UserName,Password,Salt)
values(@UserName,HASHBYTES('SHA2_512',@Password+CAST(@salt as varchar(36))),@salt)
return 1
end try
begin catch
return -1
end catch
end


GO
/****** Object:  StoredProcedure [dbo].[uspInserttblAccountClient]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[uspInserttblAccountClient]
@RealName nvarchar(100) ,
@IDaccount varchar(300) ,
@UserName nvarchar(100) ,
@Password varchar(100),
@Email varchar(100)
as
begin
declare @salt uniqueidentifier = newid()
begin try
if exists(select top 1 ID from tblAccountClient where UserName=@UserName)
begin
return 2
end
else if exists(select top 1 ID from tblAccountClient where Email=@Email)
begin
return 3
end
else if not exists(select top 1 ID from tblAccountClient where IDaccount=@IDaccount) and (@IDaccount is not null)
begin
insert into tblAccountClient(RealName,IDaccount,Email)
values (@RealName,@IDaccount,@Email)
return 1
end
else if not exists(select top 1 ID from tblAccountClient where UserName=@UserName) and 
not exists(select top 1 ID from tblAccountClient where Email=@Email) and (@IDaccount is null)
begin
insert into tblAccountClient(RealName,UserName,Password,Email,Salt)
values (@RealName,@UserName,HASHBYTES('SHA2_512',@Password+CAST(@salt as varchar(36))),@Email,@salt)
return 1
end
else if exists(select top 1 ID from tblAccountClient where Email=@Email) and exists(select top 1 ID from tblAccountClient where UserName=@UserName)
begin
return -1
end
end try
begin catch
return -1
end catch
end

GO
/****** Object:  StoredProcedure [dbo].[uspInserttblCategory]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[uspInserttblCategory]
@Name nvarchar(250),
@MetaTitle nvarchar(250),
@ParentID bigint,
@DisplayOrder int,
@SeoTitle nvarchar(250)
as
begin
begin try
insert into tblCategory(Name,MetaTitle,ParentID,DisplayOrder,SeoTitle)
values (@Name,dbo.fuConvertToUnsign(@MetaTitle),@ParentID,@DisplayOrder,@SeoTitle)
return 1
end try
begin catch
return -1
end catch
end

GO
/****** Object:  StoredProcedure [dbo].[uspInserttblProduct]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[uspInserttblProduct]
@Name nvarchar(250),
@MetaTitle nvarchar(250),
@Description ntext,
@Images nvarchar(250),
@MoreImages xml,
@Price decimal(18,0),
@PromotionPrice decimal(18,0),
@Quantity int,
@CategoryID bigint,
@Detail ntext
as
begin
begin try
insert into tblProduct(Name,MetaTitle,Description,Images,MoreImages,Price,PromotionPrice,Quantity,CategoryID,Detail)
values (@Name,dbo.fuConvertToUnsign(@MetaTitle),@Description,@Images,@MoreImages,@Price,@PromotionPrice,@Quantity,@CategoryID,@Detail)
return 1
end try
begin catch
return -1
end catch
end

GO
/****** Object:  StoredProcedure [dbo].[uspInserttblSlide]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[uspInserttblSlide]
@Image nvarchar(250),
@Link nvarchar(250),
@Description nvarchar(50)
as
begin
begin try
insert into tblSlide(Image,Link,Description)
values (@Image,@Link,@Description)
return 1
end try
begin catch
return -1
end catch
end

GO
/****** Object:  StoredProcedure [dbo].[uspLoginAccountAdmin]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[uspLoginAccountAdmin]
@UserName nvarchar(100),
@Password varchar(500)
as
begin
set nocount on
declare @userID int
if exists(select top 1 ID from tblAccountAdmin where UserName=@UserName)
begin 
set @userID = (select ID from tblAccountAdmin where UserName=@UserName and Status=1 and Password=HASHBYTES('SHA2_512',@Password+CAST(Salt as varchar(36))))
if(@userID is null)
return -1
else
return 1
end
else
return -1
end

--end procedure account admin



GO
/****** Object:  StoredProcedure [dbo].[uspLoginAccountClient]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[uspLoginAccountClient]
@UserName nvarchar(100),
@Password varchar(500)
as
begin
set nocount on
declare @userID int
if exists(select top 1 ID from tblAccountClient where UserName=@UserName)
begin 
set @userID = (select ID from tblAccountClient where UserName=@UserName and Status=1 and Password=HASHBYTES('SHA2_512',@Password+CAST(Salt as varchar(36))))
if(@userID is null)
return -1
else
return 1
end
else
return -1
end
truncate table tblAccountClient

--end procedure tblAccountClient

GO
/****** Object:  StoredProcedure [dbo].[uspUpdatetblAccountAdmin]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[uspUpdatetblAccountAdmin]
@ID bigint,
@Password varchar(500),
@Note nvarchar(500),
@Status bit 
as
begin
set nocount on
begin try
update tblAccountAdmin set Password=HASHBYTES('SHA2_512',@Password+CAST(Salt as varchar(36))) ,
Note=@Note,Status=@Status
where ID = @ID
return 1
end try
begin catch
return -1
end catch
end

GO
/****** Object:  StoredProcedure [dbo].[uspUpdatetblAccountClient]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[uspUpdatetblAccountClient]
@ID bigint,
@Note nvarchar(500),
@Status bit
as
begin
begin try
update tblAccountClient set Note = @Note,Status=@Status where ID=@ID
return 1
end try
begin catch
return -1
end catch
end

GO
/****** Object:  StoredProcedure [dbo].[uspUpdatetblCategory]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[uspUpdatetblCategory]
@ID bigint,
@Name nvarchar(250),
@MetaTitle varchar(250),
@ParentID bigint,
@DisplayOrder int,
@SeoTitle nvarchar(250),
@Status bit
as
begin
begin try
update tblCategory set Name=@Name,MetaTitle=dbo.fuConvertToUnsign(@MetaTitle),ParentID=@ParentID,
DisplayOrder=@DisplayOrder,SeoTitle=@SeoTitle,Status=@Status where ID=@ID
return 1
end try
begin catch
return -1
end catch
end

GO
/****** Object:  StoredProcedure [dbo].[uspUpdatetblProduct]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[uspUpdatetblProduct]
@ID bigint,
@Name nvarchar(250),
@MetaTitle nvarchar(250),
@Description ntext,
@Images nvarchar(250),
@MoreImages xml,
@Price decimal(18,0),
@PromotionPrice decimal(18,0),
@Quantity int,
@CategoryID bigint,
@Detail ntext,
@Status bit 
as
begin
begin try
update tblProduct set Name=@Name,MetaTitle=@MetaTitle,Description=@Description
,Images=@Images,MoreImages=@MoreImages,Price=@Price,PromotionPrice=@PromotionPrice,
Quantity=@Quantity,CategoryID=@CategoryID,Detail=@Detail,Status=@Status where ID=@ID
return 1
end try
begin catch
return -1
end catch
end

GO
/****** Object:  StoredProcedure [dbo].[uspUpdatetblSlide]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[uspUpdatetblSlide]
@ID bigint,
@Image nvarchar(250),
@DisplayOrder int,
@Link nvarchar(250),
@Description nvarchar(50),
@Status bit
as
begin
begin try
update tblSlide set Image=@Image,DisplayOrder=@DisplayOrder,Link=@Link,Description=@Description,
Status=@Status where ID=@ID
return 1
end try
begin catch
return -1
end catch
end

GO
/****** Object:  StoredProcedure [dbo].[uspUpdateViewtblProduct]    Script Date: 27/10/2017 11:54:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[uspUpdateViewtblProduct]
@ID bigint,
@ViewCount int
as
begin
begin try
update tblProduct set ViewCount=@ViewCount where ID=@ID
return 1
end try
begin catch
return -1
end catch
end

GO
USE [master]
GO
ALTER DATABASE [StoreJavaDB] SET  READ_WRITE 
GO
