' 
'	This script is used to force the renewal of the DHCP 
'	lease on a windows machine.
'
strComputer = "localhost"
Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set objNetworkSettings = objWMIService.Get("Win32_NetworkAdapterConfiguration")
objNetworkSettings.RenewDHCPLeaseAll()