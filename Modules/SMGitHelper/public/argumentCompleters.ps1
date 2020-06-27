

# define script blocks here
$Script:acsbGitBranchNamesAll = { git branch -a | %{ $_.trim('*').trim() } }
$Script:acsbGitBranchNamesOthers = { git branch | %{ $_.trim('*').trim() } | ? {$_ -notin 'master','develop' } }
$Script:acsbGitBranchNameCurrent = { git branch | ? {$_.contains('*')} | %{ $_.trim('*').trim() }  }
$Script:acsbGitArchivedTags = { git tag | ? {$_.startswith('archive/') } }

# git ls-remote --tags origin


# connect commands here
Register-ArgumentCompleter -CommandName gbd -ParameterName branch -ScriptBlock $Script:acsbGitBranchNamesOthers -ErrorAction Ignore
Register-ArgumentCompleter -CommandName go -ParameterName branch -ScriptBlock $Script:acsbGitBranchNamesAll -ErrorAction Ignore
Register-ArgumentCompleter -CommandName Git-ArchiveBranch -ParameterName branch -ScriptBlock $Script:acsbGitBranchNamesOthers -ErrorAction Ignore
Register-ArgumentCompleter -CommandName Git-RestoreBranch -ParameterName Tag -ScriptBlock $Script:acsbGitArchivedTags -ErrorAction Ignore
Register-ArgumentCompleter -CommandName Git-Merge-Fix -ParameterName Branch -ScriptBlock $Script:acsbGitBranchNamesOthers -ErrorAction Ignore


