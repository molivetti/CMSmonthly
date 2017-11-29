Matthew Olivetti
4/21/2015

IN SHORT
-Download .csv files each month from CMS.gov
--The files contain contract numbers and enrollment numbers for organizations
-From our database, collect each client's contract numbers in their dbo.PRODUCTS tables
-Match clients' contract numbers with contract numbers in .csv files
-Now we have enrollment numbers for our clients' contract numbers

FILES INCLUDED IN THIS FOLDER
CreateMasterAndClientContractNumbers.sql
csvtotsv.vbs
CreateNewMonthTable.sql
InsertTempIntoMaster.sql
GetMonthlyClients.sql

FIRST: CREATE CMSMASTERTABLE AND CLIENTCONTRACTNUMBERS
-Open C:\...\CMSMonthly\CreateMasterAndClientContractNumbers.sql
-Set @dbname to your database name
-Execute the .sql file

MONTHLY PROCEDURE TO GET CLIENT ENROLLMENT NUMBERS
1) 
Download 'Enrollment by Contract' file for desired month from:
https://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/MCRAdvPartDEnrolData/Monthly-Enrollment-by-Contract.html
2)
Extract .csv file to C:\...\CMSMonthly\CSVtoTSV
3)
Open extracted .csv file in any text editor
4)
In text editor, use search/replace tool to replace "*" with "0" for all instances. 
5)
Open C:\...\CMSMonthly\csvtotsv.vbs
6)
In the csvtotsv program, convert .csv file to .tsv
7)
Open C:\...\CMSMonthly\CreateNewMonthTable.sql
-Set the correct database name
-Set the correct values for @year and @month attributes
-Set the correct path to C:\...\CMSMonthly\CSVtoTSV
-Execute the .sql file
8)
Open C:\...\CMSMonthly\InsertTempIntoMaster.sql
-Set the correct database name
-Set the correct values for @year and @month attributes
-Execute the .sql file
9)
Move .tsv file from C:\...\CMSMonthly\CSVtoTSV to just C:\...\CMSMonthly
10)
Open C:\...\CMSMonthly\GetMonthlyClients.sql
-Set the correct database name
-Set the correct values for @year and @month attributes
-Execute the .sql file
--In the Results:
--The top table displays all the clients' contracts not found in the database
--The bottom table displays all the client's contracts found in the database
