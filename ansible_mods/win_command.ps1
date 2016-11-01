#!powershell
#<gpl header>
#WANT_JSON
#POWERSHELL_COMMON

#Grabs command to be executed and executes using Invoke-Expression "<command>"
$ErrroActionPreferece = "Stop"
$params = Parse-Args $args
$result = New-Object psobject @{
    changed = $false
}
$command = Get-AnsibleParam -obj $params -name "command" -failifempty $true
try{
    Invoke-Expression $command
    $result.changed = $true
    Exit-Json $result
}
catch{
    Fail-Json $error[0]
}