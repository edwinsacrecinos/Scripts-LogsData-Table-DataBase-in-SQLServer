/*
-- Author:  Sac
-- _Date: 2024
-- Description: This stored procedure activates the CDC from your Table in your DataBase
--Parameters: DataBase Name and Schema
exec sp_OnCDCinTable 'myTableInDataBase','dbo'
*/

CREATE PROCEDURE sp_OnCDCinTable
@table varchar(max), --Table
@Sch varchar(max) --Schema
AS
BEGIN

EXEC ('sys.sp_cdc_enable_table
@source_schema ='+' N'+''''+@Sch+''''+', 
@source_name ='+' N'+''''+@table+''''+', 
@role_name = NULL;' );


END

