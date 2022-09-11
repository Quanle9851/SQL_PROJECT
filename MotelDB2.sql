USE [master];
GO

DROP DATABASE MotelDB
GO

CREATE DATABASE MotelDB
GO

USE MotelDB
GO

CREATE TABLE [tblUser](--done
[UserID]       [varchar](10) not null PRIMARY KEY,
[FullName]     [nvarchar](100) not null,
[Image]        [nvarchar](255),
[DateOfBirth]  [date],
[CitizenNumber][varchar](12),
[Gender]		[bit] null,
[Address]		[nvarchar](200),
[Phone]        [varchar](12),
[Gmail]        [varchar](50),
[Password]     [varchar](20),
[Role]         [nvarchar](10),
[Status]       [bit] null,
);

CREATE TABLE [tblCity](--done
[CityID]      [varchar](10) not null PRIMARY KEY,
[Name]         [nvarchar](50)
);
CREATE TABLE [tblDistrict](--done
[DistrictID]      [varchar](10) not null PRIMARY KEY,
[Name]         [nvarchar](50),
[CityID]      [varchar](10) not null FOREIGN KEY REFERENCES tblCity(CityID),
);


INSERT [tblCity] ([CityID], [Name]) VALUES (N'1', N'An Giang')
INSERT [tblCity] ([CityID], [Name]) VALUES (N'2', N'Ba Ria Vung Tau')
INSERT [tblCity] ([CityID], [Name]) VALUES (N'3', N'Bạc Lieu')
INSERT [tblCity] ([CityID], [Name]) VALUES (N'4', N'Bac Giang')
INSERT [tblCity] ([CityID], [Name]) VALUES (N'9', N'Bình Định')
INSERT [tblCity] ([CityID], [Name]) VALUES (N'30', N'Thanh Pho HCM')

/*disctrictID sẽ là số của cityID + 1 2 3 tăng dần*/
INSERT [tblDistrict] ([DistrictID], [Name],[CityID]) VALUES (N'11', N'An Phú', '1')
INSERT [tblDistrict] ([DistrictID],  [Name],[CityID]) VALUES (N'12', N'Phú Tân', '1')
INSERT [tblDistrict] ([DistrictID], [Name],[CityID]) VALUES (N'21', N'Thành phố Bà Rịa', '2')
INSERT [tblDistrict] ([DistrictID],  [Name],[CityID]) VALUES (N'22', N'Thành phố Vũng Tàu', '2')
INSERT [tblDistrict] ([DistrictID], [Name],[CityID]) VALUES (N'91', N'Phù Mỹ', '9')
INSERT [tblDistrict] ([DistrictID],  [Name],[CityID]) VALUES (N'92', N'Phù Cát', '9')
INSERT [tblDistrict] ([DistrictID], [Name],[CityID]) VALUES (N'301', N'Thành phố Thủ Đức', '30')
INSERT [tblDistrict] ([DistrictID],  [Name],[CityID]) VALUES (N'302', N'Quận 2', '30')

CREATE TABLE [tblMotel](--done
[MotelID]      [varchar](10) not null PRIMARY KEY,
[Name]         [nvarchar](50),
[Phone]        [varchar](10),
[Desct]        [nvarchar] (MAX),
[Image]        [nvarchar](1000),
[Address]      [nvarchar](200), /* này sẽ nhập số nhà tên đường và phường nhé*/
[DistrictID]	[varchar](10) not null FOREIGN KEY REFERENCES tblDistrict(DistrictID),
[Ratings]      [decimal](2,1)
CONSTRAINT chk_Ratings CHECK (Ratings >= 0 AND Ratings <= 5),
[OwnerID]      [varchar](10) not null FOREIGN KEY REFERENCES tblUser(UserID),
[Status]       [bit] null,
);



CREATE TABLE [tblService](--done
[ServiceID]    [varchar](10) Not Null PRIMARY KEY ,
[ServiceName]  [nvarchar](50),
[Price]        [decimal](10) Not Null ,
[Status]       [bit] Null,
[MotelID]      [varchar](10) Not Null FOREIGN KEY REFERENCES tblMotel(MotelID),
);

CREATE TABLE [tblRoomType](
[RoomTypeID]	[varchar](10) not null PRIMARY KEY,
[TypeName]		[nvarchar](50),
[Price]			[decimal](10)

);

CREATE TABLE [tblRoom](--done
[RoomID]	   [varchar](10) not null PRIMARY KEY,
[Name]         [nvarchar](50) ,
[Image]        [nvarchar](1000),
[Desct]        [nvarchar](1500),
[Status]       [bit] Null,
[MotelID]      [varchar](10) not null FOREIGN KEY REFERENCES tblMotel(MotelID) ,
[RoomTypeID]      [varchar](10) not null FOREIGN KEY REFERENCES tblRoomType(RoomTypeID) 

);

CREATE TABLE [tblNotification]( --done
[AnnouncementID]  [varchar](10) not null PRIMARY KEY,
[Title]           [nvarchar](100),
[Desct]           [nvarchar](1500),
[Date]            [date],
[UserID]          [varchar](10) not null FOREIGN KEY REFERENCES tblUser(UserID),
);

CREATE TABLE [tblBooking](--done
[BookingID]       [varchar](10) not null PRIMARY KEY,
[BookingDate]     [date],
[Desct]           [nvarchar](1500),
[Total]           [decimal](10),
[Status]          [bit] null, 
[UserID]          [varchar](10) not null FOREIGN KEY REFERENCES tblUser(UserID),  
);
CREATE TABLE [tblBookingDetail](--done
[BookingDetailID] [varchar](10) not null PRIMARY KEY,
[RoomID]          [varchar](10) not null FOREIGN KEY REFERENCES tblRoom(RoomID),
[BookingID]       [varchar](10) not null FOREIGN KEY REFERENCES tblBooking(BookingID),
[Price]           [decimal](10),
[Time]			[int],
);

CREATE TABLE [tblPayment](
[PaymentID]       [varchar](10) UNIQUE not Null,
[Total]           [decimal](10),
[Desct]           [nvarchar](1500),
[PaymentTime]     [date],
[Sender]          [nvarchar](50),
[Receiver]        [nvarchar](50),
[PaymentTypeName] [nvarchar](50),
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
[Quantity]					[int],
[Price]                     [decimal](10),
);

ALTER TABLE [tblPayment]
ADD CONSTRAINT FK_Payment_Booking FOREIGN KEY([PaymentID]) 
    REFERENCES [tblBooking]([BookingID]);

--/////////////
--insert user



INSERT [tblRoomType] ([RoomTypeID], [TypeName], [Price]) VALUES (N'1', N'Phòng đơn', 150000)
INSERT [tblRoomType] ([RoomTypeID], [TypeName], [Price]) VALUES (N'2', N'Phòng đôi', 250000)


