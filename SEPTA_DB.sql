USE [master]
GO
/****** Object:  Database [SEPTA]    Script Date: 2016-12-05 3:19:37 PM ******/
CREATE DATABASE [SEPTA]
 GO
ALTER DATABASE [SEPTA] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SEPTA].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SEPTA] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SEPTA] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SEPTA] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SEPTA] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SEPTA] SET ARITHABORT OFF 
GO
ALTER DATABASE [SEPTA] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SEPTA] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [SEPTA] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SEPTA] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SEPTA] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SEPTA] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SEPTA] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SEPTA] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SEPTA] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SEPTA] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SEPTA] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SEPTA] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SEPTA] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SEPTA] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SEPTA] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SEPTA] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SEPTA] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SEPTA] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SEPTA] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SEPTA] SET  MULTI_USER 
GO
ALTER DATABASE [SEPTA] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SEPTA] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SEPTA] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SEPTA] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [SEPTA]
GO
/****** Object:  User [da]    Script Date: 2016-12-05 3:19:37 PM ******/
CREATE USER [da] FOR LOGIN [da] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [da]
GO
/****** Object:  StoredProcedure [dbo].[Calculate_descriptive_stats]    Script Date: 2016-12-05 3:19:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Calculate_descriptive_stats] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT AVG(latetime * 1.0) AS MEAN FROM OTP_NoOutlier;

	SELECT STDEV(latetime * 1.0) AS STDEV FROM OTP_NoOutlier;

	SELECT COUNT(latetime) AS [COUNT] from OTP_NoOutlier;

	select latetime, frequency from
	(select latetime, count(latetime) frequency
	from dbo.otp_nooutlier
	group by latetime) f
	order by latetime asc 
END


GO
/****** Object:  StoredProcedure [dbo].[CalculateLineMean]    Script Date: 2016-12-05 3:19:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CalculateLineMean]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select avg(latetime), STDEV(latetime), min(latetime), max(latetime), count(*) from otp_nooutlier where next_station in
	(SELECT Station FROM [septa_stations] WHERE Line = 'Airport Line')

	select avg(latetime), STDEV(latetime), min(latetime), max(latetime), count(*) from otp_nooutlier where next_station in
	(SELECT Station FROM [septa_stations] WHERE Line = 'Chestnut Hill East Line')

	select avg(latetime), STDEV(latetime), min(latetime), max(latetime), count(*) from otp_nooutlier where next_station in
	(SELECT Station FROM [septa_stations] WHERE Line = 'Chestnut Hill West Line')

	select avg(latetime), STDEV(latetime), min(latetime), max(latetime), count(*) from otp_nooutlier where next_station in
	(SELECT Station FROM [septa_stations] WHERE Line = 'Cynwyd Line')

	select avg(latetime), STDEV(latetime), min(latetime), max(latetime), avg(latetime), STDEV(latetime),  count(*) from otp_nooutlier where next_station in
	(SELECT Station FROM [septa_stations] WHERE Line = 'Fox Chase Line')

	select avg(latetime), STDEV(latetime), min(latetime), max(latetime), count(*) from otp_nooutlier where next_station in
	(SELECT Station FROM [septa_stations] WHERE Line = 'Glenside Combined Line')

	select avg(latetime), STDEV(latetime), min(latetime), max(latetime), count(*) from otp_nooutlier where next_station in
	(SELECT Station FROM [septa_stations] WHERE Line = 'Lansdale Doylestown Line')

	select avg(latetime), STDEV(latetime), min(latetime), max(latetime), count(*) from otp_nooutlier where next_station in
	(SELECT Station FROM [septa_stations] WHERE Line = 'Center City to University City Line')

	select avg(latetime), STDEV(latetime), min(latetime), max(latetime),  count(*) from otp_nooutlier where next_station in
	(SELECT Station FROM [septa_stations] WHERE Line = 'Manayunk/Norristown Line')

	select avg(latetime), STDEV(latetime), min(latetime), max(latetime), count(*) from otp_nooutlier where next_station in
	(SELECT Station FROM [septa_stations] WHERE Line = 'Media/Elwyn Line')

	select avg(latetime), STDEV(latetime), min(latetime), max(latetime), count(*) from otp_nooutlier where next_station in
	(SELECT Station FROM [septa_stations] WHERE Line = 'Wilmington/Newark Line')

	select avg(latetime), STDEV(latetime), min(latetime), max(latetime), count(*) from otp_nooutlier where next_station in
	(SELECT Station FROM [septa_stations] WHERE Line = 'West Trenton Line')

	--
	select avg(latetime), STDEV(latetime),  min(latetime), max(latetime), count(*) from otp_nooutlier where next_station in
	(SELECT Station FROM [septa_stations] WHERE Line = 'Trenton Line')

	select avg(latetime), STDEV(latetime), min(latetime), max(latetime), count(*) from otp_nooutlier where next_station in
	(SELECT Station FROM [septa_stations] WHERE Line = 'Paoli/Thorndale Line')

	select avg(latetime), STDEV(latetime), min(latetime), max(latetime), count(*) from otp_nooutlier where next_station in
	(SELECT Station FROM [septa_stations] WHERE Line = 'Warminster Line')

	select avg(latetime), STDEV(latetime), min(latetime), max(latetime), count(*) from otp_nooutlier where next_station in
	(SELECT Station FROM [septa_stations] WHERE Line = 'Fern Rock to Center City')

END

GO
/****** Object:  StoredProcedure [dbo].[CalculateProbability]    Script Date: 2016-12-05 3:19:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CalculateProbability] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--	 probability for poisson distribution
	SELECT (POWER(3,0) * EXP(-3)) / 1
	SELECT (POWER(3,1) * EXP(-3)) / 1
	SELECT (POWER(3,2) * EXP(-3)) / 2
	SELECT (POWER(3,3) * EXP(-3)) / (2 * 3)
	SELECT (POWER(3,4) * EXP(-3)) / (2 * 3 * 4)
	SELECT (POWER(3,5) * EXP(-3)) / (2 * 3 * 4 * 5)
	SELECT (POWER(3,6) * EXP(-3)) / (2 * 3 * 4 * 5 * 6)

	declare @alltimes float
	declare @ontime int
	declare @late1 int
	declare @late2 int
	declare @late3 int
	declare @late4 int
	declare @late5 int
	declare @late6 int

	select @alltimes = count(latetime) from dbo.otp_nooutlier 
	select @ontime = count(latetime) from dbo.otp_nooutlier where latetime = 0
	select @late1 = count(latetime) from dbo.otp_nooutlier where latetime = 1
	select @late2 = count(latetime) from dbo.otp_nooutlier where latetime = 2
	select @late3 = count(latetime) from dbo.otp_nooutlier where latetime = 3
	select @late4 = count(latetime) from dbo.otp_nooutlier where latetime = 4
	select @late5 = count(latetime) from dbo.otp_nooutlier where latetime = 5
	select @late6 = count(latetime) from dbo.otp_nooutlier where latetime = 6

	declare @prob_ontime float
	declare @prob_late1 float
	declare @prob_late2 float
	declare @prob_late3 float
	declare @prob_late4 float
	declare @prob_late5 float
	declare @prob_late6 float

	select @prob_ontime = @ontime / @alltimes
	select @prob_late1 = @late1 / @alltimes
	select @prob_late2 = @late2 / @alltimes
	select @prob_late3 = @late3 / @alltimes
	select @prob_late4 = @late4 / @alltimes
	select @prob_late5 = @late5 / @alltimes
	select @prob_late6 = @late6 / @alltimes

	select @prob_ontime '0', @prob_late1 '1', @prob_late2 '2', @prob_late3 '3', @prob_late4, @prob_late5, @prob_late6, 
	1 - (@prob_ontime + @prob_late1 + @prob_late2 + @prob_late3 + @prob_late4 + @prob_late5  ), (@prob_ontime + @prob_late1 + @prob_late2 + @prob_late3 + @prob_late4 + @prob_late5 + @prob_late6 )





END

GO
/****** Object:  StoredProcedure [dbo].[GetMultiLineStations]    Script Date: 2016-12-05 3:19:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetMultiLineStations] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	select station, count(*) as freq from septa_stations
	group by station
	having count(*) > 2
	order by count(*) desc

END

GO
/****** Object:  UserDefinedFunction [dbo].[GetNthWord]    Script Date: 2016-12-05 3:19:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery1.sql|7|0|C:\Users\Jeff\AppData\Local\Temp\~vsA0D4.sql
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetNthWord] 
(
	-- Add the parameters for the function here
	@SourceText VARCHAR(8000),
	@NthWord int
)
RETURNS VARCHAR(8000)
AS
BEGIN
	DECLARE @CurrentWord VARCHAR(8000)
	DECLARE @CurrentWordNumber int
	DECLARE @InterimText VARCHAR(8000)
	SET @InterimText = @SourceText

	DECLARE @StartPosition int
	DECLARE @EndPosition int
	DECLARE @Length int
	DECLARE @Delimiter VARCHAR(1)
	SET @Delimiter = ' ';

	SET @StartPosition = 1
	SET @EndPosition = 1
	SET @Length = LEN(@InterimText)
	SET @CurrentWordNumber = 0
	WHILE @StartPosition <= @Length -- @EndPosition > 0  -- @Length > 0 --
	BEGIN
		SET @EndPosition = CHARINDEX(@Delimiter, SUBSTRING(@InterimText, @StartPosition, @Length))
		IF @EndPosition = 0
		BEGIN
			SET @EndPosition = @Length + 1
		END
		SET @CurrentWord = SUBSTRING(@InterimText, @StartPosition, @EndPosition - 1)
		SET @CurrentWordNumber = @CurrentWordNumber + 1
		IF @CurrentWordNumber = @NthWord
		BEGIN
			BREAK;
		END
		SET @StartPosition = @EndPosition + 1
	END
	RETURN @CurrentWord
END
GO
/****** Object:  UserDefinedFunction [dbo].[SplitWords]    Script Date: 2016-12-05 3:19:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[SplitWords](@text varchar(8000))
   RETURNS @words TABLE (
      pos smallint primary key,
      value varchar(8000)
   )
AS
BEGIN
   DECLARE
      @pos smallint,
      @i smallint,
      @j smallint,
      @s varchar(8000)

   SET @pos = 1
   WHILE @pos <= LEN(@text) 
   BEGIN 
      SET @i = CHARINDEX(' ', @text, @pos)
      SET @j = CHARINDEX(',', @text, @pos)
      IF @i > 0 OR @j > 0
      BEGIN
         IF @i = 0 OR (@j > 0 AND @j < @i)
            SET @i = @j

         IF @i > @pos
         BEGIN
            -- @i now holds the earliest delimiter in the string
            SET @s = SUBSTRING(@text, @pos, @i - @pos)

            INSERT INTO @words
            VALUES (@pos, @s)
         END 
         SET @pos = @i + 1

         WHILE @pos < LEN(@text) 
            AND SUBSTRING(@text, @pos, 1) IN (' ', ',')
            SET @pos = @pos + 1 
      END 
      ELSE 
      BEGIN 
         INSERT INTO @words 
         VALUES (@pos, SUBSTRING(@text, @pos, LEN(@text) - @pos + 1))

         SET @pos = LEN(@text) + 1 
      END 
   END 
   RETURN 
END

GO
/****** Object:  Table [dbo].[otp]    Script Date: 2016-12-05 3:19:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[otp](
	[train_id] [varchar](255) NULL,
	[direction] [varchar](255) NULL,
	[origin] [varchar](255) NULL,
	[next_station] [varchar](255) NULL,
	[date] [varchar](255) NULL,
	[status] [varchar](255) NULL,
	[timeStamp] [varchar](255) NULL,
	[latetime] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OTP_NoOutlier]    Script Date: 2016-12-05 3:19:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OTP_NoOutlier](
	[train_id] [varchar](255) NULL,
	[direction] [varchar](255) NULL,
	[origin] [varchar](255) NULL,
	[next_station] [varchar](255) NULL,
	[date] [varchar](255) NULL,
	[status] [varchar](255) NULL,
	[timeStamp] [varchar](255) NULL,
	[latetime] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[septa_lines]    Script Date: 2016-12-05 3:19:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[septa_lines](
	[Line] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[septa_stations]    Script Date: 2016-12-05 3:19:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[septa_stations](
	[Line] [varchar](50) NULL,
	[Station] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[trainView]    Script Date: 2016-12-05 3:19:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[trainView](
	[train_id] [varchar](255) NULL,
	[status] [varchar](255) NULL,
	[next_station] [varchar](255) NULL,
	[service] [varchar](255) NULL,
	[dest] [varchar](255) NULL,
	[lon] [varchar](255) NULL,
	[lat] [varchar](255) NULL,
	[source] [varchar](255) NULL,
	[track_change] [varchar](255) NULL,
	[track] [varchar](255) NULL,
	[date] [varchar](255) NULL,
	[timeStamp0] [varchar](255) NULL,
	[timeStamp1] [varchar](255) NULL,
	[seconds] [varchar](255) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
USE [master]
GO
ALTER DATABASE [SEPTA] SET  READ_WRITE 
GO
