﻿$ErrorActionPreference = 'Stop'
import-module au

function global:au_BeforeUpdate { Get-RemoteFiles -NoSuffix -Purge }

function global:au_GetLatest {
    $releases = 'https://waterlan.home.xs4all.nl/dos2unix.html'
    $regex32  = 'dos2unix-([\d\.]+)-win32-nls.zip$'
    $regex64  = 'dos2unix-(?<Version>[\d\.]+)-win64-nls.zip$'

    $urls  = (Invoke-WebRequest -Uri $releases -UseBasicParsing).links
    $url32 = $urls | ? href -match $regex32
    $url64 = $urls | ? href -match $regex64

    return @{
        Version = $matches.Version
        URL32   = 'https://waterlan.home.xs4all.nl/' + $url32.href
        URL64   = 'https://waterlan.home.xs4all.nl/' + $url64.href
    }
}

function global:au_SearchReplace {
    @{
        "legal\VERIFICATION.txt"  = @{            
            "(?i)(x32: ).*"             = "`${1}$($Latest.URL32)"
            "(?i)(x64: ).*"             = "`${1}$($Latest.URL64)"
            "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType32)"
            "(?i)(checksum32:).*"       = "`${1} $($Latest.Checksum32)"
            "(?i)(checksum64:).*"       = "`${1} $($Latest.Checksum64)"
        }

        "tools\chocolateyinstall.ps1" = @{
          "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\)(.*)`""   = "`$1$($Latest.FileName32)`""
          "(?i)(^\s*file64\s*=\s*`"[$]toolsDir\\)(.*)`""   = "`$1$($Latest.FileName64)`""
        }
    }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
    update -ChecksumFor none
}