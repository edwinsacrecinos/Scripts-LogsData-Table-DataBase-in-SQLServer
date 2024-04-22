/*
-- Author:  Sac
-- _Date: 2024
-- Description: This stored procedure automatically creates a trigger 
for Insert, Update and Delete of a selected table
--Param: Table Name 
exec sp_TriggerGenerateAutomatic 'tableName'

*/

CREATE PROCEDURE  sp_TriggerGenerateAutomatic 
@tableName varchar(256)
AS
BEGIN


--Create Script to create tables
DECLARE @createScript NVARCHAR(MAX);

--Create Script for the Schema
-- Define the schema name
DECLARE @nombreEsquema NVARCHAR(128) = 'logs';
-- Generate the script to create the schema
DECLARE @scriptCrearEsquema NVARCHAR(MAX);



-- Check if the schema exists
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.SCHEMATA WHERE schema_name = @nombreEsquema)
BEGIN
    DECLARE @scriptVerificacion NVARCHAR(MAX);
    
    SET @scriptCrearEsquema = N'CREATE SCHEMA ' + @nombreEsquema+ ';';
    
-- Print the verification message
    PRINT @scriptVerificacion;
END
ELSE
BEGIN
    SET @scriptCrearEsquema = '-- El esquema ' + @nombreEsquema + ' ya existe.';
END

-- Check if the table exists in the schema
IF OBJECT_ID(@nombreEsquema + '.' + @tableName, 'U') IS NOT NULL
BEGIN
    SET @createScript = '-- La Tabla: '+@nombreEsquema+'.'+@tableName+' ya existe.'
END
ELSE
BEGIN
    
SET @createScript = (
    SELECT 'CREATE TABLE ' +'logs.Log_'+@tableName + ' (' +
           STUFF(
               (
                   SELECT ', ' + CHAR(13) + CHAR(10) + COLUMN_NAME + ' ' + DATA_TYPE +
                          CASE
                              WHEN DATA_TYPE IN ('varchar', 'char') THEN 
                                  CASE
                                      WHEN CHARACTER_MAXIMUM_LENGTH = -1 THEN '(MAX)'
                                      ELSE '(' + CAST(CHARACTER_MAXIMUM_LENGTH AS NVARCHAR(10)) + ')'
                                  END
                              WHEN DATA_TYPE IN ('numeric', 'decimal') THEN '(' + CAST(NUMERIC_PRECISION AS NVARCHAR(10)) + ',' + CAST(NUMERIC_SCALE AS NVARCHAR(10)) + ')'
                              ELSE ''
                          END +
                          CASE WHEN IS_NULLABLE = 'NO' THEN ' NOT NULL' ELSE ' NULL' END
                   FROM INFORMATION_SCHEMA.COLUMNS
                   WHERE TABLE_NAME = @tableName
                   ORDER BY ORDINAL_POSITION
                   FOR XML PATH('')
               ), 1, 2, ''
           ) +
           CHAR(13) + CHAR(10) +
           ',userDataBase varchar(150) NULL , operation varchar(100) NULL, dateOperation datetime NULL);'
);
END

DECLARE @columnNames Varchar(max);
DECLARE @ScriptTriggerInsert Varchar(MAX);
DECLARE @ScriptTriggerDelete Varchar(MAX);
DECLARE @ScriptTriggerUpdate Varchar(MAX);





select @columnNames = COALESCE (@columnNames+',','') + COLUMN_NAME
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = @tableName;


SET @ScriptTriggerInsert = '
CREATE TRIGGER trInsert'+@tableName+'
ON ' +@tableName+'
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON
    INSERT INTO '+'logs.Log_'+ @tableName+' ('+@columnNames+',userDataBase,operation,dateOperation)
    SELECT '+@columnNames+','+'SUSER_SNAME(),'+''''+'INSERT'+''''+', GETDATE()
    FROM inserted;
END;
';

SET @ScriptTriggerDelete = '
CREATE TRIGGER trDelete'+@tableName+'
ON '+@tableName+'
AFTER DELETE
AS
BEGIN
	SET NOCOUNT ON
    INSERT INTO '+'logs.Log_'+ @tableName+' ('+@columnNames+',userDataBase ,operation,dateOperation)
    SELECT '+@columnNames+','+'SUSER_SNAME(),'+''''+ 'DELETE'+''''+',  GETDATE()
    FROM deleted;
END;
';

SET @ScriptTriggerUpdate ='
CREATE TRIGGER trUpdate'+@tableName+'
ON '+@tableName+'
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON
    INSERT INTO '+'logs.Log_'+ @tableName+' ('+@columnNames+', userDataBase,operation,dateOperation)
	SELECT '+@columnNames+','+'SUSER_SNAME(),'+''''+ 'UPDATE ANTES'+''''+', GETDATE()
	FROM deleted d;

	INSERT INTO '+'logs.Log_'+ @tableName+' ('+@columnNames+',userDataBase ,operation,dateOperation)
	SELECT '+@columnNames+','+'SUSER_SNAME(),'+''''+ 'UPDATE DESPUES'+''''+', GETDATE()
	FROM inserted i;
END;
';


-- Print the outline script
PRINT @scriptCrearEsquema;
PRINT CHAR(13) + CHAR(10); -- Print a blank line

--Imprimir el script de crear tabla de log:
PRINT '-- Your version of SQL Server does not support the symbol
 you can remove it using the replace with blank tool or do it manually ';
PRINT CHAR(13) + CHAR(10); -- Print a blank line
PRINT @createScript;
PRINT CHAR(13) + CHAR(10); -- Print a blank line

--Print the INSERT trigger script
PRINT @ScriptTriggerInsert;
PRINT CHAR(13) + CHAR(10); -- Print a blank line

--Print the DELETE trigger script
PRINT @ScriptTriggerDelete;
PRINT CHAR(13) + CHAR(10); -- Print a blank line

--Print the UPDATE trigger script
PRINT @ScriptTriggerUpdate;
PRINT CHAR(13) + CHAR(10); -- Print a blank line

END

