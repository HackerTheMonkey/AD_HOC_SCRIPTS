REM Set the program default variables
SET LogDir=D:\Scorecard\Temp\Hasanein\logs
SET SQLServerName=localhost
SET LogFilename=delete_scods-rc_ODSCustomerSnapshot.main
SET Username=sa
SET Password=p@ssv0rd
SET DatabaseName=SCODS-RC

REM execute the sql script
sqlcmd -S %SQLServerName% -U %Username% -P %Password% -m1 -d %DatabaseName% -i delete_scods-rc_ODSCustomerSnapshot_script.cmd  -o %LogDir%\%LogFilename%.log