#!/windows-apps/bin/powershell.bash
Set-StrictMode -Version 2.0

$env:PSModulePath = $PSScriptRoot + ";" + $env:PSModulePath
$global:PsGetDestinationModulePath = $PSScriptRoot

# Import-Module CustomPrompt
# Import-Module Aliases

# if ($host.Name -eq 'ConsoleHost')
# {
#     Import-Module PSReadline

#     .\Scripts\SaveAndLoadHistory.ps1
# }

# Set the visual studio environment
# Set-VsVars32 2015

Pop-Location
