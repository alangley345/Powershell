# Takes files from My Powershell Github repo, signs them and moves them to a new folder. 

$signed = "~\Documents\signed_powershell"
Get-ChildItem -path "~\documents\github\powershell" | copy-item -destination $signed

$cert = Get-ChildItem Cert:\CurrentUser\My -codesigning
$files = Get-ChildItem $signed *.ps1 -Recurse

foreach ($file in $files) {
    $a = $file.fullname
    Set-AuthenticodeSignature -FilePath $a -Certificate $cert 
}
Write-Host "Finished signing"



