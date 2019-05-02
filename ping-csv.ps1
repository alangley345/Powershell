<#
This script cycles through a .csv pinging each entry.
User will have to know to desired column header as well as the csv path. 
#>

Param(
  [Parameter(Mandatory=$true, position=0)][string]$csvfile
)

$ColumnHeader = Read-Host -Prompt "Enter column header"

Write-Host "Reading file" $csvfile
$names = import-csv $csvfile | select-object $ColumnHeader

Write-Host "Started Pinging.."
foreach( $name in $names) {
    if (test-connection $name.($ColumnHeader) -count 1 -quiet) {
        Write-host $name.($ColumnHeader) "Ping succeeded." -foreground green 

    } else {
        Write-host $name.($ColumnHeader) "Ping failed." -foreground red
    }
    
}

Write-Host "Pinging Completed."