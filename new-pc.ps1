$newhost = Read-Host -Prompt "Enter desired hostname"
new-adcomputer -name $newhost

#Copies and renames a checklist file
$temp ="\\pluto\tech\Windows Install Checklists\temp.docm"
Get-ChildItem -path "\\pluto\tech\Windows Install Checklists\`$Check list - Imaged.docm" | copy-item -destination $temp  
Rename-Item -path $temp -newname $newhost`.docm