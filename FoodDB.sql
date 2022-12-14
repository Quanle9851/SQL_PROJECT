USE [master];
GO

DROP DATABASE FoodDB
GO

CREATE DATABASE FoodDB
GO

USE FoodDB
GO

CREATE TABLE [tblRole] (
    [roleID]	[NVARCHAR](20),
	[roleName]	[NVARCHAR](50),
    PRIMARY KEY (roleID)
);
GO

CREATE TABLE [tblCategory] (
    [categoryID]	[NVARCHAR](50),
	[categoryName]  [NVARCHAR](50), 
    PRIMARY KEY (categoryID)
);
GO

CREATE TABLE [tblUser] (
    [userID]	[NVARCHAR](50),
	[fullName]	[NVARCHAR](50),
    [password]	[NVARCHAR](50),
    [roleID]    [NVARCHAR](20) FOREIGN KEY REFERENCES [tblRole],
    [address]   [NVARCHAR](50),
    [birthDay]	[DATE],
    [phone]	    [VARCHAR](15),
    [email]     [NVARCHAR](30),
    PRIMARY KEY (userID)
);
GO

CREATE TABLE [tblProduct] (
    [productID]	    [NVARCHAR](50),
	[productName]	[NVARCHAR](60),
    [image]	        [NVARCHAR](50),
    [price]	        [DECIMAL],
    [quantity]      [INT],
    [categoryID]    [NVARCHAR](50)FOREIGN KEY REFERENCES [tblCategory],
    [importDate]    [DATE],
    [usingDate]     [DATE],
    PRIMARY KEY (productID)
);
GO

CREATE TABLE [tblOrder] (
    [orderID]	 [NVARCHAR](50),
	[orderDate]	 [DATE],
    [total]		 [DECIMAL],
    [userID]	 [NVARCHAR](50) FOREIGN KEY REFERENCES [tblUser],
    PRIMARY KEY (orderID)
);
GO
CREATE TABLE [tblOrderDetail] (
    [detailID]	[NVARCHAR](50),
	[price]		[DECIMAL],
    [quantity]	[INT],
    [orderID]	[NVARCHAR](50) FOREIGN KEY REFERENCES [tblOrder],
    [productID] [NVARCHAR](50)FOREIGN KEY REFERENCES [tblProduct],
    PRIMARY KEY (detailID)
);
GO





--chen du lieu
INSERT [tblRole] ([roleID], [roleName]) VALUES (N'admin01', N'admin')
INSERT [tblRole] ([roleID], [roleName]) VALUES (N'user02', N'user')
INSERT [tblUser] ([userID], [fullName], [password], [roleID], [address], [birthday], [phone], [email]) VALUES (N'user11', N'le minh hung', N'1', N'user02', N'Ben Tre','2005-06-01',098875126,N'hoangquan9851@gmail.com')
INSERT [tblUser] ([userID], [fullName], [password], [roleID], [address], [birthday], [phone], [email]) VALUES (N'adminshop', N'Le Minh Quan', N'1', N'admin01', N'TP.thu duc, HCM','2001-05-07',0942949219,N'quanlmse150533@fpt.edu.vn')
INSERT [tblUser] ([userID], [fullName], [password], [roleID], [address], [birthday], [phone], [email]) VALUES (N'hai2001', N'Nguyen ngoc hai', N'2', N'user02', N'TP.thu duc, HCM','2001-10-10',0989201457,N'')
INSERT [tblUser] ([userID], [fullName], [password], [roleID], [address], [birthday], [phone], [email]) VALUES (N'tu2001', N'Nguyen Doan Tu', N'3', N'user02', N'Q.1, HCM','2001-08-27',0344871023,N'tundse1506773@fpt.edu.vn')
INSERT [tblUser] ([userID], [fullName], [password], [roleID], [address], [birthday], [phone], [email]) VALUES (N'chuong2001', N'Nguyen Dinh Chuong', N'1', N'user02', N'Q.10, HCM','2001-09-07',0947129887,N'')
INSERT [tblUser] ([userID], [fullName], [password], [roleID], [address], [birthday], [phone], [email]) VALUES (N'adminshop2', N'le minh quan', N'1', N'admin01', N'TP.thu duc, HCM','2001-05-07',0942949219,N'quanlmse150533@fpt.edu.vn')
INSERT [tblUser] ([userID], [fullName], [password], [roleID], [address], [birthday], [phone], [email]) VALUES (N'adminshop3', N'hồ quang hiếu', N'1', N'admin01', N'TP.thu duc, HCM','2001-05-07',0942949219,N'quanlmse150533@fpt.edu.vn')

INSERT [tblCategory] ([categoryID], [categoryName]) VALUES (N'Rau Cu', N'các loại rau củ')
INSERT [tblCategory] ([categoryID], [categoryName]) VALUES (N'Hoa Qua', N'các loại hoa quả')

