$RegistryPath  = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections"
$ValueName     = "NC_ShowSharedAccessUI"
$DesiredValue  = 0

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