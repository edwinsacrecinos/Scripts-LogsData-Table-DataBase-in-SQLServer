
/*
-- Author:  Sac
-- _Date: 2024
-- Description: This stored procedure confirms the activation of the CDC in the database
--Parameters: DataBase Name
exec sp_ConfirmsActivationCDCfromDatabase 'myDataBase'
*/

CREATE PROCEDURE sp_ConfirmsActivationCDCfromDatabase
@databasename varchar(max)
AS 
BEGIN

--Activar CDC
exec ('use ' + @databasename);
--Consultar CDC Activo
select [name] as [Base de Datos], 
CASE
WHEN is_cdc_enabled = 1 THEN 'CDC Activado'
WHEN is_cdc_enabled = 0 THEN 'CDC No Activo'
ELSE 'Estado Desconocido'
END AS [Estado CDC]
from sys.databases 
where database_id= DB_ID();

END




