USE [master]
GO
/****** Object:  Database [QuanLiPizzaHut]    Script Date: 5/17/2018 2:29:40 PM ******/
CREATE DATABASE [QuanLiPizzaHut]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLiPizzaHut', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\QuanLiPizzaHut.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QuanLiPizzaHut_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\QuanLiPizzaHut_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QuanLiPizzaHut] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLiPizzaHut].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLiPizzaHut] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLiPizzaHut] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLiPizzaHut] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLiPizzaHut] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLiPizzaHut] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLiPizzaHut] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QuanLiPizzaHut] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLiPizzaHut] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLiPizzaHut] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLiPizzaHut] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLiPizzaHut] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLiPizzaHut] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLiPizzaHut] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLiPizzaHut] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLiPizzaHut] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLiPizzaHut] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QuanLiPizzaHut] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLiPizzaHut] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLiPizzaHut] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLiPizzaHut] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLiPizzaHut] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLiPizzaHut] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLiPizzaHut] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLiPizzaHut] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QuanLiPizzaHut] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLiPizzaHut] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLiPizzaHut] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLiPizzaHut] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLiPizzaHut] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [QuanLiPizzaHut]
GO
/****** Object:  StoredProcedure [dbo].[AddUser]    Script Date: 5/17/2018 2:29:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddUser]
(
	@name nvarchar(128),
	@phone nchar(128),
	@birthday datetime,
	@username nvarchar(128),
	@password nvarchar(128),
	@role bit
)
as
begin
	insert into Users(DisplayName,Phone,Birthday,UserName,Password,Managers)values(@name,@phone,@birthday,@username,@password,@role)
end

GO
/****** Object:  StoredProcedure [dbo].[DeleteNhanVien]    Script Date: 5/17/2018 2:29:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[DeleteNhanVien]
@id varchar(128)
as
begin
	Delete from Users where ID=@id
end

GO
/****** Object:  StoredProcedure [dbo].[EditUser]    Script Date: 5/17/2018 2:29:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[EditUser]
(
	@id int,
	@name nvarchar(128),
	@phone nchar(128),
	@birthday datetime
)
as
begin
	update Users set DisplayName=@name, Phone=@phone, Birthday=@birthday where ID=@id
end

GO
/****** Object:  StoredProcedure [dbo].[Search_NhanVien]    Script Date: 5/17/2018 2:29:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Search_NhanVien]
(
	@ten nvarchar(128)
)
as
begin
	select ID,DisplayName,Phone,Birthday
	from Users
	where Users.DisplayName is null or dbo.fuConvertToUnsign1(Users.DisplayName) like '%'+@ten+'%' or Users.DisplayName like '%'+@ten+'%'
end

GO
/****** Object:  UserDefinedFunction [dbo].[fuConvertToUnsign1]    Script Date: 5/17/2018 2:29:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fuConvertToUnsign1] ( @strInput NVARCHAR(4000) ) RETURNS NVARCHAR(4000) AS BEGIN IF @strInput IS NULL RETURN @strInput IF @strInput = '' RETURN @strInput DECLARE @RT NVARCHAR(4000) DECLARE @SIGN_CHARS NCHAR(136) DECLARE @UNSIGN_CHARS NCHAR (136) SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' DECLARE @COUNTER int DECLARE @COUNTER1 int SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput)) BEGIN SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END
GO
/****** Object:  Table [dbo].[Combo]    Script Date: 5/17/2018 2:29:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Combo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DisplayName] [nvarchar](128) NOT NULL,
	[Price] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ComboDetail]    Script Date: 5/17/2018 2:29:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ComboDetail](
	[STT] [int] IDENTITY(1,1) NOT NULL,
	[IDItems] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[ID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[STT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DBCustomer]    Script Date: 5/17/2018 2:29:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DBCustomer](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Address] [nvarchar](max) NULL,
	[Phone] [nvarchar](20) NULL,
	[Birthday] [datetime] NULL,
	[NumberOfOrders] [int] NOT NULL,
 CONSTRAINT [PK__Customer__3214EC27E1903FAD] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DBUnit]    Script Date: 5/17/2018 2:29:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DBUnit](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DisplayName] [nvarchar](max) NULL,
 CONSTRAINT [PK__Unit__3214EC271E58FCE2] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Items]    Script Date: 5/17/2018 2:29:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Items](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DisplayName] [nvarchar](128) NULL,
	[IDUnit] [int] NOT NULL,
	[Price] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 5/17/2018 2:29:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[STT] [int] IDENTITY(1,1) NOT NULL,
	[ID] [int] NOT NULL,
	[IDItems] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[STT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderDetailCombo]    Script Date: 5/17/2018 2:29:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetailCombo](
	[STT] [int] IDENTITY(1,1) NOT NULL,
	[ID] [int] NOT NULL,
	[IDCombo] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[STT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orders]    Script Date: 5/17/2018 2:29:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[Total_Amount] [money] NULL,
	[IDCustomer] [int] NOT NULL,
	[Address] [nvarchar](128) NOT NULL,
	[IDPromotions] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Promotions]    Script Date: 5/17/2018 2:29:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Promotions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[Discount] [float] NOT NULL,
	[DisplayName] [nvarchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 5/17/2018 2:29:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DisplayName] [nvarchar](128) NOT NULL,
	[Phone] [nvarchar](128) NOT NULL,
	[Birthday] [datetime] NOT NULL,
	[UserName] [nvarchar](128) NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[Managers] [bit] NOT NULL,
 CONSTRAINT [PK__Users__3214EC27A362DF1A] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([ID], [DisplayName], [Phone], [Birthday], [UserName], [Password], [Managers]) VALUES (4, N'Văn Tuyến', N'0123456789', CAST(0x00008CF500000000 AS DateTime), N'admin', N'db69fc039dcbd2962cb4d28f5891aae1', 1)
INSERT [dbo].[Users] ([ID], [DisplayName], [Phone], [Birthday], [UserName], [Password], [Managers]) VALUES (5, N'Công Khải', N'0123456789', CAST(0x00008BD200000000 AS DateTime), N'admin2', N'1', 1)
INSERT [dbo].[Users] ([ID], [DisplayName], [Phone], [Birthday], [UserName], [Password], [Managers]) VALUES (6, N'Đức Anh', N'0123456789', CAST(0x00008BD200000000 AS DateTime), N'admin3', N'1', 1)
INSERT [dbo].[Users] ([ID], [DisplayName], [Phone], [Birthday], [UserName], [Password], [Managers]) VALUES (7, N'staff', N'0123456789', CAST(0x00008BD200000000 AS DateTime), N'staff', N'978aae9bb6bee8fb75de3e4830a1be46', 0)
INSERT [dbo].[Users] ([ID], [DisplayName], [Phone], [Birthday], [UserName], [Password], [Managers]) VALUES (8, N'nhân viên 2', N'0123456789     ', CAST(0x00008BD200000000 AS DateTime), N'staff2', N'1', 0)
INSERT [dbo].[Users] ([ID], [DisplayName], [Phone], [Birthday], [UserName], [Password], [Managers]) VALUES (11, N'nhân viên 5', N'0123456789                                                                                                                      ', CAST(0x00008BD200000000 AS DateTime), N'staff5', N'26d1c6e522213cbf140e6508bbfb7d20', 0)
INSERT [dbo].[Users] ([ID], [DisplayName], [Phone], [Birthday], [UserName], [Password], [Managers]) VALUES (12, N'nhân viên 6', N'0123456789                                                                                                                      ', CAST(0x00008BD200000000 AS DateTime), N'staff6', N'978aae9bb6bee8fb75de3e4830a1be46', 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
ALTER TABLE [dbo].[ComboDetail]  WITH CHECK ADD FOREIGN KEY([IDItems])
REFERENCES [dbo].[Items] ([ID])
GO
ALTER TABLE [dbo].[ComboDetail]  WITH CHECK ADD FOREIGN KEY([ID])
REFERENCES [dbo].[Combo] ([ID])
GO
ALTER TABLE [dbo].[Items]  WITH CHECK ADD  CONSTRAINT [FK__Items__Price__1273C1CD] FOREIGN KEY([IDUnit])
REFERENCES [dbo].[DBUnit] ([ID])
GO
ALTER TABLE [dbo].[Items] CHECK CONSTRAINT [FK__Items__Price__1273C1CD]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD FOREIGN KEY([IDItems])
REFERENCES [dbo].[Items] ([ID])
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD FOREIGN KEY([ID])
REFERENCES [dbo].[Orders] ([ID])
GO
ALTER TABLE [dbo].[OrderDetailCombo]  WITH CHECK ADD FOREIGN KEY([IDCombo])
REFERENCES [dbo].[Combo] ([ID])
GO
ALTER TABLE [dbo].[OrderDetailCombo]  WITH CHECK ADD FOREIGN KEY([ID])
REFERENCES [dbo].[Orders] ([ID])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK__Orders__IDCustom__1B0907CE] FOREIGN KEY([IDCustomer])
REFERENCES [dbo].[DBCustomer] ([ID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK__Orders__IDCustom__1B0907CE]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([IDPromotions])
REFERENCES [dbo].[Promotions] ([ID])
GO
USE [master]
GO
ALTER DATABASE [QuanLiPizzaHut] SET  READ_WRITE 
GO
