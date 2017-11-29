--Creat master table to hold all CMS data

DECLARE @dbname VARCHAR(max)
DECLARE @sqlMaster VARCHAR(max)
DECLARE @sqlContract VARCHAR(max)
 

SET @dbname = 'TestDB'

SET @sqlMaster = 
'CREATE TABLE  '+@dbname+'.dbo.CMSDatatest
 (
	ContractNumber varchar(10)
    ,OrganizationType varchar(50)
    ,PlanType varchar(50)
    ,OrganizationName varchar(100)
    ,OrganizationMarketingName varchar(100)
    ,ParentOrganization varchar(100)
    ,ContractEffectiveDate varchar(50)
    ,OffersPartD varchar(50)
    ,MAOnly int
    ,PartD int
    ,Enrollment int
    ,Month varchar(2)
    ,Year varchar(4)
)'

exec(@sqlMaster)



--Create client contract numbers table to aggregate all our clients' contracts
SET @sqlContract =
'CREATE TABLE '+@dbname+'.dbo.ClientContractNumbers
(
	contract_number varchar(5)
    ,Client varchar(max)
)
'