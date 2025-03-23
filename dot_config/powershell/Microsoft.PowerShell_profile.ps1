# Add ~\bin to PATH
$binPath = "$HOME\bin"
if (-not $env:PATH.Contains($binPath)) {
    $env:PATH = "$binPath;$env:PATH"
}

# Terminal Icons - https://github.com/devblackops/Terminal-Icons
# Ensure Terminal-Icons module is installed before importing
if (-not (Get-Module -ListAvailable -Name Terminal-Icons)) {
    Install-Module -Name Terminal-Icons -Scope CurrentUser -Force -SkipPublisherCheck
}
Import-Module -Name Terminal-Icons

# starship config (Requires starship, installed via winget)
$ENV:STARSHIP_CONFIG = "$env:OneDriveConsumer/Apps/starship/starship.toml"
Invoke-Expression (& 'starship.exe' init powershell --print-full-init | Out-String)

# zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# Aliases
Set-Alias -Name desktop -Value "$env:OneDriveConsumer/Documents/PowerShell/Scripts/Desktop.ps1"
Set-Alias -Name grep -Value findstr
Set-Alias -Name wget -Value Invoke-WebRequest
Remove-Item Alias:z -Force
Remove-Item Alias:zi -Force
Set-Alias -Name z -Value cd
Set-Alias -Name zi -Value cdi

function ls { eza $args -l --header --hyperlink --icons --color never }
function ll { eza $args -al --header --hyperlink --icons --color never }
function touch { New-Item @args -Type File -Force }
function Get-PubIP { (Invoke-WebRequest http://ifconfig.me/ip).Content }
function reload-profile {& $profile}
function which ($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
      Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
  }
function Test-CommandExists {
    param($command)
    $exists = $null -ne (Get-Command $command -ErrorAction SilentlyContinue)
    return $exists
}
function head {
  param($Path, $n = 10)
  Get-Content $Path -Head $n
}

function tail {
  param($Path, $n = 10)
  Get-Content $Path -Tail $n
}

# PSReadLine
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

# Editor Configuration
$EDITOR = if (Test-CommandExists nvim) { 'code' }
          else { 'notepad' }

Set-PSReadLineOption -Colors @{
    Command = 'Yellow'
    Parameter = 'Green'
    String = 'DarkCyan'
}

# m4btool - https://github.com/sandreas/m4b-tool
function m4b-tool { docker run -it --rm -v ${PWD}:/mnt sandreas/m4b-tool:latest $args }

Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module

Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58
