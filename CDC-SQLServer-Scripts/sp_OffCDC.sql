
/*
-- Author:  Sac
-- _Date: 2024
-- Description: This stored procedure disables the CDC from your database
--Parameters: DataBase Name
exec sp_OffCDC 'myDataBase'
*/


CREATE PROCEDURE sp_OffCDC
@databasename varchar(max) 
AS 
BEGIN

--Disable CDC
exec ('use ' + @databasename);
EXEC sys.sp_cdc_disable_db;

END
