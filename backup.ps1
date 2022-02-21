param (
  $wowFolder = "",
  $backUpFolder = ""
)

If (!(test-path $wowFolder)) {
  Write-Output "WoW folder not found"
  Exit
}

$wtfFolder = "$($wowFolder)\_retail_\WTF\"
$uiFolder = "$($wowFolder)\_retail_\Interface\"
$ssFolder = "$($wowFolder)\_retail_\Screenshots\"

If (!(test-path $backUpFolder)) {
  New-Item -ItemType Directory -Force -Path $backUpFolder
}

$OriginalPref = $ProgressPreference
$ProgressPreference = "SilentlyContinue"


If (test-path $wtfFolder) {
  Compress-Archive -Path $wtfFolder -DestinationPath "$($backUpFolder)\wtf" -CompressionLevel "NoCompression" -Force
}

If (test-path $uiFolder) {
  Compress-Archive -Path $uiFolder -DestinationPath "$($backUpFolder)\interface" -CompressionLevel "NoCompression" -Force
}

If (test-path $ssFolder) {
  Compress-Archive -Path $ssFolder -DestinationPath "$($backUpFolder)\Screenshots" -CompressionLevel "NoCompression" -Force
}

$ProgressPreference = $OriginalPref
