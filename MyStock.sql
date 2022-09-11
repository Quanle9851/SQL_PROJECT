CREATE DATABASE MyStock 
CREATE TABLE Cars (
CarID    int  primary key,
CarName  varchar(50) ,
Manufacturer  varchar(50),
Price	money,
ReleasedYear int,
)
INSERT Cars (CarID, CarName, Manufacturer, Price, ReleasedYear) VALUES (1,'Accord','Honda Motor Company', 249700000,2021)
INSERT Cars (CarID, CarName, Manufacturer, Price, ReleasedYear) VALUES (2,'Clarity','Honda Motor Company', 45000,2021)
INSERT Cars (CarID, CarName, Manufacturer, Price, ReleasedYear) VALUES (3,'BMW 8 Series','BMW', 33400,2021)
INSERT Cars (CarID, CarName, Manufacturer, Price, ReleasedYear) VALUES (4,'Audi A6','Audi', 85000,2021)
INSERT Cars (CarID, CarName, Manufacturer, Price, ReleasedYear) VALUES (5,'Mercides benz','Mercides', 14000,2021)