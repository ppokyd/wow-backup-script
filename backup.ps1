param (
  $wow_folder = "",
  $backup_folder = "",
  $script_folder = ""
)

$Logfile = "$($script_folder)\backup.log"

Function LogWrite {
  Param ([string]$logstring)
  Add-content $Logfile -value "[$(Get-Date -f 'MM-dd-yy HH:mm:ss')] - $($logstring)"
}

LogWrite "===== BACKUP START ====="

If (!(test-path $wow_folder)) {
  LogWrite "WoW folder not found"
  Exit
}

$wtfFolder = "$($wow_folder)\_retail_\WTF\"
$uiFolder = "$($wow_folder)\_retail_\Interface\"
$ssFolder = "$($wow_folder)\_retail_\Screenshots\"

If (!(test-path $backup_folder)) {
  LogWrite "Backup folder - creating"
  New-Item -ItemType Directory -Force -Path $backup_folder
  LogWrite "Backup folder - created"
}

$OriginalPref = $ProgressPreference
$ProgressPreference = "SilentlyContinue"


If (test-path $wtfFolder) {
  LogWrite "WTF folder - backup start"
  Compress-Archive -Path $wtfFolder -DestinationPath "$($backup_folder)\wtf" -CompressionLevel "NoCompression" -Force
  LogWrite "WTF folder - backup done"
} else {
  LogWrite "WTF folder - not found"
}

If (test-path $uiFolder) {
  LogWrite "UI folder - backup start"
  Compress-Archive -Path $uiFolder -DestinationPath "$($backup_folder)\interface" -CompressionLevel "NoCompression" -Force
  LogWrite "UI folder - backup done"
} else {
  LogWrite "UI folder - not found"
}

If (test-path $ssFolder) {
  LogWrite "UI Screenshots - backup start"
  Compress-Archive -Path $ssFolder -DestinationPath "$($backup_folder)\Screenshots" -CompressionLevel "NoCompression" -Force
  LogWrite "UI Screenshots - backup done"
}

LogWrite "===== BACKUP DONE ====="
LogWrite ""

$ProgressPreference = $OriginalPref
