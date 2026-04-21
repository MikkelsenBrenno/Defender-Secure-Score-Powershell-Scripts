$RegistryPath  = "HKLM:\SOFTWARE\Policies\Microsoft\Windows Advanced Threat Protection"
$ValueName     = "ForceDefenderPassiveMode"
$DesiredValue  = 0

try {
    if (Test-Path -Path $RegistryPath) {
        $Item = Get-ItemProperty -Path $RegistryPath -ErrorAction Stop

        if ($Item.PSObject.Properties.Name -contains $ValueName) {
            New-ItemProperty -Path $RegistryPath `
                             -Name $ValueName `
                             -Value $DesiredValue `
                             -PropertyType DWord `
                             -Force | Out-Null
        }
    }

    Write-Output "Remediation successful."
    exit 0
}
catch {
    Write-Output "Remediation failed."
    exit 1
}