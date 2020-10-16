param ([String] $HOSTNAME)

Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Install IIS..."
Install-WindowsFeature Web-Server -IncludeManagementTools

Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Configure IIS..."
Uninstall-WindowsFeature Web-Dir-Browsing

Remove-Item C:\inetpub\wwwroot\*.*
Copy-Item 'C:\vagrant\files\website\*' 'C:\inetpub\wwwroot'
Set-ItemProperty "IIS:\Sites\Default Web Site" -name physicalPath -value "C:\Inetpub\wwwroot"


#New-WebSite -Name $HOSTNAME -IPAddress "192.168.1.2" -Port 80 -HostHeader lab.lan -PhysicalPath "C:\Inetpub\wwwroot\site"
#New-WebBinding -Name $HOSTNAME -IPAddress "192.168.1.2" -Port 80 -HostHeader lab.lan
