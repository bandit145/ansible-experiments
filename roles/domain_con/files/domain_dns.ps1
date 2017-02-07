param(
        [parameter(Mandatory=$true)]
        [string[]]$dnsservers
        )
$ErrorActionPreference = "Stop"
$alias = "Ethernet0"
$dnssuffix = "meme.com"
Set-DnsClient -InterfaceAlias $alias -ConnectionSpecificSuffix $dnssuffix
Set-DnsClientServerAddress -InterfaceAlias $alias -ServerAddresses $dnsservers