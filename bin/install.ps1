$NvimConfig = "$HOME\AppData\Local\nvim"
$ScriptDir = Split-Path -Parent $PSScriptRoot

Write-Host "Installing Neovim configuration..." -ForegroundColor Cyan

if ($ScriptDir -eq $NvimConfig) {
    Write-Host "Already installed at $NvimConfig"
    exit
}

if (Test-Path $NvimConfig) {
    $title = "Existing Config Found"
    $message = "Do you want to backup and replace it?"
    $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Backup and replace."
    $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", "Cancel installation."
    $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
    $result = $host.ui.PromptForChoice($title, $message, $options, 0)

    if ($result -eq 0) {
        $BackupDir = "$NvimConfig.backup.$(Get-Date -Format 'yyyyMMdd_HHmmss')"
        Write-Host "Backing up to $BackupDir"
        Rename-Item -Path $NvimConfig -NewName $BackupDir
    } else {
        Write-Host "Installation canceled."
        exit
    }
}

New-Item -ItemType Directory -Force -Path (Split-Path $NvimConfig)
Move-Item -Path $ScriptDir -Destination $NvimConfig
Write-Host "✅ Installation complete!" -ForegroundColor Green
