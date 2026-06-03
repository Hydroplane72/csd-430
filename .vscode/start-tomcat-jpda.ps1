if (-not $env:CATALINA_HOME) {
    throw "CATALINA_HOME is not set."
}

$catalinaBat = Join-Path $env:CATALINA_HOME "bin\catalina.bat"
if (-not (Test-Path -LiteralPath $catalinaBat)) {
    throw "Tomcat startup script not found: $catalinaBat"
}

& $catalinaBat jpda start

# Wait until JPDA is listening so VS Code attach on F5 is reliable.
$jpdaHost = "localhost"
$jpdaPort = 8000
$timeoutSeconds = 30
$startTime = Get-Date

while ($true) {
    try {
        $client = New-Object System.Net.Sockets.TcpClient
        $client.Connect($jpdaHost, $jpdaPort)
        if ($client.Connected) {
            $client.Close()
            Write-Output "Tomcat JPDA is ready on $jpdaHost`:$jpdaPort"
            break
        }
    }
    catch {
        # Keep waiting until timeout expires.
    }

    if (((Get-Date) - $startTime).TotalSeconds -ge $timeoutSeconds) {
        throw "Tomcat JPDA did not become ready on $jpdaHost`:$jpdaPort within $timeoutSeconds seconds."
    }

    Start-Sleep -Milliseconds 500
}