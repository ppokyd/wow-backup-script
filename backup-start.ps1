
Get-Content -Path "$($pwd)\config.txt" | Foreach-Object {
  $var = $_.Split('=')
  New-Variable -Name $var[0] -Value $var[1]
}

$taskAction = New-ScheduledTaskAction `
    -Execute "powershell.exe" `
    -Argument "-windowstyle hidden -File $($pwd)\backup.ps1 -wowFolder $($wowFolder) -backUpFolder $($backUpFolder) -scriptFolder $($pwd)"

$taskTrigger = New-ScheduledTaskTrigger -Daily -At $backupAt

$taskName = "WoWBackup"
$description = "Backup WoW interface"

Register-ScheduledTask `
    -TaskName $taskName `
    -Action $taskAction `
    -Trigger $taskTrigger `
    -Description $description

Get-ScheduledTaskInfo -TaskName "WoWBackup"