INSERT [tblUser] ([UserID], [FullName],[Password], [Image],[DateOfBirth], [CitizenNumber] ,[Gender], [Address], [Phone] ,[Gmail], [Role], [Status] ) VALUES (N'quan01', N'Le Minh Quan',N'1', N'.....','2001-05-07',321615057,1,N'111 đình phong phú,tăng nhơn phú B,TP thủ đức,hcm','0942949219','hoangquan9851@gmail.com','OW',1) 
INSERT [tblUser] ([UserID], [FullName],[Password], [Image],[DateOfBirth], [CitizenNumber],[Gender], [Address] ,[Phone] ,[Gmail], [Role], [Status] ) VALUES (N'tu06', N'Nguyen Doan Tu',N'1', N'.....','2001-05-26',78523465,1,N'111 đình phong phú,tăng nhơn phú B,TP thủ đức,hcm','01945876325','tutu988@gmail.com','OW',0) 
INSERT [tblUser] ([UserID], [FullName],[Password], [Image],[DateOfBirth], [CitizenNumber] ,[Gender], [Address],[Phone] ,[Gmail], [Role], [Status] ) VALUES (N'phuc08', N'Lam Son Phuc',N'1', N'.....','2001-02-14',235478154,1,N'111 đình phong phú,tăng nhơn phú B,TP thủ đức,hcm','01478523654','phucson223@gmail.com','OW',1)
INSERT [tblUser] ([UserID], [FullName],[Password], [Image],[DateOfBirth], [CitizenNumber] ,[Gender], [Address],[Phone] ,[Gmail], [Role], [Status] ) VALUES (N'Quang09', N'Do Duy Quang',N'1', N'.....','1998-05-14',25479864,1,N'111 đình phong phú,tăng nhơn phú B,TP thủ đức,hcm','0365258417','quang744@gmail.com','OW',1)  
INSERT [tblUser] ([UserID], [FullName],[Password], [Image],[DateOfBirth], [CitizenNumber] ,[Gender], [Address],[Phone] ,[Gmail], [Role], [Status] ) VALUES (N'chuongmai', N'Huy Chuong',N'99', N'.....','2002-01-14',214536587,1,N'111 đình phong phú,tăng nhơn phú B,TP thủ đức,hcm','0975841354','chuongmai@gmail.com','OW',0)
INSERT [tblUser] ([UserID], [FullName],[Password], [Image],[DateOfBirth], [CitizenNumber] ,[Gender], [Address],[Phone] ,[Gmail], [Role], [Status] ) VALUES (N'nhatvuong', N'Pham Nhat Vuong',N'99', N'.....','1989-01-14',248762544,1,N'111 đình phong phú,tăng nhơn phú B,TP thủ đức,hcm','0248998745','vuong@gmail.com','OW',1)  
 
INSERT [tblUser] ([UserID], [FullName],[Password], [Image],[DateOfBirth], [CitizenNumber] ,[Gender], [Address],[Phone] ,[Gmail], [Role], [Status] ) VALUES (N'doan07', N'Nguyen Huu Doan',N'1', N'.....','2001-09-17',712465325,0,N'111 đình phong phú,tăng nhơn phú B,TP thủ đức,hcm','0965852413','donatran1113@gmail.com','US',1) 
INSERT [tblUser] ([UserID], [FullName],[Password], [Image],[DateOfBirth], [CitizenNumber] ,[Gender], [Address],[Phone] ,[Gmail], [Role], [Status] ) VALUES (N'hai03', N'Tran Ngoc Hai',N'1', N'.....','2001-10-15',3541258746,1,N'111 đình phong phú,tăng nhơn phú B,TP thủ đức,hcm','0347895634','haitn@gmail.com','US',1)
INSERT [tblUser] ([UserID], [FullName],[Password], [Image],[DateOfBirth], [CitizenNumber] ,[Gender], [Address],[Phone] ,[Gmail], [Role], [Status] ) VALUES (N'tuan04', N'Nguyen Huu Pham Tuan',N'1', N'.....','2001-07-07',47853265,1,N'111 đình phong phú,tăng nhơn phú B,TP thủ đức,hcm','01653992966','tuanhp@gmail.com','US',1)
INSERT [tblUser] ([UserID], [FullName],[Password], [Image],[DateOfBirth], [CitizenNumber] ,[Gender], [Address],[Phone] ,[Gmail], [Role], [Status] ) VALUES (N'duy05', N'Ho Khanh Duy',N'1', N'.....','2001-01-25',452874365,0,N'111 đình phong phú,tăng nhơn phú B,TP thủ đức,hcm','0963756841','Devilgamer@gmail.com','US',0) 
INSERT [tblUser] ([UserID], [FullName],[Password], [Image],[DateOfBirth], [CitizenNumber] ,[Gender], [Address],[Phone] ,[Gmail], [Role], [Status] ) VALUES (N'Lamm44', N'Dang Son Lam',N'14', N'.....','1989-05-07',58213647,1,N'111 đình phong phú,tăng nhơn phú B,TP thủ đức,hcm','014752368','liontee@gmail.com','US',1)
INSERT [tblUser] ([UserID], [FullName],[Password], [Image],[DateOfBirth], [CitizenNumber] ,[Gender], [Address],[Phone] ,[Gmail], [Role], [Status] ) VALUES (N'taich74', N'Nguyen Huu Tai',N'8751', N'.....','1999-11-24',7468512,1,N'111 đình phong phú,tăng nhơn phú B,TP thủ đức,hcm','0942741653','monster11@gmail.com','US',1) 

INSERT [tblUser] ([UserID], [FullName],[Password], [Image],[DateOfBirth], [CitizenNumber] ,[Gender], [Address],[Phone] ,[Gmail], [Role], [Status] ) VALUES (N'thuy02', N'Cao Thi Phuong Thuy',N'1', N'.....','2001-04-08',45217896,1,N'111 đình phong phú,tăng nhơn phú B,TP thủ đức,hcm','0852135789','thuy01@gmail.com','AD',1)  


--insert motel
INSERT [tblMotel] ([MotelID], [Name], [Desct], [Image], [Phone], [DistrictID], [Address], [Ratings], [OwnerID], [Status]) VALUES (N'587416594',N'Nhà Trọ Phương Nam', N'Desction motel',N'https://ezcloud.vn/wp-content/uploads/2019/07/motel-la-gi.jpg', N'0948484848','301', N'111 đình phong phú,tăng nhơn phú B',4,N'quan01',1)
INSERT [tblMotel] ([MotelID], [Name], [Desct], [Image], [Phone], [DistrictID], [Address], [Ratings], [OwnerID], [Status]) VALUES (N'842578129',N'Nhà Trọ Ánh Dương',N'Desction motel',N'https://ezcloud.vn/wp-content/uploads/2019/07/motel-la-gi.jpg', N'0328787878','302', N'143A Mỹ Đức,Bình Phú',4.5,N'quan01',1)
INSERT [tblMotel] ([MotelID], [Name], [Desct], [Image], [Phone], [DistrictID], [Address], [Ratings], [OwnerID], [Status]) VALUES (N'486258478',N'Nhà Trọ Gia Lai',N'Desction motel',N'https://ezcloud.vn/wp-content/uploads/2019/07/motel-la-gi.jpg', N'0248996587','302', N'345/55 Trần Hưng Đạo, Cầu Kho',4.1,N'tu06',1)
INSERT [tblMotel] ([MotelID], [Name], [Desct], [Image], [Phone], [DistrictID], [Address], [Ratings], [OwnerID], [Status]) VALUES (N'861435762',N'Nhà Trọ Malibu Beach',N'Desction motel',N'https://ezcloud.vn/wp-content/uploads/2019/07/motel-la-gi.jpg', N'0344989898','302', N'263, Lê Hồng Phong',4.1,N'chuongmai',1)
INSERT [tblMotel] ([MotelID], [Name], [Desct], [Image], [Phone], [DistrictID], [Address], [Ratings], [OwnerID], [Status]) VALUES (N'548762589',N'Nhà Trọ Ladalat',N'Desction motel',N'https://ezcloud.vn/wp-content/uploads/2019/07/motel-la-gi.jpg', N'0147586325','91', N'263, Số 19, đường Hoa Hồng, hồ Tuyền Lâm, phường 4',3.9,N'phuc08',1)
INSERT [tblMotel] ([MotelID], [Name], [Desct], [Image], [Phone], [DistrictID], [Address], [Ratings], [OwnerID], [Status]) VALUES (N'473658715',N'Nhà Trọ Vạn Phúc',N'Desction motel',N'https://ezcloud.vn/wp-content/uploads/2019/07/motel-la-gi.jpg', N'0478523645','301', N'91 Vạn Phúc, phường Liễu Giai',4.7,N'Quang09',1)
INSERT [tblMotel] ([MotelID], [Name], [Desct], [Image], [Phone], [DistrictID], [Address], [Ratings], [OwnerID], [Status]) VALUES (N'785146827',N'Nhà Trọ VinHome',N'Desction motel',N'https://ezcloud.vn/wp-content/uploads/2019/07/motel-la-gi.jpg', N'0745898989','11', N'Đường 30 Tháng 4, Phường Hưng Lợi',4.4,N'nhatvuong',1)
INSERT [tblMotel] ([MotelID], [Name], [Desct], [Image], [Phone], [DistrictID], [Address], [Ratings], [OwnerID], [Status]) VALUES (N'625781458',N'Nhà Trọ NgocLan',N'Desction motel',N'https://ezcloud.vn/wp-content/uploads/2019/07/motel-la-gi.jpg', N'0985364865','11', N'Đặng Huy Trứ, Phường Vĩnh Nguyên',4.1,N'nhatvuong',1)
INSERT [tblMotel] ([MotelID], [Name], [Desct], [Image], [Phone], [DistrictID], [Address], [Ratings], [OwnerID], [Status]) VALUES (N'587624587',N'Nhà Trọ Kỳ Nam',N'Desction motel',N'https://ezcloud.vn/wp-content/uploads/2019/07/motel-la-gi.jpg', N'0985635353','12', N'Hùng Vương, Phường Thanh Hà',3.4,N'chuongmai',1)

