﻿import-module au
$github_repository = "reds-heig/logisim-evolution"
$releases = "https://github.com/" + $github_repository + "/releases/latest"

function global:au_GetLatest {	
     $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
	 $regex   = $github_repository + '/releases/download/v(?<Version>[\d\.]+)/logisim-evolution.jar'
	 $url = $download_page.links | ? href -match $regex
     return @{
        Version = $matches.Version
        URL32 = "https://github.com" + $url.href        
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