<#
.SYNOPSIS
Cross-platform bootstrap for Windows using winget/choco or binary fallback
Features:
1. Checks for Windows 10+ with PowerShell 5.1+
2. Installs chezmoi via winget or Chocolatey
3. Fallback: downloads binary from GitHub if no package manager
4. Prompts user before running 'chezmoi init'
5. Prompts for GitHub username for dotfiles
#>

# Ensure running on Windows 10+ and PowerShell 5.1+
if ($PSVersionTable.PSVersion.Major -lt 5 -or $PSVersionTable.PSVersion.Minor -lt 1) {
    Write-Error "PowerShell 5.1 or later is required."
    exit 1
}

Write-Host "Starting chezmoi bootstrap..."

# Function: Install chezmoi using package manager
function Install-Chezmoi {
    if (Get-Command chezmoi -ErrorAction SilentlyContinue) {
        Write-Host "chezmoi already installed."
        return
    }

    if (Get-Command winget -ErrorAction SilentlyContinue) {
        Write-Host "Installing chezmoi via winget..."
        winget install --id twpayne.chezmoi -e --accept-source-agreements --accept-package-agreements
    }
    elseif (Get-Command choco -ErrorAction SilentlyContinue) {
        Write-Host "Installing chezmoi via Chocolatey..."
        choco install chezmoi -y
    }
    else {
        Write-Host "No package manager found. Offering binary fallback."
        Write-Host "Do you want to install chezmoi from the official GitHub release? [y/N]"
        $choice = Read-Host
        if ($choice -match '^[Yy]$') {
            $url = "https://get.chezmoi.io"
            Invoke-Expression "& { iwr -useb $url | iex }"
        }
        else {
            Write-Host "Skipping chezmoi installation."
            exit 1
        }
    }
}

# Function: Prompt for GitHub username
function Prompt-GitHubUser {
    Write-Host "Enter your GitHub username for chezmoi dotfiles (e.g., yourusername):"
    $user = Read-Host
    return $user
}

# Function: Initialize chezmoi
function Init-Chezmoi {
    param([string]$GitHubUser)

    Write-Host "Do you want to run 'chezmoi init --apply $GitHubUser'? [y/N]"
    $applyChoice = Read-Host
    if ($applyChoice -match '^[Yy]$') {
        chezmoi init --apply $GitHubUser
    }
    else {
        Write-Host "Skipped chezmoi initialization."
    }
}

# ---------------------- Main Script Flow ----------------------------

Install-Chezmoi
$githubUser = Prompt-GitHubUser
Init-Chezmoi -GitHubUser $githubUser

Write-Host "Bootstrap complete."