--insert room
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'012414785', N'01', N'',N'phòng đơn 1 giường', 1, N'587416594',N'1')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID])VALUES (N'216587125', N'02', N'', N'phòng đôi 1 giường', 0, N'587416594',N'1')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'219657756', N'03', N'',N'phòng đôi 2 giường', 1, N'587416594',N'1')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'765324124', N'04', N'', N'phòng đơn 1 giường', 1, N'587416594',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'895365765', N'05', N'', N'phòng đơn 1 giường', 1, N'587416594',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'244714724', N'06', N'', N'phòng đôi 2 giường', 0, N'587416594',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'658715137', N'07', N'', N'phòng đơn 1 giường', 1, N'587416594',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'247965765', N'08', N'', N'phòng đơn 1 giường', 1, N'587416594',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'735947138', N'09', N'', N'phòng đơn 1 giường', 1, N'587416594',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'012414754', N'NO 1', N'', N'phòng đơn máy lạnh', 1, N'486258478',N'1')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'487621547', N'NO 2', N'', N'phòng đơn máy lạnh', 1, N'486258478',N'1')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'632658744', N'NO 3', N'', N'phòng đôi máy lạnh', 1, N'486258478',N'1')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'421578965', N'NO 4', N'', N'phòng đôi máy lạnh', 0, N'486258478',N'1')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'249632785', N'NO 5', N'', N'phòng đơn quạt máy', 0, N'486258478',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'124525876', N'NO 6', N'', N'phòng đơn máy lạnh', 1, N'486258478',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'632658452', N'NO 7', N'', N'phòng đơn máy lạnh', 1, N'486258478',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'758624864', N'NO 8', N'', N'phòng đơn máy lạnh', 1, N'486258478',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'587953254', N'phong 1', N'', N'phòng 1 giường mới', 1, N'587624587',N'1')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'456257895', N'phong 2', N'', N'phòng 1 giường mới', 0, N'587624587',N'1')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'248425478', N'phong 3', N'', N'phòng 2 giường điều hòa', 1, N'587624587',N'1')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'851658754', N'phong 4', N'', N'phòng 2 giường điều hòa', 0, N'587624587',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'236587157', N'phong 5', N'',N'phòng 1 giường điều hòa', 1, N'587624587',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'236854824', N'phong 6', N'', N'phòng 1 giường điều hòa', 0, N'587624587',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'895621458', N'phong 7', N'', N'phòng 1 giường điều hòa', 1, N'587624587',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'548587526', N'phong 8', N'', N'phòng 1 giường điều hòa', 1, N'587624587',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'326584957', N'phong 9', N'', N'phòng 1 giường nhỏ', 1, N'587624587',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'452713658', N'phong 10', N'', N'phòng 1 giường nhỏ', 1, N'587624587',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'986554787', N'phong 11', N'', N'phòng 1 giường nhỏ', 1, N'587624587',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'845764818', N'num 1', N'', N'phòng đơn nệm lò xo', 0, N'861435762',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'632548789', N'num 2', N'', N'phòng đơn nệm thường', 1, N'861435762',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'124569832', N'num 3', N'', N'phòng đơn nệm thường', 1, N'861435762',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'865741253', N'num 4', N'',N'phòng đơn nệm thường', 1, N'861435762',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'325487958', N'num 5', N'', N'phòng đôi nệm lò xo', 0, N'861435762',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'986525487', N'num 6', N'', N'phòng đôi nệm lò xo', 1, N'861435762',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'956325478', N'num 7', N'', N'phòng đôi nệm lò xo', 1, N'861435762',N'1')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'871245872', N'num 8', N'', N'phòng đơn nệm thường', 1, N'861435762',N'1')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'985568725', N'num 9', N'', N'phòng đơn nệm lò xo', 1, N'861435762',N'1')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'112547695', N'num 10', N'', N'phòng đơn nệm lò xo', 0 ,N'861435762',N'1')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'365982589', N'num 11', N'',N'phòng đơn nệm lò xo', 1, N'861435762',N'1')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'245782168', N'phòng số 1', N'', N'phòng đơn nhỏ', 1, N'625781458',N'1')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'626356896', N'phòng số 2', N'', N'phòng đơn nhỏ', 1, N'625781458',N'1')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'842565836', N'phòng số 3', N'', N'phòng đơn nhỏ', 1, N'625781458',N'1')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'895658269', N'phòng số 4', N'', N'phòng đơn nhỏ', 0, N'625781458',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'124858468', N'phòng số 5', N'', N'phòng đơn nhỏ', 1, N'625781458',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'642766983', N'phòng số 6', N'', N'phòng đôi máy lạnh', 0, N'625781458',N'1')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'528495989', N'phòng số 7', N'', N'phòng đôi máy lạnh', 1, N'625781458',N'1')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'663289984', N'phòng số 8', N'', N'phòng đôi máy lạnh', 1, N'625781458',N'1')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'215487599', N'phòng số 9', N'', N'phòng đôi máy lạnh', 0, N'625781458',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'854577756', N'phòng số 10', N'', N'phòng đôi máy lạnh', 1, N'625781458',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'326556884', N'phòng số 11', N'', N'phòng đôi máy lạnh', 1, N'625781458',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'521487545', N'Room 01', N'', N'phòng đôi nệm lò xo ', 1, N'842578129',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'521477856', N'Room 02', N'', N'phòng đôi nệm lò xo ', 1, N'842578129',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'632356985', N'Room 03', N'', N'phòng đôi nệm lò xo ', 0, N'842578129',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'784125569', N'Room 04', N'', N'phòng đôi nệm lò xo ', 0, N'842578129',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'336598852', N'Room 05', N'', N'phòng đôi nệm lò xo ', 0, N'842578129',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'745447857', N'Room 06', N'', N'phòng đôi nệm lò xo ', 1, N'842578129',N'2')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'225657877', N'Room 07', N'', N'phòng đơn nệm lò xo, máy lạnh ', 0, N'842578129',N'1')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'632577896', N'Room 08', N'', N'phòng đơn nệm lò xo, máy lạnh ', 1, N'842578129',N'1')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'996532157', N'Room 09', N'', N'phòng đơn nệm lò xo, máy lạnh ', 0, N'842578129',N'1')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'323565985', N'Room 10', N'', N'phòng đơn nệm lò xo, máy lạnh ', 1, N'842578129',N'1')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'747569865', N'Room 11', N'', N'phòng đơn nệm lò xo, máy lạnh ', 1, N'842578129',N'1')
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'332369568', N'Room 12', N'', N'phòng đơn nệm lò xo, máy lạnh ', 0, N'842578129',N'1')

