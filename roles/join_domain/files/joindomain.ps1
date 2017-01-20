param(
    [parameter(Mandatory=$true)]
    [string]$user,
    [parameter(Mandatory=$true)]
    [string]$userpass,
    [parameter(Mandatory=$true)]
    [string]$hostname,
    [string]$ou = "ou=Staging,"
    )
$ErrorActionPreference = "Silently Continue"
$password = ConvertTo-SecureString $userpass -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential($user,$password)
if ((gwmi win32_computersystem).partofdomain -eq $false){
    $ou = -join($ou,"dc=meme,dc=com")
    Add-Computer -DomainName "meme.com" -Credential $creds -OUPath $ou -NewName $hostname -Force
    Restart-Computer
}