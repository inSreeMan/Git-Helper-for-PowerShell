function get-gitBranches {
    param([switch]$RemoteAlso)
    if ($RemoteAlso) {
        git branch -a | % { $_.trim('*').trim() 
        }
    }
    else {
        git branch  | % { $_.trim('*').trim()   
        } 
    }
}
function pick-gitBranch {
    param(
        [string]$branch,
        [string]$filter = '*',
        [switch]$RemoteAlso)
    $b = $null
    if ($RemoteAlso) {
       $b = git branch -a | % { $_.trim('*').trim() 
        }
    }
    else {
       $b = git branch  | % { $_.trim('*').trim()   
        } 
    }
    $branches = $b | ? { $_.startswith($branch) } | ? { $_ -like $filter }
    if($branches.count){
        if($branches.count -gt 1){
            $branch = (Read-ParamFromSBList BranchName $branches)
        }else{ $branch = $branches }
    }else{
        $branch = (Read-ParamFromSBList BranchName $b)
    }
    Write-Output $branch    
}
function get-gitRemoteBranches { get-gitbranches -RemoteAlso | ? { $_.startswith('remotes/') } }
function get-gitTags { git tag | % { $_.trim('*').trim() } }
function get-gitCurrentBranch { git branch | ? { $_.contains('*') } | % { $_.trim('*').trim() } }

function get-gitArchiveTags { git tag | % { $_.trim('*').trim() } | ? { $_.startswith('archive') } }


function  gh {
    @"

   # push all archive tags to origin
   get-gitArchiveTags | %{ git push origin $_ }

"@
}