--INSERT service 
INSERT [tblService] ([ServiceID], [ServiceName], [Price], [Status], [MotelID]) VALUES (N'489656859', N'Coca', 15000, 1, N'587416594')
INSERT [tblService] ([ServiceID], [ServiceName], [Price], [Status], [MotelID]) VALUES (N'021586822', N'lavie', 10000, 1, N'587416594')
INSERT [tblService] ([ServiceID], [ServiceName], [Price], [Status], [MotelID]) VALUES (N'565468569', N'bánh', 17000, 1, N'587416594')
INSERT [tblService] ([ServiceID], [ServiceName], [Price], [Status], [MotelID]) VALUES (N'563958176', N'khăn ướt', 5000, 1, N'587416594')
INSERT [tblService] ([ServiceID], [ServiceName], [Price], [Status], [MotelID]) VALUES (N'556558557', N'7 up', 15000, 1, N'587416594')
INSERT [tblService] ([ServiceID], [ServiceName], [Price], [Status], [MotelID]) VALUES (N'558579558', N'Coca', 15000, 1, N'842578129')
INSERT [tblService] ([ServiceID], [ServiceName], [Price], [Status], [MotelID]) VALUES (N'632452177', N'lavie', 10000, 1, N'842578129')
INSERT [tblService] ([ServiceID], [ServiceName], [Price], [Status], [MotelID]) VALUES (N'986587453', N'bánh', 17000, 1, N'842578129')
INSERT [tblService] ([ServiceID], [ServiceName], [Price], [Status], [MotelID]) VALUES (N'323201578', N'khăn ướt', 5000, 1, N'842578129')
INSERT [tblService] ([ServiceID], [ServiceName], [Price], [Status], [MotelID]) VALUES (N'012495547', N'7 up', 15000, 1, N'842578129')

--INSERT Notification

INSERT [tblNotification] ([AnnouncementID], [Title],[Desct], [Date], [UserID]) VALUES ('notifi01', N'Bạn có đơn đặt phòng mới',N'Bạn có đơn đặt phòng mới chi tiết xem tại đây', '2002-01-01','quan01') 
INSERT [tblNotification] ([AnnouncementID], [Title],[Desct], [Date], [UserID]) VALUES ('notifi02', N'Bạn có phòng đang trả',N'Phòng số 2 ở Motel 02 , khách đã trả phòng', '2002-01-01','tu06') 

INSERT [tblNotification] ([AnnouncementID], [Title],[Desct], [Date], [UserID]) VALUES ('notifi03', N'Bạn vừa đặt phòng thành công',N'Bạn vừa đặt phòng xong, vui lòng kiểm tra lại hóa đơn chi tiết', '2002-01-01','duy05') 
INSERT [tblNotification] ([AnnouncementID], [Title],[Desct], [Date], [UserID]) VALUES ('notifi04', N'Bạn vừa trả phòng',N'Bạn vừa trả phòng hãy đánh giá', '2002-01-01','duy05') 


---INSERT Booking

INSERT [tblBooking] ([BookingID], [BookingDate],[Desct], [Total],[Status], [UserID]) VALUES ('booking01', '2001-05-07',N'Booking table', 59900,1,'duy05') 
INSERT [tblBooking] ([BookingID], [BookingDate],[Desct], [Total],[Status], [UserID]) VALUES ('booking02', '2022-11-08',N'Booking table', 59900,1,'duy05') 
INSERT [tblBooking] ([BookingID], [BookingDate],[Desct], [Total],[Status], [UserID]) VALUES ('booking03', '2021-08-09',N'Booking table', 59900,1,'hai03') 
INSERT [tblBooking] ([BookingID], [BookingDate],[Desct], [Total],[Status], [UserID]) VALUES ('booking04', '2022-10-10',N'Booking table', 59900,1,'tuan04') 
INSERT [tblBooking] ([BookingID], [BookingDate],[Desct], [Total],[Status], [UserID]) VALUES ('booking05', '2022-12-10',N'khach nhan phong', 500000,1,'Lamm44')
INSERT [tblBooking] ([BookingID], [BookingDate],[Desct], [Total],[Status], [UserID]) VALUES ('booking06', '2022-12-10',N'khach nhan cung ngay', 600000,1,'hai03')
UPDATE tblUser set Image = 'assets/img/avatar.jpg' where Status = 0

---INSERT BookingDetail

INSERT [tblBookingDetail] ([BookingDetailID], [RoomID],[BookingID], [Price],[Time]) VALUES ('bookDt01', '012414785','booking01', 150000,2) 
INSERT [tblBookingDetail] ([BookingDetailID], [RoomID],[BookingID], [Price],[Time]) VALUES ('bookDt02', '765324124','booking02', 250000,1) 
INSERT [tblBookingDetail] ([BookingDetailID], [RoomID],[BookingID], [Price],[Time]) VALUES ('bookDt03', '248425478','booking03', 250000,2) 
INSERT [tblBookingDetail] ([BookingDetailID], [RoomID],[BookingID], [Price],[Time]) VALUES ('bookDt04', '842565836','booking04', 150000,1) 
INSERT [tblBookingDetail] ([BookingDetailID], [RoomID],[BookingID], [Price],[Time]) VALUES ('bookDt05', '323565985','booking05', 250000,5) 
INSERT [tblBookingDetail] ([BookingDetailID], [RoomID],[BookingID], [Price],[Time]) VALUES ('bookDt06', '332369568','booking05', 250000,7) 
INSERT [tblBookingDetail] ([BookingDetailID], [RoomID],[BookingID], [Price],[Time]) VALUES ('bookDt07', '225657877','booking06', 250000,1) 

---INSERT Payment

INSERT [tblPayment] ([PaymentID], [Total],[Desct], [PaymentTime],[Sender], [Receiver],[PaymentTypeName],[Status]) VALUES ('booking01', 290000,N'payment01 table', '2021-02-02','tuan04','tu06',N'Tien mat',1) 
INSERT [tblPayment] ([PaymentID], [Total],[Desct], [PaymentTime],[Sender], [Receiver],[PaymentTypeName],[Status]) VALUES ('booking02', 290000,N'payment01 table', '2021-02-02','tuan04','tu06',N'Chuyển khoản',1) 
INSERT [tblPayment] ([PaymentID], [Total],[Desct], [PaymentTime],[Sender], [Receiver],[PaymentTypeName],[Status]) VALUES ('booking03', 290000,N'payment01 table', '2021-02-02','hai03','hai03',N'Chuyển khoản',1) 
INSERT [tblPayment] ([PaymentID], [Total],[Desct], [PaymentTime],[Sender], [Receiver],[PaymentTypeName],[Status]) VALUES ('booking04', 290000,N'payment01 table', '2021-02-02','duy05','hai03',N'Tien mat',1) 
INSERT [tblPayment] ([PaymentID], [Total],[Desct], [PaymentTime],[Sender], [Receiver],[PaymentTypeName],[Status]) VALUES ('booking05', 700000,N'payment in day', '2022-12-11','lam','quan',N'Tien mat',1)


