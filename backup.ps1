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

$wtf_folder = "$($wow_folder)\_retail_\WTF\"
$ui_folder = "$($wow_folder)\_retail_\Interface\"
$ss_folder = "$($wow_folder)\_retail_\Screenshots\"
# $new_folder = "$($wow_folder)\_retail_\New Folder\"

If (!(test-path $backup_folder)) {
  LogWrite "Backup folder - creating"
  New-Item -ItemType Directory -Force -Path $backup_folder
  LogWrite "Backup folder - created"
}

$OriginalPref = $ProgressPreference
$ProgressPreference = "SilentlyContinue"

# If (test-path $new_folder) {
#   LogWrite "New folder - backup start"
#   Compress-Archive -Path $new_folder -DestinationPath "$($backup_folder)\new_folder" -CompressionLevel "NoCompression" -Force
#   LogWrite "New folder - backup done"
# } else {
#   LogWrite "New folder - not found"
# }

If (test-path $wtf_folder) {
  LogWrite "WTF folder - backup start"
  Compress-Archive -Path $wtf_folder -DestinationPath "$($backup_folder)\wtf" -CompressionLevel "NoCompression" -Force
  LogWrite "WTF folder - backup done"
} else {
  LogWrite "WTF folder - not found"
}

If (test-path $ui_folder) {
  LogWrite "UI folder - backup start"
  Compress-Archive -Path $ui_folder -DestinationPath "$($backup_folder)\interface" -CompressionLevel "NoCompression" -Force
  LogWrite "UI folder - backup done"
} else {
  LogWrite "UI folder - not found"
}

If (test-path $ss_folder) {
  LogWrite "UI Screenshots - backup start"
  Compress-Archive -Path $ss_folder -DestinationPath "$($backup_folder)\Screenshots" -CompressionLevel "NoCompression" -Force
  LogWrite "UI Screenshots - backup done"
}

LogWrite "===== BACKUP DONE ====="
LogWrite ""

$ProgressPreference = $OriginalPref
