$RegistryPath = "HKLM:\SOFTWARE\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown"
$ValueName    = "bDisableJavaScript"
$ExpectedValue = 1

try {
    if (-not (Test-Path -Path $RegistryPath)) {
        Write-Output "Registry path not found: $RegistryPath"
        exit 1
    }

    $CurrentValue = Get-ItemPropertyValue -Path $RegistryPath -Name $ValueName -ErrorAction Stop

    if ($CurrentValue -eq $ExpectedValue) {
        Write-Output "Device Has Disabled JS for Adobe. $ValueName is set to $ExpectedValue."
        exit 0
    }
    else {
        Write-Output "Device has javascript enabled for adobe. $ValueName is set to $CurrentValue, expected $ExpectedValue."
        exit 1
    }
}
catch {
    Write-Output "Something else went wrong Follow up. Unable to read $ValueName from $RegistryPath. $_"
    exit 1
}