if (-not $env:CATALINA_HOME) {
    throw "CATALINA_HOME is not set."
}

$workspaceRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot ".."))
$root = Join-Path $env:CATALINA_HOME "webapps\ROOT"
New-Item -ItemType Directory -Path $root -Force | Out-Null

$moduleFolders = Get-ChildItem -Path $workspaceRoot -Directory |
    Where-Object { $_.Name -like "Module *" } |
    Sort-Object Name

if (-not $moduleFolders) {
    throw "No module folders found (expected folder names like 'Module 1', 'Module 2', etc.)."
}

$deployExtensions = @(
    ".jsp", ".css", ".js", ".html", ".htm",
    ".png", ".jpg", ".jpeg", ".gif", ".webp", ".svg"
)

$filesToDeploy = foreach ($module in $moduleFolders) {
    Get-ChildItem -Path $module.FullName -File -Recurse |
        Where-Object { $deployExtensions -contains $_.Extension.ToLowerInvariant() }
}

if (-not $filesToDeploy) {
    throw "No deployable files were found in module folders."
}

$duplicateNames = $filesToDeploy |
    Group-Object Name |
    Where-Object { $_.Count -gt 1 }

if ($duplicateNames) {
    $duplicateList = ($duplicateNames | ForEach-Object { $_.Name }) -join ", "
    throw "Duplicate file names detected across modules: $duplicateList. Rename duplicates to avoid overwrite in Tomcat ROOT."
}

$deployedCount = 0
foreach ($file in $filesToDeploy) {
    $destination = Join-Path $root $file.Name
    Copy-Item -LiteralPath $file.FullName -Destination $destination -Force
    Write-Output "Deploy succeeded: $($file.FullName) -> $destination"
    $deployedCount++
}

Write-Output "Deployment complete. Files deployed: $deployedCount"