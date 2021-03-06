USE [kqgl]
GO
/****** Object:  StoredProcedure [dbo].[pro_cal_zbdays]    Script Date: 2018-07-05 15:17:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE procedure [dbo].[pro_cal_zbdays]    
   	@year varchar(10)=null,  
    @month varchar(10)=null,
	@type int=0  --0:按月份统计，1：按年份统计  
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	-- 判断要创建的表名是否存在 
	if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[temp_zbdays]') and OBJECTPROPERTY(id, N'IsUserTable') = 1) 
		drop table temp_zbdays
	create table temp_zbdays(rowcounts int null,rq varchar(20) null,ygbm varchar(10) null,deptcode varchar(10) null)

	if @type=0
	begin
		insert into temp_zbdays select count(ygbm) as rowcounts,rq,ygbm,deptcode from(
			select SUBSTRING(rq,1,7) as rq,ygbm,deptcode from daylist where SUBSTRING(rq,1,4)=@year and SUBSTRING(rq,6,2)=@month) as t1
		group by rq,ygbm,deptcode
	end
	else if @type=1
	begin
		insert into temp_zbdays select count(ygbm) as rowcounts,rq,ygbm,deptcode from(
			select SUBSTRING(rq,1,4) as rq,ygbm,deptcode from daylist where SUBSTRING(rq,1,4)=@year) as t2
		group by rq,ygbm,deptcode
	end
END


GO
/****** Object:  Table [dbo].[daylist]    Script Date: 2018-07-05 15:17:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[daylist](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[rq] [varchar](10) NULL,
	[week] [char](10) NULL,
	[ygbm] [char](6) NULL,
	[ifmodify] [bit] NULL,
	[deptcode] [char](10) NULL,
	[xxygbm] [char](6) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[department]    Script Date: 2018-07-05 15:17:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[department](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[deptcode] [varchar](10) NULL,
	[deptname] [varchar](50) NULL,
	[depttype] [varchar](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[kqdj]    Script Date: 2018-07-05 15:17:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[kqdj](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ygbm] [char](6) NOT NULL,
	[type] [char](2) NULL,
	[deptcode] [char](10) NULL,
	[djdate] [varchar](10) NULL,
	[startdate] [varchar](10) NULL,
	[stopdate] [varchar](10) NULL,
	[starttime] [varchar](5) NULL,
	[stoptime] [varchar](5) NULL,
	[memo] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ryxx]    Script Date: 2018-07-05 15:17:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ryxx](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[code] [varchar](6) NOT NULL,
	[name] [varchar](10) NULL,
	[deptcode] [varchar](30) NULL,
	[xh] [int] NULL,
	[ifpb] [bit] NULL,
	[workdate] [varchar](20) NULL,
	[birthday] [varchar](20) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[temp_zbdays]    Script Date: 2018-07-05 15:17:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[temp_zbdays](
	[rowcounts] [int] NULL,
	[rq] [varchar](20) NULL,
	[ygbm] [varchar](10) NULL,
	[deptcode] [varchar](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[type]    Script Date: 2018-07-05 15:17:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[type](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[typecode] [varchar](2) NULL,
	[typename] [varchar](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[calculate_gxday]    Script Date: 2018-07-05 15:17:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Object:  Table [dbo].[daylist]    Script Date: 2018-07-04 10:28:27 ******/
--drop view calculate_gxday

CREATE view [dbo].[calculate_gxday]
as 
--计算公休天数 1-10:5天，10-20:10天，20以上：15天 
select code,(case when gxdays>=1 and gxdays <10 then 5 when gxdays>=10 and gxdays<20 then 10 when gxdays>=20 then 15 else 0 end) gxdays  
from(select code,datediff(year,convert(datetime,workdate),getdate()) as gxdays from ryxx) as t


