$RegistryPath  = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"
$ValueName     = "DisableIPSourceRouting"
$ExpectedValue = 2

try {
    if (-not (Test-Path -Path $RegistryPath)) {
        Write-Output "Registry path not found: $RegistryPath"
        exit 1
    }

    $CurrentValue = Get-ItemPropertyValue -Path $RegistryPath -Name $ValueName -ErrorAction Stop

    if ($CurrentValue -eq $ExpectedValue) {
        Write-Output "IpSourceRouting Is Set to Disabled. $ValueName is set to $ExpectedValue."
        exit 0
    }
    else {
        Write-Output "IpSourceRouting Is Enabled. $ValueName is set to $CurrentValue, expected $ExpectedValue."
        exit 1
    }
}
catch {
    Write-Output "Something Else Is wrong check the device Unable to read $ValueName. $_"
    exit 1
}