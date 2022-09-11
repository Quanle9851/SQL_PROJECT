USE master;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name='MovieDB')
	DROP DATABASE MovieDB
GO
CREATE DATABASE MovieDB
GO
USE MovieDB
GO
CREATE TABLE Movies (
    title		CHAR(100),
	year		INT,
    length		INT,
    genre		CHAR(10),
    studioName	CHAR(30),
    producerC#	INT,
    PRIMARY KEY (title, year)
);
GO
CREATE TABLE MovieStar (
    name		CHAR(30),
	address		VARCHAR(255),
    gender		CHAR(1),
    birthdate	DATE,
    PRIMARY KEY (name)
);
GO
CREATE TABLE StarsIn (
    movieTitle	CHAR(100),
    movieYear	INT,
    starName	CHAR(30),
	PRIMARY KEY (movieTitle, movieYear, starName)
);
GO
CREATE TABLE MovieExec (
    name		CHAR(30),
    address		VARCHAR(255),
    cert#		INT		PRIMARY KEY,
    netWorth	INT
);
GO
CREATE TABLE Studio (
    name		CHAR(30)	PRIMARY KEY,
    address		VARCHAR(255),
    presC#		INT
);
GO
INSERT INTO Movies VALUES ('Logan''s run', 1976, NULL, 'sciFi', 'MGM', 123);
INSERT INTO Movies VALUES ('Star Wars', 1977, 124, 'sciFi', 'Fox', 555);
INSERT INTO Movies VALUES ('Empire Strikes Back', 1980, 111, 'fantasy', 'Fox', 555);
INSERT INTO Movies VALUES ('Star Trek', 1979, 132, 'sciFi', 'Paramount', 345);
INSERT INTO Movies VALUES ('Star Trek: Nemesis', 2002, 116, 'sciFi', 'Paramount', 345);
INSERT INTO Movies VALUES ('Terms of Endearment', 1983, 132, 'romance', 'MGM', 123);
INSERT INTO Movies VALUES ('The Usual Suspects', 1995, 106, 'crime', 'MGM', 456);
INSERT INTO Movies VALUES ('Gone With the Wind', 1938, 238, 'drama', 'MGM', 123);
INSERT INTO Movies VALUES ('Wayne''s World', 1992, 95, 'comedy', 'Paramount', 123);
INSERT INTO Movies VALUES ('King Kong', 2005, 187, 'drama', 'Universal', 789);
INSERT INTO Movies VALUES ('King Kong', 1976, 134, 'drama', 'Paramount', 666);
INSERT INTO Movies VALUES ('King Kong', 1933, 100, 'drama', 'Universal', 345);
INSERT INTO Movies VALUES ('Pretty Woman', 1990, 119, 'comedy', 'Disney', 999);

INSERT INTO MovieStar VALUES ('Jane Fonda', 'Turner Av.', 'F', '1977-07-07');
INSERT INTO MovieStar VALUES ('Alec Baldwin', 'Baldwin Av.', 'M', '1977-06-07');
INSERT INTO MovieStar VALUES ('Kim Basinger', 'Baldwin Av.', 'F', '1979-05-07');
INSERT INTO MovieStar VALUES ('Harrison Ford', 'Beverly Hills', 'M', '1977-07-07');
INSERT INTO MovieStar VALUES ('Carrie Fisher', '123 Maple St.', 'F', '1999-09-09');
INSERT INTO MovieStar VALUES ('Mark Hamill', '456 Oak Rd.', 'M', '1988-08-08');
INSERT INTO MovieStar VALUES ('Debra Winger', 'A way', 'F', '1978-05-06');
INSERT INTO MovieStar VALUES ('Jack Nicholson', 'X path', 'M', '1949-05-05');
INSERT INTO MovieStar VALUES ('Kevin Spacey', 'New York Av.', 'F', '1937-12-21');

INSERT INTO StarsIn VALUES ('Star Wars', 1977, 'Carrie Fisher');
INSERT INTO StarsIn VALUES ('Star Wars', 1977, 'Mark Hamill');
INSERT INTO StarsIn VALUES ('Star Wars', 1977, 'Harrison Ford');
INSERT INTO StarsIn VALUES ('Empire Strikes Back', 1980, 'Harrison Ford');
INSERT INTO StarsIn VALUES ('The Usual Suspects', 1995, 'Kevin Spacey');
INSERT INTO StarsIn VALUES ('Terms of Endearment', 1983, 'Debra Winger');
INSERT INTO StarsIn VALUES ('Terms of Endearment', 1983, 'Jack Nicholson');

INSERT INTO MovieExec VALUES ('George Lucas', 'Oak Rd.', 555, 200000000);
INSERT INTO MovieExec VALUES ('Ted Turner', 'Turner Av.', 333, 125000000);
INSERT INTO MovieExec VALUES ('Stephen Spielberg', '123 ET road', 222, 100000000);
INSERT INTO MovieExec VALUES ('Merv Griffin', 'Riot Rd.', 199, 112000000);
INSERT INTO MovieExec VALUES ('Calvin Coolidge', 'Fast Lane', 123, 20000000);
INSERT INTO MovieExec VALUES ('Garry Marshall', 'First Street', 999, 50000000);
INSERT INTO MovieExec VALUES ('J.J. Abrams', 'High Road', 345, 45000000);
INSERT INTO MovieExec VALUES ('Bryan Singer', 'Downtown', 456, 70000000);
INSERT INTO MovieExec VALUES ('George Roy Hill', 'Baldwin Av.', 789, 20000000);
INSERT INTO MovieExec VALUES ('Dino De Laurentiis', ' Beverly Hills', 666, 120000000);

INSERT INTO Studio VALUES ('MGM','MGM Boulevard', 123);
INSERT INTO Studio VALUES ('Fox', 'Hollywood', 555);
INSERT INTO Studio VALUES ('Disney', 'Buena Vista', 999);
INSERT INTO Studio VALUES ('Paramount', 'Hollywood', 345);
INSERT INTO Studio VALUES ('Universal', 'Hollywood', 789);
GO
--Referential Integrity Constraints
ALTER TABLE Movies ADD CONSTRAINT fk_Movies_producerC# 
FOREIGN KEY(producerC#) REFERENCES MovieExec(cert#)
GO
ALTER TABLE Movies ADD CONSTRAINT fk_Movies_studioName
FOREIGN KEY(studioName) REFERENCES Studio(name)
GO
ALTER TABLE StarsIn ADD CONSTRAINT fk_StarsIn_movieTitle_movieYear 
FOREIGN KEY(movieTitle,movieYear) REFERENCES Movies(title,year)
GO
ALTER TABLE StarsIn ADD CONSTRAINT fk_StarsIn_starName 
FOREIGN KEY(starName) REFERENCES MovieStar(name)
GO
ALTER TABLE Studio ADD CONSTRAINT fk_Studio_presC# 
FOREIGN KEY(presC#) REFERENCES MovieExec(cert#)
GO
--Retrieve Data
SELECT * FROM Movies;
SELECT * FROM MovieStar;
SELECT * FROM StarsIn;
SELECT * FROM MovieExec;
SELECT * FROM Studio;
/*
ALTER TABLE MovieStar ADD phone CHAR(15);
ALTER TABLE MovieStar DROP COLUMN phone;
ALTER TABLE MovieStar ALTER COLUMN name CHAR(50);
*/