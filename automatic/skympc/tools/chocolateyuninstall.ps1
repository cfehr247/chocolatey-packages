﻿# Remove start menu shortcuts
$programs = [environment]::GetFolderPath([environment+specialfolder]::Programs)
$shortcutFilePath = Join-Path $programs "SkyMPC.lnk"
if (Test-Path $shortcutFilePath) { Remove-Item $shortcutFilePath }