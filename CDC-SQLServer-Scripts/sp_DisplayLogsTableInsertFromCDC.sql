/*
-- Author:  Sac
-- _Date: 2024
-- Description: This stored procedure display logs Insert from CDCs
exec sp_DisplayLogsTableInsertFromCDC 'moviesTable','dbo'
*/


CREATE PROCEDURE sp_DisplayLogsTableInsertFromCDC
@table varchar(max),
@esquema varchar(max)
AS 
BEGIN

DECLARE @columnNames Varchar(max);

select @columnNames = COALESCE (@columnNames+',','') + COLUMN_NAME
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = @table;

print @columnNames;

DECLARE @fullNameTableWithSchema varchar(max);

set @fullNameTableWithSchema = @esquema+'_'+@table+'_'+'CT';--Replace CT for you formant o delete

print @fullNameTableWithSchema;


EXEC( 'SELECT '+ @columnNames+', Operations = CASE WHEN d.__$operation = 2 THEN' +''''+'INSERT'+''''+
						   'ELSE'+''''+ '--'+''''+ 'END,'+
'tm.tran_begin_time AS STARTDATE, 
tm.tran_end_time AS ENDDATE
FROM cdc.'+@fullNameTableWithSchema+' as d inner join
cdc.lsn_time_mapping as tm ON
d.__$start_lsn = tm.start_lsn
WHERE d.__$operation = 2 ');



END