$RegistryPath  = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"
$ValueName     = "DisableIPSourceRouting"
$DesiredValue  = 2

try {
    if (-not (Test-Path -Path $RegistryPath)) {
        New-Item -Path $RegistryPath -Force | Out-Null
    }

    New-ItemProperty -Path $RegistryPath `
                     -Name $ValueName `
                     -Value $DesiredValue `
                     -PropertyType DWord `
                     -Force | Out-Null

    Write-Output "Remediation successful. Set $ValueName to $DesiredValue."
    exit 0
}
catch {
    Write-Output "Remediation failed. $_"
    exit 1
}