if (-not $env:CATALINA_HOME) {
    throw "CATALINA_HOME is not set."
}

$workspaceRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot ".."))
$root = Join-Path $env:CATALINA_HOME "webapps\ROOT"
New-Item -ItemType Directory -Path $root -Force | Out-Null

$moduleFolders = Get-ChildItem -Path $workspaceRoot -Directory |
    Where-Object { $_.Name -like "Module *" }

$moduleInfos = $moduleFolders | ForEach-Object {
    $moduleNumbers = [regex]::Matches($_.Name, "\d+") | ForEach-Object { [int]$_.Value }
    $moduleRank = if ($moduleNumbers.Count -gt 0) {
        ($moduleNumbers | Measure-Object -Maximum).Maximum
    } else {
        -1
    }

    [PSCustomObject]@{
        Directory = $_
        Rank = $moduleRank
    }
}

if (-not $moduleInfos) {
    throw "No module folders found (expected folder names like 'Module 1', 'Module 2', etc.)."
}

$deployExtensions = @(
    ".jsp", ".css", ".js", ".html", ".htm",
    ".png", ".jpg", ".jpeg", ".gif", ".webp", ".svg",
    ".sql"
)

$webInfClasses = Join-Path $root "WEB-INF\classes"
New-Item -ItemType Directory -Path $webInfClasses -Force | Out-Null

$deployCandidates = foreach ($module in $moduleInfos) {
    Get-ChildItem -Path $module.Directory.FullName -File -Recurse |
        Where-Object { $deployExtensions -contains $_.Extension.ToLowerInvariant() } |
        ForEach-Object {
            [PSCustomObject]@{
                File = $_
                Name = $_.Name
                ModuleName = $module.Directory.Name
                ModuleRank = $module.Rank
            }
        }
}

if (-not $deployCandidates) {
    throw "No deployable files were found in module folders."
}

$selectedDeployFiles = $deployCandidates |
    Group-Object Name |
    ForEach-Object {
        $_.Group |
            Sort-Object ModuleRank, ModuleName |
            Select-Object -Last 1
    }

$resolvedDuplicates = $deployCandidates |
    Group-Object Name |
    Where-Object { $_.Count -gt 1 }

if ($resolvedDuplicates) {
    foreach ($duplicate in $resolvedDuplicates) {
        $winner = $selectedDeployFiles | Where-Object { $_.Name -eq $duplicate.Name } | Select-Object -First 1
        Write-Output "Duplicate resolved: $($duplicate.Name) -> using $($winner.ModuleName) (rank $($winner.ModuleRank))"
    }
}

$deployedCount = 0
foreach ($selected in $selectedDeployFiles) {
    $destination = Join-Path $root $selected.Name
    Copy-Item -LiteralPath $selected.File.FullName -Destination $destination -Force
    Write-Output "Deploy succeeded: $($selected.File.FullName) -> $destination"
    $deployedCount++
}

$javaSourceCandidates = foreach ($module in $moduleInfos) {
    Get-ChildItem -Path $module.Directory.FullName -File -Recurse |
        Where-Object { $_.Extension.ToLowerInvariant() -eq ".java" } |
        ForEach-Object {
            [PSCustomObject]@{
                File = $_
                Name = $_.Name
                ModuleName = $module.Directory.Name
                ModuleRank = $module.Rank
            }
        }
}

$javaSourceFiles = $javaSourceCandidates |
    Group-Object Name |
    ForEach-Object {
        $_.Group |
            Sort-Object ModuleRank, ModuleName |
            Select-Object -Last 1
    }

if ($javaSourceFiles) {
    $javaCompiler = Get-Command javac -ErrorAction SilentlyContinue
    if (-not $javaCompiler) {
        throw "javac was not found on PATH, so Java source files could not be compiled."
    }

    $javaArguments = @(
        "-d", $webInfClasses,
        "-classpath", $webInfClasses,
        "-encoding", "UTF-8"
    ) + @($javaSourceFiles | ForEach-Object { $_.File.FullName })

    & $javaCompiler.Source @javaArguments
    if ($LASTEXITCODE -ne 0) {
        throw "Java source compilation failed."
    }

    foreach ($sourceFile in $javaSourceFiles) {
        Write-Output "Compiled Java source: $($sourceFile.File.FullName) -> $webInfClasses"
    }
}

Write-Output "Deployment complete. Files deployed: $deployedCount"