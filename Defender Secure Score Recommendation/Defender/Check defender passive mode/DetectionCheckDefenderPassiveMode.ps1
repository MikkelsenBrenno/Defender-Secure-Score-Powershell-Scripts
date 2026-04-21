$RegistryPath  = "HKLM:\SOFTWARE\Policies\Microsoft\Windows Advanced Threat Protection"
$ValueName     = "ForceDefenderPassiveMode"
$ExpectedValue = 0

try {
    if (-not (Test-Path -Path $RegistryPath)) {
        Write-Output "Preferred value is set."
        exit 0
    }

    $Item = Get-ItemProperty -Path $RegistryPath -ErrorAction Stop

    if (-not ($Item.PSObject.Properties.Name -contains $ValueName)) {
        Write-Output "Preferred value is set."
        exit 0
    }

    $CurrentValue = $Item.$ValueName

    if ($CurrentValue -eq $ExpectedValue) {
        Write-Output "Preferred value is set."
        exit 0
    }
    else {
        Write-Output "Expected value is not set needs remidiation."
        exit 1
    }
}
catch {
    Write-Output "Please follow up on the device. Unable to read value."
    exit 1
}