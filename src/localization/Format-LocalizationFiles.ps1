[CmdletBinding()]
Param()

Write-Warning "Using XLocFileList: $Env:XLocFileList"
$fileList = Get-Content -LiteralPath $Env:XLocFileList
Write-Warning "File list: ($($fileList -join ', '))"

$fileList | % {
    $fileName = $_
    Write-Warning "Reading localization file: $fileName"
    $fileContents = Get-Content $fileName -Raw # removes the BOM
    $fileContents += "`n" # add a trailing newline
    Write-Warning "Reading localization file: $fileName"
    $fileContents | Out-File `
        -FilePath $fileName `
        -Encoding UTF8NoBOM `
        -NoNewline
}

throw "hey does this even get run?"
