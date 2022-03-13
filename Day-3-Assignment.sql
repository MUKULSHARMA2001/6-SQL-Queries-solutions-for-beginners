---------------------------------------------MUKUL-----SHARMA---------------------------------------------------------------------
USE [mukul.sharma]
drop table Employees
--EMPLOYEES TABLE

CREATE TABLE Employees(
EmployeeId INT PRIMARY KEY IDENTITY(1,1) , 
Name VARCHAR(35),
Salary MONEY,
DeptId INT FOREIGN KEY REFERENCES Departments(Deptid))
SELECT * FROM Employees
INSERT INTO Employees(Name,Salary, DeptId)
Values('Mukul Sharma',20000,1),
('Hamid Saikh',30000,2),
('Pranav Patel',25000,1),
('Nidhi',40000,2);
GO

--DEPARTMENTS TABLE
----------------------------------------------------------
CREATE TABLE Departments(
DeptId INT PRIMARY KEY IDENTITY(1,1),
Name VARCHAR(50))
drop table Departments;
GO

--INSERT VALUES IN DEPARTMENTS TABLE
INSERT INTO Departments(Name)
VALUES('.net')
--------------------------------------------------------------
--COMPANIES TABLE

CREATE TABLE Companies(
CompanyId INT IDENTITY(1,1) PRIMARY KEY,
Name VARCHAR(40),
City VARCHAR(20),
PHONE DECIMAL(10,0)
)

select * from Companies

--INSERT VALUES IN Companies TABLE
insert into Companies (
Name,
City,
PHONE)
values('The One Tech','Ahmeadab',5865236558),('TenoSpark','Ahmeadab',5865236552)

---------------------------------------------------------------------------------------------------------------------------------
--EDUCATION DETAILS TABLE
CREATE TABLE EducationDetail(
Degree VARCHAR(100),
StartDate DATE,
CompletionDate DATE,
Score FLOAT,
University VARCHAR(100),
EmployeeId INT FOREIGN KEY REFERENCES Employees (EmployeeId),
EduLevel int
)
--drop table EducationDetail

--INSERT VALUES IN EducationDetails TABLE
insert into dbo.EducationDetail(Degree,
StartDate,
CompletionDate,
Score,
University,
EmployeeId,
EduLevel)
values('B.E','2019-03-03','2022-04-04',90,'GTU',1,2),
('Diploma','2020-03-03','2023-04-04',80,'GTU',2,1),
('M.E','2018-03-03','2021-04-04',70,'GTU',3,3)


select * from EducationDetail

-----------------------------------------------------------------------------------------------------------------------------

--EMPLOYMENTDETAILS TABLE
CREATE TABLE EmployeementDetail(
Id INT IDENTITY(1,1) PRIMARY KEY,
StartDate DATE, 
EndDate DATE,
EmployeeId INT FOREIGN KEY REFERENCES Employees(EmployeeId),
CompanyId INT FOREIGN KEY REFERENCES Companies(CompanyId)
)
select * from EmployeementDetail
--INSERT VALUES IN EmployeementDetails TABLE
insert into dbo.EmployeementDetail(
StartDate , 
EndDate,
EmployeeId,
CompanyId)
values('2021-03-03','2022-04-04',1,1),('2022-03-03','2023-04-04',2,2),('2023-03-03','2024-04-04',3,2)

drop table EmployeementDetail 

INSERT INTO EmployeementDetail(
StartDate, 
EndDate,
EmployeeId,
CompanyId
)
VALUES('2021-10-10','2022-10-10',1)
------------------------------------------------------------------------------------------------------------------------------------------

--Salary TABLE
CREATE TABLE Salary(
Id INT IDENTITY(1,1) PRIMARY KEY,
CrditedOn DATE,
EmployeeId INT FOREIGN KEY REFERENCES Employees(EmployeeId),
CompanyId INT FOREIGN KEY REFERENCES Companies(CompanyId),
DeptId INT FOREIGN KEY REFERENCES Departments(DeptId)
)

--drop table Salary

--INSERT VALUE IN Salary TABLE
insert into dbo.Salary(CrditedOn,
EmployeeId,
CompanyId,
DeptId)
values('2021-01-01',1,1,1),('2022-01-01',2,2,1),('2023-01-01',3,1,2),('2019-01-01',4,1,2),('2018-01-01',2,1,3),('2017-01-01',6,1,3);
select * from dbo.Employees;
select * from dbo.Companies;
select * from dbo.Departments;
select * from dbo.Salary;
-------------------------------------------------------------------------------------------------------------------------------------

--1. write sql query to Retrieve employee list with there Department Who has Department

select e.EmployeeId,e.Name,d.Name as Department_Name from dbo.employees e
INNER join dbo.Departments d on (e.DeptId = d.DeptId);

-------------------------------------------------------------------------------------------------------------------------

--2. Write sql query to Retrieve employee list with there Year of employment start date(Would be null)
--from Employment table using left join. 

select e.EmployeeId,e.Name,e.Salary,e.DeptId,d.name,YEAR(ed.StartDate) AS Start_Year_Employment from dbo.employees e
LEFT join dbo.EmployeementDetail ed on (e.EmployeeId = ed.EmployeeId) 
LEFT join dbo.Departments d on (e.DeptId = d.DeptId);


-------------------------------------------------------------------------------------------------------------------------

--3. Write sql query to Retrieve employee list with there department name and also return department name 
--as well in which no employee using right join. 

select e.EmployeeId,e.Name,e.Salary,e.DeptId,d.Name from dbo.employees e
RIGHT join dbo.Departments d on (e.DeptId = d.DeptId);

-------------------------------------------------------------------------------------------------------------------------

--4. Write sql query to Retrieve employee list with there Highest education details using outer apply.

Select e.EmployeeId,e.Name,ed.Degree,ed.Score from Employees e
outer apply(select * from EducationDetail ed where e.EmployeeId=ed.EmployeeId) ed
order by ed.EduLevel desc 

-------------------------------------------------------------------------------------------------------------------------   

--5. Write sql query to find employee from each department When last salary was credited also need to 
--handle if there is no salary credited till date then it should return null. 

select d.DeptId,d.name,max(s.CrditedOn) as CrditedOn,e.EmployeeId,e.name,e.Salary from dbo.Departments d
LEFT join dbo.Salary s on (d.DeptId = s.DeptId) 
LEFT join dbo.EmployeeS e on (e.EmployeeId = s.EmployeeId)
WHERE (SELECT max(sb.CrditedOn) FROM dbo.Salary AS sb WHERE sb.DeptId=d.DeptId)=s.CrditedOn OR s.CrditedOn is null
group by d.DeptId,d.name,e.EmployeeId,e.name,e.salary
order by d.DeptId 

------------------------------------------------------------------------------------------------------------------------
--6. Write sql query to retrieve all department list with Employee count using only those departments which are 
--having more then 0 employee. 

select d.DeptId,d.name as Department_Name,COUNT(e.EmployeeId) Emp_Count from dbo.Departments d
INNER join Employees e  ON (e.DeptId = d.DeptId)
group by d.DeptId,d.Name;

select * from Employees
select * from Departments

-------------------------------------------------------The--End----------------------------------------------------------


