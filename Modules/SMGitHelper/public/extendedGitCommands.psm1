function Git-ArchiveBranch {
    param (
        [string]$Branch
        ,[parameter(ValueFromRemainingArguments=$true)]$Remaining
    )
    git tag archive/$Branch $Branch @Remaining
    git branch -d $Branch @Remaining
}

# function Git-Remote-ArchiveBranch {
#     param (
#         [string]$Branch
#         ,[parameter(ValueFromRemainingArguments=$true)]$Remaining
#     )
#     git tag archive/$Branch $Branch @Remaining
#     git branch -d $Branch @Remaining
# }

function Git-RestoreBranch {
    param (
        [string]$Tag
    )
    $Branch = $Tag.trim('archive/')
    git checkout -b $Branch archive/$Branch
}

function Git-Remote-ArchiveBranch {
    param (
        [string]$Branch
        ,[parameter(ValueFromRemainingArguments=$true)]$Remaining
    )
    git tag archive/$Branch $Branch @Remaining
    git branch -d $Branch @Remaining
}


function Git-Merge-Fix {
    [alias('gmf')]
    param (
        [string]$Branch
        ,[parameter(ValueFromRemainingArguments=$true)]$Remaining
    )
    git merge @Remaining $Branch
}