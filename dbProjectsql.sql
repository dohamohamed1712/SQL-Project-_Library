use LibraryDB;
go

create table Floors(
  floor_number int primary key,
  NumberOfBlocks int not null,
  manage_id int null,
  Hiring_date date null
);
go

create table Employees(
Emp_id int primary key,
Fname varchar(50) not null,
Lname varchar(50) not null,
Address varchar(100) null,
Salary decimal(10,2) null,
Email varchar(100) null,
DateOfBirth date null,
PhoneNumber varchar(20) null,
Bouns decimal(10,2) null,
SupervisorId int null,
floor_id int null,

constraint FK_Emp_Supervisor foreign key  (SupervisorId)  references Employees(Emp_id),
constraint FK_Emp_Floor      foreign key   (floor_id)     references Floors(floor_number)

);
go

alter table Floors
add constraint fk_floor_manager foreign key (manage_id) references Employees(Emp_id);
go


create table [user] (
  SSN int primary key,
  Name  varchar(50) not null,
  Email varchar(100) null,
  record_id int not null,    
  
  constraint fk_user_employee foreign key (record_id) references Employees(Emp_id)
);
go

create table user_phones (
    user_ssn int not null,
    Phone  varchar(20) not null,
    constraint pk_user_phones primary key (user_ssn, Phone),
    constraint fk_phones_user foreign key (user_ssn) references [user](SSN)
);
go
 

 create table Category (
    ID  int primary key,
    Cat_name varchar(50) not null
);
go
 
create table Publisher (
    ID  int primary key,
    Name varchar(100) not null
);
go
 
create table Author (
   ID int primary key,
   Name varchar(100) not null
);
go


create table Shelf (
    code  varchar(10) primary key,
    floor_num int not null,
    constraint fk_shelf_floor foreign key (floor_num) references floors(floor_number)
);
go


create table Book (
    ID  int primary key,
    title  varchar(150) not null,
    shcode varchar(10) not null,
    pid    int not null,
    cat_id int not null,
    constraint fk_book_shelf     foreign key (shcode) references shelf(code),
    constraint fk_book_publisher foreign key (pid)     references publisher(id),
    constraint fk_book_category  foreign key (cat_id)  references category(id)
);
go


create table Have (
    book_id int not null,
    aid  int not null,
    constraint pk_have primary key (book_id, aid),
    constraint fk_have_book   foreign key (book_id) references book(id),
    constraint fk_have_author foreign key (aid)      references author(id)
);
go
 

 create table borrow (
    Emp_id        int not null,
    book_id       int not null,
    SSN           int not null,
    date_borrowed date not null,
    due_date      date not null,
    amountofmoney decimal(10,2) not null,
    constraint pk_borrow       primary key (Emp_id, book_id, SSN, date_borrowed),
    constraint fk_borrow_emp   foreign key (Emp_id)  references Employees(Emp_id),
    constraint fk_borrow_book  foreign key (book_id) references Book(id),
    constraint fk_borrow_user  foreign key (ssn)     references [user](ssn)
);
go

insert into floors (floor_number, numberofblocks, manage_id, hiring_date) values
(1, 4, null, null),
(2, 3, null, null),
(3, 5, null, null),
(4, 2, null, null),
(5, 3, null, null),
(6, 2, null, null),   
(7, 1, null, null);   
go
 

 insert into employees (emp_id, fname, lname, address, salary, email, dateofbirth, phonenumber, bouns, supervisorid, floor_id) values
