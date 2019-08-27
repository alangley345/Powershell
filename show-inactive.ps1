#gets number of days an AD computer has been inactive, prompts user for number of days back to look

$DaysInactive = Read-Host -prompt "How many days inactive? "

$time = (Get-Date).Adddays(-($DaysInactive))

Get-ADComputer -Filter {LastLogonTimeStamp -lt $time} -ResultPageSize 2000 -resultSetSize $null -Properties Name, OperatingSystem, SamAccountName, DistinguishedName
