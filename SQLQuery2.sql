/*1*/
select mgrSSN,empName,d.depNum,depName
from tblEmployee e, tblDepartment d
where e.empSSN = d.mgrSSN AND depName LIKE N'Phòng Nghiên cứu và phát triển';
go
select *
from tblDepartment
go
select *
from tblDependent
go
select *
from tblEmployee
go
select *
from tblProject
go
select *
from tblLocation
go
select *
from tblDepLocation
go
/*2*/
select proNum,proName,depName
from tblDepartment d, tblProject p
where d.depNum=p.depNum AND depName LIKE  N'Phòng Nghiên cứu và phát triển'
go
/*3*/
select proNum,proName,depName
from tblProject p, tblDepartment d
where proName LIKE N'ProjectB' AND p.depNum = d.depNum
go
/*4*/
select e.empSSN, e.empName
from tblEmployee e, tblEmployee a
where e.supervisorSSN = a.empSSN and a.empName LIKE N'Mai Duy An'
go
/*5*/
select a.empSSN, a.empName
from tblEmployee e, tblEmployee a
where e.supervisorSSN = a.empSSN and e.empName LIKE N'Mai Duy An'
go
/*6*/
select l.locNum,locName
from tblProject p, tblLocation l
where p.locNum = l.locNum and p.proName LIKE N'ProjectA'
go
/*7*/
select proNum,proName
from tblProject p, tblLocation l
where p.locNum = l.locNum and l.locName LIKE N'TP Hồ Chí Minh'
go
/*8*/ 
select depName,depBirthdate,empName
from tblDependent d, tblEmployee e
where YEAR(GETDATE()) - YEAR(depBirthdate)>18 AND d.empSSN = e.empSSN
go
/*9*/
select depName,depName,empName
from tblDependent d, tblEmployee e
where d.empSSN = e.empSSN and d.depSex LIKE N'M'
go
/*10*/
select dl.depNum, d.depName, locName
from tblDepartment d, tblDepLocation dl, tblLocation l
where  d.depName like N'Phòng Nghiên cứu và phát triển' AND d.depNum = dl.depNum AND dl.locNum = l.locNum
go 
/*11*/
select proNum, proName, depName
from tblProject p, tblLocation l, tblDepartment d
where l.locName like N'TP Hồ Chí Minh' AND l.locNum = p.locNum AND p.depNum = d.depNum
go
/*12*/
select e.empName, d.depName, d.depRelationship
from tblDependent d, tblDepartment dp, tblEmployee e
where dp.depName like N'Phòng Nghiên cứu và phát triển' AND dp.depNum = e.depNum AND e.empSSN = d.empSSN AND d.depSex LIKE N'F'
go
/*13*/ 
select e.empName,d.depName,d.depRelationship
from tblDependent d, tblEmployee e, tblDepartment dp
where YEAR(GETDATE()) - YEAR(depBirthdate)>18 AND d.empSSN = e.empSSN AND e.depNum = dp.depNum AND dp.depName LIKE N'Phòng Nghiên cứu và phát triển'
go
/*14*/
select  d.depSex,COUNT(d.depSex) AS number
from tblDependent d
group by depSex
order by count(*) 
go
/*15*/
select  depRelationship,COUNT(depRelationship) AS number
from tblDependent d
group by depRelationship
order by count(*) 
go
/*16*/
select  d.depNum, d.depName,COUNT(d.depNum) AS number_employee
from tblDepartment d,tblEmployee e
where d.depNum = e.depNum
group by d.depNum, d.depName
go
/*17*/
select top(1)
dp.depNum,dp.depName, count(dp.depNum) as number
from tblDependent d, tblDepartment dp, tblEmployee e
where dp.depNum = e.depNum AND e.empSSN = d.empSSN
group by dp.depNum, dp.depName
order by count(*)
go
/*17 c2*/
select TOP(1) dp.depNum,dp.depName,count(*) as number_of_people
from tblDependent d, tblDepartment dp, tblEmployee e
where dp.depNum = e.depNum AND e.empSSN = d.empSSN
group by dp.depNum, dp.depName
order by number_of_people ASC
go
/*18*/
select TOP(2) dp.depNum,dp.depName,count(*) as number_of_people
from tblDependent d, tblDepartment dp, tblEmployee e
where dp.depNum = e.depNum AND e.empSSN = d.empSSN
group by dp.depNum, dp.depName
order by count(*) Desc
go
/*19*/
select e.empSSN, e.empName, d.depName, sum(w.workHours) as sum_of_worktime
from tblEmployee e, tblWorksOn w,tblDepartment d
where d.depNum = e.depNum AND e.empSSN = w.empSSN
group by e.empSSN, e.empName,d.depName
go
/*20*/
select d.depNum,d.depName, sum(w.workHours)
from tblDepartment d, tblProject p, tblWorksOn w
where d.depNum = p.depNum AND p.proNum = w.proNum
group by d.depNum,d.depName
go
/*21*/
select top(3)
 e.empSSN, e.empName, d.depName, sum(w.workHours) as sum_of_worktime
