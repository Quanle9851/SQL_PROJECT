select studioName,starName
from Studio s,Movies m,StarsIn sa
where s.name=m.studioName and m.title=sa.movieTitle and m.year=1983 and s.name=N'MGM'
go
select *
from StarsIn
go

select s.name, count(m.title)
from Studio s, Movies m
where s.name=m.studioName
group by s.name
go
select *
from Studio
go


IF OBJECT_ID('deleted_movie') IS NOT NULL
	DROP procedure deleted_movie
GO
create procedure deleted_movie (@Mname char(100),@Year  int)
as
	delete from StarsIn
   Where movieTitle=@Mname and movieYear=@Year;
   delete from Movies
   where title=@Mname and year=@Year;
go
EXEC deleted_movie N'Star Wars', 1977;
drop proc deleted_movie

select *
from MovieStar s,MovieExec e
where s.name=e.name
go
select *
from MovieExec


select name,address
from dbo.MovieExec
where name LIKE 'G%' OR netWorth > 100000000
go

select s.movieTitle, s.starName
from MovieStar m, StarsIn s
where m.gender = N'F' and movieTitle like 'Terms of Endearment' and s.starName = m.name
go
SELECT sI.starName
FROM  dbo.StarsIn sI, dbo.MovieStar mS
WHERE	mS.gender = N'F'
		AND movieTitle like 'Terms of Endearment'
		And sI.starName=mS.name
GO

select e.name
from MovieExec e
where e.netWorth > ( select netWorth
                     from MovieExec e
					 where e.name = N'Stephen Spielberg')
go

select e.name, e.address
from MovieStar s, MovieExec e
where s.gender = N'M' and e.netWorth < 100000000 and s.name=e.name
go
IF OBJECT_ID('insert_movies') IS NOT NULL
	DROP procedure insert_movies
GO
create procedure insert_movies (@Mtitle char(100),@Year  int,@Mlength int, @Mgenre char(10),@Mstudioname char(30),@producerName char(30), @Mproducer int)
as
    insert into Studio (name,presC#) values (@Mstudioname,@Mproducer)
	insert into MovieExec(name,cert#) values (@producerName,@Mproducer)
	insert into Movies values (@Mtitle ,@Year ,@Mlength , @Mgenre ,@Mstudioname , @Mproducer )
	
go
EXEC insert_movies N'Kickboxer - Retaliation', 2018,141, N'Action',N'Well Go USA',N'Dimitri Logothesis',139 
create proc add_movie 
	@title		CHAR(100),
	@year		INT,
    @length		INT,
    @genre		CHAR(10),
    @studioName	CHAR(30),
    @producerC#	INT,
	@producerName CHAR(30)
as 
	insert into Studio (name,presC#) values (@studioName,@producerC#)
	insert into MovieExec(name,cert#) values (@producerName,@producerC#)
	insert into Movies(title,year,length,genre,studioName,producerC#) values (@title,@year,@length,@genre,@studioName,@producerC#)
go

BEGIN TRANSACTION;
    GO
    BEGIN TRY
        INSERT INTO MovieExec VALUES (NULL, 'Dimitri Logothesis', 139, Null) 
        INSERT INTO Studio VALUES ('Well Go USA', 'Dimitri Logothesis',139) 
        INSERT INTO Movies VALUES ('Kickboxer - Retaliation', 2018, 141, 'Action', 'Well Go USA', 139) 
    END TRY

    BEGIN CATCH
        ROLLBACK
    END CATCH
COMMIT TRANSACTION;

DROP TRANSACTION IF EXISTS DeleteMovie
go

CREATE TRANSACTION DeleteMovie

AS
BEGIN
	Declare @title nvarchar(20);
	Declare @year int;
	SET @title = 'Star Wars'
	SET @year = 1977
	DELEte from StarsIn 
	where movieTitle = (Select title from Movies where title = @title and year = @year)
	DELETE FROM Movies
	WHERE title = @title and year = @year; 

END



SELECT M.[name], M.[address] FROM MovieStar M INNER JOIN MovieExec ME
		ON M.[name] = ME.[name]
		WHERE M.gender = 'M' AND ME.netWorth < 100000000

SELECT [name] FROM MovieExec ME
			  WHERE ME.netWorth > (
			  
										SELECT netWorth
										FROM MovieExec
										WHERE [name] = 'Stephen Spielberg'
								)

BEGIN PROCEDURE;
    GO
    BEGIN TRY
        INSERT INTO MovieExec VALUES (NULL, 'Dimitri Logothesis', 139, Null) 
        INSERT INTO Studio VALUES ('Well Go USA', 'Dimitri Logothesis',139) 
        INSERT INTO Movies VALUES ('Kickboxer - Retaliation', 2018, 141, 'Action', 'Well Go USA', 139) 
    END TRY

    BEGIN CATCH
        ROLLBACK
    END CATCH
COMMIT PROCEDURE;


BEGIN PROCEDURE;
    GO
    BEGIN TRY
        INSERT INTO MovieExec VALUES (NULL, 'Dimitri Logothesis', 139, Null) 
        INSERT INTO Studio VALUES ('Well Go USA', 'Dimitri Logothesis',139) 
        INSERT INTO Movies VALUES ('Kickboxer - Retaliation', 2018, 141, 'Action', 'Well Go USA', 139) 
    END TRY

    BEGIN CATCH
        ROLLBACK
    END CATCH
COMMIT PROCEDURE;