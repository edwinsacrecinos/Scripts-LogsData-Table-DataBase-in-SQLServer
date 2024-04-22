DECLARE @TraceID INT; -- Make sure you have the ID of the trace you want to delete
SET @TraceID = 2;

EXEC sp_trace_setstatus @TraceID, 0;

EXEC sp_trace_setstatus @TraceID, 2;
