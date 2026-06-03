if (-not $env:CATALINA_HOME) {
    throw "CATALINA_HOME is not set."
}

$src = Join-Path $PSScriptRoot "..\Module 1\simple.jsp"
$src = [System.IO.Path]::GetFullPath($src)

if (-not (Test-Path -LiteralPath $src)) {
    throw "JSP source file not found: $src"
}

$root = Join-Path $env:CATALINA_HOME "webapps\ROOT"
New-Item -ItemType Directory -Path $root -Force | Out-Null

Copy-Item -LiteralPath $src -Destination (Join-Path $root "simple.jsp") -Force
Write-Output "Deploy succeeded: $src -> $root\\simple.jsp"