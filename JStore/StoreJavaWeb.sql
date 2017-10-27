create database StoreJavaDB
go 
use StoreJavaDB
go

--create table tblProductCategory
--(
--ID bigint identity primary key,
--Name nvarchar(250),
--MetaTitle varchar(250),
--ParentID bigint,
--DisplayOrder int default 0,
--SeoTitle nvarchar(250),
--CreatedDate datetime default getdate(),
--CreatedBy varchar(50),
--ModifiedDate datetime,
--ModifiedBy varchar(50),
--MetaKeywords nvarchar(250),
--MetaDescriptions nchar(250),
--Status bit not null default 1,
--ShowOnHome bit default 0
--)
--go

create table tblProduct
(
ID bigint identity primary key ,
Name nvarchar(250),
Code varchar(20),
MetaTitle nvarchar(250),
Description ntext,
Images nvarchar(250),
MoreImages xml,
Price decimal(18,0) default 0,
PromotionPrice decimal(18,0) default 0,
IncludedVat bit default 0,
Quantity int default 0,
CategoryID bigint,
Detail ntext,
Warranty int,
CreatedDate datetime default getdate(),
Status bit not null default 1,
TopHot datetime,
ViewCount int
)
go
--start procedure tblProduct
create procedure uspDatatblProductCategory
@ID bigint
as
begin
select * from tblProduct where CategoryID=@ID order by ID ASC
end
go
create procedure uspDatatblProduct
as
begin
select * from tblProduct
end
go
create procedure uspDataIDtblProduct
@ID bigint
as
begin
select * from tblProduct where ID=@ID
end
go
create procedure uspUpdateViewtblProduct
@ID bigint,
@ViewCount int
as
begin
begin try
update tblProduct set ViewCount=@ViewCount where ID=@ID
return 1
end try
begin catch
return -1
end catch
end
go
create procedure uspInserttblProduct
@Name nvarchar(250),
@MetaTitle nvarchar(250),
@Description ntext,
@Images nvarchar(250),
@MoreImages xml,
@Price decimal(18,0),
@PromotionPrice decimal(18,0),
@Quantity int,
@CategoryID bigint,
@Detail ntext
as
begin
begin try
insert into tblProduct(Name,MetaTitle,Description,Images,MoreImages,Price,PromotionPrice,Quantity,CategoryID,Detail)
values (@Name,dbo.fuConvertToUnsign(@MetaTitle),@Description,@Images,@MoreImages,@Price,@PromotionPrice,@Quantity,@CategoryID,@Detail)
return 1
end try
begin catch
return -1
end catch
end
go
create procedure uspUpdatetblProduct
@ID bigint,
@Name nvarchar(250),
@MetaTitle nvarchar(250),
@Description ntext,
@Images nvarchar(250),
@MoreImages xml,
@Price decimal(18,0),
@PromotionPrice decimal(18,0),
@Quantity int,
@CategoryID bigint,
@Detail ntext,
@Status bit 
as
begin
begin try
update tblProduct set Name=@Name,MetaTitle=@MetaTitle,Description=@Description
,Images=@Images,MoreImages=@MoreImages,Price=@Price,PromotionPrice=@PromotionPrice,
Quantity=@Quantity,CategoryID=@CategoryID,Detail=@Detail,Status=@Status where ID=@ID
return 1
end try
begin catch
return -1
end catch
end
go
create procedure uspDeletetblProduct
@ID bigint
as
begin
delete from tblProduct where ID=@ID
return 1
end

--end procedure tblProduct
go
create table tblCategory
(
ID bigint identity primary key,
Name nvarchar(250),
MetaTitle nvarchar(250),
ParentID bigint,
DisplayOrder int default 0,
SeoTitle nvarchar(250),
CreatedDate datetime default getdate(),
Status bit not null default 1
)
go

--start procedure tblCategory

create procedure uspDatatblCategoryParentID
@ID bigint
as
begin
select * from tblCategory where ParentID=@ID order by DisplayOrder ASC
end
go

create procedure uspDatatblCategoryOrder
as
begin
select * from tblCategory order by DisplayOrder ASC
end
go

