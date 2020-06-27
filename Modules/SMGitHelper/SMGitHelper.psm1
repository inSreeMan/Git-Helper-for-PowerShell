Write-Verbose "Importing Functions"
# Show identitiy signal for interactive modules
# Write-Host "loading.." -foreground green

# Set Module HashTable
# New-Variable -Name SMD -Value @{} -Scope Global -Force

# publish wrapped child module here
# Get-Command -Module HelperModuleName | Export-ModuleMember


Write-Verbose "Importing Functions"
# Import everything from defined folders
foreach ($folder in @('helpers','public')) {
    $root = Join-Path -Path $PSScriptRoot -ChildPath $folder
    if (Test-Path -Path $root) {      
        # SMPS-Importer-v3
        #
        # dot source scripts (except Tests)
        Write-Verbose "processing scripts in $root"
        $files = Get-ChildItem -Path $root -Filter *.ps1
        $files | where-Object { $_.name -NotLike '*.Tests.ps1' } | 
        ForEach-Object { Write-Verbose $_.name; . $_.FullName }
        #
        # import psm modules (except Ignored)
        Write-Verbose "processing modules from $root"
        $files = Get-ChildItem -Path $root -Filter *.psm1
        $files | where-Object { $_.name -NotLike '*.Ignore.psm1' } | 
        ForEach-Object { Write-Verbose $_.name; Import-Module $_.FullName }
    }
}
