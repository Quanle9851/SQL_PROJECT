USE [master];
GO

DROP DATABASE MotelDB
GO

CREATE DATABASE MotelDB
GO

USE MotelDB
GO



CREATE TABLE [tblUser](
[UserID]       [varchar](10) not null PRIMARY KEY,
[FullName]     [nvarchar](100),
[Password]     [varchar](20),
[Image]        [nvarchar](255) not null,
[DateOfBirth]  [date],
[CitizenNumber][varchar](12),
[Phone]        [varchar](12),
[Gmail]        [varchar](50),
[Role]         [nvarchar](10),
[Status]       [bit] null,
);

CREATE TABLE [tblMotel](
[MotelID]      [varchar](10) not null PRIMARY KEY,
[Name]         [nvarchar](50),
[Phone]        [varchar](10),
[Address]      [nvarchar](200),
[Ratings]      [decimal](2,1)
CONSTRAINT chk_Ratings CHECK (Ratings >= 0 AND Ratings <= 5),
[AdminID]      [varchar](10) not null FOREIGN KEY REFERENCES tblUser(UserID),
[Status]       [bit] null,
);

CREATE TABLE [tblService](
[ServiceID]    [varchar](10) Not Null PRIMARY KEY ,
[ServiceName]  [nvarchar](50),
[Price]        [decimal](10) Not Null ,
[Status]       [bit] Null,
[MotelID]      [varchar](10) Not Null FOREIGN KEY REFERENCES tblMotel(MotelID),
);

CREATE TABLE [tblRoom](
[RoomID]	   [varchar](10) not null PRIMARY KEY,
[Name]         [nvarchar](50) ,
[Image]        [nvarchar](255) not null,
[Price]        [decimal](10),
[Desct]        [nvarchar](1500),
[Status]       [bit] Null,
[MotelID]      [varchar](10) not null FOREIGN KEY REFERENCES tblMotel(MotelID) 
);

CREATE TABLE [tblNotification](
[AnnouncementID]  [varchar](10) not null PRIMARY KEY,
[Title]           [nvarchar](100),
[Desct]           [nvarchar](1500),
[Date]            [date],
[UserID]          [varchar](10) not null FOREIGN KEY REFERENCES tblUser(UserID),
);

CREATE TABLE [tblBooking](
[BookingID]       [varchar](10) not null PRIMARY KEY,
[BookingDate]     [date],
[Desct]           [nvarchar](1500),
[Total]           [decimal](10),
[Status]          [bit] null, 
[UserID]          [varchar](10) not null FOREIGN KEY REFERENCES tblUser(UserID),  
);

CREATE TABLE [tblBookingDetail](
[BookingDetailID] [varchar](10) not null PRIMARY KEY,
[RoomID]          [varchar](10) not null FOREIGN KEY REFERENCES tblRoom(RoomID),
[BookingID]       [varchar](10) not null FOREIGN KEY REFERENCES tblBooking(BookingID),
[Price]           [decimal](10),
);

CREATE TABLE [tblPayment](
[PaymentID]       [varchar](10) UNIQUE not Null,
[Total]           [decimal](10),
[Desct]           [nvarchar](1500),
[PaymentTime]     [date],
[Sender]          [nvarchar](50),
[Receiver]        [nvarchar](50),
[PaymentTypeName] [varchar](50),
[Status]          [bit] null,
);

CREATE TABLE [tblFeedBack](
[FeedbackID]      [varchar](10) not null PRIMARY KEY,
[Name]            [nvarchar](50),
[Desct]           [nvarchar](1500),
[Ratings]         [decimal](2,1),
[MotelID]         [varchar](10) not null FOREIGN KEY REFERENCES tblMotel(MotelID), 
[BookingID]       [varchar](10) not null FOREIGN KEY REFERENCES tblBooking(BookingID),
[Status]          [bit] null,
);

