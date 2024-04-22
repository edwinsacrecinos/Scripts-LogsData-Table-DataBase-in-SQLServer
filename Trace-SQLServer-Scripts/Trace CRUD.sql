-- Create a trace
DECLARE @TraceID int;
DECLARE @maxfilesize bigint;

set @maxfilesize = 50;

EXEC sp_trace_create @TraceID OUTPUT,
0,
N'C:\LogsSQL\trace.tblLlamadas',
@maxfilesize,
NULL;

print @TraceID;

-- Configure events to capture
DECLARE @on BIT = 1;
DECLARE @rec INT;

-- Event for INSERT
EXEC sp_trace_setevent @TraceID, 10, 1, @on;  -- SQL:BatchCompleted event
EXEC sp_trace_setevent @TraceID, 10, 12, @on; -- SP:StmtCompleted event
EXEC sp_trace_setevent @TraceID, 45, 1, @on;  -- SQL:BatchStarting event
EXEC sp_trace_setevent @TraceID, 45, 12, @on; -- SP:StmtStarting event

-- Event for DELETE
EXEC sp_trace_setevent @TraceID, 10, 1, @on;  -- SQL:BatchCompleted event
EXEC sp_trace_setevent @TraceID, 10, 12, @on; -- SP:StmtCompleted event
EXEC sp_trace_setevent @TraceID, 45, 1, @on;  -- SQL:BatchStarting event
EXEC sp_trace_setevent @TraceID, 45, 12, @on; -- SP:StmtStarting event

-- Event for UPDATE
EXEC sp_trace_setevent @TraceID, 10, 1, @on;  -- SQL:BatchCompleted event
EXEC sp_trace_setevent @TraceID, 10, 12, @on; -- SP:StmtCompleted event
EXEC sp_trace_setevent @TraceID, 45, 1, @on;  -- SQL:BatchStarting event
EXEC sp_trace_setevent @TraceID, 45, 12, @on; -- SP:StmtStarting event

-- Filter by database and table
DECLARE @database INT, @tableFilter NVARCHAR(256), @databaseID NVARCHAR(256);

SELECT @database = DB_ID(N'Calls'); -- Change 'Calls' to the name of your database
SET @databaseID = CAST(@database as NVARCHAR(256));
SET @tableFilter = N'%tblCalls%';   -- Change 'tblLlamadas' to the name of your table

EXEC sp_trace_setfilter @TraceID, 35, 0, 0, @databaseID; -- DatabaseID filter
EXEC sp_trace_setfilter @TraceID, 10, 0, 6, @tableFilter; -- TextData filter

-- Start the trace

EXEC sp_trace_setstatus 2, 1;

--- Consult traces (query all trace information)
select * from::fn_trace_getinfo(null)

/*
-- Wait for a while (optional) to capture events

-- Stop the trace
EXEC sp_trace_setstatus @TraceID, 0;

-- Close the trace
EXEC sp_trace_setstatus @TraceID, 2;
*/