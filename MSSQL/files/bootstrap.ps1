Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Pre-install..."
New-Item -Path 'C:\DB\DATA\' -ItemType Directory
New-Item -Path 'C:\DB\LOG\' -ItemType Directory

Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Copy SQL.iso..."
Copy-Item 'c:\vagrant\SQLServer2019-x64-ENU-Dev.iso' 'C:\'

Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Mount SQL.iso..."
Mount-DiskImage -ImagePath "c:\SQLServer2019-x64-ENU-Dev.iso" -StorageType ISO -PassThru | Get-Volume

Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Install MS SQL..."
d:\setup.exe /INDICATEPROGRESS /QS /IACCEPTSQLSERVERLICENSETERMS /ACTION=Install /FEATURES=SQLEngine /INSTANCENAME=MSSQLSERVER /SECURITYMODE=SQL /SQLSYSADMINACCOUNTS="vagrant" /SAPWD="P@ssw0rd" /SQLUSERDBDIR="C:\DB\DATA" /SQLUSERDBLOGDIR="C:\DB\LOG" /TCPENABLED=1
# Ex.1 Setup.exe /QS /ACTION=Install /FEATURES=SQL /INSTANCENAME=SC /SQLSVCACCOUNT=FLORENTAPPOINTA\svc-sqldb /SQLSVCPASSWORD="P@ssword!123" /AGTSVCACCOUNT=FLORENTAPPOINTA\svc-sqlagent /AGTSVCPASSWORD="P@ssword!123" /RSSVCACCOUNT=FLORENTAPPOINTA\svc-sqlreporting /RSSVCPASSWORD="P@ssword!123" /SQLSYSADMINACCOUNTS=FLORENTAPPOINTA\SQLAdmins /TCPENABLED=1 /IACCEPTSQLSERVERLICENSETERMS=1 /UPDATEENABLED=True /SECURITYMODE=SQL /SAPWD="P@ssword!123" /SQLTEMPDBDIR="S:\TempDB\" /SQLUSERDBDIR="S:\Data\" /SQLUSERDBLOGDIR="S:\Logs\" /SQLBACKUPDIR="S:\Backup\" /SQLCOLLATION="SQL_Latin1_General_CP1_CI_AS"

Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Configure MS SQL..."
netsh advfirewall firewall add rule name = SQL-TCP dir = in protocol = tcp action = allow localport = 1433 remoteip = localsubnet profile = any
netsh advfirewall firewall add rule name = SQL-UDP dir = in protocol = udp action = allow localport = 1433 remoteip = localsubnet profile = any
Set-Service sqlbrowser -StartupType Automatic
net start SQLBROWSER