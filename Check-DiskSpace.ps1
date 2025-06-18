# Show free space for all drives
Get-PSDrive -PSProvider 'FileSystem' | Select-Object Name, Free, Used, @{Name="Total(GB)";Expression={"{0:N2}" -f ($_.Used + $_.Free)/1GB}}, @{Name="Free(%)";Expression={"{0:N2}" -f ($_.Free / ($_.Used + $_.Free) * 100)}}
