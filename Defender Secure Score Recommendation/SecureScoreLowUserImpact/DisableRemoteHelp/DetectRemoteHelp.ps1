$RegistryPath  = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
$ValueName     = "fAllowToGetHelp"
$ExpectedValue = 0

try {
    if (-not (Test-Path -Path $RegistryPath)) {
        Write-Output "Registry path not found: $RegistryPath"
        exit 1
    }

    $CurrentValue = Get-ItemPropertyValue -Path $RegistryPath -Name $ValueName -ErrorAction Stop

    if ($CurrentValue -eq $ExpectedValue) {
        Write-Output "Remote Help Is Disabled. $ValueName is set to $ExpectedValue."
        exit 0
    }
    else {
        Write-Output "Remote Help is Enabled. $ValueName is set to $CurrentValue, expected $ExpectedValue."
        exit 1
    }
}
catch {
    Write-Output "Check the Device. Unable to read $ValueName. $_"
    exit 1
}