CREATE TABLE [tblReport](
[ReportID]        [varchar](10) PRIMARY KEY,
[UserID]          [varchar](10) not null FOREIGN KEY REFERENCES tblUser(UserID),
[Title]           [nvarchar](100),
[Desct]           [nvarchar](1500),
[Date]            [date],
);

CREATE TABLE [tblBookingServiceDetail](
[BookingSeviceDetailID]     [varchar](10) not null PRIMARY KEY,
[ServiceID]                 [varchar](10) not null FOREIGN KEY REFERENCES tblService(ServiceID),
[BookingID]                 [varchar](10) not null FOREIGN KEY REFERENCES tblBooking(BookingID),
[Price]                     [decimal](10),
);

ALTER TABLE [tblPayment]
ADD CONSTRAINT FK_Payment_Booking FOREIGN KEY([PaymentID]) 
    REFERENCES [tblBooking]([BookingID]);

--insert user
INSERT [tblUser] ([UserID], [FullName],[Password], [Image],[DateOfBirth], [CitizenNumber] ,[Phone] ,[Gmail], [Role], [Status] ) VALUES (N'quan01', N'Le Minh Quan',N'9851', N'.....','2001-05-07',321615057,'0942949219','hoangquan9851@gmail.com','owner',1) 
INSERT [tblUser] ([UserID], [FullName],[Password], [Image],[DateOfBirth], [CitizenNumber] ,[Phone] ,[Gmail], [Role], [Status] ) VALUES (N'thuy02', N'Cao Thi Phuong Thuy',N'1', N'.....','2001-04-08',45217896,'0852135789','thuy01@gmail.com','admin',1) 
INSERT [tblUser] ([UserID], [FullName],[Password], [Image],[DateOfBirth], [CitizenNumber] ,[Phone] ,[Gmail], [Role], [Status] ) VALUES (N'hai03', N'Tran Ngoc Hai',N'1', N'.....','2001-10-15',3541258746,'0347895634','haitn@gmail.com','customer',1)
INSERT [tblUser] ([UserID], [FullName],[Password], [Image],[DateOfBirth], [CitizenNumber] ,[Phone] ,[Gmail], [Role], [Status] ) VALUES (N'tuan04', N'Nguyen Huu Pham Tuan',N'1', N'.....','2001-07-07',47853265,'01653992966','tuanhp@gmail.com','customer',1)
INSERT [tblUser] ([UserID], [FullName],[Password], [Image],[DateOfBirth], [CitizenNumber] ,[Phone] ,[Gmail], [Role], [Status] ) VALUES (N'duy05', N'Ho Khanh Duy',N'1', N'.....','2001-01-25',452874365,'0963756841','Devilgamer@gmail.com','customer',1)
INSERT [tblUser] ([UserID], [FullName],[Password], [Image],[DateOfBirth], [CitizenNumber] ,[Phone] ,[Gmail], [Role], [Status] ) VALUES (N'tu06', N'Nguyen Doan Tu',N'1', N'.....','2001-05-26',78523465,'01945876325','tutu988@gmail.com','owner',1) 
INSERT [tblUser] ([UserID], [FullName],[Password], [Image],[DateOfBirth], [CitizenNumber] ,[Phone] ,[Gmail], [Role], [Status] ) VALUES (N'doan07', N'Nguyen Huu Doan',N'1', N'.....','2001-09-17',712465325,'0965852413','donatran1113@gmail.com','customer',1) 
INSERT [tblUser] ([UserID], [FullName],[Password], [Image],[DateOfBirth], [CitizenNumber] ,[Phone] ,[Gmail], [Role], [Status] ) VALUES (N'phuc08', N'Lam Son Phuc',N'1', N'.....','2001-02-14',235478154,'01478523654','phucson223@gmail.com','owner',1)
INSERT [tblUser] ([UserID], [FullName],[Password], [Image],[DateOfBirth], [CitizenNumber] ,[Phone] ,[Gmail], [Role], [Status] ) VALUES (N'Quang09', N'Do Duy Quang',N'1', N'.....','1998-05-14',25479864,'0365258417','quang744@gmail.com','owner',1)   
INSERT [tblUser] ([UserID], [FullName],[Password], [Image],[DateOfBirth], [CitizenNumber] ,[Phone] ,[Gmail], [Role], [Status] ) VALUES (N'Lamm44', N'Dang Son Lam',N'14', N'.....','1989-05-07',58213647,'014752368','liontee@gmail.com','customer',1)
INSERT [tblUser] ([UserID], [FullName],[Password], [Image],[DateOfBirth], [CitizenNumber] ,[Phone] ,[Gmail], [Role], [Status] ) VALUES (N'taich74', N'Nguyen Huu Tai',N'8751', N'.....','1999-11-24',7468512,'0942741653','monster11@gmail.com','customer',1)  
INSERT [tblUser] ([UserID], [FullName],[Password], [Image],[DateOfBirth], [CitizenNumber] ,[Phone] ,[Gmail], [Role], [Status] ) VALUES (N'chuongmai', N'Huy Chuong',N'99', N'.....','2002-01-14',214536587,'0975841354','chuongmai@gmail.com','owner',1)
INSERT [tblUser] ([UserID], [FullName],[Password], [Image],[DateOfBirth], [CitizenNumber] ,[Phone] ,[Gmail], [Role], [Status] ) VALUES (N'nhatvuong', N'Pham Nhat Vuong',N'99', N'.....','1989-01-14',248762544,'0248998745','vuong@gmail.com','owner',1)   
SELECT * FROM tblUser
DELETE tblUser WHERE UserID = '01'

