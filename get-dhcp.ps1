#creates a call against the get-dhcpserverv4lease cmdlet and prompt users for input

function get-dhcp
{
    $name = Read-Host -Prompt 'Input DHCP server name'
    $scope = Read-host -Prompt 'Input desired scope'
    $string = Read-Host -Prompt 'Input workstation name' 
    get-dhcpserverv4lease -computername $name -scopeid $scope |out-string -stream | select-string $string
    Read-Host -Prompt "Press Enter to exit"
}

get-dhcp