---INSERT Feedback
INSERT [tblFeedBack] ([FeedbackID], [Name],[Desct], [Ratings],[MotelID], [BookingID],[Status]) VALUES ('1', N'Phuong Thuy',N'Nhà trọ chất lượng tốt', 5,N'587416594',N'booking01',1)
INSERT [tblFeedBack] ([FeedbackID], [Name],[Desct], [Ratings],[MotelID], [BookingID],[Status]) VALUES ('2', N'Hong Anh',N'Đánh giá 5 sao', 5,N'842578129',N'booking02',1) 
INSERT [tblFeedBack] ([FeedbackID], [Name],[Desct], [Ratings],[MotelID], [BookingID],[Status]) VALUES ('3', N'Minh Nhat',N'Dịch vụ tốt', 5,N'486258478',N'booking03',1) 
INSERT [tblFeedBack] ([FeedbackID], [Name],[Desct], [Ratings],[MotelID], [BookingID],[Status]) VALUES ('4', N'Ngoc Hai',N'Phòng rất sạch sẽ', 4,N'587416594',N'booking04',1) 
INSERT [tblFeedBack] ([FeedbackID], [Name],[Desct], [Ratings],[MotelID], [BookingID],[Status]) VALUES ('5', N'Pham Tuan',N'Nhân viên phục vụ tốt', 4,N'861435762',N'booking01',1)
INSERT [tblFeedBack] ([FeedbackID], [Name],[Desct], [Ratings],[MotelID], [BookingID],[Status]) VALUES ('6', N'nhat lam',N'nha', 4,N'861435762',N'booking01',1)
INSERT [tblFeedBack] ([FeedbackID], [Name],[Desct], [Ratings],[MotelID], [BookingID],[Status]) VALUES ('5', N'Pham Tuan',N'Nhân viên phục vụ tốt', 4,N'861435762',N'booking01',1)


---INSERT Report
INSERT [tblReport] ([ReportID], [UserID],[Title], [Desct],[Date]) VALUES ('1', N'doan07',N'bao cao owner', N'Owner nay khong tot','2022-05-05') 
INSERT [tblReport] ([ReportID], [UserID],[Title], [Desct],[Date]) VALUES ('2', N'duy05',N'bao cao owner', N'Nhà trọ không đúng như mô tả','2021-05-05') 
INSERT [tblReport] ([ReportID], [UserID],[Title], [Desct],[Date]) VALUES ('3', N'tuan04',N'bao cao owner', N'Owner nay khong tot','2022-05-05') 
INSERT [tblReport] ([ReportID], [UserID],[Title], [Desct],[Date]) VALUES ('4', N'doan07',N'bao cao owner', N'Nhà trọ này chém giá','2022-05-05') 
INSERT [tblReport] ([ReportID], [UserID],[Title], [Desct],[Date]) VALUES ('5', N'doan07',N'bao cao owner', N'Owner nay khong tot','2022-05-05') 


---INSERT BookingServiceDetail

INSERT [tblBookingServiceDetail] ([BookingSeviceDetailID], [ServiceID],[BookingID], [Quantity],[Price]) VALUES ('1', '489656859','booking01', 3,15000) 
INSERT [tblBookingServiceDetail] ([BookingSeviceDetailID], [ServiceID],[BookingID], [Quantity],[Price]) VALUES ('6', '565468569','booking01', 1,25000) 
INSERT [tblBookingServiceDetail] ([BookingSeviceDetailID], [ServiceID],[BookingID], [Quantity],[Price]) VALUES ('5', '021586822','booking01', 1,25000) 
INSERT [tblBookingServiceDetail] ([BookingSeviceDetailID], [ServiceID],[BookingID], [Quantity],[Price]) VALUES ('2', '021586822','booking02', 2,10000) 
INSERT [tblBookingServiceDetail] ([BookingSeviceDetailID], [ServiceID],[BookingID], [Quantity],[Price]) VALUES ('3', '565468569','booking03', 5,17000) 
INSERT [tblBookingServiceDetail] ([BookingSeviceDetailID], [ServiceID],[BookingID], [Quantity],[Price]) VALUES ('4', '489656859','booking04', 1,15000) 


/*
SELECT * FROM tblService
SELECT * FROM tblRoom 
ORDER BY Name
DELETE tblRoom where Price >0
SELECT * FROM tblMotel
SELECT * FROM tblMotel WHERE Address like '%nhơn phú%';
SELECT * FROM tblUser
DELETE tblUser WHERE UserID = '01'
*/
UPDATE tblUser SET Password = '1' WHERE UserID = 'quan01' 
select COUNT(*) as NumberRoom from tblUser,tblMotel,tblRoom where tblUser.UserID = tblMotel.OwnerID and tblMotel.MotelID = tblRoom.MotelID and UserID = 'quan01'
select COUNT(*) as NumberService from tblUser,tblMotel,tblService where tblUser.UserID = tblMotel.OwnerID and tblMotel.MotelID = tblService.MotelID and UserID = 'quan01'
select COUNT(*) as NumberFeedback from  tblUser, tblMotel , tblFeedBack where tblUser.UserID = tblMotel.OwnerID AND tblMotel.MotelID = tblFeedBack.MotelID AND tblUser.UserID = 'quan01'		
(select tblBooking.BookingID, tblPayment.Total  from tblUser, tblMotel, tblRoom, tblBookingDetail, tblBooking ,tblPayment where tblUser.UserID = 'quan01' AND tblUser.UserID = tblMotel.OwnerID AND tblMotel.MotelID = tblRoom.MotelID AND tblRoom.RoomID = tblBookingDetail.RoomID AND tblBookingDetail.BookingID =tblBooking.BookingID AND tblBooking.BookingID = tblPayment.PaymentID GROUP BY tblBooking.BookingID , tblPayment.Total)
select BookingID, BookingDate from tblBooking Order by BookingDate DESC 

SELECT * FROM(SELECT tblUser.FullName,a.Name,a.BookingDate, a.Price, a.Time, a.Name , a.Status FROM (SELECT b.UserID,b.BookingID,m.Name as MotelName, d.Price, d.Time,b.BookingDate, b.Status, r.Name FROM tblUser as u, tblMotel as m, tblRoom as r, tblBookingDetail as d, tblBooking as b 
WHERE u.UserID = 'quan01' AND u.UserID = m.OwnerID AND m.MotelID = r.MotelID AND r.RoomID = d.RoomID  AND d.BookingID = b.BookingID) a inner join tblUser on a.UserID = tblUser.UserID )  

SELECT tblUser.FullName,tblUser.Image, a.MotelID,a.FeedbackID,a.BookingDate,a.Desct,a.Ratings FROM (SELECT TOP 5 tblBooking.UserID,tblMotel.MotelID,tblFeedBack.FeedbackID,tblBooking.BookingDate , tblFeedBack.Desct, tblFeedBack.Ratings FROM tblUser, tblMotel, tblFeedBack, tblBooking WHERE tblUser.UserID = 'quan01' AND tblUser.UserID = tblMotel.OwnerID AND tblMotel.MotelID = tblFeedBack.MotelID AND tblFeedBack.BookingID = tblBooking.BookingID) a inner join tblUser on tblUser.UserID = a.UserID ORDER BY a.BookingDate DESC
SELECT RoomID FROM tblRoom Where RoomID = ''
INSERT [tblRoom] ([RoomID], [Name], [Image], [Desct], [Status], [MotelID],[RoomTypeID]) VALUES (N'332369568', N'Room 12', N'', N'phòng đơn nệm lò xo, máy lạnh ', 0, N'842578129',N'1')

