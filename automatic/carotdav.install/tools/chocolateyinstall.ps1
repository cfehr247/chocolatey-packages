﻿$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName = $env:ChocolateyPackageName
  destination = "$toolsDir"
  file        = "$toolsDir\CarotDAV1.15.6.zip"
}
Get-ChocolateyUnzip @packageArgs
Remove-Item -Path $packageArgs.file

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName
  fileType     = "MSI"
  fileFullPath = "$toolsDir\CarotDAV1.15.6\CarotDAV1.15.6.msi"
  silentArgs   = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
}
Install-ChocolateyInstallPackage @packageArgs
