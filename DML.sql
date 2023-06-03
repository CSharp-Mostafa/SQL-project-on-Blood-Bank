
-------------------------------------CRUD Operation
Use MRL_Medical
Go
------------------------------Retrive

Use MRL_Medical
Go
Select * From ih.Department
Select * From Doctor
Select * From PatientAdmit
Select * From PatientRelease

Select * From PatientAdmitAction
Select * From PatientReleaseAction

Select * From Employee
Select * From Employee_tmp
Select * from Nurse
-----------------------Insert

Use MRL_Medical
Go
Insert into ih.Department(DepartmentName,AvailableSeat) values('Cardiology',35)
Insert into ih.Department(DepartmentName,AvailableSeat) values('Gastroenterology',30)
Insert into ih.Department(DepartmentName,AvailableSeat) values('Gynecology',20)
Insert into ih.Department(DepartmentName,AvailableSeat) values('General_Surgery',50)
Insert into ih.Department(DepartmentName,AvailableSeat) values('Neurology',15)
Insert into ih.Department(DepartmentName,AvailableSeat) values('Child',10)
		
Go

Use MRL_Medical
Insert  Doctor Values	(Next value for seq_doctor,'Kamal','Pervez','Kumira','01818252630',30000,1 ),
						(Next value for seq_doctor,'Monjur','Hossain','Sitakunda','01718252982',25000,1 ),
						(Next value for seq_doctor,'Iqbal','Hossain','Pahartali','0189258750',30000,2 ),
						(Next value for seq_doctor,'Mahadi','Foysal','Mirsorai','01719252630',25000,2 ),
						(Next value for seq_doctor,'Shirin','Akter','Sitakunda','01818252675',30000,3 ),
						(Next value for seq_doctor,'Niger','Sultana','Kumira','01685232630',30000,3 ),
						(Next value for seq_doctor,'Fahad','Ahmed','Nasirabad','01573292602',35000,4 ),
						(Next value for seq_doctor,'Amran','Hossain','Mirsorai','01918254689',25000,4 ),
						(Next value for seq_doctor,'Morshed','Alam','Nasirabad','01532586892',30000,5 )
Use MRL_Medical
Insert  Employee values (1,'kamal','Coxbazar',10000),
						(2,'Raihan','Sitakunda',9000),
						(3,'Lizon','Chattogram',5000),
						(4,'Mohiuddin','Chattogram',8000),
						(5,'Bashar','Coxbazar',12000)
Go
Use MRL_Medical
Insert  Employee_tmp values (1,'kamal','Coxbazar',10000),
						(2,'Raihan','Mirsorai',9000),
						(3,'Lizon','Chattogram',7000),
						(4,'Mohiuddin','Chattogram',8000)
Go
Use MRL_Medical				
Insert into Nurse values (1,'Nasrin','kumira',5000)
Insert into Nurse values (2,'Fatema','Sitakunda',4000)
Go


-------------------Update
Use MRL_Medical
Update ih.Department
Set DepartmentName='Baby'
Where DepartmentID=6
Go
-------------------Delete
Use MRL_Medical
Delete From ih.Department
Where DepartmentID=7
Go

Use MRL_Medical
EXEC sp_AdmitInsert 1,'Abul','Kumira','01868 330 218',100,'04-06-2020',2,3
EXEC sp_AdmitInsert 1,'Rahim','Kumira','01868 335 918',100,'05-06-2020',1,2
EXEC sp_AdmitInsert 1,'Nahim','Sitakunda','01738 330 555',100,'04-04-2020',2,2
EXEC sp_AdmitInsert 1,'Mahabub','Mirsorai','01913 330 747',100,'04-07-2020',1,1
EXEC sp_AdmitInsert 1,'Amina','Pahartali','01752 330 218',100,'04-08-2020',3,5
EXEC sp_AdmitInsert 1,'Rahima','Kumira','01752 330 218',100,'04-07-2020',3,6
EXEC sp_AdmitInsert 1,'Ribel','Nasirabad','01868 330 778',100,'04-09-2020',2,4
EXEC sp_AdmitInsert 1,'Anwar','Nowakhali','01618 330 218',100,'04-10-2020',4,7
EXEC sp_AdmitInsert 1,'Amin','Shitalpur','01868 330 010',100,'04-07-2020',4,8
EXEC sp_AdmitInsert 1,'Abul','Kumira','01909 330 218',100,'04-08-2020',5,9
EXEC sp_AdmitInsert 1,'Jabed','Mirsorai','01909 555 777',100,'04-09-2020',5,9
EXEC sp_AdmitInsert 1,'Fahim','Mirsorai','01909 555 777',100,'04-09-2020',5,9
Go

