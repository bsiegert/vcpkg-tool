[CmdletBinding()]
Param()

"Using XLocFileList: $Env:XLocFileList" | Out-Host
$fileList = Get-Content -LiteralPath $Env:XLocFileList
"File list: ($($fileList -join ', '))" | Out-Host

$fileList | % {
    $fileName = $_
    "Reading localization file: $fileName" | Out-Host
    $fileContents = Get-Content $fileName -Raw # removes the BOM
    $fileContents += "`n" # add a trailing newline
    "Reading localization file: $fileName" | Out-Host
    $fileContents | Out-File `
        -FilePath $fileName `
        -Encoding UTF8NoBOM `
        -NoNewline
}
