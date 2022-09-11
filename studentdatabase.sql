USE STUDENT_DATABASE

Create Table PERADDRESS(
PerCity varchar(30) ,
StateAdd varchar(30),
Zip decimal(10,0),
PerNum decimal(10,0),
primary key (PerNum),
)

Create Table CURADDRESS(
City varchar(30) ,
StateAdd varchar(30),
Zip decimal(10,0),
CurNum decimal(10,0),
primary key (CurNum),
)

create table DEPARTMENT(
DepName varchar(50),
DepCode decimal(10,0),
OfficeNum decimal(10,0),
OffPhone decimal(10,0),
College varchar(30),
primary key (DepCode),
)

Create Table STUDENT(
CurNum decimal(10,0),
PerNum decimal(10,0),
StName varchar(50),
StNum decimal(10,0) not null,
StSSN decimal(10,0),
PerPhone decimal(10,0),
CurPhone decimal(10,0),
StBirth date,
StSex char(1),
StClass varchar(30),
StMajor varchar(30),
STMinor varchar(30),
STDegree varchar(30),
DepCode decimal(10,0),
UNIQUE(StSSN),
primary key (StNum),
CONSTRAINT FK_STUDENT_PERADDRESS FOREIGN KEY (PerNum) REFERENCES PERADDRESS(PerNum),
CONSTRAINT FK_STUDENT_CURADDRESS FOREIGN KEY (CurNum) REFERENCES CURADDRESS(CurNum),
CONSTRAINT FK_STUDENT_DEPARTMENT FOREIGN KEY (DepCode) REFERENCES DEPARTMENT(DepCode),
)

Create table SECTION(
SecNum decimal(10,0),
SecInstruc varchar(50),
SecSem decimal(10,0),
SecYear decimal(10,0),
primary key (SecNum),
)

Create table COURSE(
CourName varchar(50),
CourNum decimal(10,0),
CourDesc varchar(50),
SemHour decimal(10,0),
LvCour decimal(10,0),
OfferDep decimal(10,0),
SecNum decimal(10,0),
primary key (CourNum),
CONSTRAINT FK_SECTION_COURSE FOREIGN KEY(SecNum) REFERENCES SECTION(SecNum),

)
create table GRADE(
StNum decimal(10,0),
SecNum decimal(10,0),
NumGrade int,
LetterGrade char(1),
primary key (StNum,SecNum),
CONSTRAINT FK_STUDENT_GRADE FOREIGN KEY(StNum) REFERENCES STUDENT(StNum),
CONSTRAINT FK_GRADE_SECTION FOREIGN KEY(SecNum) REFERENCES SECTION(SecNum),
)
Create table STJOINSEC(
StNum decimal(10,0) not null,
SecNum decimal(10,0),
PRIMARY KEY(StNum, SecNum),
CONSTRAINT FK_STUDENT_JOIN FOREIGN KEY(StNum) REFERENCES STUDENT(StNum),
CONSTRAINT FK_SECTION_JOIN FOREIGN KEY(SecNum) REFERENCES SECTION(SecNum),
)

--PERADDRESS
INSERT INTO PERADDRESS(PerCity, StateAdd, Zip, PerNum) values (N'Tam Ky',N'Quang Nam', 92, 001)
INSERT INTO PERADDRESS(PerCity, StateAdd, Zip, PerNum) values (N'Phan Thiet',N'Binh Thuan', 86, 002)
INSERT INTO PERADDRESS(PerCity, StateAdd, Zip, PerNum) values (N'TP Ben Tre',N'Ben Tre', 71, 003)
INSERT INTO PERADDRESS(PerCity, StateAdd, Zip, PerNum) values (N'PleiKu',N'Gia Lai', 81, 004)
INSERT INTO PERADDRESS(PerCity, StateAdd, Zip, PerNum) values (N'TP Quang Tri',N'Quang Tri', 74, 005)
INSERT INTO PERADDRESS(PerCity, StateAdd, Zip, PerNum) values (N'Quan 9',N'TP HCM', 55, 006)

