$RegistryPath  = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters"
$ValueName     = "RequireSecuritySignature"
$DesiredValue  = 1

try {
    if (-not (Test-Path -Path $RegistryPath)) {
        New-Item -Path $RegistryPath -Force | Out-Null
    }

    New-ItemProperty -Path $RegistryPath `
                     -Name $ValueName `
                     -Value $DesiredValue `
                     -PropertyType DWord `
                     -Force | Out-Null

    Write-Output "Remediation successful."
    exit 0
}
catch {
    Write-Output "Remediation failed."
    exit 1
}