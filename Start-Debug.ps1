<#
This script will run on debug.
It will load in a PowerShell command shell and import the module developed in the project. To end debug, exit this shell.
#>

param
(
	[Parameter(Mandatory, Position=0)]
	[string]
	$ProjectName
)

# Write a reminder on how to end debugging.
$message = "| Exit this shell to end the debug session! |";
$line = "-" * $message.Length;
$color = "Cyan";
Write-Host -ForegroundColor $color $line;
Write-Host -ForegroundColor $color $message;
Write-Host -ForegroundColor $color $line;

# Load the module.
$env:PSModulePath = ".;.\$ProjectName;$((Resolve-Path .).Path);$(dir $ProjectName -ad | select -first 1 -ExpandProperty FullName);$($env:PSModulePath)";
Import-Module $ProjectName -Verbose -Force;

# Happy debugging :-)