--CURADDRESS
INSERT INTO CURADDRESS(City, StateAdd, Zip, CurNum) values (N'TP Di An',N'Binh Duong', 61, 001)
INSERT INTO CURADDRESS(City, StateAdd, Zip, CurNum) values (N'Quan Cam Le',N'Da Nang', 43, 002)
INSERT INTO CURADDRESS(City, StateAdd, Zip, CurNum) values (N'Quan 9',N'TP Thu Duc', 59, 003)
INSERT INTO CURADDRESS(City, StateAdd, Zip, CurNum) values (N'TP Hue',N'TP Thua Thien Hue', 75, 004)
INSERT INTO CURADDRESS(City, StateAdd, Zip, CurNum) values (N'Tp Can tho',N'Can Tho', 65, 005)
INSERT INTO CURADDRESS(City, StateAdd, Zip, CurNum) values (N'TP Ha Noi',N'Thu do Ha Noi', 30, 006)

--DEPARTMENT
INSERT INTO DEPARTMENT(DepCode, DepName, OfficeNum, OffPhone, College) VaLues(001, N'FPTU-HCM', 1001, 19001888, 'He Dai Hoc Chinh Quy')
INSERT INTO DEPARTMENT(DepCode, DepName, OfficeNum, OffPhone, College) VaLues(002, N'HUTECH', 1002, 19002238, 'He Dai Hoc Chinh Quy')
INSERT INTO DEPARTMENT(DepCode, DepName, OfficeNum, OffPhone, College) VaLues(003, N'FPT POLYTECHNIC', 1003, 19002004, 'He Cao Dang')
INSERT INTO DEPARTMENT(DepCode, DepName, OfficeNum, OffPhone, College) VaLues(004, N'UEH', 1004, 19002001, 'He Dai Hoc Chinh Quy')
INSERT INTO DEPARTMENT(DepCode, DepName, OfficeNum, OffPhone, College) VaLues(005, N'VAN LANG', 1005, 19001976, 'He Dai Hoc Chinh Quy')
INSERT INTO DEPARTMENT(DepCode, DepName, OfficeNum, OffPhone, College) VaLues(006, N'VINUNI', 1004, 19001999, 'He Dai Hoc Chinh Quy')

--SECTION 
INSERT INTO SECTION(SecNum,SecInstruc, SecSem,SecYear) Values(101,N'Than Thi Ngoc Van', 2, 2021)
INSERT INTO SECTION(SecNum,SecInstruc, SecSem,SecYear) Values(102,N'Than Van Su', 2, 2021)
INSERT INTO SECTION(SecNum,SecInstruc, SecSem,SecYear) Values(103,N'Bui Anh Tuan', 1, 2019)
INSERT INTO SECTION(SecNum,SecInstruc, SecSem,SecYear) Values(104,N'Ho Hai', 1, 2020)
INSERT INTO SECTION(SecNum,SecInstruc, SecSem,SecYear) Values(105,N'Do Thi Hong Cam', 3, 2021)
--COURSE 
INSERT INTO COURSE(CourNum,CourName, CourDesc, LvCour, OfferDep, SemHour, SecNum) Values(001, N'PRO192','Basic'		,2 ,null ,45, 101)
INSERT INTO COURSE(CourNum,CourName, CourDesc, LvCour, OfferDep, SemHour, SecNum) Values(002, N'LAB211','Medium'	,3 ,20	 ,40, 102)
INSERT INTO COURSE(CourNum,CourName, CourDesc, LvCour, OfferDep, SemHour, SecNum) Values(003, N'CSI104','Basic'		,1 ,30	 ,50, 103)
INSERT INTO COURSE(CourNum,CourName, CourDesc, LvCour, OfferDep, SemHour, SecNum) Values(004, N'MAD101','Advanced'	,25,null ,55, 104)
INSERT INTO COURSE(CourNum,CourName, CourDesc, LvCour, OfferDep, SemHour, SecNum) Values(005, N'PRF192','Basic'		,1 ,35	 ,60, 105)
INSERT INTO COURSE(CourNum,CourName, CourDesc, LvCour, OfferDep, SemHour, SecNum) Values(006, N'CEA201','Medium'	,1 ,10   ,65, 101)
INSERT INTO COURSE(CourNum,CourName, CourDesc, LvCour, OfferDep, SemHour, SecNum) Values(007, N'SSL101c','Basic'	,1 ,null ,45, 102)
INSERT INTO COURSE(CourNum,CourName, CourDesc, LvCour, OfferDep, SemHour, SecNum) Values(008, N'SSG103','Advanced'	,2 ,null ,50, 103)
INSERT INTO COURSE(CourNum,CourName, CourDesc, LvCour, OfferDep, SemHour, SecNum) Values(009, N'OSG202','Basic'		,1 ,null ,65, 104)
INSERT INTO COURSE(CourNum,CourName, CourDesc, LvCour, OfferDep, SemHour, SecNum) Values(010, N'JPD113','Basic'		,3 ,null ,55, 105)

