﻿import-module au

function global:au_GetLatest {
    $releases = 'https://jmodelica.org'
    $regex    = 'JModelica.org-(?<Version>[\d\.]+).exe'

    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$url = $download_page.links | ? href -match $regex | select -First 1

    return @{ Version = $matches.Version ; URL32 = $releases + $url.href }
}

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
			"(^(\s)*url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^(\s)*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

update