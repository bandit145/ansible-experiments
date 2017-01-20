if((Get-Service -DisplayName sensu-client -ErrorAction SilentlyContinue)){
    New-Service -Name "sensu-client" -StartupType Automatic -DisplayName "sensu-client" -BinaryPathName "c:\opt\sensu\bin\sensu-client.exe" -ErrorAction "SilentlyContinue"
}
Stop-Service -DisplayName "Sensu-Client" -ErrorAction "SilentlyContinue"
Start-Service -DisplayName "Sensu-Client"