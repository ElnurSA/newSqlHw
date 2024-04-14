select * from students 

Select CHARINDEX('@', Email) from Students;

select SUBSTRING([Email], 1, CHARINDEX('@', email)-1) FROM students;

select SUBSTRING([email], CHARINDEX('@', Email)+1, LEN([Email])-CHARINDEX('@', [email])) from students;

create view vw_getStudentByAges
as
select * from Student where [Age] > 25

select * from vw_getStudentByAges

create view vw_joinStudentDatas
as
select st.fullname as 'student', ct.name as 'city', co.name as 'country' from Student st
join Cities ct
on st.CitiId = ct.Id
join Countries co
on ct.CountryId = co.Id

select * from vw_joinStudentDatas

create view vw_joinStudentDatas2
as
select st.fullname as 'student', ct.name as 'city', co.name as 'country' from Student st
join Cities ct
on st.CitiId = ct.Id
join Countries co
on ct.CountryId = co.Id


create function dbo.showWord()
returns NVARCHAR(50)
as 
BEGIN
    return 'p418'
END

declare @result NVARCHAR(50) = (select dbo.showWord())

print @result

create function dbo.showWordWithParametr(@text NVARCHAR(50))
returns nvarchar(50)
as 
BEGIN 
RETURN @text
END

select dbo.showWordWithParametr('Aqshin bey') as 'Name'

create function dbo.getStudentAvgAgesByIds(@id int)
returns INT
as
BEGIN
    declare @count int = (select COUNT(*) FROM Student where [Id]>@id)
    declare @sumAge int = (select sum(Age) FROM Student where [Id]>@id)
    RETURN @sumAge/@count
end

create function dbo.getStudentAvgAgesByIds2(@id int)
returns INT
as
BEGIN
    return (select AVG(age) from student where [Id] > @id)
end


select dbo.getStudentAvgAgesByIds(3)

select dbo.getStudentAvgAgesByIds2(2)

declare @avgAge = (select dbo.getStudentAvgAgesByIds2(3))

create function dbo.getAStudentsByCondition(@avgAge int)
returns TABLE
AS 
 return ( select * from Student where [Age] > @avgAge)


create PROCEDURE usp_showText
as
print 'salam'

exec usp_showText

create PROCEDURE usp_showTextWithParametr
@text NVARCHAR(50)
as
print @text

exec usp_showTextWithParametr 'Azerbaycan'

create PROCEDURE usp_deleteStudentById
@id INT
as 
delete from student where [id] = @id

exec usp_deleteStudentById 1

create procedure usp_createEmployee
@name NVARCHAR(50),
@address NVARCHAR(50),
@email NVARCHAR(100),
@age INt
AS
BEGIN
    INSERT into Student ([FullName], [Address],[Email], [age])
    VALUES (@name, @address, @email, @age)
END

exec usp_createEmployee 'Tofig', 'Nesibli', 'tofig@mail.ru', 28