# Log start time of script (change path to your choice)
"Script started at $(Get-Date)" | Out-File "C:\KillTelemetrylog.txt" -Append
# Check if process CompatTelRunner is active every 3 seconds, kill if active and log process
while ($true) {
    try {
        $procs = Get-Process -Name "CompatTelRunner" -ErrorAction SilentlyContinue
        if ($procs) {
            foreach ($proc in $procs) {
                # Log the detection and stopping of the process
                "CompatTelRunner detected with ID $($proc.Id) at $(Get-Date)" | Out-File "C:\KillTelemetrylog.txt" -Append
                Stop-Process -Id $proc.Id -Force -ErrorAction Stop
                "CompatTelRunner with ID $($proc.Id) stopped successfully at $(Get-Date)" | Out-File "C:\KillTelemetrylog.txt" -Append
            }
        } 
		# else {
            # "No CompatTelRunner process found at $(Get-Date)" | Out-File "C:\KillTelemetrylog.txt" -Append
        # }
    } catch {
        # Log any errors that occur
        "Error stopping CompatTelRunner at $(Get-Date): $_" | Out-File "C:\KillTelemetrylog.txt" -Append
    }
    Start-Sleep -Seconds 3
}
