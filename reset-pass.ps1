$adAccount =  (Read-Host -prompt "Provide AD User")
$newPassword = (Read-Host -prompt "Provide New password" -AsSecureString)
Set-ADAccountPassword -Identity $adAccount -reset -NewPassword $newPassword
Set-ADUser -ChangePasswordAtLogon $true -Identity $adAccount -Confirm:$false -verbose