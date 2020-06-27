
$file = $profile.CurrentUserAllHosts
$pattern = '^(?=.*\bImport-module\b)(?=.*\bSMGitHelper\b).*$'
$psprofile = Get-Content $file
if(-not ($psprofile | Select-String -Pattern $pattern)){

    Add-Content -path $file -value "`n# Git-Helper-for-PowerShell`nImport-Module $PSScriptRoot\Modules\SMGitHelper -DisableNameChecking 3>`$null`n" 
    Write-Host "Added to PowerShell profile for $env:USERNAME" -ForegroundColor Green
}else {
    Write-Host "Already added to PowerShell profile for $env:USERNAME"
}
