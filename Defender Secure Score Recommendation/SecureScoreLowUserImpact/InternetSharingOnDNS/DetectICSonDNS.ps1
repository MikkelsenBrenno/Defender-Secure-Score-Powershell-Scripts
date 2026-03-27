$RegistryPath  = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections"
$ValueName     = "NC_ShowSharedAccessUI"
$ExpectedValue = 0

try {
    if (-not (Test-Path -Path $RegistryPath)) {
        Write-Output "Registry path not found: $RegistryPath"
        exit 1
    }

    $CurrentValue = Get-ItemPropertyValue -Path $RegistryPath -Name $ValueName -ErrorAction Stop

    if ($CurrentValue -eq $ExpectedValue) {
        Write-Output "NetworkSharing Disabled. $ValueName is set to $ExpectedValue."
        exit 0
    }
    else {
        Write-Output "Networksharing on Company network is enabled. $ValueName is set to $CurrentValue, expected $ExpectedValue."
        exit 1
    }
}
catch {
    Write-Output "Not compliant. Unable to read $ValueName. $_"
    exit 1
}