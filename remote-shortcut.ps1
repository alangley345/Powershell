#defines function that creates dialog window in explorer.exe
Function Get-FileName($InitialDirectory)
{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

  $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
  $OpenFileDialog.initialDirectory = $initialDirectory
  $OpenFileDialog.filter = "CSV (*.csv) | *.csv"
  $OpenFileDialog.ShowDialog() | Out-Null
  $OpenFileDialog.filename
}

function Find-Folders {
    [Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
    [System.Windows.Forms.Application]::EnableVisualStyles()
    $browse = New-Object System.Windows.Forms.FolderBrowserDialog
    $browse.SelectedPath = "\\pluto"
    $browse.ShowNewFolderButton = $false
    $browse.Description = "Select a directory"

    $loop = $true
    while($loop)
    {
        if ($browse.ShowDialog() -eq "OK")
        {
        $loop = $false
		
		#Insert your script here
		
        } else
        {
            $res = [System.Windows.Forms.MessageBox]::Show("You clicked Cancel. Would you like to try again or exit?", "Select a location", [System.Windows.Forms.MessageBoxButtons]::RetryCancel)
            if($res -eq "Cancel")
            {
                #Ends script
                break outer
            }
        }
    }
    $browse.SelectedPath
    $browse.Dispose()
} 


# Prompt user for desired path and create named shortcut
Write-host "Select desired shortcut path"
$TargetFile = Find-Folders

#trim path and make string
$link = $TargetFile.tostring()
$link = ($link -split '\\')[-1]

#create shortcut
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut("$env:Public\Desktop\$link.lnk")
$Shortcut.TargetPath = $TargetFile
$Shortcut.Save()

$csvfile = Get-FileName 

#in message
$ColumnHeader = Read-Host -Prompt "Enter column header"

Write-Host "Reading file" $csvfile
$names = import-csv $csvfile | select-object $ColumnHeader

$path = "c:\users\public\desktop\$link`.lnk"

Write-Host "Creating Remote Links"
foreach( $name in $names) {
    write-host $name.($ColumnHeader)
    $destination = $name.($ColumnHeader)
    #copy item over to remote host

    copy-item $path -destination "\\$destination\c$\users\public\desktop\"
}

#out message
Write-Host "Links Created!"

#cleanup
remove-item C:\users\public\desktop\$link`.lnk