--STUDENT
INSERT INTO STUDENT(StNum, StName,StSSN ,StBirth, StClass, STDegree, StMajor, STMinor, StSex,  CurNum,PerNum, CurPhone, PerPhone, DepCode)
Values(150550, N'Nguyen Van Quang', 0213,'2001-04-20', N'SE1606', N'Engineer', N'Software Engineer', N'Phu Ho', N'M', 001, 002, 0343060000, 0372940000, 006)
INSERT INTO STUDENT(StNum, StName,StSSN ,StBirth, StClass, STDegree, StMajor, STMinor, StSex,  CurNum,PerNum, CurPhone, PerPhone, DepCode)
Values(150004, N'Le Minh Quan', 5057,'2001-05-07', N'SE1505', N'Designer', N'Digital Designers', N'Ve So', N'F', 003, 003, 0211710000, 0912340000, 004)
INSERT INTO STUDENT(StNum, StName,StSSN ,StBirth, StClass, STDegree, StMajor, STMinor, StSex,  CurNum,PerNum, CurPhone, PerPhone, DepCode)
Values(150533, N'Tran Ngoc Hai', 0123,'2001-10-20', N'SE1613', N'Martketer', N'Digital Marketing', N'Danh Giay', N'M', 002, 002, 0323250000, 0935470000, 003)
INSERT INTO STUDENT(StNum, StName,StSSN ,StBirth, StClass, STDegree, StMajor, STMinor, StSex,  CurNum,PerNum, CurPhone, PerPhone, DepCode)
Values(150545, N'Nguyen Doan Tu', 2304,'2000-02-24', N'SE1603', N'B.A', N'Artificial Intelligence', N'Da Cap', N'M', 004, 002, 0963520000, 0957320000, 005)
INSERT INTO STUDENT(StNum, StName,StSSN ,StBirth, StClass, STDegree, StMajor, STMinor, StSex,  CurNum,PerNum, CurPhone, PerPhone, DepCode)
Values(150557, N'Nguyen Huu Doan', 2003,'2002-03-19', N'SE1606', N'Engineer', N'Software Engineer', N'Grab', N'M', 003, 001, 0353640000, 0379360000, 001)

--GRADE
INSERT INTO GRADE(StNum, SecNum, NumGrade, LetterGrade) Values(150550, 101, 9 ,N'A')
INSERT INTO GRADE(StNum, SecNum, NumGrade, LetterGrade) Values(150550, 102, 9 ,N'A')
INSERT INTO GRADE(StNum, SecNum, NumGrade, LetterGrade) Values(150550, 103, 7 ,N'B')
INSERT INTO GRADE(StNum, SecNum, NumGrade, LetterGrade) Values(150545, 102, 7 ,N'B')
INSERT INTO GRADE(StNum, SecNum, NumGrade, LetterGrade) Values(150545, 103, 10,N'A')
INSERT INTO GRADE(StNum, SecNum, NumGrade, LetterGrade) Values(150545, 104, 9 ,N'A')
INSERT INTO GRADE(StNum, SecNum, NumGrade, LetterGrade) Values(150557, 103, 8 ,N'B')
INSERT INTO GRADE(StNum, SecNum, NumGrade, LetterGrade) Values(150557, 104, 6 ,N'C')
INSERT INTO GRADE(StNum, SecNum, NumGrade, LetterGrade) Values(150557, 105, 7 ,N'B')
INSERT INTO GRADE(StNum, SecNum, NumGrade, LetterGrade) Values(150533, 101, 4 ,N'C')
INSERT INTO GRADE(StNum, SecNum, NumGrade, LetterGrade) Values(150533, 102, 9 ,N'A')
INSERT INTO GRADE(StNum, SecNum, NumGrade, LetterGrade) Values(150533, 103, 7 ,N'B')
INSERT INTO GRADE(StNum, SecNum, NumGrade, LetterGrade) Values(150004, 104, 8 ,N'B')
INSERT INTO GRADE(StNum, SecNum, NumGrade, LetterGrade) Values(150004, 105, 9 ,N'A')
INSERT INTO GRADE(StNum, SecNum, NumGrade, LetterGrade) Values(150004, 101, 10 ,N'A')

