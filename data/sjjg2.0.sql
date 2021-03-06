USE [kqgl]
GO
/****** Object:  StoredProcedure [dbo].[pro_cal_zbdays]    Script Date: 2018-07-10 11:20:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- AUTHOR:		<SUXIAO>
-- CREATE DATE: <2018-07-04>
-- DESCRIPTION:	<根据排班表统计值班次数>
-- =============================================
CREATE PROCEDURE [dbo].[pro_cal_zbdays]    
   	@YEAR VARCHAR(10)=NULL,  
    @MONTH VARCHAR(10)=NULL,
	@TYPE INT=0  --0:按月份统计，1：按年份统计  
AS
BEGIN
	-- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
	-- INTERFERING WITH SELECT STATEMENTS.
	SET NOCOUNT ON;

    -- INSERT STATEMENTS FOR PROCEDURE HERE
	-- 判断要创建的表名是否存在 
	IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[TEMP_ZBDAYS]') AND OBJECTPROPERTY(ID, N'ISUSERTABLE') = 1) 
		DROP TABLE TEMP_ZBDAYS
	--创建保存值班次数的临时表
	CREATE TABLE TEMP_ZBDAYS(ROWCOUNTS INT NULL,RQ VARCHAR(20) NULL,YGBM VARCHAR(10) NULL,DEPTCODE VARCHAR(10) NULL)

	IF @TYPE=0   --按月份统计
	BEGIN
		INSERT INTO TEMP_ZBDAYS SELECT COUNT(YGBM) AS ROWCOUNTS,RQ,YGBM,DEPTCODE FROM(
			SELECT SUBSTRING(RQ,1,7) AS RQ,YGBM,DEPTCODE FROM DAYLIST WHERE SUBSTRING(RQ,1,4)=@YEAR AND SUBSTRING(RQ,6,2)=@MONTH) AS T1
		GROUP BY RQ,YGBM,DEPTCODE
	END
	ELSE IF @TYPE=1  --按年份统计
	BEGIN
		INSERT INTO TEMP_ZBDAYS SELECT COUNT(YGBM) AS ROWCOUNTS,RQ,YGBM,DEPTCODE FROM(
			SELECT SUBSTRING(RQ,1,4) AS RQ,YGBM,DEPTCODE FROM DAYLIST WHERE SUBSTRING(RQ,1,4)=@YEAR) AS T2
		GROUP BY RQ,YGBM,DEPTCODE
	END
END



GO
/****** Object:  StoredProcedure [dbo].[pro_create_schedule]    Script Date: 2018-07-10 11:20:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- AUTHOR:		<SUXIAO>
-- CREATE DATE: <2018-07-05>
-- DESCRIPTION:	<根据科员的排班顺序，时间范围生成排班表>
-- =============================================
CREATE PROCEDURE [dbo].[pro_create_schedule] 
	-- ADD THE PARAMETERS FOR THE STORED PROCEDURE HERE
	@STARTDATE VARCHAR(20),--开始日期
	@ENDDATE VARCHAR(20),  --结束日期
	@FIRSTNO VARCHAR(10),  --首位排班编号（序号）
	@DEPTCODE VARCHAR(10)  --部门编号
AS
BEGIN
	-- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
	-- INTERFERING WITH SELECT STATEMENTS.
	SET NOCOUNT ON;

    -- INSERT STATEMENTS FOR PROCEDURE HERE
	--定义变量
	DECLARE @SQNO INT,	
			@DATECOUNT INT,
			@PCOUNT INT,
			@TCOUNT INT,
			@CODE VARCHAR(10),
			@PCODE VARCHAR(10),
			@TCODE VARCHAR(10),
			@DATE VARCHAR(20),
			@WEEK CHAR(10),
			@DATETIME DATETIME
	DECLARE @I INT=1,@N INT=0
	--设置变量值
	SELECT @SQNO=SQNO FROM XH WHERE CODE=@FIRSTNO AND DEPTCODE=@DEPTCODE
	SELECT @TCOUNT=COUNT(1) FROM XH WHERE DEPTCODE=@DEPTCODE
	SELECT @PCOUNT=COUNT(1) FROM XH WHERE DEPTCODE=@DEPTCODE AND SQNO>=@SQNO
	--排班的前提是：XH表必须要有对应的记录
	IF @PCOUNT>0 AND @TCOUNT>0
	BEGIN
		--定义游标
		DECLARE CUR_TLIST CURSOR SCROLL FOR  --SCROLL游标才能指定任意行，默认游标只能向前
		SELECT CODE FROM XH WHERE DEPTCODE=@DEPTCODE ORDER BY SQNO ASC
		DECLARE CUR_PLIST CURSOR SCROLL FOR 
		SELECT CODE FROM XH WHERE DEPTCODE=@DEPTCODE AND SQNO>=@SQNO ORDER BY SQNO ASC
		--打开游标
		OPEN CUR_TLIST
		OPEN CUR_PLIST
		--计算两日期间的天数
		SET @DATECOUNT=DATEDIFF(DAY,@STARTDATE,@ENDDATE)+1
		--获取开始日期
		SET @DATETIME=CONVERT(DATETIME,@STARTDATE)
		--设置1为星期一
		SET DATEFIRST 1 

		--获取游标的第一个数并存到@PCODE
		FETCH FIRST FROM CUR_PLIST INTO @PCODE
		--循环获取游标值一次：处理排班序号随意开始的情况
		WHILE @I<=@DATECOUNT AND @I<=@PCOUNT AND @@FETCH_STATUS=0
		BEGIN
			SET @DATE=CONVERT(VARCHAR(20),@DATETIME,23) --转换后的格式：2018-07-06
			SELECT @WEEK=CONVERT(CHAR(10),DATEPART(WEEKDAY, @DATETIME)) --获取日期所在星期的星期数
			SET @CODE=@PCODE  --工资编号
			--保存记录前检测是否有重复日期的记录:有则删除后新增
			SELECT @N=COUNT(1) FROM DAYLIST WHERE RQ=@DATE AND DEPTCODE=@DEPTCODE
			IF @N>0 
				DELETE FROM DAYLIST WHERE RQ=@DATE AND DEPTCODE=@DEPTCODE
			--保存记录到排班表			
			INSERT INTO DAYLIST(RQ,YGBM,DEPTCODE,WEEK,IFMODIFY,XXYGBM) VALUES(@DATE,@CODE,@DEPTCODE,@WEEK,0,'')
			--循环增量控制
			SET @I=@I+1
			FETCH NEXT FROM CUR_PLIST INTO @PCODE
			SET @DATETIME=DATEADD(DAY,1,@DATETIME)
		END
		--关闭游标
		CLOSE CUR_PLIST
		DEALLOCATE CUR_PLIST

		--循环获取游标值多次：处理排班序号从1开始的情况
		FETCH FIRST FROM CUR_TLIST INTO @TCODE
		WHILE @I<=@DATECOUNT AND @I>@PCOUNT AND @@FETCH_STATUS=0
		BEGIN
			SET @DATE=CONVERT(VARCHAR(20),@DATETIME,23) --2018-07-06
			SELECT @WEEK=CONVERT(CHAR(10),DATEPART(WEEKDAY, @DATETIME))
			SET @CODE=@TCODE
			--保存记录前检测是否有重复日期的记录:有则删除后新增
			SELECT @N=COUNT(1) FROM DAYLIST WHERE RQ=@DATE AND DEPTCODE=@DEPTCODE
			IF @N>0 
				DELETE FROM DAYLIST WHERE RQ=@DATE AND DEPTCODE=@DEPTCODE
			INSERT INTO DAYLIST(RQ,YGBM,DEPTCODE,WEEK,IFMODIFY,XXYGBM) VALUES(@DATE,@CODE,@DEPTCODE,@WEEK,0,'')

			SET @I=@I+1 --自增量
			SET @DATETIME=DATEADD(DAY,1,@DATETIME) --下一个日期
			FETCH NEXT FROM CUR_TLIST INTO @TCODE
			IF @@FETCH_STATUS<>0    --循环读取游标的记录
				FETCH FIRST FROM CUR_TLIST INTO @TCODE			
		END	
		--释放游标
		CLOSE CUR_TLIST				
		DEALLOCATE CUR_TLIST 
	END
END

GO
/****** Object:  Table [dbo].[daylist]    Script Date: 2018-07-10 11:20:03 ******/
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
/****** Object:  Table [dbo].[department]    Script Date: 2018-07-10 11:20:03 ******/
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
/****** Object:  Table [dbo].[employee]    Script Date: 2018-07-10 11:20:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[employee](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[code] [varchar](6) NOT NULL,
	[name] [varchar](10) NULL,
	[deptcode] [varchar](30) NULL,
	[workdate] [varchar](20) NULL,
	[birthday] [varchar](20) NULL,
	[sex] [char](2) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[kqdj]    Script Date: 2018-07-10 11:20:03 ******/
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
/****** Object:  Table [dbo].[TEMP_ZBDAYS]    Script Date: 2018-07-10 11:20:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TEMP_ZBDAYS](
	[ROWCOUNTS] [int] NULL,
	[RQ] [varchar](20) NULL,
	[YGBM] [varchar](10) NULL,
	[DEPTCODE] [varchar](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[type]    Script Date: 2018-07-10 11:20:03 ******/
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
/****** Object:  Table [dbo].[xh]    Script Date: 2018-07-10 11:20:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[xh](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[code] [varchar](10) NULL,
	[deptcode] [varchar](10) NULL,
	[sqno] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[calculate_gxday]    Script Date: 2018-07-10 11:20:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/****** OBJECT:  TABLE [DBO].[DAYLIST]    SCRIPT DATE: 2018-07-04 10:28:27 ******/
