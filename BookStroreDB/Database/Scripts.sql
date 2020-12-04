USE [BookStroreDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCategories]    Script Date: 04/12/2020 9:46:48 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Trung Ho
-- Create date: 4/12/2020
-- Description:	Get categories have not deleted yet
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetBooks] 
AS
BEGIN
	SELECT [Bookid]
		  ,[BookName]
		  ,[Author]
		  ,[Numberofpages]
		  ,[Price]
	  FROM [dbo].[Book]
	  WHERE IsDelete = 0
END

