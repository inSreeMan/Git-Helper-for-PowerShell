
# value picker for params
function Read-ParamFromSBList {
    [CmdletBinding()]
    [alias('rpsbl')]
    param([string]$Name, $sbOrList)
    $list = @()
    if ($sbOrList -is [scriptblock]) { $list = & $sbOrList }elseif ($sbOrList -is [array]) { $list = $sbOrList }
    if ($list.count) {
        do {
            Write-Host "(valid $Name values : $($list -join ', '))".Replace('  ', ' ') -ForegroundColor DarkGray
            $selected = Read-Host -Prompt "Specify $Name (from above list)".Replace('  ', ' ')
        }while (!$list.contains($selected)) 
        Write-output $selected
    }
    else { Write-Warning "You must pass a scriptblock or array only." -WarningAction Stop }
}
# example caller :
# function Test-PromptValuePicker {
#     param(
#         $ConfigName = (Read-ParamFromSBList DSCConfigName $Script:acsbDSCConfigFolderNames),
#         $VMType = (Read-ParamFromSBList VMType @('DesignVM','TestVM','ReleaseVM'))
#     )
#     Write-Host "Passed - $Name  $Othname"
# }