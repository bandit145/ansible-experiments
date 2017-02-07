 param(
        [parameter(Mandatory=$true)]
        [string]$DomainAdmin,
        [parameter(Mandatory=$true)]
        [string]$Password,
        [parameter(Mandatory=$true)]
        [string]$Domain,
        )
    $ErrorActionPreference = "Stop"
    #check with wmi wether or not server is domain controller already
    if((Get-WmiObject win32_computersystem -Property DomainRole).DomainRole -ne 5 -and -ne 4 ){
        Install-ADDSDomainController -DomainName $Domain -Credential $Credential -InstallDns
    }
    