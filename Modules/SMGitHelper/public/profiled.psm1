# git operations
function gs { git status }  #
function gk { gitk }  #
function gt { git tag }  #
function gka { gitk --all }  #
# function gsm { git submodule update --init --recursive }  #
function glo {
    param([parameter(ValueFromRemainingArguments = $true)]$Remaining) 
    git log --oneline @Remaining 
}  #
function gpu { git push }  #
function gpuf { git push --force-with-lease }  #
function go { 
    param($branch)    
    $b = get-gitbranches
    $branches = $b | ? { $_.startswith($branch) }
    if ($branches.count) {
        if ($branches.count -gt 1) {
            $branch = (Read-ParamFromSBList BranchName $branches)
        }
        else { $branch = $branches }
    }
    git checkout $branch 
}  #
function gor { 
    param($branch)    
    $b = get-gitRemoteBranches
    $branches = $b | ? { $_.startswith($branch) }
    if ($branches.count) {
        if ($branches.count -gt 1) {
            $branch = (Read-ParamFromSBList BranchName $branches)
        }
        else { $branch = $branches }
    }
    git checkout $branch 
}  #
function gon { param($branch) git checkout -b $branch }  #
function gonf { 
    # new fix branch
    param([parameter(Mandatory)]$fixName) git checkout -b "fix/$fixName" 
}  #
function gb { 
    # .DESCRIPTION List git branches
    git branch 
}  #
function gbd {
    #
    param($branch) 
    Write-Host "`nDelete git branch : $branch" -ForegroundColor Magenta
    $res = ((Read-Host -Prompt "`nAre you sure? (y/*)"), 'No' | ? { $_.length } | select -First 1).Tolower()[0]
    if ($res -eq 'y') { git branch -D $branch }  
}

function gde {
    #
    param($branch = 'HEAD'
        # ,$exclusions = "':!*.cat' ':!*.zip'"
    ) 

    $branch = 'imgClean'
    $exclusions = "`':!*.cat` `':!*.zip`' `':!*.psd1`'"
    Write-Host "[$branch] : External git diff (excl : $exclusions)" -ForegroundColor DarkGray

    git difftool --dir-diff $branch ':!*.cat' ':!*.zip' ':!*.psd1'
    #git difftool --dir-diff $branch $exclusions

}