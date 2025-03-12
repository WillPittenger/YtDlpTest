param
(
	[Parameter(Position = 1)] $ProjectName,
	[Parameter(Position = 2)] $TargetDir,
	[Parameter(Position = 3)] $ProjectDir
)

trap
{
	Write-Error $_ -ErrorAction SilentlyContinue;

	exit 1;
}

$ErrorActionPreference = "Stop";

$dest = [IO.Path]::Combine($TargetDir, $ProjectName);

$dirPSD1 = [IO.Path]::Combine($ProjectDir, $ProjectName);

Write-host "Copying DLLs from $TargetDir and the PSD1 from $dirPSD1 to $dest.";

if([IO.Directory]::Exists($dest))
{
	del ([IO.Path]::Combine($dest, '*')) -Force -Verbose;
}
else
{
	New-Item -ItemType Directory $dest -Force -Verbose;
}

dir ([IO.Path]::Combine($TargetDir, '*.dll')), ([IO.Path]::Combine($dirPSD1, '*')) | %{Copy $_ ([io.path]::combine($dest, $_.Name)) -Force -Verbose};

exit 0;