SELECT * FROM tblBooking as b, tblBookingDetail as bd , tblBookingServiceDetail as s WHERE b.BookingID = bd.BookingID AND b.BookingID = s.BookingID 
SELECT a.BookingID , a.BookingDetailID , count(s.BookingSeviceDetailID)FROM (SELECT b.BookingID,bd.BookingDetailID FROM tblBooking as b, tblBookingDetail as bd  WHERE b.BookingID = bd.BookingID AND b.BookingID='booking05' ) a left join tblBookingServiceDetail as s ON a.BookingID = s.BookingID GROUP BY a.BookingID, a.BookingDetailID

SELECT b.BookingID, m.MotelID,r.RoomID,b.Status, b.UserID FROM tblUser as u , tblMotel as m, tblRoom as r, tblBookingDetail as bd, tblBooking as b, tblPayment


select * from tblRoomType, tblRoom where tblRoomType.MotelID = '587416594' AND tblRoomType.RoomTypeID = tblRoom.RoomTypeID
update tblRoom set Status = 1 where RoomID = '765324124'
SELECT  s.ServiceID, s.ServiceName, s.Price, d.Quantity FROM tblBookingServiceDetail as d, tblService as s WHERE s.ServiceID = d.ServiceID AND BookingID = 'booking02'

SELECT COUNT(*) as NumberRoom FROM tblUser,tblMotel,tblRoomType,tblRoom 
WHERE tblUser.UserID = tblMotel.OwnerID AND tblMotel.MotelID = tblRoomType.MotelID AND tblRoomType.RoomTypeID = tblRoom.RoomTypeID AND UserID = 'quan01'

SELECT COUNT(*) as NumberService FROM tblUser,tblMotel,tblService
WHERE tblUser.UserID = tblMotel.OwnerID AND tblMotel.MotelID = tblService.MotelID AND UserID = 'quan01'

SELECT COUNT(*) as NumberFeedback FROM  tblUser, tblMotel , tblFeedBack 
WHERE tblUser.UserID = tblMotel.OwnerID AND tblMotel.MotelID = tblFeedBack.MotelID AND tblUser.UserID = 'quan01'

SELECT tblBooking.BookingID, tblPayment.Total
FROM tblUser, tblMotel,tblRoomType, tblRoom, tblBookingDetail, tblBooking ,tblPayment
WHERE tblUser.UserID = 'quan01' AND tblUser.UserID = tblMotel.OwnerID AND tblMotel.MotelID = tblRoomType.MotelID AND tblRoomType.RoomTypeID = tblRoom.RoomTypeID AND tblRoom.RoomID = tblBookingDetail.RoomID AND tblBookingDetail.BookingID =tblBooking.BookingID AND tblBooking.BookingID = tblPayment.PaymentID
GROUP BY tblBooking.BookingID , tblPayment.Total

SELECT tblUser.FullName, a.Price, a.Time, a.Name , a.Status 
FROM (SELECT TOP 5 b.UserID, d.Price, d.Time,b.BookingDate, b.Status, r.Name FROM tblUser as u, tblMotel as m,tblRoomType as rt, tblRoom as r, tblBookingDetail as d, tblBooking as b WHERE u.UserID = 'quan01' AND u.UserID = m.OwnerID AND m.MotelID = rt.MotelID AND rt.RoomTypeID = r.RoomTypeID AND r.RoomID = d.RoomID  AND d.BookingID = b.BookingID) a inner join tblUser on a.UserID = tblUser.UserID 
ORDER BY a.BookingDate DESC

SELECT tblUser.FullName,tblUser.Image, a.MotelID,a.FeedbackID,a.BookingDate,a.Desct,a.Ratings 
FROM (SELECT TOP 5 tblBooking.UserID,tblMotel.MotelID,tblFeedBack.FeedbackID,tblBooking.BookingDate , tblFeedBack.Desct, tblFeedBack.Ratings 
FROM tblUser, tblMotel, tblFeedBack, tblBooking
WHERE tblUser.UserID = 'quan01' AND tblUser.UserID = tblMotel.OwnerID AND tblMotel.MotelID = tblFeedBack.MotelID AND tblFeedBack.BookingID = tblBooking.BookingID) a inner join tblUser on tblUser.UserID = a.UserID ORDER BY a.BookingDate DESC

SELECT RoomID, r.Name, rt.Image, Price, rt.Desct, r.Status, rt.MotelID FROM tblMotel as m, tblRoom as r, tblRoomType as rt WHERE m.MotelID = '587416594' AND m.MotelID = rt.MotelID AND r.RoomTypeID = rt.RoomTypeID 

SELECT b.BookingID, m.MotelID,r.RoomID,u.FullName,b.Status,b.BookingDate,b.Total FROM tblMotel as m, tblRoomType as rt, tblRoom as r, tblBookingDetail as bd, tblBooking as b , tblUser as u
WHERE m.OwnerID = 'quan01' AND m.MotelID = rt.MotelID AND rt.RoomTypeID = r.RoomTypeID AND r.RoomID = bd.RoomID AND bd.BookingID = b.BookingID AND b.UserID = u.UserID

SELECT PaymentTypeName FROM tblPayment WHERE tblPayment.PaymentID = 'booking01'

SELECT COUNT(*) as NumberService FROM tblBooking as b, tblBookingServiceDetail as s WHERE b.BookingID = s.BookingID AND b.BookingID = 'booking01' 

SELECT RoomID, tblRoomType.RoomTypeID, Name, tblRoomType.TypeName, Price, Desct, Status, MotelID FROM tblRoom, tblRoomType WHERE MotelID = '587416594' and tblRoom.RoomTypeID = tblRoomType.RoomTypeID
SELECT RoomTypeID FROM tblRoomType Where RoomTypeID = '5654654' 

INSERT [tblRoomType] ([RoomTypeID], [TypeName], [Price], [Image], [Desct], [MotelID]) VALUES('78787','room king',485488,'images/motel-1.jpg','phòng đôi có máy lạnh','473658715')

SELECT  r.Status, r.RoomID, rt.TypeName,m.MotelID,m.Address, dt.Name as district, c.Name as city FROM tblCity as c, tblDistrict as dt, tblMotel as m, tblRoomType as rt, tblRoom as r
WHERE c.CityID = dt.CityID AND dt.DistrictID = m.DistrictID AND m.MotelID = rt.MotelID AND rt.RoomTypeID = r.RoomTypeID AND r.RoomID='012414785' 
	
SELECT u.FullName, u.Phone, u.CitizenNumber,u.Address FROM tblUser as u WHERE UserID like '%quan01%'

SELECT  s.ServiceID, s.ServiceName, s.Price, d.Quantity FROM tblBookingServiceDetail as d, tblService as s WHERE s.ServiceID = d.ServiceID AND BookingID = 'booking01'

SELECT b.BookingID, r.RoomID, rt.Price, bd.Time FROM tblBooking as b , tblBookingDetail as bd, tblRoom as r, tblRoomType as rt 
WHERE b.BookingID = bd.BookingID AND bd.RoomID = r.RoomID AND r.RoomTypeID = rt.RoomTypeID AND b.BookingID = 'booking01'


