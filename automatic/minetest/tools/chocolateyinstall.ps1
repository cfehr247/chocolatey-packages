﻿$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  destination   = "$toolsDir"
  file          = "$toolsDir\minetest-5.1.0-win32.zip"
  file64        = "$toolsDir\minetest-5.1.0-win64.zip"
}

Get-ChocolateyUnzip @packageArgs
Remove-Item -Path $packageArgs.file,$packageArgs.file64

# Install start menu shortcut
$programs = [environment]::GetFolderPath([environment+specialfolder]::Programs)
$shortcutFilePath = Join-Path $programs "Minetest.lnk"
$targetPath = Join-Path $toolsDir "minetest-5.1.0-win$(Get-OSArchitectureWidth)\bin\minetest.exe"
Install-ChocolateyShortcut -RunAsAdmin -ShortcutFilePath $shortcutFilePath -TargetPath $targetPath
