$key = Read-Host -Prompt 'Copy Office Key Here'
set-location 'C:\Program Files (x86)\Microsoft Office\Office15'
cscript.exe ospp.vbs /inpkey:$key
cscript.exe ospp.vbs /act
