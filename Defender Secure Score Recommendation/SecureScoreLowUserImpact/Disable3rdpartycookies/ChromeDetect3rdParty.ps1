$RegistryPath  = "HKLM:\SOFTWARE\Policies\Google\Chrome"
$ValueName     = "BlockThirdPartyCookies"
$ExpectedValue = 1

try {
    if (-not (Test-Path -Path $RegistryPath)) {
        Write-Output "Registry path not found: $RegistryPath"
        exit 1
    }

    $CurrentValue = Get-ItemPropertyValue -Path $RegistryPath -Name $ValueName -ErrorAction Stop

    if ($CurrentValue -eq $ExpectedValue) {
        Write-Output "Chrome is blocking 3rd party cookies. $ValueName is set to $ExpectedValue."
        exit 0
    }
    else {
        Write-Output "Chrome is allowing 3rd party cookies. $ValueName is set to $CurrentValue, expected $ExpectedValue."
        exit 1
    }
}
catch {
    Write-Output "Check up on the device. Unable to read $ValueName. $_"
    exit 1
}