--insert motel
INSERT [tblMotel] ([MotelID], [Name], [Phone], [Address], [Ratings], [AdminID], [Status]) VALUES (N'587416594',N'Nhà Trọ Phương Nam', N'0948484848', N'111 đình phong phú,tăng nhơn phú B,TP thủ đức,hcm',4,N'quan01',1)
INSERT [tblMotel] ([MotelID], [Name], [Phone], [Address], [Ratings], [AdminID], [Status]) VALUES (N'842578129',N'Nhà Trọ Ánh Dương', N'0328787878', N'143A Mỹ Đức,Bình Phú,TP Bến Tre,Bến Tre',4.5,N'quan01',1)
INSERT [tblMotel] ([MotelID], [Name], [Phone], [Address], [Ratings], [AdminID], [Status]) VALUES (N'486258478',N'Nhà Trọ Gia Lai', N'0248996587', N'345/55 Trần Hưng Đạo, Cầu Kho, Quận 1, hcm',4.1,N'tu06',1)
INSERT [tblMotel] ([MotelID], [Name], [Phone], [Address], [Ratings], [AdminID], [Status]) VALUES (N'861435762',N'Nhà Trọ Malibu Beach', N'0344989898', N'263, Lê Hồng Phong, Thành Phố Vũng Tàu, Bà Rịa Vũng Tàu',4.1,N'chuongmai',1)
INSERT [tblMotel] ([MotelID], [Name], [Phone], [Address], [Ratings], [AdminID], [Status]) VALUES (N'548762589',N'Nhà Trọ Ladalat', N'0147586325', N'263, Số 19, đường Hoa Hồng, hồ Tuyền Lâm, phường 4, thành phố Đà Lạt, Đà Lạt',3.9,N'phuc08',1)
INSERT [tblMotel] ([MotelID], [Name], [Phone], [Address], [Ratings], [AdminID], [Status]) VALUES (N'473658715',N'Nhà Trọ Vạn Phúc', N'0478523645', N'91 Vạn Phúc, phường Liễu Giai, quận Ba Đình, Hà Nội',4.7,N'Quang09',1)
INSERT [tblMotel] ([MotelID], [Name], [Phone], [Address], [Ratings], [AdminID], [Status]) VALUES (N'785146827',N'Nhà Trọ VinHome', N'0745898989', N'Đường 30 Tháng 4, Phường Hưng Lợi, Quận Ninh Kiều, Cần Thơ',4.4,N'nhatvuong',1)
INSERT [tblMotel] ([MotelID], [Name], [Phone], [Address], [Ratings], [AdminID], [Status]) VALUES (N'625781458',N'Nhà Trọ NgocLan', N'0985364865', N'Đặng Huy Trứ, Phường Vĩnh Nguyên, TP. Nha Trang, Khánh Hòa',4.1,N'nhatvuong',1)
INSERT [tblMotel] ([MotelID], [Name], [Phone], [Address], [Ratings], [AdminID], [Status]) VALUES (N'587624587',N'Nhà Trọ Kỳ Nam', N'0985635353', N'Hùng Vương, Phường Thanh Hà, Thành phố Hội An, Quảng Nam',3.4,N'chuongmai',1)
SELECT * FROM tblMotel
SELECT * FROM tblMotel WHERE Address like '%nhơn phú%';

