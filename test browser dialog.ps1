$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ 
    InitialDirectory = [Environment]::GetFolderPath('Desktop') 
    Filter = 'CSV Files (*.csv)|*.csv'
}
$null = $FileBrowser.ShowDialog()