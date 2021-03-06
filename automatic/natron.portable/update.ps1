﻿import-module au

function global:au_GetLatest {
  $github_repository = 'NatronGitHub/Natron'
  $releases = 'https://github.com/' + $github_repository + '/releases'
  $regex32  = 'Natron-(?<Version>[\d\.]+)-Windows-x86_32bit-no-installer.zip$'
  $regex64  = 'Natron-(?<Version>[\d\.]+)-Windows-x86_64bit-no-installer.zip$'

  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $url32         = $download_page.links | ? href -match $regex32 | select -First 1
  $version       = $matches.Version
	$url64         = $download_page.links | ? href -match $regex64 | select -First 1

    return @{
        Version = $version
        URL32   = 'https://github.com' + $url32.href
        URL64   = 'https://github.com' + $url64.href
    }
}

function global:au_SearchReplace {
    @{
        "tools\chocolateyinstall.ps1" = @{
          "(^(\s)*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
          "(^(\s)*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
          "(^(\s)*url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
          "(^(\s)*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
          "Natron-[\d\.]+-Windows-x86_[$]{OSArchitectureWidth}bit-no-installer\\bin\\natron.exe" = "Natron-$($Latest.Version)-Windows-x86_`${OSArchitectureWidth}bit-no-installer\bin\natron.exe"
        }
    }
}

update