--insert room
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'012414785', N'01', N'', 450000,N'phòng đơn 1 giường', 1, N'587416594')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'216587125', N'02', N'', 650000,N'phòng đôi 1 giường', 1, N'587416594')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'219657756', N'03', N'', 850000,N'phòng đôi 2 giường', 1, N'587416594')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'765324124', N'04', N'', 450000,N'phòng đơn 1 giường', 1, N'587416594')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'895365765', N'05', N'', 450000,N'phòng đơn 1 giường', 1, N'587416594')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'244714724', N'06', N'', 850000,N'phòng đôi 2 giường', 1, N'587416594')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'658715137', N'07', N'', 450000,N'phòng đơn 1 giường', 1, N'587416594')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'247965765', N'08', N'', 450000,N'phòng đơn 1 giường', 1, N'587416594')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'735947138', N'09', N'', 450000,N'phòng đơn 1 giường', 1, N'587416594')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'012414754', N'NO 1', N'', 325000,N'phòng đơn máy lạnh', 1, N'486258478')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'487621547', N'NO 2', N'', 225000,N'phòng đơn máy lạnh', 1, N'486258478')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'632658744', N'NO 3', N'', 425000,N'phòng đôi máy lạnh', 1, N'486258478')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'421578965', N'NO 4', N'', 425000,N'phòng đôi máy lạnh', 1, N'486258478')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'249632785', N'NO 5', N'', 225000,N'phòng đơn quạt máy', 1, N'486258478')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'124525876', N'NO 6', N'', 325000,N'phòng đơn máy lạnh', 1, N'486258478')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'632658452', N'NO 7', N'', 325000,N'phòng đơn máy lạnh', 1, N'486258478')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'758624864', N'NO 8', N'', 325000,N'phòng đơn máy lạnh', 1, N'486258478')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'587953254', N'phong 1', N'', 255000,N'phòng 1 giường mới', 1, N'587624587')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'456257895', N'phong 2', N'', 255000,N'phòng 1 giường mới', 1, N'587624587')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'248425478', N'phong 3', N'', 355000,N'phòng 2 giường điều hòa', 1, N'587624587')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'851658754', N'phong 4', N'', 355000,N'phòng 2 giường điều hòa', 1, N'587624587')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'236587157', N'phong 5', N'', 195000,N'phòng 1 giường điều hòa', 1, N'587624587')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'236854824', N'phong 6', N'', 195000,N'phòng 1 giường điều hòa', 1, N'587624587')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'895621458', N'phong 7', N'', 195000,N'phòng 1 giường điều hòa', 1, N'587624587')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'548587526', N'phong 8', N'', 195000,N'phòng 1 giường điều hòa', 1, N'587624587')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'326584957', N'phong 9', N'', 125000,N'phòng 1 giường nhỏ', 1, N'587624587')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'452713658', N'phong 10', N'', 125000,N'phòng 1 giường nhỏ', 1, N'587624587')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'986554787', N'phong 11', N'', 125000,N'phòng 1 giường nhỏ', 1, N'587624587')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'845764818', N'num 1', N'', 250000,N'phòng đơn nệm lò xo', 1, N'861435762')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'632548789', N'num 2', N'', 150000,N'phòng đơn nệm thường', 1, N'861435762')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'124569832', N'num 3', N'', 150000,N'phòng đơn nệm thường', 1, N'861435762')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'865741253', N'num 4', N'', 150000,N'phòng đơn nệm thường', 1, N'861435762')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'325487958', N'num 5', N'', 350000,N'phòng đôi nệm lò xo', 1, N'861435762')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'986525487', N'num 6', N'', 350000,N'phòng đôi nệm lò xo', 1, N'861435762')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'956325478', N'num 7', N'', 350000,N'phòng đôi nệm lò xo', 1, N'861435762')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'871245872', N'num 8', N'', 150000,N'phòng đơn nệm thường', 1, N'861435762')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'985568725', N'num 9', N'', 250000,N'phòng đơn nệm lò xo', 1, N'861435762')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'112547695', N'num 10', N'', 250000,N'phòng đơn nệm lò xo', 1, N'861435762')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'365982589', N'num 11', N'', 250000,N'phòng đơn nệm lò xo', 1, N'861435762')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'245782168', N'phòng số 1', N'', 118000,N'phòng đơn nhỏ', 1, N'625781458')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'626356896', N'phòng số 2', N'', 118000,N'phòng đơn nhỏ', 1, N'625781458')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'842565836', N'phòng số 3', N'', 118000,N'phòng đơn nhỏ', 1, N'625781458')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'895658269', N'phòng số 4', N'', 118000,N'phòng đơn nhỏ', 1, N'625781458')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'124858468', N'phòng số 5', N'', 118000,N'phòng đơn nhỏ', 1, N'625781458')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'642766983', N'phòng số 6', N'', 218000,N'phòng đôi máy lạnh', 1, N'625781458')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'528495989', N'phòng số 7', N'', 218000,N'phòng đôi máy lạnh', 1, N'625781458')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'663289984', N'phòng số 8', N'', 218000,N'phòng đôi máy lạnh', 1, N'625781458')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'215487599', N'phòng số 9', N'', 218000,N'phòng đôi máy lạnh', 1, N'625781458')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'854577756', N'phòng số 10', N'', 218000,N'phòng đôi máy lạnh', 1, N'625781458')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Price], [Desct], [Status], [MotelID]) VALUES (N'326556884', N'phòng số 11', N'', 218000,N'phòng đôi máy lạnh', 1, N'625781458')
SELECT * FROM tblRoom 
ORDER BY Name
DELETE tblRoom where Price >0

--INSERT service 
INSERT [tblService] ([ServiceID], [ServiceName], [Price], [Status], [MotelID]) VALUES (N'489656859', N'Coca', 15000, 1, N'587416594')
INSERT [tblService] ([ServiceID], [ServiceName], [Price], [Status], [MotelID]) VALUES (N'021586822', N'lavie', 10000, 1, N'587416594')
INSERT [tblService] ([ServiceID], [ServiceName], [Price], [Status], [MotelID]) VALUES (N'565468569', N'bánh', 17000, 1, N'587416594')
INSERT [tblService] ([ServiceID], [ServiceName], [Price], [Status], [MotelID]) VALUES (N'563958176', N'khăn ướt', 5000, 1, N'587416594')
INSERT [tblService] ([ServiceID], [ServiceName], [Price], [Status], [MotelID]) VALUES (N'556558557', N'7 up', 15000, 1, N'587416594')	
SELECT * FROM tblService


select * from tblRoom where MotelID = '842578129'