﻿import-module au
 
function global:au_BeforeUpdate { Get-RemoteFiles -NoSuffix -Purge }

function global:au_GetLatest {
  $releases_32 = 'https://download.kde.org/stable/umbrello/latest/win32'
  $regex_32    = 'umbrello-i686-w64-mingw32-(?<Version>[\d\.]+).*-setup.exe$'
  $releases_64 = 'https://download.kde.org/stable/umbrello/latest/win64'
  $regex_64    = 'umbrello-x86_64-w64-mingw32-[\d\.]+.*-setup.exe$'

  $download_page_32 = (Invoke-WebRequest -Uri $releases_32 -UseBasicParsing)
  $file_32 = $download_page_32.links | ? href -match $regex_32
  $version = $matches.Version

  $download_page_64 = (Invoke-WebRequest -Uri $releases_64 -UseBasicParsing)
  $file_64 = $download_page_64.links | ? href -match $regex_64

  return @{
    Version = $version
    URL32 = "$releases_32/$file_32.href"
    URL64 = "$releases_64/$file_64.href"
}

function global:au_SearchReplace {
    @{
       "legal\VERIFICATION.txt"  = @{            
            "(?i)(x32: ).*"               = "`${1}$($Latest.URL32)"
            "(?i)(x64: ).*"               = "`${1}$($Latest.URL32)"            
            "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType32)"
            "(?i)(checksum32:).*"       = "`${1} $($Latest.Checksum32)"
            "(?i)(checksum64:).*"       = "`${1} $($Latest.Checksum32)"
        }

        "tools\chocolateyinstall.ps1" = @{        
          "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\)(.*)`""   = "`$1$($Latest.FileName32)`""
        }
    }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
    update -ChecksumFor none
}