Use MRL_Medical 
EXEC sp_ReleaseInsert 1,10000,'04-09-2020',1,2,0.05
EXEC sp_ReleaseInsert 1,10000,'04-09-2020',7,3,0.15

-----------Six Clause 
Use MRL_Medical
Select DepartmentName,Count(DoctorID) as [No Of Doctor]
From ih.Department 
Join Doctor
on ih.Department.DepartmentID=Doctor.DepartmentID
Group by DepartmentName
Having Count(DoctorID)>=1
Order By DepartmentName ASC

Use MRL_Medical
Select PatientID,PatientName,Contact,DepartmentID
From patientAdmit
Where AdmitDate>='04-05-2020' and AdmitDate<='04-07-2020'


----Inner join
Use MRL_Medical
Select Doctor.DoctorID,DoctorFname, DoctorLname, Patientname, Admitdate
From Doctor
Join PatientAdmit
on Doctor.DoctorID=PatientAdmit.DoctorID


----Left outer join
Use MRL_Medical
Select DepartmentName, PatientName, AdmitDate
From ih.Department
Left join PatientAdmit
on ih.Department.DepartmentID=PatientAdmit.DepartmentID
Order by Departmentname DESC


----Right Outer Join
Use MRL_Medical
Select PatientID, PatientName, DoctorFName
From PatientAdmit as p
Right Join Doctor as d
on p.PatientID = d.DoctorID

-----Full Outer Join 
Use MRL_Medical
Select ih.Department.DepartmentID,DepartmentName,DoctorID, DoctorFname,DoctorLName,Cellphoneno
From ih.Department
Full outer join Doctor
on ih.Department.DepartmentID=Doctor.DepartmentID


-----Cross join
Use MRL_Medical
Select ih.Department.DepartmentID,DepartmentName,DoctorLname
From ih.Department
Cross Join Doctor

------Self Join
Use MRL_Medical
Select *
From ih.Department AS A, ih.Department AS B
Where A.DepartmentID<>B.DepartmentID

---------Merge
Use MRL_Medical
MERGE Employee AS t
USING Employee_tmp AS s
ON (s.EmployeeID= t.EmployeeID)
WHEN MATCHED 
   THEN UPDATE SET t.EmployeeName = s.EmployeeName, t.ContactAddress=s.ContactAddress, t.Salary=s.Salary
WHEN NOT MATCHED BY TARGET
   THEN INSERT (EmployeeID, EmployeeName, ContactAddress,Salary) VALUES (s.EmployeeID, s.EmployeeName,s.ContactAddress,s.Salary)
WHEN NOT MATCHED BY SOURCE
   THEN DELETE;
GO

------------Union
Use MRL_Medical
Select * From Employee
Union 
Select * From Nurse

-------Query/Sub Querry
Use MRL_Medical
Select  Max(Netbill) As [Highest Bill]
From PatientRelease
Go

Select  Min(Netbill) As [Lowest Bill]
From PatientRelease
Go

Select DepartmentName, SUM(Netbill) as [Total]
From ih.Department
Join PatientAdmit
on ih.Department.DepartmentID=PatientAdmit.DepartmentID
Join PatientRelease
on PatientRelease.PatientID=PatientAdmit.PatientID
Where Departmentname IN (Select  DepartmentName From ih.department 
						Where DepartmentName='Cardiology' or DepartmentName= 'Gastroenterology' or DepartmentName='Gynecology' )
Group by DepartmentName
Go


Select * 
From PatientAdmit
Where PatientID IN (Select PatientID From PatientRelease)
Go



WITH myCTE
AS
(Select  PatientName,Contact,NetBill
	From PatientAdmit
	Join PatientRelease 
	on PatientAdmit.PatientID=PatientRelease.PatientID)
SELECT * FROM myCTE 
GO

Select * From ih.Department
Select * From Doctor
Select * From PatientAdmit
Select * From PatientRelease

Select * From PatientAdmitAction
Select * From PatientReleaseAction

Select * From Employee
Select * From Employee_tmp


Delete From PatientAdmit
Where PatientID=11

Delete From PatientRelease
Where Id=1


-----Floor,Ceiling,Round

Declare @e Money=25.99
Select FLOOR(@e) As FloorResult


Declare @e Money=25.99
Select Ceiling(@e) As CeilingResult


Select Round(12.50,2)

Select Round(12.50,-1)

---Case
Use MRL_Medical
Select DepartmentID,
Case DepartmentID
When '1' Then 'Cardiology'
When '2' Then 'Gastroenterology'
When '3' Then 'Gynecology'
When '4' Then 'General_Surgery'
When '5' Then 'Neurology'
Else 'Child'
End
From ih.Department
Go


---Cube

Select DoctorFname, Sum(Salary)
From Doctor
Group by Cube (DoctorFname)