--JOIN
INSERT INTO STJOINSEC(SecNum,StNum) Values(101, 150550)
INSERT INTO STJOINSEC(SecNum,StNum) Values(102, 150004)
INSERT INTO STJOINSEC(SecNum,StNum) Values(103, 150533)
INSERT INTO STJOINSEC(SecNum,StNum) Values(104, 150545)
INSERT INTO STJOINSEC(SecNum,StNum) Values(105, 150557)

INSERT INTO STJOINSEC(SecNum,StNum) Values(102, 150550)
INSERT INTO STJOINSEC(SecNum,StNum) Values(104, 150557)
INSERT INTO STJOINSEC(SecNum,StNum) Values(105, 150545)
INSERT INTO STJOINSEC(SecNum,StNum) Values(102, 150533)
INSERT INTO STJOINSEC(SecNum,StNum) Values(101, 150004)


SELECT * FROM SECTION
SELECT * FROM DEPARTMENT
SELECT * FROM GRADE
SELECT * FROM PERADDRESS
SELECT * FROM CURADDRESS
SELECT * FROM COURSE
SELECT * FROM STJOINSEC
SELECT * FROM STUDENT
SELECT StName,NumGrade FROM STUDENT st, GRADE g
WHERE st.StNum=g.StNum and st.StName=N'Nguyen Van Quang'
USE STUDENT_DATABASE
GO
IF OBJECT_ID('Student_Tri') IS NOT NULL
	DROP TRIGGER Student_Tri
GO
-- TRIGGER AGE STUDENT ABOVE 18
CREATE TRIGGER StudentAge_Tri ON STUDENT
AFTER INSERT, UPDATE
AS 
	DECLARE @StBirth DATE, @Age INT
	SELECT @StBirth = StBirth
	FROM inserted

	SET @Age=YEAR(GETDATE())- YEAR(@StBirth)
	IF(@Age<18)
	BEGIN 
	RAISERROR('Student not enough 18 years old',16,1)
	ROLLBACK TRANSACTION
END
GO
--TEST
INSERT INTO STUDENT(StNum, StName,StSSN ,StBirth, StClass, STDegree, StMajor, STMinor, StSex,  CurNum,PerNum, CurPhone, PerPhone, DepCode)
Values(150123, N'Nguyen Huu D', 2022,'2005-03-19', N'SE1606', N'Engineer', N'Software Engineer', N'Grab', N'M', 003, 001, 0353640000, 0379360000, 001)
GO
--TRIGGER SEX STUSENT
IF OBJECT_ID('StudentSex_Tri') IS NOT NULL
	DROP TRIGGER StudentSex_Tri
GO
CREATE TRIGGER StudentSex_Tri ON STUDENT
AFTER INSERT, UPDATE
AS
	DECLARE @StSex Char(1)
	SELECT @StSex=StSex
	FROM STUDENT
	IF(@StSex NOT LIKE N'F' or @StSex NOT LIKE N'M')
	BEGIN 
	RAISERROR('Sex of student must F or M',16,1)
	ROLLBACK TRANSACTION
	END
GO
--TEST
UPDATE STUDENT
SET StSex=N'G'
WHERE StNum=150550
GO
SELECT * FROM STUDENT
GO

--TRIGGER STUDENT NUMGRADE WITH LETGRADE
IF OBJECT_ID('StudentGrade_Tri') IS NOT NULL 
DROP TRIGGER StudentGrade_Tri 
GO 
CREATE TRIGGER StudentGrade_Tri ON GRADE 
AFTER UPDATE AS 
DECLARE @NumGrade int, @LetGrade char(1) 
SELECT @NumGrade=ins.NumGrade, @LetGrade=ins.LetterGrade FROM inserted ins; 

IF (@NumGrade >= 9 and @LetGrade=N'A') 
	SET @LetGrade=N'A'
ELSE IF (@NumGrade >= 7 and @NumGrade < 9 and @LetGrade=N'B') 
	SET @LetGrade=N'B' 
ELSE IF (@NumGrade >= 4 and @NumGrade < 7 and @LetGrade=N'C') 
	SET @LetGrade=N'C' 
ELSE IF (@NumGrade<4 and @LetGrade=N'D')
	SET @LetGrade=N'D' 
ELSE
BEGIN
 RAISERROR('NumGade >= 9 is A,NumGade >= 7 is B, NumGade >= 4 is C, NumGade < 4 is D',16,1)  
 ROLLBACK TRANSACTION
END 
GO
UPDATE GRADE
SET NumGrade=10 ,LetterGrade=N'A'
WHERE StNum=150550 and SecNum=101
SELECT * FROM GRADE