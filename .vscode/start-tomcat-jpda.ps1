if (-not $env:CATALINA_HOME) {
    throw "CATALINA_HOME is not set."
}

$catalinaBat = Join-Path $env:CATALINA_HOME "bin\catalina.bat"
if (-not (Test-Path -LiteralPath $catalinaBat)) {
    throw "Tomcat startup script not found: $catalinaBat"
}

& $catalinaBat jpda start