(1,  'ali',     'hassan',  'cairo',   6000.00, 'ali.hassan@lib.com',   '1985-02-10', '01011111111', 300.00, null, 1),
(2,  'mohamed', 'nabil',   'alex',    7000.00, 'mohamed.nabil@lib.com','1988-05-14', '01022222222', 200.00, 1,    6),
(3,  'sara',    'kamal',   'cairo',   5500.00, null,                   '1990-07-01', '01033333333', 150.00, 1,    2),
(4,  'ahmed',   'fathy',   'giza',    null,    'ahmed.fathy@lib.com',  '1992-09-23', '01044444444', 500.00, 2,    7),
(5,  'omar',    'amr',     'alex',    6500.00, 'omar.amr@lib.com',     '1991-03-03', '01055555555', 250.00, 1,    3),
(6,  'sam',     'adel',    'cairo',   4800.00, 'sam.adel@lib.com',     '1993-11-11', '01066666666', 100.00, 2,    4),
(7,  'nourhan', 'tarek',   'alex',    5200.00, 'nourhan.tarek@lib.com','1994-01-19', '01077777777', 180.00, 3,    5),
(8,  'mona',    'adel',    'cairo',   null,    'mona.adel@lib.com',    '1989-06-06', '01088888888', 400.00, 3,    1),
(9,  'amr',     'salah',   'giza',    5900.00, null,                   '1990-12-30', '01099999999', 220.00, 4,    2),
(12, 'ali',     'mohamed', 'cairo',   6100.00, 'ali.mohamed@lib.com',  '1987-04-17', '01012121212', 260.00, 5,    6),
(20, 'hany',    'fouad',   'alex',    7200.00, 'hany.fouad@lib.com',   '1986-08-08', '01020202020', 300.00, null, 6);
go


update floors set manage_id = 1,  hiring_date = '2019-01-01' where floor_number = 1;
update floors set manage_id = 2,  hiring_date = '2020-03-15' where floor_number = 2;
update floors set manage_id = 5,  hiring_date = '2018-06-01' where floor_number = 3;
update floors set manage_id = 6,  hiring_date = '2021-02-20' where floor_number = 4;
update floors set manage_id = 7,  hiring_date = '2017-09-09' where floor_number = 5;
update floors set manage_id = 20, hiring_date = '2022-01-10' where floor_number = 6;
update floors set manage_id = 4,  hiring_date = '2019-11-05' where floor_number = 7;
go
 

 insert into category (id, cat_name) values
(1, 'programming'),
(2, 'fiction'),
(3, 'history'),
(4, 'science');
go

insert into publisher (id, name) values
(1, 'harpercollins'),
(2, 'penguin books'),
(3, 'o''reilly media'),
(4, 'pearson');
go
 

 insert into author (id, name) values
(1, 'robert martin'),
(2, 'j.k. rowling'),
(3, 'yuval noah harari'),
(4, 'martin fowler'),
(5, 'isaac asimov');
go
 
 insert into shelf (code, floor_num) values
('a1', 1),
('a2', 1),
('b1', 2),
('c1', 3),
('d1', 4);
go

insert into book (id, title, shcode, pid, cat_id) values
(1, 'clean code',              'a1', 3, 1),
(2, 'refactoring',             'a2', 3, 1),
(3, 'design patterns',         'a1', 4, 1),
(4, 'harry potter',            'b1', 1, 2),
(5, 'sapiens',                 'c1', 1, 3),
(6, 'foundation',              'd1', 2, 4);
go
 

 insert into have (book_id, aid) values
(1, 1),
(2, 1),
(2, 4),
(3, 4),
(4, 2),
(5, 3),
(6, 5);
go

insert into [user] (ssn, name, email, record_id) values
(10, 'sara youssef',   'sara.y@mail.com',   1),
(11, 'karim adel',     'karim.a@mail.com',  2),
(12, 'ahmed reda',     'ahmed.r@mail.com',  3),
(13, 'salma hossam',   'salma.h@mail.com',  4),
(14, 'ahmed reda',     'ahmed.reda2@mail.com', 5), 
(15, 'nada ibrahim',   null,                6);
go


insert into user_phones (user_ssn, phone) values
(10, '01111111111'),
(10, '01111111112'),
(11, '01122222222'),
(12, '01133333333'),
(13, '01144444444'),
(14, '01155555555'),
(15, '01166666666');
go 

