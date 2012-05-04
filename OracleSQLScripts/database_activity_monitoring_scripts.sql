-- check the creation & modification dates of PL/SQL code within the database
Select 
       t.object_name,
       t.created,
       t.last_ddl_time,
       status
       From User_Objects t
       Where to_char(t.last_ddl_time,'yyyymm')='200803';
       
-- to check if the given table(s) is/are refrenced by any PL/SQL code or not
Select * From User_Source v Where lower(v.text) Like '%&keyword%';
Select text From user_source Where user_source.name='HASANEIN_TEST01';-- get the source code of a specific script

