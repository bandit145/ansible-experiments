if((choco) -like '*Chocolatey*' -eq $false){
    iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
}