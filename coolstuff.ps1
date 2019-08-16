
for($i=0;$i -le 10;$i+1){
    Add-Type -AssemblyName System.Windows.Forms
    # show the MsgBox:
    [System.Windows.Forms.MessageBox]::Show("Phil Sucks!")
}
