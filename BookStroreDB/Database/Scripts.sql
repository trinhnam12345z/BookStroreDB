USE [BookStore]
GO
/****** Object:  Table [dbo].[Books]    Script Date: 12/4/2020 3:10:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Books](
	[Bookid] [int] IDENTITY(1,1) NOT NULL,
	[BookName] [nvarchar](255) NOT NULL,
	[Author] [nvarchar](255) NOT NULL,
	[Publisher] [nvarchar](255) NOT NULL,
	[PublishYear] [int] NOT NULL,
	[Price] [int] NOT NULL,
	[IsDelete] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Bookid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Books] ADD  DEFAULT ((0)) FOR [IsDelete]
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateBook]    Script Date: 12/4/2020 3:10:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trinh Nam
-- Create date: 01/12/2020
-- Description:	Create new book
-- =============================================
CREATE PROCEDURE [dbo].[sp_CreateBook]
	@BookName NVARCHAR(255),
	@Author NVARCHAR(255),
	@Publisher NVARCHAR(255),
	@PublishYear INT,
	@Price INT

AS
BEGIN
	DECLARE @BookId	INT = 0,
	@IsDelete BIT = 0,
			@Message	NVARCHAR(200) = 'Something went wrong, please contact administrator.'

	BEGIN TRY
		IF(@BookName IS NULL OR @BookName = '')
		BEGIN
			SET @Message = 'Book name is required.'
		END
		ELSE
		IF(@Author IS NULL OR @Author = '')
		BEGIN
			SET @Message = 'Author is required.'
		END
		ELSE
		IF(@Publisher IS NULL OR @Publisher = '')
		BEGIN
			SET @Message = 'Publisher is required.'
		END
		ELSE
		IF(@PublishYear IS NULL OR @PublishYear = '')
		BEGIN
			SET @Message = 'PublishYear is required.'
		END
		ELSE
		IF(@Price IS NULL OR @Price = '')
		BEGIN
			SET @Message = 'Price is required.'
		END
		ELSE
			BEGIN
				INSERT INTO [dbo].[Books]
						   ([BookName]
						   ,[Author]
						   ,[Publisher]
						   ,[PublishYear]
						   ,[Price]
						   ,[IsDelete])
					 VALUES
						   (@BookName
						   ,@Author 
						   ,@Publisher
						   ,@PublishYear
						   ,@Price
						   ,@IsDelete)


				SET @BookId = SCOPE_IDENTITY()
				SET @Message = 'Book has been created success.'
			END
		SELECT @BookId AS BookId, @Message AS [Message]
	END TRY
	BEGIN CATCH
		SELECT @BookId AS BookId, @Message AS [Message]
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteBook]    Script Date: 12/4/2020 3:10:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trinh Nam
-- Create date: 1/12/2020
-- Description:	Delete Book
-- =============================================
CREATE PROCEDURE [dbo].[sp_DeleteBook]
	@BookId		INT	
AS
BEGIN
	
	DECLARE @Message	NVARCHAR(200) = 'Something went wrong, please contact administrator.'
	DECLARE @Result		BIT = 0
	DECLARE @IsDelete	BIT = 1

	BEGIN TRAN
	BEGIN TRY
		IF(ISNULL(@BookId,0) = 0)
		BEGIN
			SET @Message = 'Book Id is required.'
		END
		ELSE
			BEGIN
				IF(NOT EXISTS(SELECT * FROM Books WHERE Bookid = @BookId))
				BEGIN
					SET @Message = 'Can not found BookId'	
				END
				ELSE
				IF(EXISTS(SELECT * FROM Books WHERE Bookid = @BookId AND IsDelete = 1))
				BEGIN
					SET @Message = 'Book has been deleted'
				END
				ELSE
				BEGIN
					UPDATE Books
					SET IsDelete = @IsDelete
					WHERE Bookid = @BookId

					SET @Message = 'Book has been delete success'
					SET @Result = 1
				END
		END
		SELECT @Result AS Result, @Message AS [Message] ,@BookId AS BookId  ,@IsDelete AS IsDeleted
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		SELECT @Result AS Result, @Message AS [Message],@BookId AS BookId ,@IsDelete AS IsDeleted
		ROLLBACK TRAN
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetBooks]    Script Date: 12/4/2020 3:10:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Trịnh Nam
-- Create date: 04/12/2020
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetBooks] 
AS
BEGIN
	SELECT [BookId]
		  ,[BookName]
		  ,[Author]
		  ,[Publisher]
		  ,[PublishYear]
		  ,[Price]
	  FROM [dbo].[Books]
	  WHERE IsDelete = 0
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ShowBooks]    Script Date: 12/4/2020 3:10:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Trịnh Nam
-- Create date: 04/12/2020
-- =============================================
CREATE PROCEDURE [dbo].[sp_ShowBooks] 
	@BookId INT
AS
BEGIN
	DECLARE @Message NVARCHAR(200) = 'Something went wrong, please contact administrator.'
	BEGIN
		IF(ISNULL(@BookId,0) = 0)
			BEGIN
				SET @Message = 'Book ID is required.'
			END
		ELSE
		IF (NOT EXISTS (SELECT * FROM Books WHERE BookId = @BookId))
		BEGIN
			SET @Message = 'Book is not exists.'
		END
		ELSE
			SELECT * FROM Books WHERE BookId = @BookId
		END
		SELECT @BookId AS BookId, @Message AS [Message]
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateBook]    Script Date: 12/4/2020 3:10:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trinh Nam
-- Create date: 27/11/2020
-- Description:	Update category
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateBook]
	@BookId	INT,
	@BookName NVARCHAR(255),
	@Author NVARCHAR(255),
	@Publisher NVARCHAR(255),
	@PublishYear INT,
	@Price INT
AS
BEGIN
	
	DECLARE @Message	NVARCHAR(200) = 'Something went wrong, please contact administrator.'
	DECLARE @Result		BIT = 0

	BEGIN TRAN
	BEGIN TRY
		IF(ISNULL(@BookId,0) = 0)
		BEGIN
			SET @Message = 'Book Id is required.'
		END
		ELSE
		BEGIN
			IF(ISNULL(@BookName, '') = '')
			BEGIN
				SET @Message = 'Book name is required.'
			END
			ELSE
			IF(@Author IS NULL OR @Author = '')
			BEGIN
				SET @Message = 'Author is required.'
			END
			ELSE
			IF(@Publisher IS NULL OR @Publisher = '')
			BEGIN
				SET @Message = 'Publisher is required.'
			END
			ELSE
			IF(@PublishYear IS NULL OR @PublishYear = '')
			BEGIN
				SET @Message = 'PublishYear is required.'
			END
			ELSE
			IF(@Price IS NULL OR @Price = '')
			BEGIN
				SET @Message = 'Price is required.'
			END
			ELSE
			BEGIN
				IF(NOT EXISTS(SELECT * FROM Books WHERE Bookid = @BookId))
				BEGIN
					SET @Message = 'Can not found Book Id'	
				END
				ELSE
				BEGIN
					IF(EXISTS(SELECT * FROM Books WHERE BookName = @BookName AND Bookid <> @BookId))
					BEGIN
						SET @Message = 'Book is exists'	
					END
					ELSE
					BEGIN
						UPDATE Books
						SET BookName = @BookName,
							Author = @Author ,
							Publisher = @Publisher ,
							PublishYear =@PublishYear ,
							Price = @Price 
						WHERE Bookid = @BookId

						SET @Message = 'Book has been updated success'
						SET @Result = 1
					END
				END
			END
		END
		SELECT @Result AS Result, @Message AS [Message] ,@BookId AS CategoryId
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		SELECT @Result AS Result, @Message AS [Message],@BookId AS CategoryId
		ROLLBACK TRAN
	END CATCH
END
GO
