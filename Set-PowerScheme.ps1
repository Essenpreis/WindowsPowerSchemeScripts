
function Set-PowerScheme {
    param (
        [string]$SchemeName,
        [string]$SchemeGUID
    )

    # Check if the specified power scheme already exists
    $schemeExists = powercfg /list | Select-String -Pattern $SchemeName

    if ($schemeExists) {
        # Extract the GUID of the existing power scheme
        $string = $schemeExists
        $schemeGUIDToApply = ($string -split "GUID: ")[1] -split " " | Select-Object -First 1

    } else {
        # Duplicate the specified power scheme
        $output = powercfg -duplicatescheme $SchemeGUID

        # Parse the output to get the new GUID
        $string = $output
        $schemeGUIDToApply = ($string -split "GUID: ")[1] -split " " | Select-Object -First 1

    }

    # Set the specified power scheme as active
    powercfg /setactive $schemeGUIDToApply
}

# Example usage
#Set-PowerScheme -SchemeName "Ultimate Performance" -SchemeGUID "e9a42b02-d5df-448d-aa00-03f14749eb61"




#https://www.elevenforum.com/t/restore-missing-power-plans-in-windows-11.6898/
# Generate with Co-Pilot prompt: 
# write a powershell  script that first duplicates the high performance power scheme with command powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61. Then it parses the output of this duplicate command which could be Power Scheme GUID: f74183bd-e9de-4ae3-a07a-383336c82b78  (Ultimate Performance). 
# Then it stores the the GUID for powerscheme called Ultimate Performance in variable high_perf_scheme. Finally it calls command powercfg /setactive $high_perf_scheme, means with variable high_perf_scheme.
# Before calling technical powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 it should check with powercfg /list if there is a power scheme and Ultimate Performance. If it does not exist it will call powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
#if ultimateexists it should store the guid of the scheme in variable high_perf_scheme
#refactor into a powershell function that takes argument 1. power scheme name e.g. Ultimate Performance and 2. the built in windows guid for this scheme. Inside the function the check for the scheme and duplication and activation is performed.