SELECT tblBooking.BookingID, tblBooking.Total
FROM tblUser, tblMotel,tblRoomType, tblRoom, tblBookingDetail, tblBooking 
WHERE tblUser.UserID = 'quan01' AND tblUser.UserID = tblMotel.OwnerID AND tblMotel.MotelID = tblRoomType.MotelID AND tblRoomType.RoomTypeID = tblRoom.RoomTypeID AND tblRoom.RoomID = tblBookingDetail.RoomID AND tblBookingDetail.BookingID =tblBooking.BookingID 
GROUP BY tblBooking.BookingID , tblBooking.Total

select tblMotel.Name as motelname, tblRoom.RoomID from tblMotel, tblRoom , tblRoomType where tblMotel.MotelID = tblRoomType.MotelID AND tblRoomType.RoomTypeID = tblRoom.RoomTypeID AND tblRoom.RoomID='012414785'

SELECT tblUser.FullName, a.Price, a.Time, a.Name , a.Status 
FROM (SELECT TOP 5 b.UserID, rt.Price, d.Time,b.BookingDate, b.Status, r.Name FROM tblUser as u, tblMotel as m,tblRoomType as rt, tblRoom as r, tblBookingDetail as d, tblBooking as b WHERE u.UserID = 'quan01' AND u.UserID = m.OwnerID AND m.MotelID = rt.MotelID AND rt.RoomTypeID = r.RoomTypeID AND r.RoomID = d.RoomID  AND d.BookingID = b.BookingID) a inner join tblUser on a.UserID = tblUser.UserID 
ORDER BY a.BookingDate DESC

SELECT b.Status, b.UserID,r.Status, b.BookingID, r.RoomID, rt.TypeName,m.MotelID,m.Address, dt.Name as district, c.Name as city, b.BookingDate,bd.Time FROM tblCity as c, tblDistrict as dt, tblMotel as m, tblRoomType as rt, tblRoom as r,tblBookingDetail as bd, tblBooking as b
WHERE c.CityID = dt.CityID AND dt.DistrictID = m.DistrictID AND m.MotelID = rt.MotelID AND rt.RoomTypeID = r.RoomTypeID AND r.RoomID = bd.RoomID AND bd.BookingID = b.BookingID AND r.RoomID= '452713658' AND (b.Status =0 OR b.Status=2)

SELECT * from tblUser, tblMotel where tblUser.UserID = tblMotel.OwnerID AND (tblUser.UserID = 'Quang09' or tblUser.UserID = 'quan01')

UPDATE tblRoom SET Status = 2 WHERE RoomID = '012414754'
select * from tblRoom

SELECT RoomID, Name, tblRoomType.TypeName, Price, Desct, tblRoom.Status, MotelID FROM tblRoom, tblRoomType WHERE MotelID = '587416594' and tblRoom.RoomTypeID = tblRoomType.RoomTypeID AND (tblRoom.Status = 0 OR tblRoom.Status = 1 )

UPDATE tblMotel SET status = 0 WHERE MotelID = '565687'

SELECT rt.RoomTypeID, rt.TypeName FROM tblMotel as m, tblRoomType as rt WHERE m.MotelID = rt.MotelID AND m.MotelID = '587416594'

SELECT  r.Name as RoomName,r.RoomTypeID,r.Status, r.RoomID, rt.TypeName,m.MotelID,m.Address, dt.Name as district, c.Name as city FROM tblCity as c, tblDistrict as dt, tblMotel as m, tblRoomType as rt, tblRoom as r
WHERE c.CityID = dt.CityID AND dt.DistrictID = m.DistrictID AND m.MotelID = rt.MotelID AND rt.RoomTypeID = r.RoomTypeID AND r.RoomID= '528495989'

SELECT RoomID, Name, tblRoomType.TypeName, Price, Desct, tblRoom.Status, MotelID FROM tblRoom, tblRoomType 
WHERE MotelID = '587416594' and tblRoom.RoomTypeID = tblRoomType.RoomTypeID AND tblRoom.Name like '%king%' AND (tblRoom.Status = 0 OR tblRoom.Status = 1 ) 

SELECT * FROM tblMotel as m , tblRoomType as rt, tblRoom as r WHERE m.MotelID = rt.MotelID AND rt.RoomTypeID = r.RoomTypeID AND m.MotelID = '587416594' AND r.Status = 1

SELECT * FROM tblService as s WHERE s.MotelID = '587416594';

UPDATE tblService SET ServiceName = ?, Price = ? WHERE ServiceID = ?

UPDATE tblPayment SET PaymentTime = CURRENT_TIMESTAMP , Desct = ?, PaymentTypeName = ? WHERE PaymentID = ?

UPDATE tblBooking SET Status = 1 WHERE BookingID = ?;

UPDATE tblRoom SET Status = 0 WHERE RoomID = ?;

UPDATE tblRoom SET Status = 1 WHERE RoomID = ?
select (month('2017/08/25')) from tblBooking

UPDATE tblBooking SET Status = 0 WHERE BookingID = ?

UPDATE tblRoom SET Status = 1 FROM tblBooking, tblBookingDetail, tblRoom WHERE tblBooking.BookingID = ? AND tblBooking.BookingID = tblBookingDetail.BookingID AND tblBookingDetail.RoomID = tblRoom.RoomID

SELECT * FROM tblBooking, tblBookingDetail, tblRoom WHERE tblBooking.BookingID = '8892133' AND tblBooking.BookingID = tblBookingDetail.BookingID AND tblBookingDetail.RoomID = tblRoom.RoomID

SELECT distinct b.BookingID, b.Total
FROM tblMotel as m , tblRoomType as rt, tblRoom as r , tblBookingDetail as bd, tblBooking as b
WHERE m.MotelID = '587416594' AND m.MotelID = rt.MotelID AND rt.RoomTypeID = r.RoomTypeID AND r.RoomID = bd.RoomID AND bd.BookingID = b.BookingID  AND (b.Status = 1 OR b.Status = 2 )


SELECT tblBooking.BookingID, tblBooking.Total
FROM tblUser, tblMotel,tblRoomType, tblRoom, tblBookingDetail, tblBooking ,tblPayment
WHERE tblUser.UserID = 'quan01' AND tblUser.UserID = tblMotel.OwnerID AND tblMotel.MotelID = tblRoomType.MotelID AND tblRoomType.RoomTypeID = tblRoom.RoomTypeID AND tblRoom.RoomID = tblBookingDetail.RoomID AND tblBookingDetail.BookingID =tblBooking.BookingID AND tblBooking.BookingID = tblPayment.PaymentID
GROUP BY tblBooking.BookingID , tblBooking.Total

SELECT BookingID FROM tblBooking 
WHERE MONTH(BookingDate) = 12 AND YEAR(BookingDate) = 2022

SELECT a.BookingDate, a.MotelID, SUM(a.Total) as total 
FROM (SELECT distinct m.MotelID,b.BookingID,b.BookingDate ,b.Total  FROM tblMotel as m, tblRoomType as rt, tblRoom as r, tblBookingDetail as bd ,tblBooking as b
WHERE m.MotelID = rt.MotelID AND rt.RoomTypeID = r.RoomTypeID AND r.RoomID = bd.RoomID AND bd.BookingID = b.BookingID AND m.OwnerID = 'quan01' AND (b.Status = 1 OR b.Status = 2 ) AND b.BookingDate between (SELECT DATEADD(wk, 0, DATEADD(DAY, 1-DATEPART(WEEKDAY, GETDATE()), DATEDIFF(dd, 0, GETDATE())))) and (SELECT DATEADD(wk, 1, DATEADD(DAY, 0-DATEPART(WEEKDAY, GETDATE()), DATEDIFF(dd, 0, GETDATE())))) ) a 
GROUP BY  a.BookingDate, a.MotelID, a.BookingDate 
ORDER BY a.BookingDate