from tblEmployee e, tblWorksOn w,tblDepartment d
where d.depNum = e.depNum AND e.empSSN = w.empSSN
group by e.empSSN, e.empName,d.depName
order by sum_of_worktime ASC
go
/*22*/
select top(1)
 e.empSSN, e.empName, d.depName, sum(w.workHours) as sum_of_worktime
from tblEmployee e, tblWorksOn w,tblDepartment d
where d.depNum = e.depNum AND e.empSSN = w.empSSN
group by e.empSSN, e.empName,d.depName
order by sum_of_worktime desc
go
/*23*/
select e.empSSN, e.empName,d.depName
from tblEmployee e, tblDepartment d, tblProject p
where e.depNum = d.depNum AND d.depNum = p.depNum 
group by e.empSSN, e.empName,d.depName
having count(e.empSSN) = 1
go
/*24*/
select e.empSSN, e.empName,d.depName
from tblEmployee e, tblDepartment d, tblProject p
where e.depNum = d.depNum AND d.depNum = p.depNum 
group by e.empSSN, e.empName,d.depName
having count(e.empSSN) = 2
go
/*25*/
select e.empSSN, e.empName,d.depName
from tblEmployee e, tblDepartment d, tblProject p
where e.depNum = d.depNum AND d.depNum = p.depNum 
group by e.empSSN, e.empName,d.depName
having count(e.empSSN) >= 2
go
/*26*/
select p.proNum, p.proName,count(e.empSSN) as number_of_employee
from tblProject p, tblDepartment d, tblEmployee e
where p.depNum = d.depNum AND d.depNum = e.depNum
group by p.proNum, p.proName
go
/*27*/
select p.proNum,p.proName,sum(w.workHours)
from tblProject p, tblWorksOn w
where p.proNum = w.proNum
group by p.proNum,p.proName
go
/*28*/
select top(2)
p.proNum, p.proName,count(e.empSSN) as number_of_employee
from tblProject p, tblDepartment d, tblEmployee e
where p.depNum = d.depNum AND d.depNum = e.depNum
group by p.proNum, p.proName
order by number_of_employee Asc
go
/*29*/
select top(3)
p.proNum, p.proName,count(e.empSSN) as number_of_employee
from tblProject p, tblDepartment d, tblEmployee e
where p.depNum = d.depNum AND d.depNum = e.depNum
group by p.proNum, p.proName
order by number_of_employee desc
/*30*/
select top(1)
p.proNum,p.proName,sum(w.workHours) as sum_of_time
from tblProject p, tblWorksOn w
where p.proNum = w.proNum
group by p.proNum,p.proName
order by sum_of_time ASC
go
/*31*/
select top(1)
p.proNum,p.proName,sum(w.workHours) as sum_of_time
from tblProject p, tblWorksOn w
where p.proNum = w.proNum
group by p.proNum,p.proName
order by sum_of_time DESC
go
/*32*/
select l.locName, count(l.locName) as sum_of_department
from tblDepartment d, tblDepLocation dl, tblLocation l
where d.depNum=dl.depNum AND dl.locNum = l.locNum
group by l.locName
go
/*33*/
select d.depNum, d.depName,count(l.locNum) as sum_of_location
from tblDepartment d, tblDepLocation dl, tblLocation l
where d.depNum=dl.depNum AND dl.locNum = l.locNum
group by d.depNum, d.depName
go
/*34*/
select top(1)
d.depNum, d.depName,count(l.locNum) as sum_of_location
from tblDepartment d, tblDepLocation dl, tblLocation l
where d.depNum=dl.depNum AND dl.locNum = l.locNum
group by d.depNum, d.depName
order by sum_of_location DESC
go
/*35*/
select top(1)
d.depNum, d.depName,count(l.locNum) as sum_of_location
from tblDepartment d, tblDepLocation dl, tblLocation l
where d.depNum=dl.depNum AND dl.locNum = l.locNum
group by d.depNum, d.depName
order by sum_of_location ASC
go
/*36*/
select top(1)
l.locName, count(l.locName) as sum_of_department
from tblDepartment d, tblDepLocation dl, tblLocation l
where d.depNum=dl.depNum AND dl.locNum = l.locNum
group by l.locName
order by sum_of_department DESC
go
/*37*/
select top(2)
l.locName, count(l.locName) as sum_of_department
from tblDepartment d, tblDepLocation dl, tblLocation l
where d.depNum=dl.depNum AND dl.locNum = l.locNum
group by l.locName
order by sum_of_department ASC
go
/*38*/
select top(13)
e.empSSN,e.empName,count(e.empSSN) as sum_of_dependent
from tblEmployee e, tblDependent d
where e.empSSN=d.empSSN
group by e.empSSN,e.empName
order by sum_of_dependent DESC
go
/*39*/
select top(13)
e.empSSN,e.empName,count(e.empSSN) as sum_of_dependent
from tblEmployee e, tblDependent d
where e.empSSN=d.empSSN
group by e.empSSN,e.empName
order by sum_of_dependent ASC
go
/*40*/
select e.empSSN,e.empName,dp.depName
from  tblEmployee e,tblDepartment dp
where  e.depNum = dp.depNum
EXCEPT
select e.empSSN,e.empName,dp.depName
from   tblDependent d ,tblEmployee e,tblDepartment dp
where  e.depNum = dp.depNum AND e.empSSN = d.empSSN
go
/*41*/
select dp.depNum, dp.depName
from  tblEmployee e,tblDepartment dp
where  e.depNum = dp.depNum
EXCEPT
select  dp.depNum ,dp.depName
from   tblDependent d ,tblEmployee e,tblDepartment dp
where  e.depNum = dp.depNum AND e.empSSN = d.empSSN
go
/*42*/
select e.empSSN, e.empName,dp.depName
from  tblEmployee e,tblDepartment dp
where  e.depNum = dp.depNum 
EXCEPT
select e.empSSN, e.empName,dp.depName
from  tblEmployee e,tblDepartment dp,tblProject p
where  e.depNum = dp.depNum AND dp.depNum = p.depNum
go
/*43*/
select dp.depNum,dp.depName
from  tblEmployee e,tblDepartment dp
where  e.depNum = dp.depNum 
EXCEPT
select dp.depNum,dp.depName
from  tblEmployee e,tblDepartment dp,tblProject p
where  e.depNum = dp.depNum AND dp.depNum = p.depNum
go
/*44*/
select dp.depNum,dp.depName
from  tblEmployee e,tblDepartment dp
where  e.depNum = dp.depNum 
EXCEPT
select dp.depNum,dp.depName
from  tblEmployee e,tblDepartment dp,tblProject p
where  e.depNum = dp.depNum AND dp.depNum = p.depNum AND p.proName LIKE N'ProjectA'
go
/*45*/
select d.depNum,d.depName, count(p.depNum) as sum_of_project
from tblProject p, tblDepartment d
where d.depNum = p.depNum 
group by d.depNum,d.depName
go
/*46*/
select top(3)
d.depNum,d.depName, count(p.depNum) as sum_of_project
from tblProject p, tblDepartment d
where d.depNum = p.depNum 
group by d.depNum,d.depName
order by sum_of_project ASC
go
/*47*/
select top(1)
d.depNum,d.depName, count(p.depNum) as sum_of_project
from tblProject p, tblDepartment d
where d.depNum = p.depNum 
group by d.depNum,d.depName
order by sum_of_project DESC
go
/*48*/
select d.depNum,d.depName,count(e.empSSN),p.proName
from tblEmployee e, tblDepartment d, tblProject p
where e.depNum = d.depNum AND d.depNum = p.depNum 
group by d.depNum,d.depName,p.proName
having count(e.empSSN) > 5
go
/*49*/
select e.empSSN,e.empName
from tblDepartment d, tblEmployee e
where d.depNum=e.depNum AND d.depName like N'Phòng nghiên cứu và phát triển'
EXCEPT
select e.empSSN,e.empName
from tblEmployee e, tblDependent dp
where e.empSSN=dp.empSSN 
go
/*50*/
select e.empSSN,e.empName,SUM(w.workHours)
from tblEmployee e,tblWorksOn w
where e.empSSN=w.empSSN
group by e.empSSN,e.empName
EXCEPT
select e.empSSN,e.empName,SUM(w.workHours)
from tblEmployee e, tblWorksOn w, tblDependent d
where e.empSSN=d.empSSN AND e.empSSN=w.empSSN
group by e.empSSN,e.empName 
go
/*51*/
select e.empSSN,e.empName,SUM(w.workHours)
from tblEmployee e,tblWorksOn w
where e.empSSN=w.empSSN
group by e.empSSN,e.empName
EXCEPT
select e.empSSN,e.empName,SUM(w.workHours)
from tblEmployee e, tblWorksOn w, tblDependent d
where e.empSSN=d.empSSN AND e.empSSN=w.empSSN
group by e.empSSN,e.empName 
having count(e.empSSN) > 3
go