insert into borrow (emp_id, book_id, ssn, date_borrowed, due_date, amountofmoney) values
(1, 1, 10, '2022-03-05', '2022-04-05', 50.00),
(1, 2, 10, '2022-05-10', '2022-06-10', 40.00),
(2, 3, 10, '2022-06-01', '2022-07-15', 45.00),
(3, 4, 11, '2022-02-01', '2022-06-15', 60.00),
(2, 5, 12, '2022-08-01', '2022-09-01', 55.00),
(4, 6, 13, '2022-04-20', '2022-05-20', 15.00),  
(1, 1, 14, '2021-12-01', '2022-01-01', 50.00),   
(3, 6, 10, '2022-09-01', '2022-10-01', 20.00);
go

alter table floors alter column manage_id int not null;
go


--1. Write a query that displays Full name of an employee who has more than
--3 letters in his/her First Name.
select Fname +' ' +Lname as FullName from Employees 
where len( Fname)>3; 

--Write a query to display the total number of Programming books
--available in the library with alias name ‘NO OF PROGRAMMING
--BOOKS’ 
select count (*) as No_OF_PROGRAMMIN_BOOKS 
from Book b
join Category c
on c.ID=b.cat_id
where c.Cat_name='Programming';


--Write a query to display the number of books published by
--(HarperCollins) with the alias name 'NO_OF_BOOKS'. 
select count(*) as NO_OF_BOOKS
from Book b
join Publisher p 
on p.ID=b.pid
where p.Name ='HarperCollins';



--Write a query to display the User SSN and name, date of borrowing and
--due date of the User whose due date is before July 2022.
select u.SSN,u.Name ,b.date_borrowed,b.due_date
from [user] u
join borrow b
on u.SSN=b.SSN
where b.due_date <'2022-07-01';



--Write a query to display book title, author name and display in the
--following format,
--' [Book Title] is written by [Author Name].
select b.title + ' is written by ' + a.Name as BookAuthor
from Book b
join Have h on b.ID = h.book_id
join Author a on h.aId = a.ID;

--Write a query to display the name of users who have letter 'A' in their names.

select name from [user]
where name like '%a%';


--Write a query that display user SSN who makes the most borrowing
select top 1 ssn
from borrow
group by ssn
order by count(*) desc;

--Write a query that displays the total amount of money that each user paid for borrowing books.

select u.SSN, u.Name, SUM(b.AmountOfMoney) as TotalPaid
from [user] u
join borrow b on u.SSN = b.SSN
group by u.SSN, u.Name;

--write a query that displays the category which has the book that has the
--minimum amount of money for borrowing.
select c.Cat_Name
from borrow b
join Book bk on b.book_id = bk.ID
join Category c on bk.Cat_id = c.ID
where b.AmountOfMoney = (select min(AmountOfMoney) from borrow);



--write a query that displays the email of an employee if it's not found,
--display address if it's not found, display date of birthday.
select coalesce(Email, Address, convert(varchar, DateOfBirth, 23)) as ContactInfo
from Employees;



--Write a query to list the category and number of books in each category
--with the alias name 'Count Of Books'.
select c.Cat_name, count(*) as [Count Of Books]
from Category c
join Book b
on c.ID=b.cat_id
group by c.Cat_name;


--Write a query that display books id which is not found in floor num = 1 and shelf-code = A1
select b.ID 
from book b
where b.ID not in (
  select bk.ID
  from book bk
  join Shelf sh on bk.shcode=sh.code
  join Floors f on f.floor_number=sh.floor_num
  where f.floor_number = 1 and sh.code='a1'
);


--13.Write a query that displays the floor number , Number of Blocks and
--number of employees working on that floor

select f.floor_number,f.NumberOfBlocks ,count(e.Emp_id) as Employess_working_in
from Employees e
join Floors f 
on f.floor_number=e.floor_id
group by f.floor_number,f.NumberOfBlocks;

