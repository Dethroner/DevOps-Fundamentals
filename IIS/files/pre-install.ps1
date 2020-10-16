param ([String] $newPass)

$box = Get-ItemProperty -Path HKLM:SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName -Name "ComputerName"
$box = $box.ComputerName.ToString().ToLower()

Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Setting timezone..."
c:\windows\system32\tzutil.exe /s "Belarus Standard Time"

Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Disable IPv6 on all network adatpers..."
Get-NetAdapterBinding -ComponentID ms_tcpip6 | ForEach-Object {Disable-NetAdapterBinding -Name $_.Name -ComponentID ms_tcpip6}
Get-NetAdapterBinding -ComponentID ms_tcpip6 
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v DisabledComponents /t REG_DWORD /d 255 /f

Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Rename Administrator to admin & Enable..."
Enable-LocalUser Administrator
Set-LocalUser -Name "Administrator" -PasswordNeverExpires $true
Rename-LocalUser -Name "Administrator" -NewName "admin"
net user admin $newPass
Add-LocalGroupMember -Group "Remote Desktop Users" -Member "admin"

