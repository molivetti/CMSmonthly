DECLARE @txtfile VARCHAR(max)
DECLARE @CSVtoTSVtempfolder VARCHAR(max)
DECLARE @table VARCHAR(max)
DECLARE @sqlstring VARCHAR(max)
DECLARE @month VARCHAR(2)
DECLARE @year VARCHAR(4)
DECLARE @dbname VARCHAR(max)

--Set your database name here
SET @dbname = 'TestDB'
--Set path for temp folder that holds the csv-to-tsv converted files
SET @CSVtoTSVtempfolder = 'T:\Dev\CMS\master\CMSMonthly\CSVtoTSV'

SET @month = '06'
SET @year = '2015'
SET @txtfile = @CSVtoTSVtempfolder + '\Monthly_Report_By_Contract_'+@year+'_'+@month+'.tsv'
SET @table = @dbname + '.dbo.CMStemp_' + @month + '_' + @year 
SET @sqlstring =
'CREATE TABLE ' + @table +
' (
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
    
)

BULK INSERT ' + @table + ' 
FROM "' + @txtfile + '"
WITH
(
FIRSTROW = 2
)

ALTER TABLE '+@table+'
	ADD Month varchar(2)
	
ALTER TABLE '+@table+'
	ADD Year varchar(4)

UPDATE '+@table+'
SET		Month = '+@month+'
		,Year =	'+@year+'

'
PRINT (@sqlstring)
EXEC (@sqlstring)
