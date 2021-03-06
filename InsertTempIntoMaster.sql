--Insert CMStemp_??_???? into the master CMS table

DECLARE @month VARCHAR(2)
DECLARE @year VARCHAR(4)
DECLARE @sqlstring VARCHAR(max)
DECLARE @dbname VARCHAR(max)

--Set database name
SET @dbname = 'TestDB'

--Set your month/year here
SET @month = '05'
SET @year = '2015'

SET @sqlstring =
'INSERT INTO ['+@dbname+'].[dbo].[CMSdata](ContractNumber, OrganizationType, PlanType, OrganizationName, OrganizationMarketingName, ParentOrganization, ContractEffectiveDate, OffersPartD, MAOnly, PartD, Enrollment, Month, Year)
SELECT ContractNumber, OrganizationType, PlanType, OrganizationName, OrganizationMarketingName, ParentOrganization, ContractEffectiveDate, OffersPartD, MAOnly, PartD, Enrollment, Month, Year
FROM ['+@dbname+'].[dbo].[CMStemp_'+@month+'_'+@year+']'
PRINT (@sqlstring)
EXEC (@sqlstring)