--14.Display Book Title and User Name to designate Borrowing that occurred
--within the period ‘3/1/2022’ and ‘10/1/2022’

select b.title ,u.Name
from Book b
join borrow bw on bw.book_id=b.ID
join [user] u on u.SSN=bw.SSN
where bw.date_borrowed between '2022-03-01' and '2022-10-01';


--Display Employee Full Name and Name Of his/her Supervisor as Supervisor Name
select e.Fname +' '+ e.Lname as FullName ,s.Fname +' '+ s.Lname as SupervisorName
from Employees e
inner join Employees s
on s.Emp_id=e.SupervisorId;


--Select Employee name and his/her salary but if there is no salary display  Employee bonus.

select e.Fname +' '+ e.Lname as FullName,coalesce(e.Salary, e.Bouns) as SalaryOrBouns
from Employees e; 

--Display max and min salary for Employees
select min(Salary) as minimumSalary ,max(Salary) as maximumSalary
from Employees;
go
--Write a function that take Number and display if it is even or odd

create function dbo.checkevenodd (@number int)
returns varchar(10)
as
begin
    declare @result varchar(10);

    if @number % 2 = 0
        set @result = 'even';
    else
        set @result = 'odd';

    return @result;
end;
go
  select dbo.checkevenodd(7);   -- odd
  select dbo.checkevenodd(10);  -- even


  select emp_id, dbo.checkevenodd(emp_id) as number_type
  from employees;

  go
--write a function that take category name and display Title of books in that category
GO

create function dbo.GetBooksByCategory (@CategoryName varchar(50))
returns table
as
return
(
    select b.Title
    from Book b
    join Category c on c.ID = b.cat_id
    where c.Cat_name = @CategoryName
);
GO

select * from dbo.GetBooksByCategory('Science');
go
--write a function that takes the phone of the user and displays Book Title ,
--user-name, amount of money and due-date.
go
create function dbo.GetBorrowInfoByPhone (@Phone varchar(20))
returns table
as
return
(
    select bk.Title, u.Name as UserName, b.AmountOfMoney, b.Due_Date
    from User_Phones up
    join [User] u on up.User_SSN = u.SSN
    join Borrow b on u.SSN = b.SSN
    join Book bk on b.book_id = bk.ID
    where up.Phone = @Phone
);
go
select * from dbo.GetBorrowInfoByPhone('01111111111');

--Write a function that take user name and check if it's duplicated
go
create function dbo.CheckUserNameDuplicate (@UserName varchar(50))
returns varchar(200)
as
begin
    declare @Cnt int;
    declare @Result varchar(200);

    select @Cnt = count(*) from [User] where Name = @UserName;

    if @Cnt = 0
        set @Result = @UserName + ' is Not Found';
    else if @Cnt = 1
        set @Result = @UserName + ' is not duplicated';
    else
        set @Result = @UserName + ' is Repeated ' + CAST(@Cnt as varchar(10)) + ' times';

    return @Result;
end;
go
select dbo.CheckUserNameDuplicate('Ahmed Reda') as Msg;
select dbo.CheckUserNameDuplicate('Sara Youssef') as Msg;
select dbo.CheckUserNameDuplicate('Mostafa Khaled') as Msg;

--Create a scalar function that takes date and Format to return Date With That Format.
go
create function dbo.FormatDate (@InputDate date, @Format varchar(20))
returns varchar(50)
as
begin
    declare @Result varchar(50);
    set @Result = FORMAT(@InputDate, @Format);
    return @Result;
end;
go

select dbo.FormatDate('2022-07-15', 'dd/MM/yyyy') as FormattedDate;
select dbo.FormatDate('2022-07-15', 'MMMM dd, yyyy') as FormattedDate;
select dbo.FormatDate('2022-07-15', 'yyyy-MM-dd') as FormattedDate;

