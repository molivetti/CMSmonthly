Declare @month varchar(MAX)
Declare @year  varchar(MAX)
Declare @notFound  varchar(MAX)
Declare @foundClients  varchar(MAX)
Declare @dbname varchar(MAX)

--Set your month & year here
Set @month = '06'
Set @year  = '2015'

--Set database name here
Set @dbname = 'TestDB'

--Contract numbers NOT in CMS
Set @notFound = '
SELECT 
  CCN.contract_number
  ,CCN.Client
FROM 
  ['+@dbname+'].[dbo].[CMStemp_'+@month+'_'+@year+'] as CMS
  RIGHT JOIN '+@dbname+'.dbo.ClientContractNumbers as CCN
ON CMS.ContractNumber = CCN.contract_number
WHERE CMS.ContractNumber is NULL
ORDER BY Client
'
Exec (@notFound)
  
--Contract numbers and enrollment count for client contract numbers found in CMS
--We do not include PDP or Employer/Union Only DIrect Contract PDP organization types
Set @foundClients = '
SELECT ContractNumber
      ,OrganizationType
      ,PlanType
      ,OrganizationName
      ,OrganizationMarketingName
      ,ParentOrganization
      ,ContractEffectiveDate
      ,CCN.Client
      ,Enrollment
FROM 
['+@dbname+'].[dbo].[CMStemp_'+@month+'_'+@year+'] as CMS
JOIN '+@dbname+'.dbo.ClientContractNumbers as CCN
ON CMS.ContractNumber = CCN.contract_number
WHERE
	OrganizationType != ''PDP'' AND
	OrganizationType != ''Employer/Union Only Direct Contract PDP''
ORDER BY Client
'
Exec(@foundClients)