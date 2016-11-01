#!powershell
#<license>
# WANT_JSON
# POWERSHELL_COMMON

$ErrorActionPreference = "Stop"
$params = Parse-args $args
$path = Get-AnsibleParam -obj $params -name "path" -failifempty $true
$result = New-Object psobject @{
    changed=$false
}

try{
    Set-DscLocalConfigurationManager -Path $path
    $result.changed=$true
    Exit-Json $result

}

catch{
    Fail-Json $error[0]
}