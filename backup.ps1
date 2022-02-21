param (
  $wowFolder = "",
  $backUpFolder = "",
  $scriptFolder = ""
)

$Logfile = "$($scriptFolder)\backup.log"

Function LogWrite {
  Param ([string]$logstring)
  Add-content $Logfile -value "[$(Get-Date -f 'MM-dd-yy HH:mm:ss')] - $($logstring)"
}

LogWrite "===== BACKUP START ====="

If (!(test-path $wowFolder)) {
  LogWrite "WoW folder not found"
  Exit
}

$wtfFolder = "$($wowFolder)\_retail_\WTF\"
$uiFolder = "$($wowFolder)\_retail_\Interface\"
$ssFolder = "$($wowFolder)\_retail_\Screenshots\"

If (!(test-path $backUpFolder)) {
  LogWrite "Backup folder - creating"
  New-Item -ItemType Directory -Force -Path $backUpFolder
  LogWrite "Backup folder - created"
}

$OriginalPref = $ProgressPreference
$ProgressPreference = "SilentlyContinue"


If (test-path $wtfFolder) {
  LogWrite "WTF folder - backup start"
  Compress-Archive -Path $wtfFolder -DestinationPath "$($backUpFolder)\wtf" -CompressionLevel "NoCompression" -Force
  LogWrite "WTF folder - backup done"
} else {
  LogWrite "WTF folder - not found"
}

If (test-path $uiFolder) {
  LogWrite "UI folder - backup start"
  Compress-Archive -Path $uiFolder -DestinationPath "$($backUpFolder)\interface" -CompressionLevel "NoCompression" -Force
  LogWrite "UI folder - backup done"
} else {
  LogWrite "UI folder - not found"
}

If (test-path $ssFolder) {
  Compress-Archive -Path $ssFolder -DestinationPath "$($backUpFolder)\Screenshots" -CompressionLevel "NoCompression" -Force
}

LogWrite "===== BACKUP DONE ====="
LogWrite ""

$ProgressPreference = $OriginalPref
