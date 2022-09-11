use PlantShop
CREATE TABLE [Plants] (
    [PID]	    [NVARCHAR](50),
	[PName]	[NVARCHAR](60),
    [imgpath]	        [NVARCHAR](50),
    [price]	        [DECIMAL],
    [status]   [INT],
    [cateID]    [NVARCHAR](50)FOREIGN KEY REFERENCES [Categories],
    PRIMARY KEY (PID)
);
GO
INSERT Categories (cateID,cateName) VALUES (N'cay cao',N'cac loai cay cao')
INSERT Plant (PID,PName,imgpath,price,status,cateID) VALUES (N'1',N'cay thong',N'images/ca-rot.jpg',12,1,N'cay cao')
INSERT Plant (PID,PName,imgpath,price,status,cateID) VALUES (N'4',N'cay chuoi',N'images/ca-rot.jpg',12,4,N'cay cao')
INSERT Plant (PID,PName,imgpath,price,status,cateID) VALUES (N'3',N'cay xoai',N'images/ca-rot.jpg',12,0,N'cay cao')
SELECT PID, PName, imgpath, price, status, cateID FROM Plants WHERE PName like '%c%' AND status = 1

CREATE TABLE [Plant] (
    [PID]	    [NVARCHAR](50),
	[PName]	[NVARCHAR](60),
    [imgpath]	        [NVARCHAR](50),
    [price]	        [DECIMAL],
    [status]   [bit],
    [cateID]    [NVARCHAR](50),
    PRIMARY KEY (PID)
);
GO

select * from Plant
UPDATE Plant SET status =1 WHERE status =0
use FoodDB
select * from tblOrder where userID like 'tu2001'
select * from tblProduct, tblOrder, tblOrderDetail where userID like 'tu2001' AND tblOrder.orderID = tblOrderDetail.orderID AND tblOrderDetail.productID = tblProduct.productID
