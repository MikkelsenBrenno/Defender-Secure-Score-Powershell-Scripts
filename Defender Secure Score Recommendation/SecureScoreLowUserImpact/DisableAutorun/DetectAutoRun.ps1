$RegistryPath  = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$ValueName     = "NoAutorun"
$ExpectedValue = 1

try {
    if (-not (Test-Path -Path $RegistryPath)) {
        Write-Output "Registry path not found: $RegistryPath"
        exit 1
    }

    $CurrentValue = Get-ItemPropertyValue -Path $RegistryPath -Name $ValueName -ErrorAction Stop

    if ($CurrentValue -eq $ExpectedValue) {
        Write-Output "AutoRun Is Disabled. $ValueName is set to $ExpectedValue."
        exit 0
    }
    else {
        Write-Output "AutoRun Is enabled. $ValueName is set to $CurrentValue, expected $ExpectedValue."
        exit 1
    }
}
catch {
    Write-Output "Something Went Wrong Check the Device. Unable to read $ValueName. $_"
    exit 1
}