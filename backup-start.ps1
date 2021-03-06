
Get-Content -Path "$($pwd)\config.txt" | Foreach-Object {
  $var = $_.Split('=')
  New-Variable -Name $var[0] -Value $var[1]
}

$taskAction = New-ScheduledTaskAction `
    -Execute "powershell.exe" `
    -Argument "-windowstyle hidden -ExecutionPolicy Bypass -File $($pwd)\backup.ps1 -wow_folder $($wow_folder) -backup_folder $($backup_folder) -script_folder $($pwd)"

$taskTrigger = New-ScheduledTaskTrigger -Daily -At $backup_at
$taskSettings = New-ScheduledTaskSettingsSet -StartWhenAvailable

$taskName = "WoWBackup"
$description = "Backup WoW interface"

Register-ScheduledTask `
    -TaskName $taskName `
    -Action $taskAction `
    -Trigger $taskTrigger `
    -Settings $taskSettings `
    -Description $description

Get-ScheduledTaskInfo -TaskName "WoWBackup"
