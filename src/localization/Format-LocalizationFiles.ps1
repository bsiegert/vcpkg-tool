$fileList = Get-Content $Env:XLocFileList

$fileList | % {
    $fileName = $_
    $fileContents = Get-Content $fileName -Raw # removes the BOM
    if (-not $fileContents.EndsWith("`n"))
    {
        $fileContents += "`n" # add a trailing newline
    }
    $fileContents | Out-File `
        -FilePath $fileName `
        -Encoding UTF8NoBOM `
        -NoNewline
}
