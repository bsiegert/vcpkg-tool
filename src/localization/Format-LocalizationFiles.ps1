[CmdletBinding()]
Param()

$fileList = Get-Content -LiteralPath $Env:XLocFileList

$fileList | % {
    "" | Out-File -FilePath $fileName
    #$fileName = $_
    #$fileContents = Get-Content $fileName -Raw # removes the BOM
    #$fileContents += "`n" # add a trailing newline
    #$fileContents | Out-File `
        #-FilePath $fileName `
        #-Encoding UTF8NoBOM `
        #-NoNewline
}
