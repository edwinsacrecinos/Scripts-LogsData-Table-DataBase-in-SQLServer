insert into [dbo].[tblLlamadas]
 ( [compania], [fechaRegistro], [minutosLlamadas], [llamadaValida])
 values ('Calling GT',getdate(),12,1)


 SELECT DB_ID('Llamadas');

 select * from [dbo].[tblLlamadas]


 update [dbo].[tblLlamadas]
 set compania = 'Tigo tv'
 where id = 1

 delete [dbo].[tblLlamadas] where id = 5


 SELECT *
FROM ::fn_trace_gettable('C:\LogsSQL\LogTblLlamadas.trc', default);


select* from fn_trace_getfilterinfo(2)