#gets number of days an AD computer has been inactive, prompts user for number of days back to look.
#Then it passes the info to remove-adcomputer and prompt the user for confimation prior to execution
Import-Module ActiveDirectory

$DaysInactive = Read-Host -prompt "How many days inactive? "

$SearchName = Read-Host -prompt "File name (no .txt) "

$time = (Get-Date).Adddays(-($DaysInactive))

Get-ADComputer -Filter {LastLogonTimeStamp -lt $time} |select-object name | export-csv ~\downloads\$searchname`.csv -NoTypeInformation
 
foreach-object { Get-ADComputer -Filter {LastLogonTimeStamp -lt $time} }| Remove-ADObject -Recursive -WhatIf
 