create procedure uspDatatblCategory
as
begin
select * from tblCategory
end
go
create procedure uspInserttblCategory
@Name nvarchar(250),
@MetaTitle nvarchar(250),
@ParentID bigint,
@DisplayOrder int,
@SeoTitle nvarchar(250)
as
begin
begin try
insert into tblCategory(Name,MetaTitle,ParentID,DisplayOrder,SeoTitle)
values (@Name,dbo.fuConvertToUnsign(@MetaTitle),@ParentID,@DisplayOrder,@SeoTitle)
return 1
end try
begin catch
return -1
end catch
end
go
create procedure uspUpdatetblCategory
@ID bigint,
@Name nvarchar(250),
@MetaTitle varchar(250),
@ParentID bigint,
@DisplayOrder int,
@SeoTitle nvarchar(250),
@Status bit
as
begin
begin try
update tblCategory set Name=@Name,MetaTitle=dbo.fuConvertToUnsign(@MetaTitle),ParentID=@ParentID,
DisplayOrder=@DisplayOrder,SeoTitle=@SeoTitle,Status=@Status where ID=@ID
return 1
end try
begin catch
return -1
end catch
end
go
create procedure uspDeletetblCategory
@ID bigint
as
begin
delete from tblCategory where ID=@ID
return 1
end

--end procedure tblCategory

--go
--create table tblContent
--(
--ID bigint identity primary key ,
--Name nvarchar(250),
--MetaTitle varchar(250),
--Description nvarchar(550),
--Images nvarchar(250),
--CategoryID bigint,
--Detail ntext,
--Warranty int,
--CreatedDate datetime default getdate(),
--CreatedBy varchar(50),
--ModifiedDate datetime,
--ModifiedBy varchar(50),
--MetaKeywords nvarchar(250),
--MetaDescriptions nchar(250),
--Status bit not null default 1,
--TopHot datetime,
--ViewCount int,
--Tags nvarchar(500)
--)
--go
--create table tblTag
--(
--ID varchar(100),
--Name nvarchar(100)
--) 
--go
--create table tblContentTag
--(
--ContentID bigint identity primary key,
--TagID varchar(100) 
--)
--go
--create table tblAbout
--(
--ID bigint identity primary key ,
--Name nvarchar(250),
--MetaTitle varchar(250),
--Description nvarchar(550),
--Detail ntext,
--CreatedDate datetime default getdate(),
--CreatedBy varchar(50),
--ModifiedDate datetime,
--ModifiedBy varchar(50),
--MetaKeywords nvarchar(250),
--MetaDescriptions nchar(250),
--Status bit not null default 1
--)
--go
--create table tblContact
--(
--ID int identity primary key,
--Content ntext,
--Status bit not null default 1
--)
--go
--create table tblFeedback
--(
--ID int identity primary key,
--Name nvarchar(50),
--Phone nvarchar(50),
--Email nvarchar(50),
--Address nvarchar(50),
--Content nvarchar(250),
--CreatedDate datetime default getdate(),
--Status bit not null default 1
--)
go
create table tblSlide
(
ID int identity primary key,
Image nvarchar(250),
DisplayOrder int default 1,
Link nvarchar(250),
Description nvarchar(50),
CreatedDate datetime default getdate(),
Status bit not null default 1
)
go

--start procedure tblSlide
create procedure uspDatatblSlide
as
begin
select * from tblSlide
end
go
create procedure uspInserttblSlide
@Image nvarchar(250),
@Link nvarchar(250),
@Description nvarchar(50)
as
begin
begin try
insert into tblSlide(Image,Link,Description)
values (@Image,@Link,@Description)
return 1
end try
begin catch
return -1
end catch
end
go
create procedure uspUpdatetblSlide
@ID bigint,
@Image nvarchar(250),
@DisplayOrder int,
@Link nvarchar(250),
@Description nvarchar(50),
@Status bit
as
begin
begin try
update tblSlide set Image=@Image,DisplayOrder=@DisplayOrder,Link=@Link,Description=@Description,
Status=@Status where ID=@ID
return 1
end try
begin catch
return -1
end catch
end
go
create procedure uspDeletetblSlide
@ID bigint
as
begin
delete from tblSlide where ID=@ID
return 1
end

