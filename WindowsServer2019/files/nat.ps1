Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Pre-configure..."
Get-NetAdapter -Name "Ethernet" | Rename-NetAdapter -NewName "External"
Get-NetAdapter -Name "Ethernet 2" | Rename-NetAdapter -NewName "net1"
Get-NetAdapter -Name "Ethernet 3" | Rename-NetAdapter -NewName "net2"

Enable-NetFirewallRule -DisplayName "File and Printer Sharing (Echo Request - ICMPv4-In)"

Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Install RRAS..."
Install-WindowsFeature Routing -IncludeAllSubFeature -IncludeManagementTools -Restart
Install-RemoteAccess -VpnType RoutingOnly -PassThru

Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Configure NAT..."
netsh routing ip nat install
netsh routing ip nat add interface "External" mode=full
netsh routing ip nat add interface "net1"
netsh routing ip nat add interface "net2"