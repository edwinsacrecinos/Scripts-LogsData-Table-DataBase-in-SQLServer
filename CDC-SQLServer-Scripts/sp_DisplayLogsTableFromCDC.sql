
/*
-- Author:  Sac
-- _Date: 2024
-- Description: This stored procedure Display your Logs Table from CDC
exec sp_DisplayLogsTableFromCDC 'moviesTable','dbo'
*/


CREATE PROCEDURE sp_DisplayLogsTableFromCDC
@table varchar(max),
@sche varchar(max)
AS 
BEGIN

DECLARE @columnNames Varchar(max);

select @columnNames = COALESCE (@columnNames+',','') + COLUMN_NAME
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = @table;

print @columnNames;

DECLARE @fullNameTableWithSchemavarchar(max);

set @fullNameTableWithSchema= @sche+'_'+@table+'_'+'CT'; --Replace CT for you formant o delete

print @fullNameTableWithSchema;


EXEC( 'SELECT '+ @columnNames+', Operations = CASE WHEN d.__$operation = 1 THEN' +''''+'DELETE'+''''+
						   'WHEN d.__$operation = 2 THEN'+''''+'INSERT'+''''+
						   'WHEN d.__$operation = 3 THEN'+''''+ 'UPDATE BEFORE'+''''+
						   'WHEN d.__$operation = 4 THEN'+''''+ 'UPDATE AFTER'+''''+
						   'ELSE'+''''+ '--'+''''+ 'END,'+
'tm.tran_begin_time AS INICIO, 
tm.tran_end_time AS FINAL
FROM cdc.'+@fullNameTableWithSchema+' as d inner join
cdc.lsn_time_mapping as tm ON
d.__$start_lsn = tm.start_lsn');



END