INSERT [tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate]) VALUES (N'01', N'Cà rốt gói 500g', N'images/ca-rot.jpg', 12, 20, N'Rau Cu','2022-03-22', '2022-03-25')
INSERT [tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate]) VALUES (N'02', N'Bắp mỹ gói 2 trái', N'images/bap-my.jpg', 17, 32, N'Rau Cu','2022-03-20', '2022-03-23')
INSERT [tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate]) VALUES (N'03', N'Cà chua gói 500g', N'images/ca-chua.jpg', 32, 10, N'Rau Cu','2022-03-23', '2022-03-26')
INSERT [tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate]) VALUES (N'04', N'Hành tây gói 500g', N'images/hanh-tay.jpg', 20, 22, N'Rau Cu','2022-03-18', '2022-03-23')
INSERT [tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate]) VALUES (N'05', N'Dưa leo gói 500g', N'images/dua-leo.jpg', 15, 15, N'Rau Cu','2022-03-17', '2022-03-25')
INSERT [tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate]) VALUES (N'06', N'Khoai tây túi 500g', N'images/khoai-tay.jpg', 14, 8, N'Rau Cu','2022-03-12', '2022-03-16')
INSERT [tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate]) VALUES (N'07', N'Su hào gói 300g', N'images/su-hao.jpg', 7, 17, N'Rau Cu','2022-03-19', '2022-03-23')
INSERT [tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate]) VALUES (N'09', N'Tỏi bông sen gói 100g', N'images/toi.jpg', 6, 20, N'Rau Cu','2022-03-18', '2022-03-26')
INSERT [tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate]) VALUES (N'10', N'Táo gói 3 trái', N'images/tao.jpg', 200, 40, N'Hoa Qua','2022-03-17', '2022-03-27')
INSERT [tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate]) VALUES (N'11', N'Quýt 1kg', N'images/quyt.jpg', 79, 30, N'Hoa Qua','2022-03-14', '2022-03-25')
INSERT [tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate]) VALUES (N'12', N'Xoài túi 1kg', N'images/xoai.jpg', 75, 20, N'Hoa Qua','2022-03-17', '2022-03-29')
INSERT [tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate]) VALUES (N'13', N'Lê túi 1kg', N'images/le.jpg', 39, 40, N'Hoa Qua','2022-03-17', '2022-03-27')
INSERT [tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate]) VALUES (N'14', N'Chuối nải 1kg', N'images/chuoi.jpg', 27, 40, N'Hoa Qua','2022-03-12', '2022-03-29')
INSERT [tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate]) VALUES (N'15', N'Ổi vỉ 1kg', N'images/oi.jpg', 15, 26, N'Hoa Qua','2022-03-14', '2022-03-27')
INSERT [tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate]) VALUES (N'16', N'Dưa hấu 1 trái', N'images/dua-hau.jpg', 107, 40, N'Hoa Qua','2022-03-17', '2022-03-27')


INSERT tblOrder (orderID,orderDate,total,userID) VALUES (N'112',null,18,N'tu2001')

SELECT orderID FROM tblOrder WHERE userID='tu2001' AND orderDate is null;
DELETE tblUser Where userID = 'haha'
DELETE tblOrder Where userID = 'tu2001' 
DELETE tblProduct Where productID = '01'
SELECT * FROM tblOrder;
SELECT * FROM tblUser;
SELECT * FROM tblProduct;
SELECT * FROM tblProduct WHERE quantity = 20;
SELECT * FROM tblProduct WHERE productName like '%t%';
SELECT productID, productName, image, price, quantity, catagoryID, importDate,usingDate FROM tblProduct WHERE productName like '%c%'
UPDATE tblProduct SET productName='haha', image='sdfsdf', price=15.00,quantity=7,catagoryID='Rau Cu',importDate='20-5-2021',usingDate='2021-05-21'  WHERE productID='05'
DROP table tblProduct
SELECT userID, fullname, roleID, address, birthday, phone, email FROM tblUser WHERE userID='helloWord'
SELECT fullname FROM tblUser WHERE userID = 'user11' AND password = '0'
SELECT productID, productName,importDate,usingDate FROM tblProduct WHERE CURRENT_TIMESTAMP < usingDate
SELECT productName FROM tblProduct WHERE productID='01' AND quantity >= 21
INSERT tblOrder (orderID,orderDate,total,userID) VALUES (N'01',CURRENT_TIMESTAMP,12,N'user11')
SELECT * from tblOrder
SELECT * from tblOrderDetail
SELECT quantity FROM tblProduct WHERE productID='01'
DELETE tblOrder Where total >0
DELETE tblOrderDetail Where quantity >0