--DROP VIEW CALCULATE_GXDAY

CREATE VIEW [dbo].[calculate_gxday]
AS 
--计算公休天数 1-10:5天，10-20:10天，20以上：15天 
SELECT CODE,(CASE WHEN GXDAYS>=1 AND GXDAYS <10 THEN 5 WHEN GXDAYS>=10 AND GXDAYS<20 THEN 10 WHEN GXDAYS>=20 THEN 15 ELSE 0 END) GXDAYS  
FROM(SELECT CODE,DATEDIFF(YEAR,CONVERT(DATETIME,WORKDATE),GETDATE()) AS GXDAYS FROM EMPLOYEE) AS T




GO
/****** Object:  View [dbo].[view_kqdj]    Script Date: 2018-07-10 11:20:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[view_kqdj]
AS
SELECT   dbo.kqdj.id, dbo.kqdj.ygbm, dbo.employee.name, dbo.kqdj.type, dbo.type.typename, dbo.kqdj.startdate, dbo.kqdj.starttime, 
                dbo.kqdj.stopdate, dbo.kqdj.stoptime, dbo.kqdj.djdate, dbo.kqdj.deptcode,dbo.department.deptname, dbo.kqdj.memo
FROM      dbo.kqdj LEFT OUTER JOIN
                dbo.type ON dbo.kqdj.type = dbo.type.typecode LEFT OUTER JOIN
                dbo.employee ON dbo.kqdj.ygbm = dbo.employee.code LEFT OUTER JOIN
				dbo.department on dbo.kqdj.deptcode=dbo.department.deptcode





GO
/****** Object:  View [dbo].[view_kqhours]    Script Date: 2018-07-10 11:20:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[view_kqhours]
AS
SELECT   b.deptcode, b.ygbm, dbo.employee.name, b.type, dbo.type.typename, b.djdate, b.startdate, b.starttime, b.stopdate, b.stoptime, 
                b.hours, ROUND(b.days, 1) AS days
FROM      (SELECT   ygbm, type, deptcode, djdate, startdate, starttime, stopdate, stoptime, hours, case when hours%24>1 and hours%24<6 then hours/24+0.5 when hours%24>=6 and hours%24<24 then hours/24+1.0 else hours/24 end AS days
                 FROM      (SELECT   ygbm, type, deptcode, djdate, startdate, starttime, stopdate, stoptime, (DATEDIFF(HOUR, startdate + ' ' + starttime, stopdate + ' ' + stoptime)) AS hours
                                  FROM      dbo.kqdj) AS a) AS b LEFT OUTER JOIN
                dbo.type ON b.type = dbo.type.typecode LEFT OUTER JOIN
                dbo.employee ON b.ygbm = dbo.employee.code





GO
/****** Object:  View [dbo].[view_pbxx]    Script Date: 2018-07-10 11:20:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_pbxx]
AS
SELECT dbo.daylist.id, dbo.daylist.rq,dbo.daylist.deptcode,dbo.department.deptname,dbo.daylist.ifmodify, dbo.daylist.ygbm, dbo.employee.name, dbo.daylist.week, 
                CASE dbo.daylist.week WHEN '7' THEN '星期日' WHEN '1' THEN '星期一' WHEN '2' THEN '星期二' WHEN '3' THEN '星期三'
                 WHEN '4' THEN '星期四' WHEN '5' THEN '星期五' WHEN '6' THEN '星期六' END AS weekname
FROM  dbo.daylist LEFT OUTER JOIN
                dbo.department ON dbo.daylist.deptcode = dbo.department.deptcode
				left outer join dbo.employee on dbo.daylist.ygbm=dbo.employee.code 




GO
/****** Object:  View [dbo].[view_zbcstj]    Script Date: 2018-07-10 11:20:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[view_zbcstj]
AS
SELECT a.deptcode, a.rq, a.ygbm, b.name, a.rowcounts as zbcs
FROM temp_zbdays a LEFT OUTER JOIN
      dbo.employee b ON a.ygbm = b.code



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
