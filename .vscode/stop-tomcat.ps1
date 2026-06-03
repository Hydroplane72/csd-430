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