$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName = $env:ChocolateyPackageName
  file        = "$toolsDir\LyX-233-Installer-1.exe"
  silentArgs  = "/S"
}

Install-ChocolateyInstallPackage @packageArgs