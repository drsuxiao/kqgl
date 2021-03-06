USE [mydata]
GO
/****** Object:  Table [dbo].[daylist]    Script Date: 2017-10-12 17:47:08 ******/
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
/****** Object:  Table [dbo].[kqdj]    Script Date: 2017-10-12 17:47:08 ******/
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
/****** Object:  Table [dbo].[ryxx]    Script Date: 2017-10-12 17:47:08 ******/
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
	[ifpb] [bit] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[type]    Script Date: 2017-10-12 17:47:08 ******/
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
/****** Object:  View [dbo].[view_kqdj]    Script Date: 2017-10-12 17:47:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_kqdj]
AS
SELECT   dbo.kqdj.id, dbo.kqdj.ygbm, dbo.kqdj.type, dbo.type.typename, dbo.ryxx.name, dbo.kqdj.startdate, dbo.kqdj.starttime, 
                dbo.kqdj.stopdate, dbo.kqdj.stoptime, dbo.kqdj.djdate, dbo.kqdj.deptcode, dbo.kqdj.memo
FROM      dbo.kqdj LEFT OUTER JOIN
                dbo.type ON dbo.kqdj.type = dbo.type.typecode LEFT OUTER JOIN
                dbo.ryxx ON dbo.kqdj.ygbm = dbo.ryxx.code

GO
/****** Object:  View [dbo].[view_kqhours]    Script Date: 2017-10-12 17:47:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_kqhours]
AS
SELECT   b.deptcode, b.ygbm, dbo.ryxx.name, b.type, dbo.type.typename, b.djdate, b.startdate, b.starttime, b.stopdate, b.stoptime, 
                b.hours, ROUND(b.days, 1) AS days
FROM      (SELECT   ygbm, type, deptcode, djdate, startdate, starttime, stopdate, stoptime, hours, CASE WHEN hours > 1 AND 
                                 hours < 5 THEN 0.5 WHEN hours >= 5 AND 
                                 hours < 24 THEN 1.0 WHEN hours >= 24 THEN hours / 24 + (CASE WHEN (hours % 24) 
                                 = 0 THEN 0.0 WHEN (hours % 24) > 1 AND (hours % 24) < 5 THEN 0.5 WHEN (hours % 24) >= 5 AND 
                                 (hours % 24) < 24 THEN 1.0 END) END AS days
                 FROM      (SELECT   ygbm, type, deptcode, djdate, startdate, starttime, stopdate, stoptime, (CONVERT(int, 
                                                  DATEDIFF(Minute, startdate + ' ' + starttime, stopdate + ' ' + stoptime)) + 1) / 60 AS hours
                                  FROM      dbo.kqdj) AS a) AS b LEFT OUTER JOIN
                dbo.type ON b.type = dbo.type.typecode LEFT OUTER JOIN
                dbo.ryxx ON b.ygbm = dbo.ryxx.code

GO
/****** Object:  View [dbo].[view_kqtj]    Script Date: 2017-10-12 17:47:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_kqtj]
AS
SELECT d.deptcode, d.rq, d.ygbm, dbo.ryxx.name, CASE WHEN substring(d.rq, 6, 5) 
      IN ('01-01', '01-02', '01-27', '01-28', '01-29', '01-30', '01-31', '02-01', '02-02', '04-02', 
      '04-03', '04-04', '04-29', '04-30', '05-01', '05-28', '05-29', '05-30', '10-01', '10-02', 
      '10-03', '10-04', '10-05', '10-06', '10-07', '10-08') 
      THEN '节假日' ELSE '' END AS holiday, 
      CASE WHEN d.week = '1' THEN '星期日' WHEN d.week = '7' THEN '星期六' ELSE '' END
       AS ifweek, d.xxygbm
FROM dbo.daylist d LEFT OUTER JOIN
      dbo.ryxx ON d.ygbm = dbo.ryxx.code


GO
/****** Object:  View [dbo].[view_pbxx]    Script Date: 2017-10-12 17:47:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_pbxx]
AS
SELECT dbo.daylist.id, dbo.daylist.rq, dbo.ryxx.deptcode, 
      CASE dbo.ryxx.deptcode WHEN '0' THEN '(新阳)计算机网络中心' WHEN '1' THEN '(厢竹)计算机网络中心'
       END AS deptname, dbo.daylist.ifmodify, dbo.daylist.ygbm, dbo.ryxx.name, 
      dbo.daylist.week, 
      CASE dbo.daylist.week WHEN '1' THEN '星期日' WHEN '2' THEN '星期一' WHEN '3' THEN
       '星期二' WHEN '4' THEN '星期三' WHEN '5' THEN '星期四' WHEN '6' THEN '星期五' WHEN
       '7' THEN '星期六' END AS weekname, dbo.ryxx.xh
FROM dbo.daylist LEFT OUTER JOIN
      dbo.ryxx ON dbo.daylist.ygbm = dbo.ryxx.code


GO
/****** Object:  View [dbo].[view_zbcstj]    Script Date: 2017-10-12 17:47:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_zbcstj]
AS
SELECT a.deptcode, a.rq, a.ygbm, b.name, a.zbcs
FROM (SELECT deptcode, rq, ygbm, COUNT(ygbm) AS zbcs
        FROM (SELECT substring(rq, 1, 7) rq, ygbm, deptcode
                FROM daylist) AS a
        GROUP BY deptcode, rq, ygbm) a LEFT OUTER JOIN
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
