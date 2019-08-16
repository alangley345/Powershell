
pnputil /add-driver "\\pluto\tech\$ Drivers\Printers\$Kyocera - ALL\^Kx740830_2019_useme\KX_Driver_v740830\en\64bit\OEMSETUP.inf" /install
add-printerdriver "Kyocera TASKalfa 4200i KX"

Remove-Printer -name CANDOC8
add-printer -name CANDOC8 -drivername "Kyocera TASKalfa 4002i KX" -port 10.1.70.174