GO
/****** Object:  View [dbo].[view_kqdj]    Script Date: 2018-07-05 15:17:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_kqdj]
AS
SELECT   dbo.kqdj.id, dbo.kqdj.ygbm, dbo.ryxx.name, dbo.kqdj.type, dbo.type.typename, dbo.kqdj.startdate, dbo.kqdj.starttime, 
                dbo.kqdj.stopdate, dbo.kqdj.stoptime, dbo.kqdj.djdate, dbo.kqdj.deptcode,dbo.department.deptname, dbo.kqdj.memo
FROM      dbo.kqdj LEFT OUTER JOIN
                dbo.type ON dbo.kqdj.type = dbo.type.typecode LEFT OUTER JOIN
                dbo.ryxx ON dbo.kqdj.ygbm = dbo.ryxx.code LEFT OUTER JOIN
				dbo.department on dbo.kqdj.deptcode=dbo.department.deptcode



GO
/****** Object:  View [dbo].[view_kqhours]    Script Date: 2018-07-05 15:17:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_kqhours]
AS
SELECT   b.deptcode, b.ygbm, dbo.ryxx.name, b.type, dbo.type.typename, b.djdate, b.startdate, b.starttime, b.stopdate, b.stoptime, 
                b.hours, ROUND(b.days, 1) AS days
FROM      (SELECT   ygbm, type, deptcode, djdate, startdate, starttime, stopdate, stoptime, hours, case when hours%24>1 and hours%24<6 then hours/24+0.5 when hours%24>=6 and hours%24<24 then hours/24+1.0 else hours/24 end AS days
                 FROM      (SELECT   ygbm, type, deptcode, djdate, startdate, starttime, stopdate, stoptime, (DATEDIFF(HOUR, startdate + ' ' + starttime, stopdate + ' ' + stoptime)) AS hours
                                  FROM      dbo.kqdj) AS a) AS b LEFT OUTER JOIN
                dbo.type ON b.type = dbo.type.typecode LEFT OUTER JOIN
                dbo.ryxx ON b.ygbm = dbo.ryxx.code



GO
/****** Object:  View [dbo].[view_pbxx]    Script Date: 2018-07-05 15:17:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_pbxx]
AS
SELECT   dbo.daylist.id, dbo.daylist.rq, 
                CASE dbo.daylist.deptcode WHEN '0' THEN '(新阳)计算机网络中心' WHEN '1' THEN '(厢竹)计算机网络中心' END AS deptname,
                 dbo.daylist.ifmodify, dbo.daylist.ygbm, dbo.ryxx.name, dbo.daylist.week, 
                CASE dbo.daylist.week WHEN '1' THEN '星期日' WHEN '2' THEN '星期一' WHEN '3' THEN '星期二' WHEN '4' THEN '星期三'
                 WHEN '5' THEN '星期四' WHEN '6' THEN '星期五' WHEN '7' THEN '星期六' END AS weekname, dbo.ryxx.xh, 
                dbo.daylist.deptcode
FROM      dbo.daylist LEFT OUTER JOIN
                dbo.ryxx ON dbo.daylist.ygbm = dbo.ryxx.code

GO
/****** Object:  View [dbo].[view_zbcstj]    Script Date: 2018-07-05 15:17:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[view_zbcstj]
AS
SELECT a.deptcode, a.rq, a.ygbm, b.name, a.rowcounts as zbcs
FROM temp_zbdays a LEFT OUTER JOIN
      dbo.ryxx b ON a.ygbm = b.code

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[16] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "kqdj"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 146
               Right = 183
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "type"
            Begin Extent = 
               Top = 6
               Left = 221
               Bottom = 127
               Right = 367
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ryxx"
            Begin Extent = 
               Top = 132
               Left = 221
               Bottom = 272
               Right = 366
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 14
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_kqdj'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_kqdj'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[20] 2[18] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "b"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 265
               Right = 180
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "type"
            Begin Extent = 
               Top = 0
               Left = 383
               Bottom = 121
               Right = 529
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ryxx"
            Begin Extent = 
               Top = 171
               Left = 541
               Bottom = 311
               Right = 686
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 13
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2025
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_kqhours'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_kqhours'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "daylist"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 146
               Right = 183
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "ryxx"
            Begin Extent = 
               Top = 6
               Left = 221
               Bottom = 146
               Right = 366
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 11
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_pbxx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_pbxx'
GO
