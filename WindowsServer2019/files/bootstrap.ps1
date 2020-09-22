Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Install DHCP..."
Add-WindowsFeature -Name DHCP –IncludeManagementTools
Import-Module DHCPServer
Set-ItemProperty –Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManager\Roles\12 –Name ConfigurationState –Value 2

Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Configure DHCP..."
Add-DhcpServerv4Scope -name "net1" -StartRange 192.168.1.1 -EndRange 192.168.1.254 -SubnetMask 255.255.255.0 -LeaseDuration 7:00:00 -State InActive
Add-DhcpServerv4ExclusionRange -ScopeID 192.168.1.0 -StartRange 192.168.1.1 -EndRange 192.168.1.100
Set-DhcpServerv4OptionValue -ScopeID 192.168.1.0 -DnsServer 8.8.8.8 -Router 192.168.1.2
Set-DhcpServerv4Scope -ScopeID 192.168.1.0 -State Active
Add-DhcpServerv4Scope -name "net2" -StartRange 192.168.2.1 -EndRange 192.168.2.254 -SubnetMask 255.255.255.0 -LeaseDuration 7:00:00 -State InActive
Add-DhcpServerv4ExclusionRange -ScopeID 192.168.2.0 -StartRange 192.168.2.1 -EndRange 192.168.2.100
Set-DhcpServerv4OptionValue -ScopeID 192.168.2.0 -DnsServer 8.8.8.8 -Router 192.168.2.2
Set-DhcpServerv4Scope -ScopeID 192.168.2.0 -State Active

Restart-service dhcpserver