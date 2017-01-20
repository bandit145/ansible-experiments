param(
[parameter(Mandatory=$true)]
[string]$ShareName,
[parameter(Mandatory=$true)]
[string]$Path
)

Remove-SmbShare -Name $ShareName -Force -ErrorAction "SilentlyContinue"
New-SmbShare -Name $ShareName -Path $Path -FullAccess "Everyone"