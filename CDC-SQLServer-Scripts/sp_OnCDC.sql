
/*
-- Author:  Sac
-- _Date: 2024
-- Description: This stored procedure activates the CDC from your database
--Parameters: DataBase Name
exec sp_OnCDC 'myDataBase'
*/

CREATE PROCEDURE sp_OnCDC
@databasename varchar(max)
AS 
BEGIN

--activate CDC
exec ('use ' + @databasename);
EXEC sys.sp_cdc_enable_db 



END
