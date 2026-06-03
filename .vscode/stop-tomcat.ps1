if (-not $env:CATALINA_HOME) {
    Write-Output "CATALINA_HOME is not set. Nothing to stop."
    exit 0
}

$shutdownBat = Join-Path $env:CATALINA_HOME "bin\shutdown.bat"
if (-not (Test-Path -LiteralPath $shutdownBat)) {
    Write-Output "Tomcat shutdown script not found: $shutdownBat"
    exit 0
}

& $shutdownBat

# Tomcat 11 may be configured without a shutdown port; if so, stop the matching Java bootstrap process.
Start-Sleep -Seconds 2

$tomcatHomePattern = [regex]::Escape($env:CATALINA_HOME)
$runningTomcat = Get-CimInstance Win32_Process |
    Where-Object {
        $_.Name -eq "java.exe" -and
        $_.CommandLine -match "org\.apache\.catalina\.startup\.Bootstrap" -and
        $_.CommandLine -match $tomcatHomePattern
    }

if ($runningTomcat) {
    foreach ($proc in $runningTomcat) {
        try {
            Stop-Process -Id $proc.ProcessId -Force -ErrorAction Stop
            Write-Output "Forced stop for Tomcat process ID: $($proc.ProcessId)"
        }
        catch {
            Write-Output "Unable to stop Tomcat process ID $($proc.ProcessId): $($_.Exception.Message)"
        }
    }
}
else {
    Write-Output "Tomcat stopped cleanly."
}