import-module au

function global:au_BeforeUpdate { Get-RemoteFiles -NoSuffix -Purge }

function global:au_GetLatest {
  $releases = 'http://www.log4om.com/dl/'
  $regex    = 'Log4OM_(?<Version>[\d_]+).zip'

  (Invoke-WebRequest -Uri $releases).RawContent -match $regex | select -First 1
  $version = $matches.Version -Replace "_", "."
    
	return @{
    Version = $version
    VersionUrl = $matches.Version
    URL32 = 'http://www.log4om.com/log4om/release/Log4OM_' + $matches.Version + '.zip'
  }
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
          "(?i)(^\s*fileFullPath\s*=\s*`"[$]toolsDir\\)(.*)`""   = "`$1$($Latest.FileName32)`""
          "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\)(.*)`""   = "`$1Log4OM_$($Latest.VersionURL).exe`""
        }
    }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
    update -ChecksumFor none
}