--Create a stored procedure to show the number of books per Category
go
create procedure sp_BooksPerCategory
as
begin
    select c.Cat_Name, count(b.ID) as NumberOfBooks
    from Category c
    left join Book b on c.ID = b.Cat_id
    group by c.Cat_Name;
end;
go
exec sp_BooksPerCategory;

--24.Create a stored procedure that will be used in case there is an old manager
go
create procedure sp_ReplaceFloorManager
    @OldEmpId int,
    @NewEmpId int,
    @FloorNumber int
as
begin
   
    if not exists (
        select 1 from Floors
        where floor_number = @FloorNumber and manage_id = @OldEmpId
    )
    begin
        print 'Old manager does not match the current manager of this floor.';
        return;
    end

   
    if not exists (select 1 from Employees where Emp_id = @NewEmpId)
    begin
        print 'New employee does not exist.';
        return;
    end

    update Floors
    set manage_id = @NewEmpId,
        Hiring_date = GETDATE()
    where floor_number = @FloorNumber;

    print 'Manager updated successfully.';
end;
exec sp_ReplaceFloorManager @OldEmpId = 1, @NewEmpId = 8, @FloorNumber = 1;

--25.Create a view AlexAndCairoEmp that displays Employee data for users who live in Alex or Cairo.
go
create view AlexAndCairoEmp
as
select Emp_id, Fname, Lname, Address, Salary, Email, DateOfBirth, PhoneNumber, Bouns
from Employees
where Address = 'Alex' or Address = 'Cairo';

go
select * from AlexAndCairoEmp;


--create a view "V2" That displays number of books per shelf

go
create view V2
as
select s.code as ShelfCode, count(b.ID) as NumberOfBooks
from Shelf s
left join Book b on s.code = b.ShCode
group by s.code;

go
select * from V2;

--27.create a view "V3" That display the shelf code that have maximum
--number of books using the previous view "V2" 
go
create view V3
as
select ShelfCode
from V2
where NumberOfBooks = (select max(NumberOfBooks) from V2);
go

select * from V3;

--Create a table named ‘ReturnedBooks’ With the Following Structure :
create table ReturnedBooks (
    User_SSN    int not null,
    Book_Id     int not null,
    Due_Date    date not null,
    Return_Date date not null,
    fees        decimal(10,2) null,
    constraint FK_RB_User foreign key (User_SSN) references [User](SSN),
    constraint FK_RB_Book foreign key (Book_Id)  references Book(ID)
);
go
create trigger trg_ReturnedBooks_CalcFees
on ReturnedBooks
instead of insert
as
begin
    insert into ReturnedBooks (User_SSN, Book_Id, Due_Date, Return_Date, fees)
    select 
        i.User_SSN,
        i.Book_Id,
        i.Due_Date,
        i.Return_Date,
        case 
            when i.Return_Date <> i.Due_Date then 0.20 * br.AmountOfMoney
            else 0
        end as fees
    from inserted i
    join Borrow br 
        on br.SSN = i.User_SSN 
        and br.book_id = i.Book_Id 
        and br.Due_Date = i.Due_Date;
end;


--29.In the Floor table insert new Floor With Number of blocks 2 , employee
--with SSN = 20 as a manager for this Floor,The start date for this manager
--is Now. Do what is required if you know that : Mr.Omar Amr(SSN=5)
--moved to be the manager of the new Floor (id = 6), and they give Mr. Ali
--Mohamed(his SSN =12) His position 
UPDATE Floors
SET manage_id = 12,  Hiring_date= GETDATE()
WHERE manage_id = 5;

INSERT INTO Floors (NumberOfBlocks, manage_id, Hiring_date)
VALUES (2, 5, GETDATE());



--Create view name (v_2006_check) that will display Manager id

GO

create view v_2006_check
as
select manage_id as ManagerId,
       floor_number as FloorNumber,
       NumberOfBlocks,
       Hiring_date as HiringDate
