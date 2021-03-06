#turns specified fodler into csv
$dir = read-host -prompt "Enter directory to generate csv from"
get-childitem $dir | export-csv ~\downloads\temp.csv
import-csv ~\downloads\temp.csv | select-object BaseName | export-csv ~\downloads\filtered.csv
remove-item -path ~\downloads\temp.csv

## Read the contents of the export file into a variable
$FileContent = Get-Content ~\downloads\filtered.csv

## Create a hash table of key/value pairs of what we want to find and what we want to replace it with
$FindReplace = @{'BaseName'='SamAccountName'
}

## Capture the header row into a variable
$HeaderRow = $FileContent[1];

## Loop through the hash table and find/replace all of the column names
$FindReplace.GetEnumerator() | ForEach-Object {$HeaderRow = $HeaderRow.Replace($_.Name,$_.Value)}

## Replace the initial header row in the CSV with our new header row
Set-Content ~\downloads\filtered.csv -Value $HeaderRow,$FileContent[2..($FileContent.Count)];

#gets current content of DISABLED folder
$path = 'ou=DISABLED Accounts,ou=users domain wide,dc=claxton,dc=local'
Get-ADUser -Filter * -SearchBase $path | export-csv ~\downloads\temp.csv
import-csv ~\downloads\temp.csv | select-object SamAccountName | Sort-Object SamAccountName | export-csv ~\downloads\disabled.csv -NoTypeInformation
remove-item -path ~\downloads\temp.csv

$filtered = import-Csv ~\downloads\filtered.csv
$disabled = import-csv ~\downloads\disabled.csv
#compares the files in question for matches
foreach ($item1 in $filtered){

    foreach ($item2 in $disabled){
        
        $obj = "" | Select-Object SamAccountName
        if ($item1.SamAccountName -eq $item2.SamAccountName){
            $obj.SamAccountName = $item1.SamAccountName
            $obj | Export-Csv -Path ~\downloads\matches.csv -Append -NoTypeInformation
        }
    }
}

write-host "Done"