$source = read-host -prompt "Enter source hostname"
$destination = read-host -prompt "Enter destination hostname"
$user = read-host -prompt "Enter folder name"
new-item -path "\\$destination\c$\" -name "$user" -itemtype "directory"

copy-item "\\$source\c$\users\$user\desktop\" -destination "\\$destination\c$\$user" -Recurse
copy-item "\\$source\c$\users\$user\documents\" -destination "\\$destination\c$\$user" -Recurse
copy-item "\\$source\c$\users\$user\downloads\" -destination "\\$destination\c$\$user" -Recurse