--end procedure tblSlide
--go
--create table tblAds
--(
--ID int identity primary key,
--Image nvarchar(250),
--DisplayOrder int default 1,
--Link nvarchar(250),
--Description nvarchar(50),
--CreatedDate datetime default getdate(),
--Status bit not null default 1
--)
--go

--create table tblMenuType
--(
--ID int identity primary key,
--Name nvarchar(50)
--)
--go
--create table tblMenu
--(
--ID int identity primary key,
--Text nvarchar(50),
--Link nvarchar(250),
--DisplayOrder int ,
--Target nvarchar(50),
--Status bit not null default 1,
--TypeID int 
--)
--go
--create table tblFooter
--(
--ID varchar(50) primary key,
--Content ntext,
--Status bit not null default 1
--)
--go
--create table tblSystemConfig
--(
--ID varchar(50),
--Name nvarchar(50),
--Type varchar(50),
--Value nvarchar(250),
--Status bit not null default 1 
--)
--go
--create table tblOrderBy
--(
--ID bigint identity primary key,
--CreatedDate datetime default getdate(),
--CustomerID bigint,
--ShipName nvarchar(50),
--ShipMobile varchar(50),
--ShipAddress nvarchar(250),
--ShipEmail nvarchar(100),
--Status bit not null default 1
--)
go
create table tblOrderDetail
(
ID bigint identity primary key,
ProductID bigint not null,
Quantity int default 0,
Price decimal default 0,
Status bit not null default 1
)

go
create table tblBill
(
ID bigint identity primary key,
ClientID varchar(50),
CreatedDate datetime default getdate(),
ProductID bigint,
Quantity int default 0,
Price decimal default 0,
TotalPrice decimal default 0,
Status bit not null default 1
)
go

create table tblAccountClient
(
ID bigint identity primary key ,
RealName nvarchar(100) ,
IDaccount varchar(300),
UserName nvarchar(100) ,
Password varchar(100),
Email varchar(100) ,
Salt varchar(100),
CreatedDate datetime default getdate(),
Note nvarchar(500),
Status bit not null default 1
)
--start procedure tblAccountClient
go
create procedure uspDatatblAccountClient
as
begin
select * from tblAccountClient
end
go
create procedure uspInserttblAccountClient
@RealName nvarchar(100) ,
@IDaccount varchar(300) ,
@UserName nvarchar(100) ,
@Password varchar(100),
@Email varchar(100)
as
begin
declare @salt uniqueidentifier = newid()
begin try
if exists(select top 1 ID from tblAccountClient where UserName=@UserName)
begin
return 2
end
else if exists(select top 1 ID from tblAccountClient where Email=@Email)
begin
return 3
end
else if not exists(select top 1 ID from tblAccountClient where IDaccount=@IDaccount) and (@IDaccount is not null)
begin
insert into tblAccountClient(RealName,IDaccount,Email)
values (@RealName,@IDaccount,@Email)
return 1
end
else if not exists(select top 1 ID from tblAccountClient where UserName=@UserName) and 
not exists(select top 1 ID from tblAccountClient where Email=@Email) and (@IDaccount is null)
begin
insert into tblAccountClient(RealName,UserName,Password,Email,Salt)
values (@RealName,@UserName,HASHBYTES('SHA2_512',@Password+CAST(@salt as varchar(36))),@Email,@salt)
return 1
end
else if exists(select top 1 ID from tblAccountClient where Email=@Email) and exists(select top 1 ID from tblAccountClient where UserName=@UserName)
begin
return -1
end
end try
begin catch
return -1
end catch
end
go
create procedure uspUpdatetblAccountClient
@ID bigint,
@Note nvarchar(500),
@Status bit
as
begin
begin try
update tblAccountClient set Note = @Note,Status=@Status where ID=@ID
return 1
end try
begin catch
return -1
end catch
end
go
create procedure uspDeletetblAccountClient
@ID bigint
as
begin
delete from tblAccountClient where ID=@ID
return 1
end
go

create procedure uspLoginAccountClient
@UserName nvarchar(100),
@Password varchar(500)
as
begin
set nocount on
declare @userID int
if exists(select top 1 ID from tblAccountClient where UserName=@UserName)
begin 
set @userID = (select ID from tblAccountClient where UserName=@UserName and Status=1 and Password=HASHBYTES('SHA2_512',@Password+CAST(Salt as varchar(36))))
if(@userID is null)
return -1
else
return 1
end
else
return -1
end
truncate table tblAccountClient

