﻿$ErrorActionPreference = 'Stop'
import-module au

function global:au_GetLatest {
    $github_repository = "mifi/lossless-cut"
    $releases = "https://github.com/" + $github_repository + "/releases/latest"
    # $regex    = $github_repository + '/tree/v(?<Version>[\d\.]+)$'
    $regex    = 'LosslessCut-(?<Version>[\d\.]+).exe$'    

    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $url           = $download_page.links | ? href -match $regex

    return @{
        Version = $matches.Version
        URL32   = 'https://github.com/' + $url.href
    }
}

function global:au_SearchReplace {
    @{
        "tools\chocolateyinstall.ps1" = @{
            "(^(\s)*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(^(\s)*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(^(\s)*url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^(\s)*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

update
