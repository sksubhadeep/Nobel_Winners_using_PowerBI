select *
from PortFolioProject.dbo.Nobel


--Change the Born and died date format from YYYY-MM-DD to YYYY

select left(Born,4) as Born_Year,left(Died,4) as Died_Year
from PortFolioProject.dbo.Nobel
order by Id

ALTER TABLE PortFolioProject.dbo.Nobel
Add Born_Year smallint

ALTER TABLE PortFolioProject.dbo.Nobel
Add Died_Year smallint

Update PortFolioProject.dbo.Nobel
Set Born_Year=left(Born,4)

Update PortFolioProject.dbo.Nobel
Set Died_Year=left(Died,4)

select Born_Year,Died_Year
from PortFolioProject.dbo.Nobel
order by Id

--Create a Life_Expectancy Column

select (Died_Year-Born_Year) as Life_Expectancy
from PortFolioProject.dbo.Nobel

ALTER TABLE PortFolioProject.dbo.Nobel
Add Life_Expectancy nvarchar(255)

Update PortFolioProject.dbo.Nobel
Set Life_Expectancy=(Died_Year-Born_Year)


--Combine First Name and Last Name as Name Column

select CONCAT_WS(' ',Firstname,Surname) as Name
from PortFolioProject.dbo.Nobel
order by Id

ALTER TABLE PortFolioProject.dbo.Nobel
Add Name nvarchar(255)

Update PortFolioProject.dbo.Nobel
Set Name=CONCAT_WS(' ',Firstname,Surname)

--Replacing the old country and city names with recent names

select 
case when Born_country like '%(now%' then SUBSTRING(Born_country,CHARINDEX('(',Born_country)+5,len(Born_country)-CHARINDEX('(',Born_country)-5) when Born_country ='the Netherlands' then 'Netherlands' else Born_country end as Born_country_new,
case when Born_city like '%(now%' then SUBSTRING(Born_city,CHARINDEX('(',Born_city)+5,len(Born_city)-CHARINDEX('(',Born_city)-5) else Born_city end as Born_city_new,
case when Died_country like '%(now%' then SUBSTRING(Died_country,CHARINDEX('(',Died_country)+5,len(Died_country)-CHARINDEX('(',Died_country)-5) when Died_country ='the Netherlands' then 'Netherlands' else Died_country end as Died_country_new,
case when Died_city like '%(now%' then SUBSTRING(Died_city,CHARINDEX('(',Died_city)+5,len(Died_city)-CHARINDEX('(',Died_city)-5)  else Died_city end as Died_city_new,
case when Organization_country like '%(now%' then SUBSTRING(Organization_country,CHARINDEX('(',Organization_country)+5,len(Organization_country)-CHARINDEX('(',Organization_country)-5) when Organization_country ='the Netherlands' then 'Netherlands' else Organization_country end as Organization_country_new
from PortFolioProject.dbo.Nobel
order by Id

ALTER TABLE PortFolioProject.dbo.Nobel
Add Born_country_new nvarchar(255),Born_city_new nvarchar(255),Died_country_new nvarchar(255),Died_city_new nvarchar(255),Organization_country_new nvarchar(255)

Update PortFolioProject.dbo.Nobel
Set Born_country_new=case when Born_country like '%(now%' then SUBSTRING(Born_country,CHARINDEX('(',Born_country)+5,len(Born_country)-CHARINDEX('(',Born_country)-5) when Born_country ='the Netherlands' then 'Netherlands' else Born_country end,
Born_city_new=case when Born_city like '%(now%' then SUBSTRING(Born_city,CHARINDEX('(',Born_city)+5,len(Born_city)-CHARINDEX('(',Born_city)-5) else Born_city end,
Died_country_new=case when Died_country like '%(now%' then SUBSTRING(Died_country,CHARINDEX('(',Died_country)+5,len(Died_country)-CHARINDEX('(',Died_country)-5) when Died_country ='the Netherlands' then 'Netherlands' else Died_country end,
Died_city_new=case when Died_city like '%(now%' then SUBSTRING(Died_city,CHARINDEX('(',Died_city)+5,len(Died_city)-CHARINDEX('(',Died_city)-5)  else Died_city end,
Organization_country_new=case when Organization_country like '%(now%' then SUBSTRING(Organization_country,CHARINDEX('(',Organization_country)+5,len(Organization_country)-CHARINDEX('(',Organization_country)-5) when Organization_country ='the Netherlands' then 'Netherlands' else Organization_country end

select Born_country_new,Born_city_new,Died_country_new,Died_city_new,Organization_country_new
from PortFolioProject.dbo.Nobel
order by Id

--Changing the Gender as M and F

select case when Gender ='male' then 'M' when Gender ='female' then 'F' else NULL end
from PortFolioProject.dbo.Nobel


ALTER TABLE PortFolioProject.dbo.Nobel
Add New_gender nvarchar(255)

Update PortFolioProject.dbo.Nobel
Set New_gender=case when Gender ='male' then 'M' when Gender ='female' then 'F' else NULL end


--Delete unused columns

ALTER TABLE PortFolioProject.dbo.Nobel
DROP COLUMN Id,Firstname,Surname,Born,Died,Born_country,Born_city,Died_country,Died_city,Organization_country,Gender

ALTER TABLE PortFolioProject.dbo.Nobel
DROP COLUMN Born_country_code,Died_country_code,Overall_motivation,Geo_Shape,Geo_Point_2D

--Count the numbers of Novel Winners for Each Category

select Category,count(category) as Cnt
from PortFolioProject.dbo.Nobel
group by Category
order by Cnt desc

--Listing all count of nobel prizes category wise for the year in which maximum nobel prizes have been awarded

select avg(year) as Year
,Category,count(category) as Cnt
from PortFolioProject.dbo.Nobel
where year = (select year from PortFolioProject.dbo.Nobel group by year
having count(year) = (select top 1 count(year) as cnt from PortFolioProject.dbo.Nobel group by year order by cnt desc))
group by Category
order by Cnt desc

--Select all male awardees who have received the nobel prizes in the category "Physics" and from country "USA" before the WW2

select Name,Year,Motivation
from PortFolioProject.dbo.Nobel
where Category='Physics' and Born_country_new = 'USA' and New_gender='M' and Year < 1945

--Copy the Modified table to system
--Open Command Prompt and type the below code
--bcp <database_name>.<schema_name>.<table_name> out <file_destination_path> -S<server_instance> -c -t"," -T