--end procedure tblAccountClient
go
create table tblAccountAdmin
(
ID bigint identity primary key ,
UserName nvarchar(100),
Password varchar(500),
Salt varchar(200),
Note nvarchar(500),
Status bit not null default 1
)
go

--start procedure account admin

create procedure uspInserttblAccountAdmin
@UserName nvarchar(100),
@Password varchar(500)
as
begin
set nocount on
declare @salt uniqueidentifier = newid()
begin try
insert into tblAccountAdmin(UserName,Password,Salt)
values(@UserName,HASHBYTES('SHA2_512',@Password+CAST(@salt as varchar(36))),@salt)
return 1
end try
begin catch
return -1
end catch
end

go

create procedure uspUpdatetblAccountAdmin
@ID bigint,
@Password varchar(500),
@Note nvarchar(500),
@Status bit 
as
begin
set nocount on
begin try
update tblAccountAdmin set Password=HASHBYTES('SHA2_512',@Password+CAST(Salt as varchar(36))) ,
Note=@Note,Status=@Status
where ID = @ID
return 1
end try
begin catch
return -1
end catch
end
go


create procedure uspDeletetblAccountAdmin
@ID bigint 
as
begin
set nocount on
begin try
delete tblAccountAdmin where ID=@ID
return 1
end try
begin catch
return -1
end catch
end
go

create procedure uspDatatblAccountAdmin
as
begin
select * from tblAccountAdmin
end
go

create procedure uspLoginAccountAdmin
@UserName nvarchar(100),
@Password varchar(500)
as
begin
set nocount on
declare @userID int
if exists(select top 1 ID from tblAccountAdmin where UserName=@UserName)
begin 
set @userID = (select ID from tblAccountAdmin where UserName=@UserName and Status=1 and Password=HASHBYTES('SHA2_512',@Password+CAST(Salt as varchar(36))))
if(@userID is null)
return -1
else
return 1
end
else
return -1
end

--end procedure account admin


go

--start function seo title


CREATE FUNCTION fuConvertToUnsign
( @strInput NVARCHAR(4000) )
 RETURNS NVARCHAR(4000) 
 AS BEGIN IF @strInput IS NULL 
 RETURN @strInput IF @strInput = '' RETURN @strInput 
 DECLARE @RT NVARCHAR(4000) 
 DECLARE @SIGN_CHARS NCHAR(136) 
 DECLARE @UNSIGN_CHARS NCHAR (136)
  SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) 
  SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' 
  DECLARE @COUNTER int 
  DECLARE @COUNTER1 int 
  SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput))
   BEGIN SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) 
   BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) )
    BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1)
	 ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) 
	 BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END
	 
	 go

select dbo.fuConvertToUnsign('Anh yêu em')
--end function seo title


go

--phan trang 
create procedure customPage
@current_page bigint,
@limit bigint,
@name nvarchar(200)
as
begin
declare @total_record bigint
declare @total_page bigint
declare @start bigint 

if @name is not null 
set @total_record = (select count(*) from tblProduct where Name like '%'+@name+'%')
else if @name is null 
set @total_record = (select count(*) from tblProduct)

set @total_page = CEILING(CAST(@total_record as decimal)/CAST(@limit as decimal))

if @current_page>@total_page
begin
set @current_page = @total_page 
end
else if @current_page<1
begin 
set @current_page = 1
end

set @start = (@current_page-1)*@limit

if @name is not null 
begin 
;WITH Numberedtblcontact AS
(
    SELECT
	    *,
        ROW_NUMBER() OVER (ORDER BY id) AS RowNumber
    FROM
        tblProduct where Name like '%'+@name+'%'
)select top(@limit)* from Numberedtblcontact where  RowNumber BETWEEN  @start and @start+@limit
end

else if @name is null 
begin 
;WITH Numberedtblcontact AS
(
    SELECT
	    *,
        ROW_NUMBER() OVER (ORDER BY id) AS RowNumber
    FROM
        tblProduct 
)select top(@limit)* from Numberedtblcontact where  RowNumber BETWEEN  @start and @start+@limit
end

return @total_page
end

select * from tblProduct
select * from tblCategory