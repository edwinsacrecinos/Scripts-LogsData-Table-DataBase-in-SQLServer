/*
-- Author:  Sac
-- _Date: 2024
-- Description: This stored procedure confirms the activation of the CDC on the table
--Parameters: Table Name
exec sp_ConfirmsActivationCDCfromTable 'myTable'
*/

CREATE PROCEDURE sp_ConfirmsActivationCDCfromTable
@table varchar(max)
AS
BEGIN
select [name] as Tabla, 
CASE
WHEN is_tracked_by_cdc = 1 THEN 'CDC On'
WHEN is_tracked_by_cdc = 0 THEN 'CDC Off'
ELSE 'unknown' -- state unknown
END AS [State CDC]
from sys.tables
where [name] = @table;

END