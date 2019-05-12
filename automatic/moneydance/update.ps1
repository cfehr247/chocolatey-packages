﻿import-module au
$github_repository = "tomokuni/Myrica"
$releases = "https://github.com/" + $github_repository + "/releases/latest"
$regex   = "/archive/(?<Version>[\d\.]+).zip$"

function global:au_GetLatest {	
    $releases = 'https://infinitekind.com/download-moneydance-personal-finance-software'
    $regex = 'Moneydance\ [\d\.]+\ \((?<Version>\d+)\)'    
	$url = (Invoke-WebRequest -Uri $releases) -match $regex
	return @{
		Version = "0.0." + $matches.Version        
	}
}

function global:au_SearchReplace {
    @{
        "tools\chocolateyinstall.ps1" = @{
			"(^(\s)*url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^(\s)*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }        
    }
}

update