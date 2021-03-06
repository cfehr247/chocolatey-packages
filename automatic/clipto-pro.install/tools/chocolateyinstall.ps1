﻿$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName

  url           = 'https://github.com/clipto-pro/Desktop/releases/download/v1.8.6/clipto.pro-1.8.6.exe'
  checksum      = '969591FBABC3226EF399C60ED555F09AEAE9DAEC943DEB3CACF3CD444B224920'
  checksumType  = 'sha256'

  silentArgs    = '/S'
}

Install-ChocolateyPackage @packageArgs
