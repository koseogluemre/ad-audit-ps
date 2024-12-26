$computers = Get-ADComputer -Filter * -Property Name

foreach ($computer in $computers) {
    $computerName = $computer.Name
    try {
        $smbSigningStatus = Get-WmiObject -Namespace "root\Microsoft\Windows\SMB" -Class "MSFT_SmbClientConfiguration" -ComputerName $computerName
        if (-not $smbSigningStatus.RequireSecuritySignature -or -not $smbSigningStatus.EnableSecuritySignature) {
            Write-Host "SMB Signing Not Required or Disabled on: $computerName"
        }
    } catch {
        Write-Host "Could not connect to $computerName"
    }
}
