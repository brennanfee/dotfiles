#!/windows-apps/bin/powershell.bash
Set-StrictMode -Version 2.0

if ($PSVersionTable.PSVersion.Major -lt 4)
{
    Write-Host -ForegroundColor 'Red' "You are running an older version of PowerShell.  You need to install at least PowerShell 4 to continue.  Re-run install-powerShell.ps1 once you upgrade."
    exit 1
}

# Check Profile Directory
$profileDirectory = Split-Path $PROFILE -Parent
$hasProfile = Test-Path $PROFILE
if($hasProfile -eq $false)
{
    if (-not (Test-Path $profileDirectory)){
        New-Item $profileDirectory -type directory | Out-Null
    }

    New-Item $PROFILE -type file | Out-Null
    Write-Host "Creating profile."
}

$root = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

# Set up main PowerShell Profile
$isInstalled = Get-Content $PROFILE | ForEach-Object { if($_.Contains("$root\powershell\profile.ps1") -eq $true){$true;}}

if($isInstalled -ne $true){
    Add-Content $PROFILE "$root\powershell\profile.ps1"
    Add-Content $PROFILE ""
    Add-Content $PROFILE "function prompt {"
    Add-Content $PROFILE "    return Get-CustomPrompt"
    Add-Content $PROFILE "}"

    Write-Host "Your environment has been configured at: $PROFILE"
}
else
{
    Write-Host "Your environment is already configured at: $PROFILE"
}

# Setup NuGet profile used within Visual Studio
$nuGetFile = Join-Path $profileDirectory "NuGet_profile.ps1"
$isNugetInstalled = $false

if (Test-Path $nugetFile){
    $isNugetInstalled = Get-Content $nuGetFile | ForEach-Object { if($_.Contains("$root\powershell\profile.ps1") -eq $true){$true;}}
}

if($isNugetInstalled -ne $true){
    Add-Content $nuGetFile "$root\powershell\profile.ps1"
    Add-Content $nuGetFile ""
    Add-Content $nuGetFile "function prompt {"
    Add-Content $nuGetFile "    return Get-CustomPrompt"
    Add-Content $nuGetFile "}"

    Write-Host "Your NuGet environment has been configured at: $nuGetFile"
}
else
{
    Write-Host "Your NuGet environment is already configured at: $nuGetFile"
}
