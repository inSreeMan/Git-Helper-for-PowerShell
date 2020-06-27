# git flow hotfix start
function Git-Flow-New-Hotfix {
    [alias('gfnhf')]
    param (
        [parameter(Mandatory)][string]$HotfixName
        , [parameter(ValueFromRemainingArguments = $true)]$Remaining
    )
    # git flow hotfix start "hotfix_$Branch"
    git checkout master
    git checkout -b "hotfix_$HotfixName"
}

function Git-Flow-Close-Hotfix {
    [alias('gfchf')]
    param (
        [string]$Branch
        , [switch]$Squash
        # , [parameter(ValueFromRemainingArguments = $true)]$Remaining
    )
    $BranchName = Pick-GitBranch -Branch $Branch -filter 'hotfix_*'
    # git flow hotfix finish $Branch
    if ($Squash) { $Branch = "--squash $BranchName" }else { $Branch = $BranchName }
    git checkout master
    git merge $Branch
    git checkout develop
    git merge $Branch
    git branch -D $BranchName
}
