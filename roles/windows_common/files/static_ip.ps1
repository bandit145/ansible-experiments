param(
    [param(Mandatory=$true)]
    [string]$ipaddress,
    [param(Mandatory=$true)]
    [string]$defaultgateway
    )
$ErrorActionPreference = "Stop"
$addressfamily = "IPv4"
$alias = "Ethernet0"
$dnssuffix = "meme.com"
$dnsservers = Get-DnsClientServerAddress -InterfaceAlias $alias -AddressFamily $addressfamily
$dnsservers = $dnsservers.ServerAddresses
Remove-NetIpAddress -InterfaceAlias $alias -Confirm:$false
New-NetIpAddress -InterfaceAlias $alias -AddressFamily $addressfamily -PrefixLength 24 -IPAddress $ipaddress -DefaultGateway $defaultgateway
Set-DnsClient -InterfaceAlias $alias -ConnectionSpecificSuffix $dnssuffix
Set-DnsClientServerAddress -InterfaceAlias $alias -ServerAddresses $dnsservers