SELECT CAST(a.BookingDate as DATE) as BookingDate, a.MotelID, SUM(a.Total) as total 
FROM (SELECT distinct m.MotelID,b.BookingID,b.BookingDate ,b.Total  FROM tblMotel as m, tblRoomType as rt, tblRoom as r, tblBookingDetail as bd ,tblBooking as b
WHERE m.MotelID = rt.MotelID AND rt.RoomTypeID = r.RoomTypeID AND r.RoomID = bd.RoomID AND bd.BookingID = b.BookingID AND m.OwnerID = 'leminhquan' AND (b.Status = 1 OR b.Status = 2 ) AND b.BookingDate between ( SELECT DATEFROMPARTS(YEAR(GETDATE()), 1, 1) ) and ( SELECT DATEFROMPARTS(YEAR(GETDATE()), 12, 31) ) )a 
GROUP BY  CAST(a.BookingDate as DATE), a.MotelID 
ORDER BY CAST(a.BookingDate as DATE)
	
SELECT m.OwnerID FROM tblRoom as r , tblRoomType as rt , tblMotel as m WHERE r.RoomID = '1741820' AND r.RoomTypeID = rt.RoomTypeID AND rt.MotelID = m.MotelID

SELECT b.Status, b.UserID, r.Status, b.BookingID, r.RoomID, rt.TypeName,m.MotelID,m.Address, dt.Name as district, c.Name as city, b.BookingDate,bd.Time FROM tblCity as c, tblDistrict as dt, tblMotel as m, tblRoomType as rt, tblRoom as r,tblBookingDetail as bd, tblBooking as b
WHERE c.CityID = dt.CityID AND dt.DistrictID = m.DistrictID AND m.MotelID = rt.MotelID AND rt.RoomTypeID = r.RoomTypeID AND r.RoomID = bd.RoomID AND bd.BookingID = b.BookingID AND r.RoomID= '3433790' AND (b.Status = 2 OR b.Status = 0 OR b.Status= 4)

SELECT RoomID, Name, tblRoomType.TypeName, Price, Desct, tblRoom.Status, MotelID FROM tblRoom, tblRoomType WHERE MotelID = '' and tblRoom.RoomTypeID = tblRoomType.RoomTypeID AND tblRoomType.RoomTypeID = '1' AND(tblRoom.Status = 0 OR tblRoom.Status = 1 )



CREATE FUNCTION dbo.StartOfWeek1  -- always a Sunday
(
    @d DATE
)
RETURNS DATE
AS
BEGIN
    RETURN (SELECT DATEADD(WEEK, DATEDIFF(WEEK, '19050101', @d), '19050101'));
END
GO

SELECT AnnouncementID, Title, tblNotification.Desct, tblNotification.Date as Date ,tblNotification.Status as Status, tblUser.FullName
FROM tblNotification,tblUser,tblBooking
WHERE tblUser.UserID = tblBooking.UserID AND tblBooking.BookingID = tblNotification.AnnouncementID AND tblNotification.OwnerID = 'leminhquan'
ORDER BY tblNotification.Date DESC 



(SELECT DATEADD(wk, 0, DATEADD(DAY, 1-DATEPART(WEEKDAY, GETDATE()), DATEDIFF(dd, 0, GETDATE()))))
(SELECT DATEADD(wk, 1, DATEADD(DAY, 0-DATEPART(WEEKDAY, GETDATE()), DATEDIFF(dd, 0, GETDATE())))) --last day current week

SELECT DATEFROMPARTS(YEAR(GETDATE()), 1, 1) AS 'First Day of Current Year';
SELECT DATEFROMPARTS(YEAR(GETDATE()), 12, 31) AS 'End of Current Year';
SELECT COUNT(*) as NumberNotification FROM  tblNotification, tblBooking
WHERE  tblBooking.UserID = ? AND tblBooking.BookingID = tblNotification.AnnouncementID AND tblNotification.Status = 1
SELECT AnnouncementID, Title, Desct, tblNotification.Date as Date ,tblNotification.Status as Status, tblUser.UserID FROM tblNotification,tblUser,tblBooking WHERE tblBooking.UserID = tblUser.UserID AND tblUser.UserID = ? AND tblBooking.BookingID = tblNotification.AnnouncementID

SELECT AnnouncementID, Title, tblNotification.Desct, tblNotification.Date as Date ,tblNotification.Status as Status, tblUser.FullName
FROM tblNotification,tblUser,tblBooking
WHERE tblUser.UserID = tblBooking.UserID AND tblBooking.BookingID = tblNotification.AnnouncementID AND tblNotification.OwnerID = ?

UPDATE tblRoom SET Status = 0 FROM tblBooking as b, tblBookingDetail as bd, tblRoom as r 
WHERE b.BookingID = '368141' AND b.BookingID = bd.BookingID AND bd.RoomID = r.RoomID

SELECT b.Status, b.Total ,bd.Time, m.Name as motelName,  r.Name as roomName, rt.TypeName as roomType, m.Address, d.Name as districtName, c.Name as cityName, b.BookingDate,p.PaymentTypeName
FROM tblPayment as p , tblBooking as b, tblBookingDetail as bd, tblRoom as r, tblRoomType as rt, tblMotel as m, tblDistrict as d, tblCity as c
WHERE b.BookingID = 'booking02' AND p.PaymentID = b.BookingID AND b.BookingID = bd.BookingID AND bd.RoomID = r.RoomID AND r.RoomTypeID = rt.RoomTypeID AND rt.MotelID = m.MotelID AND m.DistrictID = d.DistrictID AND d.CityID = c.CityID AND  r.RoomID='765324124'

SELECT s.ServiceID, s.ServiceName, s.Price, s.Status FROM tblRoom as r, tblRoomType as rt, tblMotel as m, tblService as s
WHERE r.RoomID = '012414785' AND r.RoomTypeID = rt.RoomTypeID AND rt.MotelID = m.MotelID AND m.MotelID = s.MotelID AND s.Status = 1

SELECT s.ServiceID , s.ServiceName, bsd.Quantity, s.Price FROM tblBooking as b, tblBookingServiceDetail as bsd , tblService as s
WHERE b.BookingID = 'booking02' AND b.BookingID = bsd.BookingID AND bsd.ServiceID = '021586822' AND bsd.ServiceID = s.ServiceID

UPDATE tblBookingServiceDetail SET Quantity = 15 , Total = 123123 FROM tblBooking , tblBookingServiceDetail
WHERE tblBooking.BookingID = 'booking02' AND tblBookingServiceDetail.ServiceID = '021586822' AND tblBooking.BookingID  = tblBookingServiceDetail.BookingID

UPDATE tblBooking SET Total = ? FROM tblBooking WHERE tblBooking.BookingID = ?

SELECT * FROM tblService WHERE tblService.ServiceID = '012495547'

INSERT [tblBookingServiceDetail] ([BookingSeviceDetailID], [ServiceID], [BookingID], [Quantity], [Total]) VALUES(?,?,?,?,?)
SELECT tblBooking.Total FROM tblBooking WHERE tblBooking.BookingID = ?

SELECT b.BookingID, r.RoomID, rt.Price, bd.Time FROM tblBooking as b , tblBookingDetail as bd, tblRoom as r, tblRoomType as rt
WHERE b.BookingID = bd.BookingID AND bd.RoomID = r.RoomID AND r.RoomTypeID = rt.RoomTypeID AND b.BookingID = ?

SELECT s.Price, sd.Quantity FROM tblBooking as b, tblBookingServiceDetail as sd, tblService as s 
WHERE b.BookingID = sd.BookingID AND sd.ServiceID = s.ServiceID AND b.BookingID = ?

