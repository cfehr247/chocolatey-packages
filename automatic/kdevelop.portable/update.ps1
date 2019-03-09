import-module au

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$releases = 'https://www.kdevelop.org/download'

function global:au_GetLatest {
     $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
	 $regex   = '-portable\.7z$'
	 $url = $download_page.links | ? href -match $regex | select -First 2	 
	 $version = $url -split '-|.exe' | select -Last 1 -Skip 2	 
	 $version_release = $version -replace '[.]',''	 
     return @{ Version = $version ; VersionRelease = $version_release ; URL32 = $url.href[1] ; URL64 = $url.href[0] }
}

function global:au_SearchReplace {
    @{
	    "kdevelop.portable.nuspec" = @{
			"<releaseNotes>https://www.kdevelop.org/news/kdevelop-(.*?)-released</releaseNotes>" = "<releaseNotes>https://www.kdevelop.org/news/kdevelop-$($Latest.VersionRelease)-released</releaseNotes>"
        }
		"tools\chocolateyInstall.ps1" = @{
			"(^(\s)*url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
			"(^(\s)*url64bit\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
            "(^(\s)*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^(\s)*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }		
    }
}

update