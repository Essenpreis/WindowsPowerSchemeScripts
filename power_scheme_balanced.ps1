# Activates the Windows Balanced Power Scheme

. .\Set-PowerScheme.ps1
Set-PowerScheme -SchemeName "Balanced" -SchemeGUID "381b4222-f694-41f0-9685-ff5bb260df2e"
powercfg /list

$tasks = "Taskmgr", "ms-settings", "powercfg"
foreach ($task in $tasks) {
    Get-Process -Name $task -ErrorAction SilentlyContinue | Stop-Process -Force
    # Write-Output "Attempting Stop " $task
}

# # Restart the tasks
# Start-Process "taskmgr.exe"
# Start-Process "ms-settings:batterysaver"
# Start-Process "powercfg.cpl" 

# Open some programs to check
# Taskmgr.exe # Goto tab Performance. Speed should be at 80% to 90% of max processor speed at all time
# start ms-settings:batterysaver # Should show: Power mode can't be set while high performance power plan is used
# powercfg.cpl # Should show power plan Ultimate Performance as selected


# would set minimum processor state in current scheme - not needed as ulti perf scheme has this
# powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMIN 100
# powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMAX 100
# powercfg /setdcvalueindex SCHEME_CURRENT SUB_ENERGYSAVER ESBATTTHRESHOLD 100
# powercfg /setactive SCHEME_CURRENT
