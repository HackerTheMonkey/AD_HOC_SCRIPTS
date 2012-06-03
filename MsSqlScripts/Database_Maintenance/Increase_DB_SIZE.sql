-- Get the size of the datafiles of the hasdb01 database
use [scods];
select t.name, t.size from sys.database_files t where t.type_desc='ROWS';

-- Change the size of the database file
alter database [SCODS]  modify file (name='SCODS1', size=49 GB)

-- Get the Db size again
select t.name, t.size from sys.database_files t where t.type_desc='ROWS';

-- Change the auto-growth settings for all the files in all the databases to grow by 10% when needed.
alter database [scods-ct] modify file(name='scods-ct', filegrowth=10%);
alter database [scods-rc] modify file(name='scods-rc', filegrowth=10%);
alter database [scods-ek] modify file(name='scods-ek', filegrowth=10%);
alter database [scods] modify file(name='scods1', filegrowth=10%);
alter database [screport] modify file(name='screport', filegrowth=10%);
alter database [scload] modify file(name='scload', filegrowth=10%);
alter database [scrules] modify file(name='scrules', filegrowth=10%);
