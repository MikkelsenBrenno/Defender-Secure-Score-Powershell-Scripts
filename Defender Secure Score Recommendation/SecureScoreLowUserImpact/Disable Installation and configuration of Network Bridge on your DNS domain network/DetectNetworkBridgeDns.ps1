$RegistryPath  = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections"
$ValueName     = "NC_AllowNetBridge_NLA"
$ExpectedValue = 0

try {
    if (-not (Test-Path -Path $RegistryPath)) {
        Write-Output "Registry path not found: $RegistryPath"
        exit 1
    }

    $CurrentValue = Get-ItemPropertyValue -Path $RegistryPath -Name $ValueName -ErrorAction Stop

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