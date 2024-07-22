# Activates the Windows Ultimate Performance Power Scheme

. .\Set-PowerScheme.ps1
Set-PowerScheme -SchemeName "Ultimate Performance" -SchemeGUID "e9a42b02-d5df-448d-aa00-03f14749eb61"
powercfg /list



# Open some programs to check
$tasks = "Taskmgr", "ms-settings", "powercfg"
foreach ($task in $tasks) {
    Get-Process -Name $task -ErrorAction SilentlyContinue | Stop-Process -Force
}
# Restart the tasks
Start-Process "taskmgr.exe"
Start-Process "ms-settings:batterysaver"
Start-Process "powercfg.cpl"


# Taskmgr.exe # Goto tab Performance. Speed should be at 80% to 90% of max processor speed at all time
# start ms-settings:batterysaver # Should show: Power mode can't be set while high performance power plan is used
# powercfg.cpl # Should show power plan Ultimate Performance as selected


# would set minimum processor state in current scheme - not needed as ulti perf scheme has this
# powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMIN 100
# powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMAX 100
# powercfg /setdcvalueindex SCHEME_CURRENT SUB_ENERGYSAVER ESBATTTHRESHOLD 100
# powercfg /setactive SCHEME_CURRENT