from Floors
where Hiring_date between '2022-03-01' and '2022-05-31'
with check option;
GO


--31.Create a trigger to prevent anyone from Modifying or Delete or Insert in the Employee table

go

create trigger trg_PreventEmployeeChanges
on Employees
instead of insert, update, delete
as
begin
    print 'You are not allowed to Insert, Update or Delete any data in the Employees table.';
end;
go

--32.Testing Referential Integrity , Mention What Will Happen When:
--A هيفشل  — لأن جدول [user] مفيهوش أي مستخدم بـ SSN = 50

--b هيفشل — الموظف 20 (Hany Fouad) هو مدير الفلور رقم 6 (Floors.manage_id = 20 عن طريق 
--fk_floor_manager). بما إن الـ FK ده معملوش ON UPDATE CASCADE، فتغيير الـ Primary Key (Emp_id) هيكسر العلاقة ويترفض تلقائيًا.

--c  هيفشل ❌ — وده أوضح حالة، لأن الموظف رقم 1 (Ali Hassan) متربوط بيه 4 علاقات مختلفة:
--Floors.manage_id = 1 (مدير الفلور رقم 1)
--Employees.SupervisorId = 1 (هو المشرف على الموظفين 2, 3, 5, 8)
--[user].record_id = 1 (المستخدم Sara Youssef، SSN=10، مرتبط بيه كـ Employee record)
--borrow.Emp_id = 1 (له صفوف استعارة مسجلة)

--d هيفشل  — بعد التحديث اللي حصل في سؤال 29 (UPDATE Floors SET manage_id = 12 WHERE manage_id = 5)، بقى الموظف 12 
--(Ali Mohamed) هو مدير الفلور رقم 3. فالحذف هيرفض بسبب fk_floor_manager، رغم إنه مش عنده مرؤوسين أو سجلات استعارة مرتبطة بيه في البيانات دي.

--e هيفشل  — لأن Emp_id هو الـ Primary Key، وSQL Server بيعمل تلقائيًا Clustered Index عليه وقت إنشاء الجدول (مفيش أي تحديد صريح إنه Non-Clustered). وبما إن الجدول ميقدرش يكون فيه أكتر من 



--33.Try to Create Login With Your Name And give yourself access Only to
--Employee and Floor tables then allow this login to select and insert data
--into tables and deny Delete and update (Don't Forget To take screenshot
--to every step)

USE master;
GO

CREATE LOGIN DohaMohamed
WITH PASSWORD = 'StrongP@ss123',
     CHECK_POLICY = ON;
GO

SELECT name, type_desc FROM sys.server_principals WHERE name = 'DohaMohamed';

USE LibraryDB;
GO

CREATE USER DohaMohamed
FOR LOGIN DohaMohamed;
GO

SELECT name, type_desc FROM sys.database_principals WHERE name = 'DohaMohamed';

GRANT SELECT, INSERT ON Employees TO  DohaMohamed;
GRANT SELECT, INSERT ON Floors TO DohaMohamed;
GO

DENY DELETE, UPDATE ON Employees TO DohaMohamed;
DENY DELETE, UPDATE ON Floors TO DohaMohamed;
GO

SELECT 
    pr.name AS UserName,
    o.name AS TableName,
    p.permission_name,
    p.state_desc
FROM sys.database_permissions p
JOIN sys.database_principals pr ON p.grantee_principal_id = pr.principal_id
JOIN sys.objects o ON p.major_id = o.object_id
WHERE pr.name = 'DohaMohamed';


SELECT * FROM Employees;
INSERT INTO Floors (floor_number, NumberOfBlocks, manage_id, Hiring_date)
VALUES (9, 1, 1, GETDATE());

UPDATE Employees SET Salary = 9999 WHERE Emp_id = 1;
DELETE FROM Employees WHERE Emp_id = 1;

